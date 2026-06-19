
import math
import os


def binary_to_svrom(input_bitmaps, output_rom, module_name="font_rom"):
    if not os.path.exists(input_bitmaps):
        raise FileNotFoundError(f"Cannot find input file '{input_bitmaps}'.")

    with open(input_bitmaps, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f.readlines()]

    rom_data = {}
    char_names = []
    current_char = None
    char_bitmap = []

    for line in lines:
        if line.startswith("CP437:"):
            parts = line.split("|")
            dec_part = parts[1].strip() 
            char_name = parts[3].strip()
            current_char = int(dec_part.split(":")[1].strip())
            char_bitmap = []
            char_names.append(char_name)
        
        elif line.startswith("░") or line.startswith("█"):
            binary_string = line.replace("░", "0").replace("█", "1")
            char_bitmap.append(binary_string)
            
            if len(char_bitmap) == 16 and current_char is not None:
                rom_data[current_char] = char_bitmap
                current_char = None

    max_height = max(len(data) for data in rom_data.values())
    row_bits = max(1, math.ceil(math.log2(max_height)))
    row_width = max(len(row) for data in rom_data.values() for row in data)

    with open(output_rom, "w", encoding="utf-8") as f:
        f.write(f"module {module_name} (\n")
        f.write(f"    input logic [7:0] char_code, // CP437 character code\n")
        f.write(f"    input logic [{row_bits-1}:0] row,       // Row index (0-{max_height-1})\n")
        f.write(f"    output logic [{row_width-1}:0] font_data  // Font data\n")
        f.write(f");\n\n")

        f.write("always_comb begin\n")
        f.write(f"    font_data = {row_width}'b" + "0" * row_width + ";\n\n")
        f.write("    unique case (char_code)\n\n")

        for code, data_rows in sorted(rom_data.items()):
            hex_str = f"{code:02X}"
            f.write(f"        8'h{hex_str}: begin // {char_names[code]}\n")
            f.write("            unique case (row)\n")

            for i, row_str in enumerate(data_rows):
                f.write(f"                {row_bits}'d{i}: font_data = {row_width}'b{row_str};\n")
            
            f.write(f"                default: font_data = {row_width}'b" + "0" * row_width + ";\n")
            f.write("            endcase\n")
            f.write("        end\n\n")

        f.write(f"        default: font_data = {row_width}'b" + "0" * row_width + ";\n")
        f.write("    endcase\n")
        f.write("end\n\n")
        f.write("endmodule\n")
    print(f"Successfully generated SystemVerilog ROM '{output_rom}' containing {len(rom_data)} characters.")


if __name__ == "__main__":
    input_file = "./out/CLEagleIII_8x16_bitmap.txt"  
    output_file = "./out/CLEagleIII_8x16_rom.sv"
    binary_to_svrom(input_file, output_file)