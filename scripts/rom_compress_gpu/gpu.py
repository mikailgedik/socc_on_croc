#!/usr/bin/env python3

import kp
import numpy as np
import os
from rom_compress.logic_gen import Machine
from random import Random
import time
from multiprocessing import Pool
import tracemalloc

words_per_stage = list(map(lambda l: (l+31)//32, Machine.FF_PER_STAGE))
max_words_per_stage = max(max(words_per_stage), (Machine.INPUT_WIDTH + 31) // 32)
input_width_words = (Machine.INPUT_WIDTH + 31) // 32
LOCAL_COMPUTE_SIZE=(1,1,1)
stims = [[i] for i in range(4)]
stims_as_bytes = list(bytes(stim_vec[i // 4].to_bytes(4, byteorder='little')[i % 4]
                                for i in range(len(stim_vec) * 4)) for stim_vec in stims)

def let_machine_run(m: Machine):
    return m.run(stims_as_bytes)
# using util function from kp gitrepo: python/test/utils
def compile_source(src_path):
    # TODO oh no code injection
    args = f"-DWORDS_PER_STAGE={','.join(str(i) for i in words_per_stage)} "\
    f"-DWORDS_PER_STAGE_LENGTH={len(words_per_stage)} "\
    f"-DMAX_STAGE_SIZE={max_words_per_stage} "\
    f"-DOUTPUT_WORDS={words_per_stage[-1]} "\
    f"-DLOCAL_SIZE_X={LOCAL_COMPUTE_SIZE[0]} "\
    f"-DLOCAL_SIZE_Y={LOCAL_COMPUTE_SIZE[1]} "\
    f"-DLOCAL_SIZE_Z={LOCAL_COMPUTE_SIZE[2]} "\
    f"-DSTIMULI_LENGTH={len(stims)} "
    cmd = f"glslangValidator -V {src_path} {args} -o tmp_kp_shader.comp.spv"
    if os.system(cmd) != 0:
        raise ValueError(f"Compilation {cmd} failed")
    
    return open("tmp_kp_shader.comp.spv", "rb").read()

def extend_list(l: list[list[int]], to: int) -> list[list[int]]:
    return list(i + list(0 for _ in range(to - len(i))) for i in l)

def display_top(snapshot, key_type='lineno', limit=3):
    # Source - https://stackoverflow.com/a/45679009
    # Posted by Don Kirkby, modified by community. See post 'Timeline' for change history
    # Retrieved 2026-05-13, License - CC BY-SA 4.0

    import linecache
    import os
    snapshot = snapshot.filter_traces((
        tracemalloc.Filter(False, "<frozen importlib._bootstrap>"),
        tracemalloc.Filter(False, "<unknown>"),
    ))
    top_stats = snapshot.statistics(key_type)

    print("Top %s lines" % limit)
    for index, stat in enumerate(top_stats[:limit], 1):
        frame = stat.traceback[0]
        # replace "/path/to/module/file.py" with "module/file.py"
        filename = os.sep.join(frame.filename.split(os.sep)[-2:])
        print("#%s: %s:%s: %.1f KiB"
              % (index, filename, frame.lineno, stat.size / 1024))
        line = linecache.getline(frame.filename, frame.lineno).strip()
        if line:
            print('    %s' % line)

    other = top_stats[limit:]
    if other:
        size = sum(stat.size for stat in other)
        print("%s other: %.1f KiB" % (len(other), size / 1024))
    total = sum(stat.size for stat in top_stats)
    print("Total allocated size: %.1f KiB" % (total / 1024))

def total_size(o, handlers={}, verbose=False):
    """ Returns the approximate memory footprint an object and all of its contents.

    Automatically finds the contents of the following builtin containers and
    their subclasses:  tuple, list, deque, dict, set and frozenset.
    To search other containers, add handlers to iterate over their contents:

        handlers = {SomeContainerClass: iter,
                    OtherContainerClass: OtherContainerClass.get_elements}

    """
    # from __future__ import print_function
    from sys import getsizeof, stderr
    from itertools import chain
    from collections import deque

    dict_handler = lambda d: chain.from_iterable(d.items())
    all_handlers = {tuple: iter,
                    list: iter,
                    deque: iter,
                    dict: dict_handler,
                    set: iter,
                    frozenset: iter,
                   }
    all_handlers.update(handlers)     # user handlers take precedence
    seen = set()                      # track which object id's have already been seen
    default_size = getsizeof(0)       # estimate sizeof object without __sizeof__

    def sizeof(o):
        if id(o) in seen:       # do not double count the same object
            return 0
        seen.add(id(o))
        s = getsizeof(o, default_size)

        if verbose:
            print(s, type(o), repr(o), file=stderr)

        for typ, handler in all_handlers.items():
            if isinstance(o, typ):
                s += sum(map(sizeof, handler(o)))
                break
        return s

    return sizeof(o)


def kompute(shader) -> None:
    # 1. Create Kompute Manager with default settings (device 0, first queue and no extensions)
    tracemalloc.start()
    time_start : int = time.time_ns()
    mgr = kp.Manager()
    rng = Random(0)

    # 2. Create and initialise Kompute Tensors through manager
    # stims = list(
    #     [[0x0],[0x1],[0x2],[0x3], [0x4],[0x5],[0x6]]
    # )
    # stims = [[rng.randint(0,0xFFFFFFFF)] for _ in range(6)]

    testus_machinus = Machine()
    # testus_machinus.stage_comb[0].and_enable = bytes([0x00, 0x00, 0xFF, 0xFF])
    # testus_machinus.stage_comb[0].xor_enable = bytes([0x00, 0xFF, 0x00, 0xFF])
    # testus_machinus.stage_comb[0].inv_enable = bytes([0x0F, 0x0F, 0x0F, 0x0F])

    # 3. Create algorithm based on shader
    workgroup = (1, 1, 1)

    machines = [testus_machinus.modified_clone(1, None, rng) for _ in range(workgroup[0] * LOCAL_COMPUTE_SIZE[0] * LOCAL_COMPUTE_SIZE[1] * LOCAL_COMPUTE_SIZE[2])]
    # machines = [testus_machinus]

    print(f"Machines: {(time.time_ns() - time_start) // 1_000_000:02d}ms.")
    print(f"Mach: {total_size(machines) // (1024)}KiB")
    time_start = time.time_ns()

    sources_in = mgr.tensor_t(np.array(list(
        extend_list(m.sources_to_list(), max_words_per_stage * 32) for m in machines
    ), dtype=np.uint32))
    enables_and_in = mgr.tensor_t(np.array(list(
        extend_list(m.and_to_list(), max_words_per_stage) for m in machines
    ), dtype=np.uint32))
    enables_xor_in = mgr.tensor_t(np.array(list(
        extend_list(m.xor_to_list(), max_words_per_stage) for m in machines
    ), dtype=np.uint32))
    enables_inv_in = mgr.tensor_t(np.array(list(
        extend_list(m.inv_to_list(), max_words_per_stage) for m in machines
    ), dtype=np.uint32))
    machine_states = mgr.tensor_t(np.array(list(
        list(list(0 for _ in range(max_words_per_stage)) for _ in range(len(words_per_stage))) for _ in machines
    ), dtype=np.uint32), tensor_type=kp.TensorTypes.storage)
    stimuli_in = mgr.tensor_t(np.array(
        list(s + list(0 for _ in range(max_words_per_stage - len(s))) for s in stims),
        dtype=np.uint32))
    output_buff = mgr.tensor_t(np.zeros((len(machines), len(stims), words_per_stage[-1]), dtype=np.uint32))
    
    params = [sources_in, enables_and_in, enables_xor_in, enables_inv_in,
              machine_states, stimuli_in, output_buff]
    for p in params:
        print(p.data().shape)
    print("Params size", sum(p.data().size * 4 for p in params) // (1024), "KiB")
    print(f"Params: {(time.time_ns() - time_start) // 1_000_000:05d}ms.")
    snapshot = tracemalloc.take_snapshot()
    display_top(snapshot)
    time_start = time.time_ns()

    # See documentation shader section for compile_source
    spirv = compile_source(shader)
    print(f"Compiler: {(time.time_ns() - time_start) // 1_000_000:05d}ms.")
    time_start = time.time_ns()
    snapshot = tracemalloc.take_snapshot()
    display_top(snapshot)
    
    algo = mgr.algorithm(params, spirv, workgroup)
    print(f"Algo: {(time.time_ns() - time_start) // 1_000_000:05d}ms.")
    snapshot = tracemalloc.take_snapshot()
    display_top(snapshot)
    time_start = time.time_ns()
    # 4. Run operation synchronously using sequence
    (mgr.sequence()
        .record(kp.OpTensorSyncDevice(params))
        .record(kp.OpAlgoDispatch(algo))
        .eval())

    # 5. Sync results from the GPU asynchronously
    sq = mgr.sequence()
    sq.eval_async(kp.OpTensorSyncLocal(params))

    # ... Do other work asynchronously whilst GPU finishes

    sq.eval_await()
    print(f"GPU: {(time.time_ns() - time_start) // 1_000_000:05d}ms.")

    output_array = output_buff.data().reshape((len(machines), len(stims), words_per_stage[-1]))
    # print("Output: ", list(list(list(f"{k:x}" for k in j) for j in i) for i in output_array))

    
    all_machines_ran = None
    with Pool(8) as p:
        time_start = time.time_ns()
        all_machines_ran = p.map(let_machine_run, machines)
        # all_machines_ran = [m.run(stims_as_bytes) for m in machines]
    print(f"CPU: {(time.time_ns() - time_start) // 1_000_000:05d}ms.")

    reference_res_as_ints = list(list(list(int.from_bytes(bb[4*i:4*i+4], byteorder='little') for i in range(len(bb) // 4)) for bb in ran_mach) for ran_mach in all_machines_ran)
    # print("Reference: ", list(list(list(f"{k:x}" for k in j) for j in i) for i in reference_res_as_ints))

    for i in range(len(reference_res_as_ints)):
        for j in range(len(reference_res_as_ints[i])):
            for k in range(len(reference_res_as_ints[i][j])):
                if reference_res_as_ints[i][j][k] != output_array[i][j][k]:
                    raise ValueError(f"{i}, {j}, {k}")
if __name__ == "__main__":
    kompute("rom_compress_gpu/kernel.comp")
