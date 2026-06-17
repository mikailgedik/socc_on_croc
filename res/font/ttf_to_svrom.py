#!/usr/bin/env python3

import argparse
import math
import os
import re
import tempfile
import unicodedata

from PIL import Image, ImageDraw, ImageFont


def get_cp437_mapping():
    """
    Returns a list of tuples (byte, char) for the CP437 character set.
    """
    return [(i, bytes([i]).decode("cp437")) for i in range(256)]


def ttf_to_cp437_binary(font_path, output_path, font_size, grid_w, grid_h, offset):
    """
    Render all 256 CP437 characters from the TTF font into a text-based binary font file.
    """
    if not os.path.exists(font_path):
        raise FileNotFoundError(f"Cannot find font file '{font_path}'.")

    try:
        font = ImageFont.truetype(font_path, font_size)
    except IOError as exc:
        raise RuntimeError(f"Cannot open font '{font_path}': {exc}") from exc

    chars = get_cp437_mapping()

    with open(output_path, "w", encoding="utf-8") as out_file:
        for byte_val, char in chars:
            img = Image.new("L", (grid_w, grid_h), color=0)
            draw = ImageDraw.Draw(img)
            draw.text(offset, char, font=font, fill=255)

            hex_val = f"0x{byte_val:02X}"
            out_file.write(f"CP437: {hex_val} | Dec: {byte_val:<3} | Char: '{char}' | Size: {grid_w}x{grid_h}\n")

            for y in range(grid_h):
                row_bits = ["1" if img.getpixel((x, y)) > 0 else "0" for x in range(grid_w)]
                out_file.write("".join(row_bits) + "\n")

            out_file.write("\n")

    print(f"Wrote binary font file '{output_path}' containing {len(chars)} CP437 characters.")


def convert_binary_to_sv(input_txt, output_sv, module_name="font_rom", raw_binary_out=None):
    """
    Parse an existing text-based binary font file and generate a SystemVerilog ROM module.
    """
    if not os.path.exists(input_txt):
        raise FileNotFoundError(f"Cannot find input file '{input_txt}'.")

    with open(input_txt, "r", encoding="utf-8") as f:
        lines = f.readlines()

    font_data = {}
    current_char_code = None
    char_name = ""
    expected_height = 0
    current_binary_rows = []

    for line in lines:
        line = line.strip()
        if not line:
            continue

        if "Size:" in line:
            dec_match = re.search(r"(?:ASCII|Dec):\s*(\d+)", line)
            size_match = re.search(r"Size:\s*(\d+)x(\d+)", line)
            char_match = re.search(r"Char:\s*'(.*?)'", line)

            if dec_match and size_match:
                current_char_code = int(dec_match.group(1))
                expected_height = int(size_match.group(2))

                if char_match and len(char_match.group(1)) > 0:
                    raw_char = char_match.group(1)[0]
                    try:
                        char_name = unicodedata.name(raw_char)
                    except ValueError:
                        char_name = f"UNKNOWN_CHAR_{current_char_code}"
                else:
                    char_name = f"Code_{current_char_code}"

                current_binary_rows = []
                continue

        if current_char_code is not None and all(c in "01" for c in line):
            current_binary_rows.append(line)
            if len(current_binary_rows) == expected_height:
                font_data[current_char_code] = {
                    "name": char_name,
                    "data": current_binary_rows,
                }
                current_char_code = None
                current_binary_rows = []

    if not font_data:
        raise RuntimeError("No valid character data found in the input file.")

    max_height = max(len(d["data"]) for d in font_data.values())
    row_bits = max(1, math.ceil(math.log2(max_height)))
    row_width = max(len(row) for d in font_data.values() for row in d["data"])
    
    bytes_raw = bytearray()

    with open(output_sv, "w", encoding="utf-8") as f:
        f.write(f"module {module_name} (\n")
        f.write(f"    input logic [7:0] char_code, // ASCII/CP437 character code\n")
        f.write(f"    input logic [{row_bits-1}:0] row,       // Row index (0-{max_height-1})\n")
        f.write(f"    output logic [{row_width-1}:0] font_data  // Font data\n")
        f.write(f");\n\n")

        f.write("always_comb begin\n")
        f.write(f"    font_data = {row_width}'b" + "0" * row_width + ";\n\n")
        f.write("    unique case (char_code)\n\n")

        for code, info in sorted(font_data.items()):
            hex_str = f"{code:02X}"
            f.write(f"        8'h{hex_str}: begin // Char: '{info['name']}'\n")
            f.write("            unique case (row)\n")

            for i, row_str in enumerate(info["data"]):
                f.write(f"                {row_bits}'d{i}: font_data = {row_width}'b{row_str};\n")
                raw_byte = int(row_str, 2)
                raw_byte_reversed : int = 0
                for k in range(8):
                    raw_byte_reversed = raw_byte_reversed << 1
                    raw_byte_reversed |= ((raw_byte >> k) & 1)
                bytes_raw.extend(raw_byte_reversed.to_bytes(1, byteorder='little'))
            f.write(f"                default: font_data = {row_width}'b" + "0" * row_width + ";\n")
            f.write("            endcase\n")
            f.write("        end\n\n")

        f.write(f"        default: font_data = {row_width}'b" + "0" * row_width + ";\n")
        f.write("    endcase\n")
        f.write("end\n\n")
        f.write("endmodule\n")

    if not raw_binary_out is None:
        with open(raw_binary_out, "wb") as f:
            f.write(bytes_raw)
    print(f"Successfully generated SystemVerilog ROM '{output_sv}' containing {len(font_data)} characters.")


def ttf_to_svrom(
    font_path,
    output_sv,
    font_size,
    grid_w,
    grid_h,
    offset,
    module_name,
    binary_out=None,
    raw_binary_out=None,
):
    """
    Convert a TTF font directly into a SystemVerilog ROM using the CP437 mapping.
    """
    temp_binary = None
    try:
        if binary_out is None:
            temp_file = tempfile.NamedTemporaryFile(prefix="ttf_font_", suffix=".txt", delete=False)
            binary_out = temp_file.name
            temp_file.close()
            temp_binary = binary_out

        ttf_to_cp437_binary(font_path, binary_out, font_size, grid_w, grid_h, offset)
        convert_binary_to_sv(binary_out, output_sv, module_name, raw_binary_out)
    finally:
        if temp_binary is not None and os.path.exists(temp_binary):
            os.remove(temp_binary)


def parse_offset(value):
    parts = value.split(",")
    if len(parts) != 2:
        raise argparse.ArgumentTypeError("Offset must be two comma-separated integers, e.g. 0,0")
    try:
        return int(parts[0]), int(parts[1])
    except ValueError:
        raise argparse.ArgumentTypeError("Offset values must be integers.")


def main():
    parser = argparse.ArgumentParser(
        description="Convert a TTF font into a SystemVerilog CP437 font ROM."
    )
    parser.add_argument("--font-path", required=True, help="Path to the TTF font file.")
    parser.add_argument("--output-sv", required=True, help="Destination SystemVerilog ROM file.")
    parser.add_argument("--font-size", type=int, default=16, help="Font point size to render.")
    parser.add_argument("--grid-width", type=int, default=8, help="Width of each glyph in pixels.")
    parser.add_argument("--grid-height", type=int, default=16, help="Height of each glyph in pixels.")
    parser.add_argument(
        "--offset",
        type=parse_offset,
        default=(0, 0),
        help="Text drawing offset as 'x,y' inside each glyph grid.",
    )
    parser.add_argument(
        "--module-name",
        default="font_rom",
        help="Name of the SystemVerilog module to generate.",
    )
    parser.add_argument(
        "--binary-out",
        default=None,
        help="Optional intermediate binary font file path to keep.",
    )
    parser.add_argument(
        "--raw-binary-out",
        default=None,
        help="Output the values which end up in the system verilog output also this file (bit-reversed).",
    )

    args = parser.parse_args()
    ttf_to_svrom(
        font_path=args.font_path,
        output_sv=args.output_sv,
        font_size=args.font_size,
        grid_w=args.grid_width,
        grid_h=args.grid_height,
        offset=args.offset,
        module_name=args.module_name,
        binary_out=args.binary_out,
        raw_binary_out=args.raw_binary_out
    )


if __name__ == "__main__":
    main()
