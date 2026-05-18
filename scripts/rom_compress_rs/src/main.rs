mod structs;

use flume::bounded;
use wgpu::util::{BufferInitDescriptor, DeviceExt};
use anyhow;
use std::fs;

const WORKERS : [u32; 3] = [4, 4, 2];

#[tokio::main]
pub async fn main() -> anyhow::Result<()> {
    env_logger::init();
    run().await
}

pub fn write_stims() -> anyhow::Result<()> {
    let mut v : Vec<u8> = vec![];
    for i in 0..128 {
        v.extend(usize::to_le_bytes(i));
    }
    fs::write("../../verilator/stimuli/ram_init.bin", v)?;
    Ok(())
}

struct GpuRuntime {

}

impl GpuRuntime {
    pub async fn new() -> Self {
        GpuRuntime {
            
        }
    }
}



pub async fn run() -> anyhow::Result<()> {
    write_stims()?;
    let machines = vec![{let mut m = structs::Machine::new(); m.rng(0); m}; 16];

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

    // stimuli = stimuli[0..(512)].to_vec();

    let instance = wgpu::Instance::default();
    let adapter = instance
        .request_adapter(&wgpu::RequestAdapterOptions::default())
        .await
        .unwrap();
    let mut device_descriptor : wgpu::DeviceDescriptor = Default::default();
    // TODO hmmmmmmmmmmmmmmmm 1GiB limit for buffer?
    device_descriptor.required_limits.max_storage_buffer_binding_size = 1024 * 1024 * 1024;
    device_descriptor.required_limits.max_buffer_size = 1024 * 1024 * 1024;
    
    let (device, queue) = adapter.request_device(&device_descriptor).await.unwrap();

    device.set_device_lost_callback(|reason, dbg_str| {
        eprintln!("Lost device: {:?} {}", reason, dbg_str);
    } );

    let  wgsl_src = fs::read_to_string("./introduction.wgsl")?
        .replace("%TOTAL_STAGES%", &(structs::U32_PER_STAGE.len() - 1).to_string())
        .replace("%U32_MAX_PER_STAGE%", &structs::U32_MAX_PER_STAGE.to_string())
        .replace("%U32_PER_STAGE%", &structs::U32_PER_STAGE.iter().skip(1).map(|r| r.to_string()).collect::<Vec<String>>().join(", "))
        .replace("%STIMULI_LENGTH%", &stimuli.len().to_string())
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
    let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
        label: Some("Introduction Compute Pipeline"),
        layout: None,
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
        usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::STORAGE,
    });
    let and_buffer = device.create_buffer_init(&BufferInitDescriptor {
        label: Some("and"),
        contents: &machines.iter().map(|m| m.get_and())
            .fold(Vec::<u8>::with_capacity(typ_buff_size), |mut n: Vec<u8>,m: Vec<u8>| {n.extend(m); n}),
        usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::STORAGE,
    });
    let xor_buffer = device.create_buffer_init(&BufferInitDescriptor {
        label: Some("xor"),
        contents: &machines.iter().map(|m| m.get_xor())
            .fold(Vec::<u8>::with_capacity(typ_buff_size), |mut n: Vec<u8>,m: Vec<u8>| {n.extend(m); n}),
        usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::STORAGE,
    });
    let inv_buffer = device.create_buffer_init(&BufferInitDescriptor {
        label: Some("inv"),
        contents: &machines.iter().map(|m| m.get_inv())
            .fold(Vec::<u8>::with_capacity(typ_buff_size), |mut n: Vec<u8>,m: Vec<u8>| {n.extend(m); n}),
        usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::STORAGE,
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
        usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::STORAGE,
    });

    let output_buffer = device.create_buffer(&wgpu::BufferDescriptor {
        label: Some("output"),
        size: (machines.len()
            * stimuli.len()
            * structs::U32_PER_STAGE[structs::U32_PER_STAGE.len() - 1] * size_of::<u32>()) as u64,
        usage: wgpu::BufferUsages::COPY_SRC | wgpu::BufferUsages::STORAGE,
        mapped_at_creation: false,
    });

    let temp_buffer = device.create_buffer(&wgpu::BufferDescriptor {
        label: Some("temp"),
        size: output_buffer.size(),
        usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
        mapped_at_creation: false,
    });

    let bind_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
        label: None,
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
                resource: output_buffer.as_entire_binding(),
            },
        ],
    });

    let mut encoder = device.create_command_encoder(&Default::default());

    {
        let num_dispatches = machines.len().div_ceil((WORKERS[0] * WORKERS[1] * WORKERS[2]) as usize) as u32;

        let mut pass = encoder.begin_compute_pass(&Default::default());
        pass.set_pipeline(&pipeline);
        pass.set_bind_group(0, &bind_group, &[]);
        pass.dispatch_workgroups(num_dispatches, 1, 1);
    }

    encoder.copy_buffer_to_buffer(&output_buffer, 0, &temp_buffer, 0, temp_buffer.size());

    {
        let (tx, rx) = bounded(1);
        queue.on_submitted_work_done(move || {
            match tx.send(0u32) {
                Ok(()) => {}
                Err(e) => {
                    println!("Error while sending {:?}", e);
                }
            }
        });
        queue.submit([encoder.finish()]);
        rx.recv_async().await?;
    }

    {
        // The mapping process is async, so we'll need to create a channel to get
        // the success flag for our mapping
        let (tx, rx) = bounded(1);

        // We send the success or failure of our mapping via a callback
        temp_buffer.map_async(wgpu::MapMode::Read, .., move |result| {
            match tx.send(result) {
                Ok(()) => {}
                Err(e) => {
                    println!("Error while sending {:?}", e);
                }
            }
        });

        // The callback we submitted to map async will only get called after the
        // device is polled or the queue submitted
        device.poll(wgpu::PollType::wait_indefinitely())?;

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
        let output_data = temp_buffer.get_mapped_range(..);
        // let tmp : &[u32] = bytemuck::cast_slice(&output_data);
        // for i in 0..machines.len() {
        //     let ll = i * stimuli.len() * structs::U32_MAX_PER_STAGE;
        //     println!("{} {} {}", tmp.len(), ll, tmp[ll]);
        // }
        
        let selected_machine = machines.len() - 1;

        let machine_sv = machines[selected_machine].to_sv("test_gen_rom");
        fs::write("../../src/generated/test_gen_rom.sv", machine_sv)?;

        let size_of_one = stimuli.len() * structs::U32_PER_STAGE[structs::U32_PER_STAGE.len() - 1] * size_of::<u32>();
        
        fs::write("../../verilator/output2.bin", &output_data[selected_machine*size_of_one..(selected_machine + 1) * size_of_one])?;

        // Now we have the data on the CPU we can do what ever we want to with it
        // assert_eq!(&input_data, bytemuck::cast_slice(&output_data));
    }

    // We need to unmap the buffer to be able to use it again
    temp_buffer.unmap();

    log::info!("Success!");
    Ok(())
}