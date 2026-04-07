#!/usr/bin/env python3
import sys

def process_file(input_path : str, output_path: str, bytes_per_pixel: int):
    with open(input_path, "rb") as f_in, open(output_path, "wb") as f_out:
        data_i : bytes = f_in.read()
        data_o : bytearray = bytearray()
        for i in range(int(len(data_i)/3)):
            b = data_i[3*i + 2]
            g = data_i[3*i + 1]
            r = data_i[3*i + 0]
            if bytes_per_pixel == 1:
                data_o.append((r & 0b11100000) | ((g >> 3) & 0b11100) | (b >> 6))
            elif bytes_per_pixel == 2:
                data_o.append((b >> 6) | ((g << 3) & 0b11100000))
                data_o.append((g >> 5) | (r & 0b11111000))
            elif bytes_per_pixel == 3:
                data_o.append(b)
                data_o.append(g)
                data_o.append(r)
            elif bytes_per_pixel == 4:
                data_o.append(b)
                data_o.append(g)
                data_o.append(r)
                data_o.append(0)
            else:
                raise ValueError("invalid bytes per pixel")
        f_out.write(data_o)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: byte_converter.py <bytes_per_pixel> <input_file> <output_file>")
        sys.exit(1)
    bytes_per_pixel = int(sys.argv[1])
    input_file = sys.argv[2]
    output_file = sys.argv[3]

    process_file(input_file, output_file, bytes_per_pixel)