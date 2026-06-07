use crate::structs::{
    Machines, OUTPUT_START, PREVIOUS_STAGE_FF, TOTAL_FF, TOTAL_MACHINES, U32_NEEDED_FOR_FF,
    U32_PER_OUTPUT, U32_PER_STIMULI,
};
use anyhow;
use flume::bounded;
use std::fs::{self, File};
use std::io::Write;
use wgpu::util::{BufferInitDescriptor, DeviceExt};

use rand::rngs::StdRng;
use rand::{Rng, SeedableRng};

const WORKERS: [u32; 3] = [4, 4, 2];
const NUM_DISPATCHES: u32 =
    TOTAL_MACHINES.div_ceil((WORKERS[0] * WORKERS[1] * WORKERS[2]) as usize) as u32;
const STIMULI_PER_DISPATCH: u32 = 512;

const BEST_MACHINE_SV_FILE: &str = "../../src/generated/test_gen_rom.sv";
const BEST_MACHINE_OUTPUT_FILE: &str = "../../verilator/output-rs.bin";
const STATS_FILE: &str = "./stats.csv";
const MACHINES_FILE: &str = "./machines.bin";

struct GpuBuffers {
    sources_old: wgpu::Buffer,
    bitfiddle_old: wgpu::Buffer,
    sources_new: wgpu::Buffer,
    bitfiddle_new: wgpu::Buffer,
    machine_state_q: wgpu::Buffer,
    machine_state_d: wgpu::Buffer,
    stimuli: wgpu::Buffer,
    golden: wgpu::Buffer,
    output_vs_golden: wgpu::Buffer,
    output: wgpu::Buffer,
    tmp: wgpu::Buffer,
}

pub struct GpuRuntime {
    machines: Box<Machines>,
    stimuli_amount: usize,
    instance: wgpu::Instance,
    adapter: wgpu::Adapter,
    device: wgpu::Device,
    queue: wgpu::Queue,
    pipeline: wgpu::ComputePipeline,
    buffers: GpuBuffers,
    bind_group: wgpu::BindGroup,
}

impl GpuRuntime {
    pub async fn new(
        machines: Box<Machines>,
        stimuli_u8: &[u8],
        golden: &[u8],
    ) -> anyhow::Result<GpuRuntime> {
        assert!(stimuli_u8.len() % (size_of::<u32>() * U32_PER_STIMULI) == 0);
        assert!(golden.len() % (size_of::<u32>() * U32_PER_OUTPUT) == 0);
        assert_eq!(
            golden.len() / (size_of::<u32>() * U32_PER_STIMULI),
            stimuli_u8.len() / (size_of::<u32>() * U32_PER_OUTPUT)
        );
        let stimuli_amount = stimuli_u8.len() / (size_of::<u32>() * U32_PER_STIMULI);

        log::info!("Stimuli amount: {stimuli_amount}");

        let instance = wgpu::Instance::default();
        let adapter = instance
            .request_adapter(&wgpu::RequestAdapterOptions::default())
            .await
            .unwrap();
        let mut device_descriptor: wgpu::DeviceDescriptor = Default::default();
        // TODO hmmmmmmmmmmmmmmmm 1GiB limit for buffer?
        device_descriptor
            .required_limits
            .max_storage_buffer_binding_size = 1024 * 1024 * 1024;
        device_descriptor.required_limits.max_buffer_size = 1024 * 1024 * 1024;
        device_descriptor.required_limits.max_immediate_size = 128;
        device_descriptor
            .required_limits
            .max_storage_buffers_per_shader_stage = 16;
        device_descriptor.required_features |= wgpu::Features::IMMEDIATES;
        let (device, queue) = adapter.request_device(&device_descriptor).await.unwrap();

        device.set_device_lost_callback(|reason, dbg_str| {
            log::error!("Lost device: {:?} {}", reason, dbg_str);
        });

        let wgsl_src = fs::read_to_string("./kernel.wgsl")?
            .replace("%TOTAL_MACHINES%", &TOTAL_MACHINES.to_string())
            .replace("%TOTAL_FF%", &TOTAL_FF.to_string())
            .replace("%U32_NEEDED_FOR_FF%", &U32_NEEDED_FOR_FF.to_string())
            .replace(
                "%PREVIOUS_STAGE_FF_ARRAY_LENGTH%",
                &PREVIOUS_STAGE_FF.len().to_string(),
            )
            .replace(
                "%PREVIOUS_STAGE_FF%",
                &PREVIOUS_STAGE_FF
                    .iter()
                    .map(|r| r.to_string())
                    .collect::<Vec<String>>()
                    .join(", "),
            )
            .replace("%OUTPUT_START%", &OUTPUT_START.to_string())
            .replace("%STIMULI_LENGTH%", &stimuli_amount.to_string())
            .replace("%STIMULI_PER_DISPATCH%", &STIMULI_PER_DISPATCH.to_string());

        let shader_module_descr = wgpu::ShaderModuleDescriptor {
            label: Some("kernel.wgsl"),
            source: wgpu::ShaderSource::Wgsl(wgsl_src.into()),
        };
        let shader = device.create_shader_module(shader_module_descr);

        let push_constants = [
            ("workers_x", WORKERS[0] as f64),
            ("workers_y", WORKERS[1] as f64),
            ("workers_z", WORKERS[2] as f64),
        ];
        let mut compile_options: wgpu::PipelineCompilationOptions = Default::default();
        compile_options.constants = &push_constants;

        let pipeline_bindgroup_layout0_entries: [wgpu::BindGroupLayoutEntry; 10] = {
            let tmp: Vec<wgpu::BindGroupLayoutEntry> = (0..10u32)
                .into_iter()
                .map(|i| wgpu::BindGroupLayoutEntry {
                    binding: i,
                    visibility: wgpu::ShaderStages::COMPUTE,
                    ty: wgpu::BindingType::Buffer {
                        ty: wgpu::BufferBindingType::Storage {
                            read_only: match i {
                                6 | 7 => true,
                                _ => false,
                            },
                        },
                        has_dynamic_offset: false,
                        min_binding_size: None,
                    },
                    count: None,
                })
                .collect::<Vec<_>>();
            tmp.try_into().expect("Oh no")
        };
        let pipeline_bindgroup_layout0 =
            device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
                label: Some("pipeline layout bindgroup 0"),
                entries: &pipeline_bindgroup_layout0_entries,
            });

        let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
            label: Some("pipeline layout"),
            bind_group_layouts: &[Some(&pipeline_bindgroup_layout0)],
            immediate_size: 16,
        });

        let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
            label: Some("Introduction Compute Pipeline"),
            layout: Some(&pipeline_layout),
            module: &shader,
            entry_point: Some("main"),
            compilation_options: compile_options,
            cache: Default::default(),
        });

        let sources_new_buffer = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("sources new"),
            contents: bytemuck::cast_slice(&machines.sources),
            usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
        });

        let bitfiddle_new_buffer = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("bitfiddle new"),
            contents: bytemuck::cast_slice(&machines.bitfiddle),
            usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
        });

        let sources_old_buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("sources old"),
            size: sources_new_buffer.size(),
            usage: wgpu::BufferUsages::COPY_DST
                | wgpu::BufferUsages::COPY_SRC
                | wgpu::BufferUsages::STORAGE,
            mapped_at_creation: false,
        });
        let bitfiddle_old_buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("bitfiddle old"),
            size: bitfiddle_new_buffer.size(),
            usage: wgpu::BufferUsages::COPY_DST
                | wgpu::BufferUsages::COPY_SRC
                | wgpu::BufferUsages::STORAGE,
            mapped_at_creation: false,
        });

        let machine_state_q_buff = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("machine_state_q"),
            size: (TOTAL_MACHINES * U32_NEEDED_FOR_FF * size_of::<u32>()) as u64,
            usage: wgpu::BufferUsages::STORAGE,
            mapped_at_creation: false,
        });

        let machine_state_d_buff = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("machine_state_d"),
            size: machine_state_q_buff.size(),
            usage: wgpu::BufferUsages::STORAGE,
            mapped_at_creation: false,
        });

        let stimuli_buff = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("stimuli"),
            contents: &stimuli_u8,
            usage: wgpu::BufferUsages::STORAGE,
        });

        let golden_buff = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("golden"),
            contents: &golden,
            usage: wgpu::BufferUsages::STORAGE,
        });

        let output_buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("output"),
            size: (TOTAL_MACHINES * stimuli_amount * U32_PER_OUTPUT * size_of::<u32>()) as u64,
            usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
            mapped_at_creation: false,
        });

        let output_vs_golden_buff = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("output vs golden"),
            contents: bytemuck::cast_slice(&machines.score),
            usage: wgpu::BufferUsages::COPY_DST
                | wgpu::BufferUsages::COPY_SRC
                | wgpu::BufferUsages::STORAGE,
        });

        let temp_buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("temp"),
            size: std::cmp::max(
                std::cmp::max(output_vs_golden_buff.size(), output_buffer.size()),
                sources_new_buffer.size(),
            ) as u64,
            usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
            mapped_at_creation: false,
        });

        let bind_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
            label: Some("bind group"),
            layout: &pipeline.get_bind_group_layout(0),
            entries: &[
                wgpu::BindGroupEntry {
                    binding: 0,
                    resource: sources_old_buffer.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 1,
                    resource: bitfiddle_old_buffer.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 2,
                    resource: sources_new_buffer.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 3,
                    resource: bitfiddle_new_buffer.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 4,
                    resource: machine_state_q_buff.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 5,
                    resource: machine_state_d_buff.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 6,
                    resource: stimuli_buff.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 7,
                    resource: golden_buff.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 8,
                    resource: output_buffer.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 9,
                    resource: output_vs_golden_buff.as_entire_binding(),
                },
            ],
        });
        Ok(GpuRuntime {
            machines,
            stimuli_amount,
            instance,
            adapter,
            device,
            queue,
            pipeline,
            buffers: GpuBuffers {
                sources_old: sources_old_buffer,
                bitfiddle_old: bitfiddle_old_buffer,
                sources_new: sources_new_buffer,
                bitfiddle_new: bitfiddle_new_buffer,
                machine_state_q: machine_state_q_buff,
                machine_state_d: machine_state_d_buff,
                stimuli: stimuli_buff,
                golden: golden_buff,
                output: output_buffer,
                output_vs_golden: output_vs_golden_buff,
                tmp: temp_buffer,
            },
            bind_group,
        })
    }

    pub async fn run(&mut self) -> anyhow::Result<()> {
        // TODO Change from deterministic to truly random once testing finishes
        let s: [u32; 8] = [
            0xABAF_4321,
            0xdeadbeef,
            0x4978_2348,
            0x7cbd_46da,
            0x4321_4329,
            0xA67b_d8d4,
            0x2242_a421,
            0x25bc_762c,
        ];
        let mut rng = StdRng::from_seed(bytemuck::cast_slice(&s).try_into().unwrap());
        const TOTAL_SIMS: u32 = 4096 * 16;
        const SIMS_PER_ENCODER: u32 = 16;
        const RESHUFFLE_PERIOD: u32 = 1;
        // T defines how much delta is tolerated at total. If the delta is X, the chances of
        // the chances of acceptance are 2^(-X/T)
        // Ideally we want to define that at the beginning, if every bit is wrong, there is an acceptance rate of 1/2
        // Thus,  2^(-X/T_0) == 0.5 -> T_0 = MAX_ERRORS
        // The temperature should decrease too with each repetion. Algorithm can be linear
        let start_temp: f32 = (self.stimuli_amount * PREVIOUS_STAGE_FF[PREVIOUS_STAGE_FF.len() - 1]) as f32 * 0.002f32;
        let mut last_temp = start_temp;
        fs::write(
            STATS_FILE,
            "best score; avg score; worst score; best replace; avg replace; worst replace; best override; avg override; worst override\n",
        )?;

        let start_time = std::time::Instant::now();
        for kappa in 0..TOTAL_SIMS.div_ceil(SIMS_PER_ENCODER) {
            let mut encoder = self.device.create_command_encoder(&Default::default());

            for simulation_iter in (kappa * SIMS_PER_ENCODER)
                ..std::cmp::min((kappa + 1) * SIMS_PER_ENCODER, TOTAL_SIMS)
            {
                let iterations_left_normalized: f32 =
                    1.0 - (simulation_iter + 1) as f32 / (TOTAL_SIMS as f32);
                let mut temperature: f32 = start_temp * iterations_left_normalized;
                last_temp = temperature;
                // TODO decrease this with time?
                let randomization_chance: f32 = if simulation_iter != 0 {
                    (iterations_left_normalized + 0.1f32) * 0.9f32
                } else {
                    1.0f32
                }.clamp(0f32, 1f32);
                self.compute_pass_compare_or_create_new(
                    &mut encoder,
                    if simulation_iter != 0 {
                        Some(temperature)
                    } else {
                        None
                    },
                    Some((randomization_chance * 0xFFFF as f32) as u32),
                    rng.next_u32(),
                );

                for i in 0..(self.stimuli_amount.div_ceil(STIMULI_PER_DISPATCH as usize)) {
                    self.compute_pass_run(&mut encoder, (i as u32) * STIMULI_PER_DISPATCH);
                }
            }
            self.queue.submit([encoder.finish()]);

            let (tx, rx) = bounded(1);
            self.queue.on_submitted_work_done(move || {
                if let Err(e) = tx.send(0u32) {
                    log::error!("Error while sending {:?}", e);
                }
            });
            self.device.poll(wgpu::PollType::wait_indefinitely())?;
            let total_time_extrapolated: u128 = start_time.elapsed().as_millis()
                * (TOTAL_SIMS.div_ceil(SIMS_PER_ENCODER) as u128)
                / (kappa as u128 + 1);
            log::info!(
                "Iteration group {}/{}. Left: {}min",
                kappa + 1,
                TOTAL_SIMS.div_ceil(SIMS_PER_ENCODER),
                (total_time_extrapolated
                    - total_time_extrapolated * (kappa as u128 + 1)
                        / (TOTAL_SIMS.div_ceil(SIMS_PER_ENCODER) as u128))
                    / (60 * 1000)
            );
            rx.recv_async().await?;

            if kappa != 0 && kappa % RESHUFFLE_PERIOD == 0 {
                // self.reshuffle_machines().await?;
                self.load_and_print_stats(last_temp).await?;
                // log::info!("Score: {}", self.machines.score[0][3]);
                // log::info!("Reshuffled machines");
            }
        }

        Ok(())
    }

    pub fn compute_pass_run(&self, encoder: &mut wgpu::CommandEncoder, stimuli_start: u32) {
        let mut pass = encoder.begin_compute_pass(&Default::default());
        pass.set_pipeline(&self.pipeline);
        let immediates: [u32; 4] = [
            1u32, // Mode == calculate
            stimuli_start,
            0u32,
            0u32,
        ];
        pass.set_immediates(0, bytemuck::cast_slice(&immediates));
        pass.set_bind_group(0, &self.bind_group, &[]);
        pass.dispatch_workgroups(NUM_DISPATCHES, 1, 1);
    }

    /// randomization_chance_temp: randomization chance has to be between 0x0 and 0xFFFF
    pub fn compute_pass_compare_or_create_new(
        &self,
        encoder: &mut wgpu::CommandEncoder,
        replace_old_machine_if_better_temp: Option<f32>,
        randomization_chance: Option<u32>,
        seed: u32,
    ) {
        let mode: u32 = match (replace_old_machine_if_better_temp, randomization_chance) {
            (Some(_), None) => 2,
            (None, Some(_)) => 3,
            (Some(_), Some(_)) => 4,
            (None, None) => panic!("What should this even mean?"),
        };
        let mut pass = encoder.begin_compute_pass(&Default::default());
        pass.set_pipeline(&self.pipeline);
        let immediates: [u32; 4] = [
            mode,
            seed,
            u32::from_le_bytes(
                replace_old_machine_if_better_temp
                    .unwrap_or(0f32)
                    .to_le_bytes(),
            ),
            randomization_chance.unwrap_or(0u32),
        ];
        pass.set_immediates(0, bytemuck::cast_slice(&immediates));
        pass.set_bind_group(0, &self.bind_group, &[]);
        pass.dispatch_workgroups(NUM_DISPATCHES, 1, 1);
    }

    pub async fn load_and_print_stats(&mut self, temp: f32) -> anyhow::Result<()> {
        self.load_old_from_gpu(true).await?;
        let stats = self.machines.compute_statistics();
        let mut f = File::options().append(true).open(STATS_FILE)?;
        writeln!(
            &mut f,
            "{};{};{};{};{};{};{};{};{}",
            stats.0.0,
            stats.0.1,
            stats.0.2,
            stats.1.0,
            stats.1.1,
            stats.1.2,
            stats.2.0,
            stats.2.1,
            stats.2.2
        )?;
        drop(f);
        let mut f = File::options()
            .write(true)
            .append(false)
            .create(true)
            .open(MACHINES_FILE)?;
        f.write_all(bytemuck::cast_slice::<_, u8>(&self.machines.bitfiddle))?;
        f.write_all(bytemuck::cast_slice::<_, u8>(&self.machines.sources))?;
        f.write_all(bytemuck::cast_slice::<_, u8>(&self.machines.score))?;

        Ok(())
    }

    pub async fn reshuffle_machines(&mut self) -> anyhow::Result<()> {
        self.load_old_from_gpu(true).await?;

        {
            let stats = self.machines.compute_statistics();
            let mut f = File::options().append(true).open(STATS_FILE)?;
            writeln!(
                &mut f,
                "{};{};{};{};{};{};{};{};{}",
                stats.0.0,
                stats.0.1,
                stats.0.2,
                stats.1.0,
                stats.1.1,
                stats.1.2,
                stats.2.0,
                stats.2.1,
                stats.2.2
            )?;
            drop(f);
            let mut f = File::options()
                .write(true)
                .append(false)
                .create(true)
                .open(MACHINES_FILE)?;
            f.write_all(bytemuck::cast_slice::<_, u8>(&self.machines.bitfiddle))?;
            f.write_all(bytemuck::cast_slice::<_, u8>(&self.machines.sources))?;
            f.write_all(bytemuck::cast_slice::<_, u8>(&self.machines.score))?;
        }

        for i in 0..TOTAL_MACHINES / 2 {
            self.machines.sources[TOTAL_MACHINES - 1 - i] = self.machines.sources[i];
            self.machines.bitfiddle[TOTAL_MACHINES - 1 - i] = self.machines.bitfiddle[i];
            self.machines.score[TOTAL_MACHINES - 1 - i] = self.machines.score[i];
        }
        log::info!("Writing...");
        self.write_buffer(
            &self.buffers.sources_old,
            bytemuck::cast_slice(&self.machines.sources),
        )
        .await?;
        log::info!("Wrote");
        self.write_buffer(
            &self.buffers.bitfiddle_old,
            bytemuck::cast_slice(&self.machines.bitfiddle),
        )
        .await?;

        self.write_buffer(
            &self.buffers.output_vs_golden,
            bytemuck::cast_slice(&self.machines.score),
        )
        .await?;

        Ok(())
    }

    pub async fn store_results(&mut self) -> anyhow::Result<()> {
        let output_data = self.read_buffer(&self.buffers.output).await?;
        // Do not sort. If sorted, the output_data will not be sorted, while the self.machines are sorted
        self.load_old_from_gpu(false).await?;
        let mut best_machine = 0;
        for i in 0..TOTAL_MACHINES {
            if self.machines.score[best_machine][0] > self.machines.score[i][0] {
                best_machine = i;
            }
        }

        let selected_machine = best_machine;

        let machine_sv = self.machines.to_sv(selected_machine, "test_gen_rom");
        fs::write(BEST_MACHINE_SV_FILE, machine_sv)?;

        let size_of_one = self.stimuli_amount * U32_PER_OUTPUT * size_of::<u32>();
        log::info!("Size of output: {}", size_of_one);
        fs::write(
            BEST_MACHINE_OUTPUT_FILE,
            &output_data[selected_machine * size_of_one..(selected_machine + 1) * size_of_one],
        )?;

        Ok(())
    }

    pub async fn load_old_from_gpu(&mut self, sort_by_score: bool) -> anyhow::Result<()> {
        let machine_sources_raw: Vec<u8> = self.read_buffer(&self.buffers.sources_old).await?;
        let machine_bitfiddle_raw = self.read_buffer(&self.buffers.bitfiddle_old).await?;
        let output_vs_golden_raw = self.read_buffer(&self.buffers.output_vs_golden).await?;

        let machine_sources =
            bytemuck::cast_slice::<u8, [u32; U32_NEEDED_FOR_FF * 32]>(&machine_sources_raw);
        let machine_bitfiddle =
            bytemuck::cast_slice::<u8, [[u32; 4]; U32_NEEDED_FOR_FF]>(&machine_bitfiddle_raw);
        let output_vs_golden: &[[u32; 4]] = bytemuck::cast_slice(&output_vs_golden_raw);

        if sort_by_score {
            let mut sorted_scores: Vec<(&[u32; 4], usize)> = output_vs_golden
                .iter()
                .zip(0..output_vs_golden.len())
                .collect();
            sorted_scores.sort_unstable_by(|([s1, _, _, _], _), ([s2, _, _, _], _)| s1.cmp(s2));

            for i in 0..machine_sources.len() {
                self.machines.sources[i] = machine_sources[sorted_scores[i].1];
                self.machines.bitfiddle[i] = machine_bitfiddle[sorted_scores[i].1];
                self.machines.score[i] = output_vs_golden[sorted_scores[i].1];
            }
        } else {
            self.machines.sources = machine_sources.try_into().unwrap();
            self.machines.bitfiddle = machine_bitfiddle.try_into().unwrap();
            self.machines.score = output_vs_golden.try_into().unwrap();
        }

        Ok(())
    }

    pub async fn write_buffer(&self, buff: &wgpu::Buffer, data: &[u8]) -> anyhow::Result<()> {
        self.queue.write_buffer(&buff, 0, &data);
        self.queue.submit([]);

        let (tx, rx) = bounded(1);
        self.queue.on_submitted_work_done(move || {
            if let Err(e) = tx.send(0u32) {
                log::error!("Error while sending {:?}", e);
            }
        });
        self.device.poll(wgpu::PollType::wait_indefinitely())?;
        rx.recv_async().await?;
        Ok(())
    }

    pub async fn read_buffer(&self, buff: &wgpu::Buffer) -> anyhow::Result<Vec<u8>> {
        assert!(buff.size() <= self.buffers.tmp.size());
        let map_size = buff.size();

        {
            let mut encoder = self.device.create_command_encoder(&Default::default());
            encoder.copy_buffer_to_buffer(buff, 0, &self.buffers.tmp, 0, map_size);

            self.queue.submit([encoder.finish()]);
            let (tx, rx) = bounded(1);
            self.queue.on_submitted_work_done(move || {
                if let Err(e) = tx.send(0u32) {
                    log::error!("Error while sending {:?}", e);
                }
            });

            self.device.poll(wgpu::PollType::wait_indefinitely())?;
            rx.recv_async().await?;
        }
        // The mapping process is async, so we'll need to create a channel to get
        // the success flag for our mapping
        let (tx, rx) = bounded(1);

        // We send the success or failure of our mapping via a callback
        self.buffers
            .tmp
            .map_async(wgpu::MapMode::Read, .., move |result| {
                if let Err(e) = tx.send(result) {
                    log::error!("Error while sending {:?}", e);
                }
            });
        // The callback we submitted to map async will only get called after the
        // device is polled or the queue submitted
        self.device.poll(wgpu::PollType::wait_indefinitely())?;

        // We check if the mapping was successful here
        rx.recv_async().await??;

        // We then get the bytes that were stored in the buffer
        let output_data = self.buffers.tmp.get_mapped_range(..map_size);
        let r = output_data.to_vec();
        drop(output_data); // Need to drop BufferView explicitly so that we can unmap the buffer
        self.buffers.tmp.unmap();
        Ok(r)
    }
}
