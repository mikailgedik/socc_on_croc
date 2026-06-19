from PIL import Image, ImageDraw, ImageFont
import os

# DOS/OEM-US character set ('437' variants) index with corresponding name
cp437_characters = [
    (0, "Null"),
    (1, "White Smiling Face"),
    (2, "Black Smiling Face"),
    (3, "Black Heart Suit"),
    (4, "Black Diamond Suit"),
    (5, "Black Club Suit"),
    (6, "Black Spade Suit"),
    (7, "Bullet"),
    (8, "Inverse Bullet"),
    (9, "White Circle"),
    (10, "Inverse White Circle"),
    (11, "Male Sign"),
    (12, "Female Sign"),
    (13, "Eighth Note"),
    (14, "Beamed Eighth Notes"),
    (15, "Sun with Rays"),

    (16, "Right-Pointing Triangle"),
    (17, "Left-Pointing Triangle"),
    (18, "Up-Down Arrow"),
    (19, "Double Exclamation Mark"),
    (20, "Pilcrow Sign"),
    (21, "Section Sign"),
    (22, "Black Rectangle"),
    (23, "Up-Down Arrow with Base"),
    (24, "Upwards Arrow"),
    (25, "Downwards Arrow"),
    (26, "Rightwards Arrow"),
    (27, "Leftwards Arrow"),
    (28, "Right Angle"),
    (29, "Left Right Arrow"),
    (30, "Upwards Triangle"),
    (31, "Downwards Triangle"),

    (32, "Space"),
    (33, "Exclamation Mark"),
    (34, "Quotation Mark"),
    (35, "Number Sign"),
    (36, "Dollar Sign"),
    (37, "Percent Sign"),
    (38, "Ampersand"),
    (39, "Apostrophe"),
    (40, "Left Parenthesis"),
    (41, "Right Parenthesis"),
    (42, "Asterisk"),
    (43, "Plus Sign"),
    (44, "Comma"),
    (45, "Hyphen-Minus"),
    (46, "Full Stop"),
    (47, "Slash"),

    (48, "Digit Zero"),
    (49, "Digit One"),
    (50, "Digit Two"),
    (51, "Digit Three"),
    (52, "Digit Four"),
    (53, "Digit Five"),
    (54, "Digit Six"),
    (55, "Digit Seven"),
    (56, "Digit Eight"),
    (57, "Digit Nine"),
    (58, "Colon"),
    (59, "Semicolon"),
    (60, "Less-Than Sign"),
    (61, "Equals Sign"),
    (62, "Greater-Than Sign"),
    (63, "Question Mark"),

    (64, "At Sign"),
    (65, "Uppercase A"),
    (66, "Uppercase B"),
    (67, "Uppercase C"),
    (68, "Uppercase D"),
    (69, "Uppercase E"),
    (70, "Uppercase F"),
    (71, "Uppercase G"),
    (72, "Uppercase H"),
    (73, "Uppercase I"),
    (74, "Uppercase J"),
    (75, "Uppercase K"),
    (76, "Uppercase L"),
    (77, "Uppercase M"),
    (78, "Uppercase N"),
    (79, "Uppercase O"),

    (80, "Uppercase P"),
    (81, "Uppercase Q"),
    (82, "Uppercase R"),
    (83, "Uppercase S"),
    (84, "Uppercase T"),
    (85, "Uppercase U"),
    (86, "Uppercase V"),
    (87, "Uppercase W"),
    (88, "Uppercase X"),
    (89, "Uppercase Y"),
    (90, "Uppercase Z"),
    (91, "Left Square Bracket"),
    (92, "Backslash"),
    (93, "Right Square Bracket"),
    (94, "Circumflex Accent"),
    (95, "Underscore"),

    (96, "Grave Accent"),
    (97, "Lowercase a"),
    (98, "Lowercase b"),
    (99, "Lowercase c"),
    (100, "Lowercase d"),
    (101, "Lowercase e"),
    (102, "Lowercase f"),
    (103, "Lowercase g"),
    (104, "Lowercase h"),
    (105, "Lowercase i"),
    (106, "Lowercase j"),
    (107, "Lowercase k"),
    (108, "Lowercase l"),
    (109, "Lowercase m"),
    (110, "Lowercase n"),
    (111, "Lowercase o"),

    (112, "Lowercase p"),
    (113, "Lowercase q"),
    (114, "Lowercase r"),
    (115, "Lowercase s"),
    (116, "Lowercase t"),
    (117, "Lowercase u"),
    (118, "Lowercase v"),
    (119, "Lowercase w"),
    (120, "Lowercase x"),
    (121, "Lowercase y"),
    (122, "Lowercase z"),
    (123, "Left Curly Bracket"),
    (124, "Vertical Line"),
    (125, "Right Curly Bracket"),
    (126, "Tilde"),
    (127, "House"),

    (128, "Latin Capital C with Cedilla"),
    (129, "Latin Small U with Diaeresis"),
    (130, "Latin Small E with Acute"),
    (131, "Latin Small A with Circumflex"),
    (132, "Latin Small A with Diaeresis"),
    (133, "Latin Small A with Grave"),
    (134, "Latin Small A with Ring Above"),
    (135, "Latin Small C with Cedilla"),
    (136, "Latin Small E with Circumflex"),
    (137, "Latin Small E with Diaeresis"),
    (138, "Latin Small E with Grave"),
    (139, "Latin Small I with Diaeresis"),
    (140, "Latin Small I with Circumflex"),
    (141, "Latin Small I with Grave"),
    (142, "Latin Capital A with Diaeresis"),
    (143, "Latin Capital A with Ring Above"),

    (144, "Latin Capital E with Acute"),
    (145, "Latin Small Ash (ae)"),
    (146, "Latin Capital Ash (AE)"),
    (147, "Latin Small O with Circumflex"),
    (148, "Latin Small O with Diaeresis"),
    (149, "Latin Small O with Grave"),
    (150, "Latin Small U with Circumflex"),
    (151, "Latin Small U with Grave"),
    (152, "Latin Small Y with Diaeresis"),
    (153, "Latin Capital O with Diaeresis"),
    (154, "Latin Capital U with Diaeresis"),
    (155, "Cent Sign"),
    (156, "Pound Sign"),
    (157, "Yen Sign"),
    (158, "Peseta Sign"),
    (159, "Latin Small F with Hook / Florin"),

    (160, "Latin Small A with Acute"),
    (161, "Latin Small I with Acute"),
    (162, "Latin Small O with Acute"),
    (163, "Latin Small U with Acute"),
    (164, "Latin Small N with Tilde"),
    (165, "Latin Capital N with Tilde"),
    (166, "Feminine Ordinal Indicator"),
    (167, "Masculine Ordinal Indicator"),
    (168, "Inverted Question Mark"),
    (169, "Reversed Not Sign"),
    (170, "Not Sign"),
    (171, "Vulgar Fraction One Half"),
    (172, "Vulgar Fraction One Quarter"),
    (173, "Inverted Exclamation Mark"),
    (174, "Left-Pointing Double Angle Quotation Mark"),
    (175, "Right-Pointing Double Angle Quotation Mark"),

    (176, "Light Shade"),
    (177, "Medium Shade"),
    (178, "Dark Shade"),
    (179, "Box Drawings Light Vertical"),
    (180, "Box Drawings Light Vertical and Left"),
    (181, "Box Drawings Vertical Single and Left Double"),
    (182, "Box Drawings Vertical Double and Left Single"),
    (183, "Box Drawings Down Double and Left Single"),
    (184, "Box Drawings Down Single and Left Double"),
    (185, "Box Drawings Double Vertical and Left"),
    (186, "Box Drawings Double Vertical"),
    (187, "Box Drawings Double Down and Left"),
    (188, "Box Drawings Double Up and Left"),
    (189, "Box Drawings Up Double and Left Single"),
    (190, "Box Drawings Up Single and Left Double"),
    (191, "Box Drawings Light Down and Left"),

    (192, "Box Drawings Light Up and Right"),
    (193, "Box Drawings Light Up and Horizontal"),
    (194, "Box Drawings Light Down and Horizontal"),
    (195, "Box Drawings Light Vertical and Right"),
    (196, "Box Drawings Light Horizontal"),
    (197, "Box Drawings Light Vertical and Horizontal"),
    (198, "Box Drawings Vertical Single and Right Double"),
    (199, "Box Drawings Vertical Double and Right Single"),
    (200, "Box Drawings Double Up and Right"),
    (201, "Box Drawings Double Down and Right"),
    (202, "Box Drawings Double Up and Horizontal"),
    (203, "Box Drawings Double Down and Horizontal"),
    (204, "Box Drawings Double Vertical and Right"),
    (205, "Box Drawings Double Horizontal"),
    (206, "Box Drawings Double Vertical and Horizontal"),
    (207, "Box Drawings Up Single and Horizontal Double"),

    (208, "Box Drawings Up Double and Horizontal Single"),
    (209, "Box Drawings Down Single and Horizontal Double"),
    (210, "Box Drawings Down Double and Horizontal Single"),
    (211, "Box Drawings Up Double and Right Single"),
    (212, "Box Drawings Up Single and Right Double"),
    (213, "Box Drawings Down Single and Right Double"),
    (214, "Box Drawings Down Double and Right Single"),
    (215, "Box Drawings Vertical Double and Horizontal Single"),
    (216, "Box Drawings Vertical Single and Horizontal Double"),
    (217, "Box Drawings Light Up and Left"),
    (218, "Box Drawings Light Down and Right"),
    (219, "Full Block"),
    (220, "Lower Half Block"),
    (221, "Left Half Block"),
    (222, "Right Half Block"),
    (223, "Upper Half Block"),

    (224, "Greek Small Alpha"),
    (225, "Greek Small Beta / Latin Small Sharp S"),
    (226, "Greek Capital Gamma"),
    (227, "Greek Small Pi"),
    (228, "Greek Capital Sigma"),
    (229, "Greek Small Sigma"),
    (230, "Micro Sign / Mu"),
    (231, "Greek Small Tau"),
    (232, "Greek Capital Phi"),
    (233, "Greek Capital Theta"),
    (234, "Greek Capital Omega"),
    (235, "Greek Small Delta"),
    (236, "Infinity"),
    (237, "Greek Small Phi"),
    (238, "Greek Small Epsilon"),
    (239, "Intersection"),

    (240, "Identical To"),
    (241, "Plus-Minus Sign"),
    (242, "Greater-Than or Equal To"),
    (243, "Less-Than or Equal To"),
    (244, "Top Half Integral"),
    (245, "Bottom Half Integral"),
    (246, "Division Sign"),
    (247, "Almost Equal To"),
    (248, "Degree Sign"),
    (249, "Bullet Operator"),
    (250, "Middle Dot"),
    (251, "Square Root"),
    (252, "Superscript Latin Small N"),
    (253, "Superscript Two"),
    (254, "Black Square"),
    (255, "Non-breaking Space")
]


def get_cp437_mapping():
    return [(i, bytes([i]).decode("cp437")) for i in range(256)]


def ttf_to_cp437_bitmap(font_path, output_path, font_size, grid_w, grid_h, offset):
    if not os.path.exists(font_path):
        print(f"Error: Cannot find font file at '{font_path}'.")
        return
    
    try:
        font = ImageFont.truetype(font_path, font_size)
    except IOError:
        print(f"Error: Cannot open font '{font_path}'.")
        return
    
    with open(output_path, "w", encoding="utf-8") as out_file:
        for index, name in cp437_characters:
            img = Image.new("L", (grid_w, grid_h), color=0)
            draw = ImageDraw.Draw(img)
            char = get_cp437_mapping()[index][1]
            draw.text(offset, char, font=font, fill=255)
            hex_val = f"0x{index:02X}"
            out_file.write(f"CP437: {hex_val} | Dec: {index:<3} | Size: {grid_w}x{grid_h} | Name: '{name}' \n")

            for y in range(grid_h):
                row_bits = []
                for x in range(grid_w):
                    pixel_value = img.getpixel((x, y))
                    bit = "█" if pixel_value > 0 else "░"
                    row_bits.append(bit)
                
                out_file.write("".join(row_bits) + "\n")

            out_file.write("\n")


if __name__ == "__main__":
    input_file = "./CLEagleIII/Px437_CL_EagleIII_8x16.ttf"  
    output_file = "./out/CLEagleIII_8x16_bitmap.txt"
    ttf_to_cp437_bitmap(input_file, output_file, 16, 8, 16, (0,0))