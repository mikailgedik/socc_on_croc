mod gpu;
mod structs;

use crate::gpu::GpuRuntime;
use crate::structs::{Machines, PADDING_STIMS, U32_PER_OUTPUT, U32_PER_STIMULI};
use std::fs;
use std::ops::Range;

const STIMULI_FILE: &str = "../../verilator/stimuli/ram_init.bin";
const GOLDEN_FILE: &str = "../../verilator/stimuli/font8bit.data";
// For testing only to reduce runtime size
const STIMULI_TRIMMER: Option<Range<usize>> = Some((65 * 8)..(68 * 8));

#[tokio::main(flavor = "current_thread")]
pub async fn main() -> anyhow::Result<()> {
    env_logger::init();
    log::info!("Starting...");
    write_stims()?;
    log::info!("Wrote stims");

    let machines: Box<Machines> = Machines::new();

    let mut stimuli_u8: Vec<u8> = fs::read(STIMULI_FILE)?;
    let mut golden_file: Vec<u8> = fs::read(GOLDEN_FILE)?;

    if let Some(Range { start, end }) = STIMULI_TRIMMER {
        golden_file.drain((end * size_of::<u32>() * U32_PER_OUTPUT)..);
        golden_file.drain(..(start * size_of::<u32>() * U32_PER_OUTPUT));
    }

    let mut golden = vec![0u8; size_of::<u32>() * U32_PER_OUTPUT * PADDING_STIMS];
    golden.extend(&golden_file);

    stimuli_u8.extend([0u8; size_of::<u32>() * U32_PER_STIMULI * PADDING_STIMS]);

    log::info!(
        "Stimuli/Golden len: {}, {}",
        golden_file.len(),
        golden_file.len()
    );
    let mut now = std::time::Instant::now();
    let mut gpu = GpuRuntime::new(machines, &stimuli_u8, &golden).await?;
    log::info!("Creation: {}ms", now.elapsed().as_millis());
    now = std::time::Instant::now();
    gpu.run().await?;
    log::info!("Running {}ms", now.elapsed().as_millis());
    now = std::time::Instant::now();
    gpu.store_results().await?;
    log::info!("Storing {}ms", now.elapsed().as_millis());
    now = std::time::Instant::now();

    Ok(())
}

pub fn write_stims() -> anyhow::Result<()> {
    if let Some(trimmer) = STIMULI_TRIMMER {
        let mut v: Vec<u8> = Vec::with_capacity(trimmer.len());
        for i in trimmer {
            v.extend(u32::to_le_bytes(i as u32));
        }
        fs::write(STIMULI_FILE, v)?;
    }
    Ok(())
}
