def load_stimuli(src: str, size: int) -> list[list[bool]]:
    stim : list[list[bool]] = list()
    assert size > 0
    with open(src, "rb") as f:
        while len(f.peek()) != 0:
            bytes_to_read = ((size + 31) // 32) * 4
            read : list[bool] = list()
            while bytes_to_read > 0:
                b = f.read(bytes_to_read)
                if len(b) == 0:
                    raise ValueError("EOF reached while still reading")
                bytes_to_read -= len(b)
                for v in b:
                    for i in range(8):
                        read.append(((v >> i) & 1) == 1)
            stim.append(read)
    return stim

def write_to_file(dst: str, vals: list[list[bool]]) -> None:
    def bool_to_bytes(bools: list[bool]) -> bytes:
        # Pad all to 32 bits
        if len(bools) % 32 != 0:
            bools = bools.copy()
            bools.extend([False for _ in range(32 - (len(bools) % 32))])
        arr = bytearray()
        for i in range(int(len(bools)/8)):
            arr.append(
                (1 if bools[8 * i] else 0) +
                (2 if bools[8 * i + 1] else 0) +
                (4 if bools[8 * i + 2] else 0) +
                (8 if bools[8 * i + 3] else 0)+
                (16 if bools[8 * i + 4] else 0) +
                (32 if bools[8 * i + 5] else 0) +
                (64 if bools[8 * i + 6] else 0) +
                (128 if bools[8 * i + 7] else 0)
            )
        return arr
    with open(dst, "wb") as f:
        for s in vals:
            f.write(bool_to_bytes(s))
