#!/usr/bin/env python3

import sys

if __name__ == '__main__':
    if len(sys.argv) != 2 and len(sys.argv) != 4:
        raise ValueError("to many/few args. only provide output file")

    bytes_per_enc = 4
    enc_per_glyph = 4
    with open(sys.argv[1], "rb") as f:
        read = f.read()
        arr = []
        assert len(read) % (bytes_per_enc * enc_per_glyph) == 0
        print(f"glyphs: {len(read) // (bytes_per_enc * enc_per_glyph)}")
        r = range(len(read) // bytes_per_enc)
        if len(sys.argv) == 4:
            assert int(sys.argv[2]) >= 0
            assert int(sys.argv[3]) <= (len(read)//bytes_per_enc) // enc_per_glyph
            r = range(int(sys.argv[2]) * enc_per_glyph, int(sys.argv[3]) * enc_per_glyph)
        for i in r:
            arr.append(str(int.from_bytes(read[i*bytes_per_enc:(i+1)*bytes_per_enc], byteorder="little")))
        print(", ".join(arr))
