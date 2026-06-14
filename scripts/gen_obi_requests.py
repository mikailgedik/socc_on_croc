#!/usr/bin/env python3
import sys
"""
Generates binary data for the OBI requests
"""

RAM_ADDR_WIDTH = 10 + 2

class ObiR:
    def __init__(self, addr: int, data: int, we: bool, mask: int = 0b1111):
        self.addr = addr
        self.data = data
        self.attr = (mask << 28)
        self.attr |= (1 if we else 0)

reqs : list[ObiR] = [
    ObiR(0x0, 0x1, True),
    ObiR(0x0 + (1 << RAM_ADDR_WIDTH) * 1, 0xfeeffaaf, True),
    ObiR(0x0 + (1 << RAM_ADDR_WIDTH) * 2, 0xfeeffaaf, True),
    ObiR(0x0, 0x0, False),
    ObiR(0x0, 0x0, True, 0b0101),
    ObiR(0x0, 0x0, False),
]

if __name__ == '__main__':
    if len(sys.argv) != 2:
        raise ValueError("to many/few args. only provide output file")
    with open(sys.argv[1], "wb") as f:
        for r in reqs:
            f.write(r.addr.to_bytes(4, 'little'))
            f.write(r.data.to_bytes(4, 'little'))
            f.write(r.attr.to_bytes(4, 'little'))