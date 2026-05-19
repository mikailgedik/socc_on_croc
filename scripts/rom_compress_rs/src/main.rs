mod structs;

use flume::bounded;
use wgpu::util::{BufferInitDescriptor, DeviceExt};
use anyhow;
use std::fs;
use crate::structs::Machine;

const WORKERS : [u32; 3] = [4, 4, 2];
const STIMULI_PER_DISPATCH : u32 = 16;
#[tokio::main]
pub async fn main() -> anyhow::Result<()> {
    env_logger::init();
    write_stims()?;
    let machines = vec![{let mut m = structs::Machine::new(); m.rng(0); m}; 32];

    let stimuli_u8 = fs::read("../../verilator/stimuli/ram_init.bin")?;
    assert!(stimuli_u8.len() % (size_of::<u32>() * structs::U32_PER_STAGE[0]) == 0);
    let stim_length = stimuli_u8.len() / (size_of::<u32>() * structs::U32_PER_STAGE[0]);
    let mut stimuli : Vec<[u8; size_of::<u32>() * structs::U32_MAX_PER_STAGE]> = Vec::with_capacity(stim_length);
    for i in 0..stim_length {
        let mut tmp = [0u8; size_of::<u32>() * structs::U32_MAX_PER_STAGE];
        for j in 0..(size_of::<u32>() * structs::U32_PER_STAGE[0]) {
            tmp[j] = stimuli_u8[i * size_of::<u32>() * structs::U32_PER_STAGE[0] + j];
        }
        stimuli.push(tmp);
    }


    let golden = stimuli.clone();

    let mut gpu = GpuRuntime::new(&machines, &stimuli, &golden).await?;
    gpu.run().await?;

    log::info!("Success!");
    Ok(())
}

pub fn write_stims() -> anyhow::Result<()> {
    let mut v : Vec<u8> = vec![];
    for i in 0..(128) {
        v.extend(usize::to_le_bytes(i));
    }
    fs::write("../../verilator/stimuli/ram_init.bin", v)?;
    Ok(())
}

struct GpuBuffers {
    sources: wgpu::Buffer,
    and_enables: wgpu::Buffer,
    xor_enables: wgpu::Buffer,
    inv_enables: wgpu::Buffer,
    machine_state_q: wgpu::Buffer,
    machine_state_d: wgpu::Buffer,
    stimuli: wgpu::Buffer,
    golden: wgpu::Buffer,
    output_vs_golden: wgpu::Buffer,
    output: wgpu::Buffer,
    tmp: wgpu::Buffer,
}

struct GpuRuntime<'a> {
    machines: &'a [Machine],
    stimuli: &'a [[u8; size_of::<u32>() * structs::U32_MAX_PER_STAGE]],
    instance: wgpu::Instance,
    adapter: wgpu::Adapter,
    device: wgpu::Device,
    queue: wgpu::Queue,
    pipeline: wgpu::ComputePipeline,
    buffers: GpuBuffers,
    bind_group: wgpu::BindGroup
}

impl GpuRuntime<'_> {
    pub async fn new<'a>(machines: &'a [Machine],
        stimuli: &'a [[u8; size_of::<u32>() * structs::U32_MAX_PER_STAGE]],
        golden: &'a [[u8; size_of::<u32>() * structs::U32_MAX_PER_STAGE]]) -> anyhow::Result<GpuRuntime<'a>> {
        let instance = wgpu::Instance::default();
        let adapter = instance
            .request_adapter(&wgpu::RequestAdapterOptions::default())
            .await
            .unwrap();
        let mut device_descriptor : wgpu::DeviceDescriptor = Default::default();
        // TODO hmmmmmmmmmmmmmmmm 1GiB limit for buffer?
        device_descriptor.required_limits.max_storage_buffer_binding_size = 1024 * 1024 * 1024;
        device_descriptor.required_limits.max_buffer_size = 1024 * 1024 * 1024;
        device_descriptor.required_limits.max_immediate_size = 128;
        device_descriptor.required_limits.max_storage_buffers_per_shader_stage = 16;
        device_descriptor.required_features |= wgpu::Features::IMMEDIATES;
        let (device, queue) = adapter.request_device(&device_descriptor).await.unwrap();

        device.set_device_lost_callback(|reason, dbg_str| {
            eprintln!("Lost device: {:?} {}", reason, dbg_str);
        } );

        let  wgsl_src = fs::read_to_string("./kernel.wgsl")?
            .replace("%TOTAL_STAGES%", &(structs::U32_PER_STAGE.len() - 1).to_string())
            .replace("%U32_MAX_PER_STAGE%", &structs::U32_MAX_PER_STAGE.to_string())
            .replace("%U32_PER_STAGE%", &structs::U32_PER_STAGE.iter().skip(1).map(|r| r.to_string()).collect::<Vec<String>>().join(", "))
            .replace("%STIMULI_LENGTH%", &stimuli.len().to_string())
            .replace("%STIMULI_PER_DISPATCH%", &STIMULI_PER_DISPATCH.to_string())
            ;

        let shader_module_descr = wgpu::ShaderModuleDescriptor {
            label: Some("Shader Module"),
            source: wgpu::ShaderSource::Wgsl(wgsl_src.into()),
        };
        let shader = device.create_shader_module(shader_module_descr);

        let push_constants = [
            ("workers_x", WORKERS[0] as f64),
            ("workers_y", WORKERS[1] as f64),
            ("workers_z", WORKERS[2] as f64)];
        let mut compile_options : wgpu::PipelineCompilationOptions = Default::default();
        compile_options.constants = &push_constants;

        let pipeline_bindgroup_layout0_entries : [wgpu::BindGroupLayoutEntry; 10]= {
            let tmp : Vec<wgpu::BindGroupLayoutEntry> = (0..10u32).into_iter().map(|i| {
                wgpu::BindGroupLayoutEntry {
                    binding: i,
                    visibility: wgpu::ShaderStages::COMPUTE,
                    ty: wgpu::BindingType::Buffer {
                        ty: wgpu::BufferBindingType::Storage {
                            read_only: match i {
                                6 | 7 => true,
                                _ => false
                            }
                        },
                        has_dynamic_offset: false,
                        min_binding_size: None
                    },
                    count: None,
                }
            }).collect::<Vec<_>>();
            tmp.try_into().expect("Oh no")
        };
        let pipeline_bindgroup_layout0 = device.create_bind_group_layout(
            &wgpu::BindGroupLayoutDescriptor {
                label: Some("pipeline layout bindgroup 0"),
                entries: &pipeline_bindgroup_layout0_entries
            }
        );

        let pipeline_layout = device.create_pipeline_layout(
            &wgpu::PipelineLayoutDescriptor {
                label: Some("pipeline layout"),
                bind_group_layouts: &[Some(&pipeline_bindgroup_layout0)],
                immediate_size: 12,
            }
        );

        let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
            label: Some("Introduction Compute Pipeline"),
            layout: Some(&pipeline_layout),
            module: &shader,
            entry_point: Some("main"),
            compilation_options: compile_options,
            cache: Default::default(),
        });

        let typ_buff_size : usize = machines.len() *
            (structs::U32_PER_STAGE.len() - 1)
            * structs::U32_MAX_PER_STAGE * size_of::<u32>();
        let sources_tmp = machines.iter().map(|m| m.get_sources())
                .fold(Vec::<u8>::with_capacity(typ_buff_size * 32), |mut n: Vec<u8>,m: Vec<u8>| {n.extend(m); n});
        
        let sources_buffer = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("sources"),
            contents: &sources_tmp,
            usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
        });
        let and_buffer = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("and"),
            contents: &machines.iter().map(|m| m.get_and())
                .fold(Vec::<u8>::with_capacity(typ_buff_size), |mut n: Vec<u8>,m: Vec<u8>| {n.extend(m); n}),
            usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
        });
        let xor_buffer = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("xor"),
            contents: &machines.iter().map(|m| m.get_xor())
                .fold(Vec::<u8>::with_capacity(typ_buff_size), |mut n: Vec<u8>,m: Vec<u8>| {n.extend(m); n}),
            usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
        });
        let inv_buffer = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("inv"),
            contents: &machines.iter().map(|m| m.get_inv())
                .fold(Vec::<u8>::with_capacity(typ_buff_size), |mut n: Vec<u8>,m: Vec<u8>| {n.extend(m); n}),
            usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
        });
        
        let machine_state_q_buff = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("machine_state_q"),
            size: typ_buff_size as u64,
            usage: wgpu::BufferUsages::STORAGE,
            mapped_at_creation: false,
        });

        let machine_state_d_buff = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("machine_state_d"),
            size: typ_buff_size as u64,
            usage: wgpu::BufferUsages::STORAGE,
            mapped_at_creation: false,
        });

        let stimuli_buff = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("stimuli"),
            contents: &stimuli.iter().fold(Vec::<u8>::new(), |mut a,b| {a.extend(b); a}),
            usage: wgpu::BufferUsages::STORAGE,
        });

        let golden_buff = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("golden"),
            contents: &golden.iter().fold(Vec::<u8>::new(), |mut a,b| {a.extend(b); a}),
            usage: wgpu::BufferUsages::STORAGE,
        });

        let output_buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("output"),
            size: (machines.len()
                * stimuli.len()
                * structs::U32_PER_STAGE[structs::U32_PER_STAGE.len() - 1] * size_of::<u32>()) as u64,
            usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
            mapped_at_creation: false,
        });

        let output_vs_golden_buff = device.create_buffer_init(&BufferInitDescriptor {
            label: Some("golden"),
            contents: &golden.iter().fold(Vec::<u8>::new(), |mut a,b| {a.extend(b); a}),
            usage: wgpu::BufferUsages::STORAGE,
        });

        let temp_buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("temp"),
            size: output_buffer.size(),
            usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
            mapped_at_creation: false,
        });

        let bind_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
            label: Some("bind group"),
            layout: &pipeline.get_bind_group_layout(0),
            entries: &[
                wgpu::BindGroupEntry {
                    binding: 0,
                    resource: sources_buffer.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 1,
                    resource: and_buffer.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 2,
                    resource: xor_buffer.as_entire_binding(),
                },
                wgpu::BindGroupEntry {
                    binding: 3,
                    resource: inv_buffer.as_entire_binding(),
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
            stimuli,
            instance,
            adapter,
            device,
            queue,
            pipeline,
            buffers: GpuBuffers {
                sources: sources_buffer,
                and_enables: and_buffer,
                xor_enables: xor_buffer,
                inv_enables: inv_buffer,
                machine_state_q: machine_state_q_buff,
                machine_state_d: machine_state_d_buff,
                stimuli: stimuli_buff,
                golden: golden_buff,
                output: output_buffer,
                output_vs_golden: output_vs_golden_buff,
                tmp: temp_buffer
            },
            bind_group
        })
    }

    pub async fn run(&mut self) -> anyhow::Result<()> {
        let mut encoder = self.device.create_command_encoder(&Default::default());

        let batch_stimuli_size : usize = STIMULI_PER_DISPATCH as usize;
        let num_dispatches = self.machines.len().div_ceil((WORKERS[0] * WORKERS[1] * WORKERS[2]) as usize) as u32;

        for i in 0..(self.stimuli.len().div_ceil(batch_stimuli_size)) {            

            let mut pass = encoder.begin_compute_pass(&Default::default());
            pass.set_pipeline(&self.pipeline);
            let immediates : [[u8;4]; 3]= [
                (i as u32 * STIMULI_PER_DISPATCH).to_le_bytes(),
                0u32.to_le_bytes(), // Currently unused
                0u32.to_le_bytes(), // Currently unused
            ];
            pass.set_immediates(0, bytemuck::cast_slice(&immediates));
            pass.set_bind_group(0, &self.bind_group, &[]);
            pass.dispatch_workgroups(num_dispatches, 1, 1);
        }

        encoder.copy_buffer_to_buffer(&self.buffers.output, 0, &self.buffers.tmp, 0, self.buffers.tmp.size());

        {
            let (tx, rx) = bounded(1);
            self.queue.on_submitted_work_done(move || {
                match tx.send(0u32) {
                    Ok(()) => {}
                    Err(e) => {
                        println!("Error while sending {:?}", e);
                    }
                }
            });
            self.queue.submit([encoder.finish()]);
            rx.recv_async().await?;
        }

        {
            // The mapping process is async, so we'll need to create a channel to get
            // the success flag for our mapping
            let (tx, rx) = bounded(1);

            // We send the success or failure of our mapping via a callback
            self.buffers.tmp.map_async(wgpu::MapMode::Read, .., move |result| {
                match tx.send(result) {
                    Ok(()) => {}
                    Err(e) => {
                        println!("Error while sending {:?}", e);
                    }
                }
            });

            // The callback we submitted to map async will only get called after the
            // device is polled or the queue submitted
            self.device.poll(wgpu::PollType::wait_indefinitely())?;

            // We check if the mapping was successful here
            let res = rx.recv_async().await?;
            match res {
                Ok(()) => {}
                Err(e) => {
                    println!("Oh no, {:?}", e);
                    panic!("Very bad");
                }
            }

            // We then get the bytes that were stored in the buffer
            let output_data = self.buffers.tmp.get_mapped_range(..);
            // let tmp : &[u32] = bytemuck::cast_slice(&output_data);
            // for i in 0..machines.len() {
            //     let ll = i * stimuli.len() * structs::U32_MAX_PER_STAGE;
            //     println!("{} {} {}", tmp.len(), ll, tmp[ll]);
            // }
            
            let selected_machine = self.machines.len() - 1;

            let machine_sv = self.machines[selected_machine].to_sv("test_gen_rom");
            fs::write("../../src/generated/test_gen_rom.sv", machine_sv)?;

            let size_of_one = self.stimuli.len() * structs::U32_PER_STAGE[structs::U32_PER_STAGE.len() - 1] * size_of::<u32>();
            
            fs::write("../../verilator/output2.bin", &output_data[selected_machine*size_of_one..(selected_machine + 1) * size_of_one])?;

            // Now we have the data on the CPU we can do what ever we want to with it
            // assert_eq!(&input_data, bytemuck::cast_slice(&output_data));
        }

        // We need to unmap the buffer to be able to use it again
        self.buffers.tmp.unmap();

        Ok(())
    }
}
