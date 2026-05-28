#!/usr/bin/env python3
# from PIL import Image
import PIL
from PIL.Image import Image
# COPYRIGHT of the hex-numbers:
# /************************************************************************
# * font.c
# * Copyright (C) Lisa Milne 2014 <lisa@ltmnet.com>
# *
# * This program is free software: you can redistribute it and/or modify
# * it under the terms of the GNU General Public License as published by
# * the Free Software Foundation, either version 3 of the License, or
# * (at your option) any later version.
# *
# * This program is distributed in the hope that it will be useful, but
# * WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# * See the GNU General Public License for more details.
# *
# * You should have received a copy of the GNU General Public License
# * along with this program.  If not, see <http://www.gnu.org/licenses/>
# ************************************************************************/
ARRAY = [0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x0, 	0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x7E7E7E7E7E7E0000, 0x0, 	0x808080800080000, 0x2828000000000000, 0x287C287C280000, 0x81E281C0A3C0800, 0x6094681629060000, 0x1C20201926190000, 0x808000000000000, 0x810202010080000, 0x1008040408100000, 0x2A1C3E1C2A000000, 0x8083E08080000, 0x81000, 0x3C00000000, 0x80000, 0x204081020400000, 0x1824424224180000, 0x8180808081C0000, 0x3C420418207E0000, 0x3C420418423C0000, 0x81828487C080000, 0x7E407C02423C0000, 0x3C407C42423C0000, 0x7E04081020400000, 0x3C423C42423C0000, 0x3C42423E023C0000, 0x80000080000, 0x80000081000, 0x6186018060000, 0x7E007E000000, 0x60180618600000, 0x3844041800100000, 0x3C449C945C201C, 0x1818243C42420000, 0x7844784444780000, 0x3844808044380000, 0x7844444444780000, 0x7C407840407C0000, 0x7C40784040400000, 0x3844809C44380000, 0x42427E4242420000, 0x3E080808083E0000, 0x1C04040444380000, 0x4448507048440000, 0x40404040407E0000, 0x4163554941410000, 0x4262524A46420000, 0x1C222222221C0000, 0x7844784040400000, 0x1C222222221C0200, 0x7844785048440000, 0x1C22100C221C0000, 0x7F08080808080000, 0x42424242423C0000, 0x8142422424180000, 0x4141495563410000, 0x4224181824420000, 0x4122140808080000, 0x7E040810207E0000, 0x3820202020380000, 0x4020100804020000, 0x3808080808380000, 0x1028000000000000, 0x7E0000, 0x1008000000000000, 0x3C023E463A0000, 0x40407C42625C0000, 0x1C20201C0000, 0x2023E42463A0000, 0x3C427E403C0000, 0x18103810100000, 0x344C44340438, 0x2020382424240000, 0x800080808080000, 0x800180808080870, 0x20202428302C0000, 0x1010101010180000, 0x665A42420000, 0x2E3222220000, 0x3C42423C0000, 0x5C62427C4040, 0x3A46423E0202, 0x2C3220200000, 0x1C201804380000, 0x103C1010180000, 0x2222261A0000, 0x424224180000, 0x81815A660000, 0x422418660000, 0x422214081060, 0x3C08103C0000, 0x1C103030101C0000, 0x808080808080800, 0x38080C0C08380000, 0x324C000000, 0x7E7E7E7E7E7E0000]
WIDTH, HEIGHT = 16 * 8, 8 * 8

def pixel_from_hardcoded_ascii(ascii: int, x: int, y: int) -> bool:
   shift : int = ((7 - x) + (7 - y) * 8)
   assert shift < 64, str(x) + " " + str(y)
   return ((ARRAY[ascii] >> shift) & 1) == 1

def pixel_from_hardcoded(x: int, y: int):
    # image is (16 * 32) pixels wide and high

    ascii :int = (x // 8) + (y // 8) * 16
    if ascii < len(ARRAY):
        return pixel_from_hardcoded_ascii(ascii, x % 8, y % 8)
    return False

def generate_and_export_image(filename="output-original.png") -> Image:
    img = PIL.Image.new("1", (WIDTH, HEIGHT), color=0)
    for y in range(HEIGHT):
        for x in range(WIDTH):
            if pixel_from_hardcoded(x, y):
                img.putpixel((x, y), 1)
    img.save(filename)
    return img

def binary_file_to_img(filename: str = "../verilator/stimuli/font8bit.data") -> Image:
    img = PIL.Image.new("1", (WIDTH, HEIGHT), color=0)
    with open(filename, "rb") as f:
        data = f.read()

    idx = 0
    for ascii in range(128):
        for y in range(8):
            if idx < len(data):
                b = data[idx]
                idx += 4 # 4 bytes at a time, the stimuli/output have padding
            else:
                b = 0
            for x in range(8):
                pixel_val = 1 if (b & (1 << (7 - x))) else 0
                img.putpixel(((ascii % 16) * 8 + x, (ascii // 16) * 8 + y), pixel_val)
    return img

def generate_golden(img: Image, output: str = "../verilator/stimuli/font8bit.data"):
    arr = bytearray()
    for ascii in range(128):
        for y in range(8):
            b = 0
            for x in range(8):
                b <<= 1
                b |= 1 if img.getpixel(((ascii % 8) * 8 + x, (ascii // 16) * 8 + y)) == 1 else 0

            arr.append(b)
            arr.append(0)
            arr.append(0)
            arr.append(0)
    with open(output, "wb") as f:
        f.write(arr)


if __name__ == '__main__':
    # img : Image = generate_and_export_image()
    # generate_golden(img)
    
    img = binary_file_to_img("../verilator/output-rs.bin")
    img.save("output2.png")
    # generate_golden(img)