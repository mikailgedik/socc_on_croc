use crate::structs::{
    Machines, OUTPUT_START, PREVIOUS_STAGE_FF, TOTAL_FF, TOTAL_MACHINES, U32_NEEDED_FOR_FF,
    U32_PER_OUTPUT, U32_PER_STIMULI,
};
use anyhow;
use flume::bounded;
use std::fs;
use wgpu::util::{BufferInitDescriptor, DeviceExt};

use rand::rngs::StdRng;
use rand::{Rng, SeedableRng};

const WORKERS: [u32; 3] = [4, 4, 2];
const STIMULI_PER_DISPATCH: u32 = 64;

const BEST_MACHINE_SV_FILE: &str = "../../src/generated/test_gen_rom.sv";
const BEST_MACHINE_OUTPUT_FILE: &str = "../../verilator/output-rs.bin";

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
            // We can safely assume that the very first "old" machine produces bogus
            // Setting every score to worst makes the first "new" machine immediately overwrites the initial "old" machine
            contents: &vec![0xFFu8; TOTAL_MACHINES * 4 * size_of::<u32>()],
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
        let batch_stimuli_size: usize = STIMULI_PER_DISPATCH as usize;
        let num_dispatches =
            TOTAL_MACHINES.div_ceil((WORKERS[0] * WORKERS[1] * WORKERS[2]) as usize) as u32;
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
        const TOTAL_SIMS: u32 = 4096 * 2;
        const MAX_PER_ENCODER: u32 = 4;
        const RESHUFFLE_PERIOD: u32 = 16;
        // T defines how much delta is tolerated at total. If the delta is X, the chances of
        // the chances of acceptance are 2^(-X/T)
        // Ideally we want to define that at the beginning, if every bit is wrong, there is an acceptance rate of 1/2
        // Thus,  2^(-X/T_0) == 0.5 -> T_0 = MAX_ERRORS
        // The temperature should decrease too with each repetion. Algorithm can be linear
        const START_TEMP: f32 = PREVIOUS_STAGE_FF[PREVIOUS_STAGE_FF.len() - 1] as f32;
        {
            let start_time = std::time::Instant::now();
            for kappa in 0..TOTAL_SIMS.div_ceil(MAX_PER_ENCODER) {
                let (tx, rx) = bounded(1);
                self.queue.on_submitted_work_done(move || {
                    if let Err(e) = tx.send(0u32) {
                        log::error!("Error while sending {:?}", e);
                    }
                });

                let mut encoder = self.device.create_command_encoder(&Default::default());

                for simulation_iter in (kappa * MAX_PER_ENCODER)
                    ..std::cmp::min((kappa + 1) * MAX_PER_ENCODER, TOTAL_SIMS)
                {
                    let iterations_left_normalized: f32 =
                        1.0 - (simulation_iter + 1) as f32 / (TOTAL_SIMS as f32);
                    let temperature: f32 = START_TEMP * iterations_left_normalized;
                    // TODO decrease this with time?
                    let randomization_chance = (0xFFFF as f32
                        * (if simulation_iter != 0 {
                            0.05f32
                        } else {
                            1.0f32
                        })) as u32;
                    {
                        let mut pass = encoder.begin_compute_pass(&Default::default());
                        pass.set_pipeline(&self.pipeline);
                        let immediates: [u32; 4] = [
                            2u32,                 // Mode == randomize
                            randomization_chance, // Change of mutation (0x0 - 0xFFFF)
                            rng.next_u32(),       // Random seed
                            u32::from_le_bytes(temperature.to_le_bytes()),
                        ];
                        pass.set_immediates(0, bytemuck::cast_slice(&immediates));
                        pass.set_bind_group(0, &self.bind_group, &[]);
                        pass.dispatch_workgroups(num_dispatches, 1, 1);
                    }

                    for i in 0..(self.stimuli_amount.div_ceil(batch_stimuli_size)) {
                        let mut pass = encoder.begin_compute_pass(&Default::default());
                        pass.set_pipeline(&self.pipeline);
                        let immediates: [u32; 3] = [
                            1u32, // Mode == calculate
                            (i as u32 * STIMULI_PER_DISPATCH),
                            0u32, // Random seed
                        ];
                        pass.set_immediates(0, bytemuck::cast_slice(&immediates));
                        pass.set_bind_group(0, &self.bind_group, &[]);
                        pass.dispatch_workgroups(num_dispatches, 1, 1);
                    }
                }
                self.queue.submit([encoder.finish()]);
                self.device.poll(wgpu::PollType::wait_indefinitely())?;
                let total_time_extrapolated: u128 = start_time.elapsed().as_millis()
                    * (TOTAL_SIMS.div_ceil(MAX_PER_ENCODER) as u128)
                    / (kappa as u128 + 1);
                log::info!(
                    "Iteration group {}/{}. Left: {}min",
                    kappa + 1,
                    TOTAL_SIMS.div_ceil(MAX_PER_ENCODER),
                    (total_time_extrapolated
                        - total_time_extrapolated * (kappa as u128 + 1)
                            / (TOTAL_SIMS.div_ceil(MAX_PER_ENCODER) as u128))
                        / (60 * 1000)
                );
                rx.recv_async().await?;

                if kappa != 0 && kappa % RESHUFFLE_PERIOD == 0 {
                    self.reshuffle_machines().await?;
                    log::info!("Reshuffled machines");
                }
            }
        }

        Ok(())
    }

    pub async fn reshuffle_machines(&mut self) -> anyhow::Result<()> {
        let machine_sources_raw: Vec<u8> = self.read_buffer(&self.buffers.sources_old).await?;
        let machine_bitfiddle_raw = self.read_buffer(&self.buffers.bitfiddle_old).await?;
        let output_vs_golden_raw = self.read_buffer(&self.buffers.output_vs_golden).await?;

        let machine_sources =
            bytemuck::cast_slice::<u8, [u32; U32_NEEDED_FOR_FF * 32]>(&machine_sources_raw);
        let machine_bitfiddle =
            bytemuck::cast_slice::<u8, [[u32; 4]; U32_NEEDED_FOR_FF]>(&machine_bitfiddle_raw);
        let output_vs_golden: &[[u32; 4]; TOTAL_MACHINES] =
            bytemuck::cast_slice(&output_vs_golden_raw)
                .try_into()
                .unwrap();
        let mut sorted_scores: Vec<_> = output_vs_golden
            .iter()
            .zip(0..output_vs_golden.len())
            .collect();
        sorted_scores.sort_unstable_by(|k1, k2| k1.0[0].cmp(&k2.0[0]));
        for k in sorted_scores.iter() {
            log::info!("{:?}", k.0);
        }
        for i in 0..TOTAL_MACHINES / 2 {
            sorted_scores[TOTAL_MACHINES - 1 - i] = sorted_scores[i];
        }

        for i in 0..machine_sources.len() {
            self.machines.sources[i] = machine_sources[sorted_scores[i].1];
            self.machines.bitfiddle[i] = machine_bitfiddle[sorted_scores[i].1];
        }

        // self.machines.sources = bytemuck::cast_slice::<u8, [u32; U32_NEEDED_FOR_FF * 32]>(&machine_sources_raw).try_into().unwrap();
        // self.machines.bitfiddle = bytemuck::cast_slice::<u8, [[u32; 4]; U32_NEEDED_FOR_FF]>(&machine_bitfiddle_raw).try_into().unwrap();

        self.write_buffer(
            &self.buffers.sources_old,
            bytemuck::cast_slice(&self.machines.sources),
        )
        .await?;
        self.write_buffer(
            &self.buffers.bitfiddle_old,
            bytemuck::cast_slice(&self.machines.bitfiddle),
        )
        .await?;

        let scores_only: Vec<[u32; 4]> = sorted_scores.iter().map(|k| *k.0).collect();
        self.write_buffer(
            &self.buffers.output_vs_golden,
            bytemuck::cast_slice(&scores_only),
        )
        .await?;

        Ok(())
    }

    pub async fn store_results(&mut self) -> anyhow::Result<()> {
        let output_data = self.read_buffer(&self.buffers.output).await?;

        let machine_sources_raw: Vec<u8> = self.read_buffer(&self.buffers.sources_new).await?;
        let machine_bitfiddle_raw = self.read_buffer(&self.buffers.bitfiddle_new).await?;
        let output_vs_golden_raw = self.read_buffer(&self.buffers.output_vs_golden).await?;

        self.machines.sources =
            bytemuck::cast_slice::<u8, [u32; U32_NEEDED_FOR_FF * 32]>(&machine_sources_raw)
                .try_into()
                .unwrap();
        self.machines.bitfiddle =
            bytemuck::cast_slice::<u8, [[u32; 4]; U32_NEEDED_FOR_FF]>(&machine_bitfiddle_raw)
                .try_into()
                .unwrap();

        let output_vs_golden: &[[u32; 4]; TOTAL_MACHINES] =
            bytemuck::cast_slice(&output_vs_golden_raw)
                .try_into()
                .unwrap();

        let mut best_machine = 0;
        for i in 0..output_vs_golden.len() {
            if output_vs_golden[best_machine][1] > output_vs_golden[i][1] {
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

    pub async fn write_buffer(&self, buff: &wgpu::Buffer, data: &[u8]) -> anyhow::Result<()> {
        self.queue.write_buffer(&buff, 0, &data);
        let (tx, rx) = bounded(1);
        self.queue.on_submitted_work_done(move || {
            if let Err(e) = tx.send(0u32) {
                log::error!("Error while sending {:?}", e);
            }
        });
        self.queue.submit([]);
        rx.recv_async().await?;
        Ok(())
    }

    pub async fn read_buffer(&self, buff: &wgpu::Buffer) -> anyhow::Result<Vec<u8>> {
        assert!(buff.size() <= self.buffers.tmp.size());
        let map_size = buff.size();

        {
            let mut encoder = self.device.create_command_encoder(&Default::default());
            encoder.copy_buffer_to_buffer(buff, 0, &self.buffers.tmp, 0, map_size);

            let (tx, rx) = bounded(1);
            self.queue.on_submitted_work_done(move || {
                if let Err(e) = tx.send(0u32) {
                    log::error!("Error while sending {:?}", e);
                }
            });
            self.queue.submit([encoder.finish()]);
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
