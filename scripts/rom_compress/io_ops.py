def load_stimuli(src: str, size: int) -> list[bytes]:
    stim : list[bytes] = list()
    assert size > 0
    with open(src, "rb") as f:
        while len(f.peek()) != 0:
            bytes_to_read = ((size + 31) // 32) * 4
            read : bytearray = bytearray()
            while bytes_to_read > 0:
                b = f.read(bytes_to_read)
                if len(b) == 0:
                    raise ValueError("EOF reached while still reading")
                bytes_to_read -= len(b)
                read.extend(b)
            stim.append(bytes(read))
    return stim

def write_to_file(dst: str, vals: list[bytes]) -> None:
    with open(dst, "wb") as f:
        for s in vals:
            f.write(s)
            if len(s) % 4 != 0:
                f.write(bytes(4 - (len(s) % 4)))
