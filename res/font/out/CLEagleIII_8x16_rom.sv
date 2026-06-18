module font_rom (
    input logic [7:0] char_code, // ASCII/CP437 character code
    input logic [3:0] row,       // Row index (0-15)
    output logic [7:0] font_data  // Font data
);

always_comb begin
    font_data = 8'b00000000;

    unique case (char_code)

        8'h00: begin // Char: 'UNKNOWN_CHAR_0'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h01: begin // Char: 'UNKNOWN_CHAR_1'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111110;
                4'd3: font_data = 8'b10000001;
                4'd4: font_data = 8'b10100101;
                4'd5: font_data = 8'b10000001;
                4'd6: font_data = 8'b10000001;
                4'd7: font_data = 8'b10111101;
                4'd8: font_data = 8'b10011001;
                4'd9: font_data = 8'b10000001;
                4'd10: font_data = 8'b10000001;
                4'd11: font_data = 8'b01111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h02: begin // Char: 'UNKNOWN_CHAR_2'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111110;
                4'd3: font_data = 8'b11111111;
                4'd4: font_data = 8'b11011011;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b11111111;
                4'd7: font_data = 8'b11000011;
                4'd8: font_data = 8'b11100111;
                4'd9: font_data = 8'b11111111;
                4'd10: font_data = 8'b11111111;
                4'd11: font_data = 8'b01111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h03: begin // Char: 'UNKNOWN_CHAR_3'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01100110;
                4'd3: font_data = 8'b11111111;
                4'd4: font_data = 8'b11111111;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b01111110;
                4'd7: font_data = 8'b01111110;
                4'd8: font_data = 8'b00111100;
                4'd9: font_data = 8'b00111100;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h04: begin // Char: 'UNKNOWN_CHAR_4'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00010000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b00111000;
                4'd4: font_data = 8'b01111100;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11111110;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b01111100;
                4'd9: font_data = 8'b01111100;
                4'd10: font_data = 8'b00111000;
                4'd11: font_data = 8'b00111000;
                4'd12: font_data = 8'b00010000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h05: begin // Char: 'UNKNOWN_CHAR_5'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00111100;
                4'd4: font_data = 8'b00111100;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b11111111;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b01111110;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h06: begin // Char: 'UNKNOWN_CHAR_6'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00111100;
                4'd5: font_data = 8'b00111100;
                4'd6: font_data = 8'b01111110;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b11111111;
                4'd9: font_data = 8'b11111111;
                4'd10: font_data = 8'b01111110;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00111100;
                4'd13: font_data = 8'b01111110;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h07: begin // Char: 'UNKNOWN_CHAR_7'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00111100;
                4'd7: font_data = 8'b00111100;
                4'd8: font_data = 8'b00111100;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h08: begin // Char: 'UNKNOWN_CHAR_8'
            unique case (row)
                4'd0: font_data = 8'b11111111;
                4'd1: font_data = 8'b11111111;
                4'd2: font_data = 8'b11111111;
                4'd3: font_data = 8'b11111111;
                4'd4: font_data = 8'b11100111;
                4'd5: font_data = 8'b11000011;
                4'd6: font_data = 8'b11000011;
                4'd7: font_data = 8'b11000011;
                4'd8: font_data = 8'b11100111;
                4'd9: font_data = 8'b11111111;
                4'd10: font_data = 8'b11111111;
                4'd11: font_data = 8'b11111111;
                4'd12: font_data = 8'b11111111;
                4'd13: font_data = 8'b11111111;
                4'd14: font_data = 8'b11111111;
                4'd15: font_data = 8'b11111111;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h09: begin // Char: 'UNKNOWN_CHAR_9'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00111100;
                4'd4: font_data = 8'b01100110;
                4'd5: font_data = 8'b01000010;
                4'd6: font_data = 8'b01000010;
                4'd7: font_data = 8'b01000010;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b00111100;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h0A: begin // Char: 'REVERSE SOLIDUS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h0B: begin // Char: 'UNKNOWN_CHAR_11'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011110;
                4'd3: font_data = 8'b00001110;
                4'd4: font_data = 8'b00011010;
                4'd5: font_data = 8'b00110010;
                4'd6: font_data = 8'b01111000;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h0C: begin // Char: 'UNKNOWN_CHAR_12'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01100110;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b00111100;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b01111110;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h0D: begin // Char: 'REVERSE SOLIDUS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111111;
                4'd3: font_data = 8'b00110011;
                4'd4: font_data = 8'b00110011;
                4'd5: font_data = 8'b00111111;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b00110000;
                4'd9: font_data = 8'b01110000;
                4'd10: font_data = 8'b11110000;
                4'd11: font_data = 8'b11100000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h0E: begin // Char: 'UNKNOWN_CHAR_14'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111111;
                4'd3: font_data = 8'b01100011;
                4'd4: font_data = 8'b01100011;
                4'd5: font_data = 8'b01111111;
                4'd6: font_data = 8'b01100011;
                4'd7: font_data = 8'b01100011;
                4'd8: font_data = 8'b01100011;
                4'd9: font_data = 8'b01100111;
                4'd10: font_data = 8'b11100111;
                4'd11: font_data = 8'b11100110;
                4'd12: font_data = 8'b11000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h0F: begin // Char: 'UNKNOWN_CHAR_15'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b11011011;
                4'd5: font_data = 8'b00111100;
                4'd6: font_data = 8'b11100111;
                4'd7: font_data = 8'b11100111;
                4'd8: font_data = 8'b00111100;
                4'd9: font_data = 8'b11011011;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h10: begin // Char: 'UNKNOWN_CHAR_16'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b10000000;
                4'd3: font_data = 8'b11000000;
                4'd4: font_data = 8'b11100000;
                4'd5: font_data = 8'b11111000;
                4'd6: font_data = 8'b11111110;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b11111000;
                4'd9: font_data = 8'b11100000;
                4'd10: font_data = 8'b11000000;
                4'd11: font_data = 8'b10000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h11: begin // Char: 'UNKNOWN_CHAR_17'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000010;
                4'd3: font_data = 8'b00000110;
                4'd4: font_data = 8'b00001110;
                4'd5: font_data = 8'b00111110;
                4'd6: font_data = 8'b11111110;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b00111110;
                4'd9: font_data = 8'b00001110;
                4'd10: font_data = 8'b00000110;
                4'd11: font_data = 8'b00000010;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h12: begin // Char: 'UNKNOWN_CHAR_18'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00111100;
                4'd2: font_data = 8'b01111110;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b01111110;
                4'd14: font_data = 8'b00111100;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h13: begin // Char: 'UNKNOWN_CHAR_19'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01100110;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01100110;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b01100110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h14: begin // Char: 'UNKNOWN_CHAR_20'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111111;
                4'd3: font_data = 8'b11011011;
                4'd4: font_data = 8'b11011011;
                4'd5: font_data = 8'b11011011;
                4'd6: font_data = 8'b11011011;
                4'd7: font_data = 8'b01111011;
                4'd8: font_data = 8'b00011011;
                4'd9: font_data = 8'b00011011;
                4'd10: font_data = 8'b00011011;
                4'd11: font_data = 8'b00011011;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h15: begin // Char: 'UNKNOWN_CHAR_21'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01111100;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b00111000;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b01101100;
                4'd9: font_data = 8'b00111000;
                4'd10: font_data = 8'b00001100;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b01111100;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h16: begin // Char: 'UNKNOWN_CHAR_22'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b11111110;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h17: begin // Char: 'UNKNOWN_CHAR_23'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b01111110;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b01111110;
                4'd9: font_data = 8'b00111100;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b01111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h18: begin // Char: 'UNKNOWN_CHAR_24'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00111100;
                4'd2: font_data = 8'b01111110;
                4'd3: font_data = 8'b11111111;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h19: begin // Char: 'UNKNOWN_CHAR_25'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b11111111;
                4'd13: font_data = 8'b01111110;
                4'd14: font_data = 8'b00111100;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h1A: begin // Char: 'UNKNOWN_CHAR_26'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00001000;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00001110;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00001110;
                4'd9: font_data = 8'b00001100;
                4'd10: font_data = 8'b00001000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h1B: begin // Char: 'UNKNOWN_CHAR_27'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00010000;
                4'd5: font_data = 8'b00110000;
                4'd6: font_data = 8'b01110000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b01110000;
                4'd9: font_data = 8'b00110000;
                4'd10: font_data = 8'b00010000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h1C: begin // Char: 'UNKNOWN_CHAR_28'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b11000000;
                4'd5: font_data = 8'b11000000;
                4'd6: font_data = 8'b11000000;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h1D: begin // Char: 'UNKNOWN_CHAR_29'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00101000;
                4'd6: font_data = 8'b01101100;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b01101100;
                4'd9: font_data = 8'b00101000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h1E: begin // Char: 'UNKNOWN_CHAR_30'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00010000;
                4'd4: font_data = 8'b00010000;
                4'd5: font_data = 8'b00111000;
                4'd6: font_data = 8'b00111000;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b01111100;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b11111110;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h1F: begin // Char: 'UNKNOWN_CHAR_31'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b11111110;
                4'd4: font_data = 8'b11111110;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b01111100;
                4'd7: font_data = 8'b00111000;
                4'd8: font_data = 8'b00111000;
                4'd9: font_data = 8'b00010000;
                4'd10: font_data = 8'b00010000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h20: begin // Char: 'SPACE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h21: begin // Char: 'EXCLAMATION MARK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00111100;
                4'd4: font_data = 8'b00111100;
                4'd5: font_data = 8'b00111100;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h22: begin // Char: 'QUOTATION MARK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01100011;
                4'd3: font_data = 8'b01100011;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h23: begin // Char: 'NUMBER SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01101100;
                4'd2: font_data = 8'b01101100;
                4'd3: font_data = 8'b11111110;
                4'd4: font_data = 8'b11111110;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b01101100;
                4'd7: font_data = 8'b01101100;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b01101100;
                4'd11: font_data = 8'b01101100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h24: begin // Char: 'DOLLAR SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00110000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b01111000;
                4'd4: font_data = 8'b11001100;
                4'd5: font_data = 8'b11000000;
                4'd6: font_data = 8'b11000000;
                4'd7: font_data = 8'b01111000;
                4'd8: font_data = 8'b00001100;
                4'd9: font_data = 8'b00001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00110000;
                4'd13: font_data = 8'b00110000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h25: begin // Char: 'PERCENT SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11100110;
                4'd3: font_data = 8'b10100110;
                4'd4: font_data = 8'b11101100;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00110000;
                4'd9: font_data = 8'b00110111;
                4'd10: font_data = 8'b01100101;
                4'd11: font_data = 8'b01100111;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h26: begin // Char: 'AMPERSAND'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b01101100;
                4'd5: font_data = 8'b00111000;
                4'd6: font_data = 8'b01110110;
                4'd7: font_data = 8'b11011100;
                4'd8: font_data = 8'b11011100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h27: begin // Char: 'Code_39'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00110000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h28: begin // Char: 'LEFT PARENTHESIS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00001100;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00110000;
                4'd5: font_data = 8'b00110000;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b00110000;
                4'd9: font_data = 8'b00110000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00001100;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h29: begin // Char: 'RIGHT PARENTHESIS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00110000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00001100;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b00001100;
                4'd8: font_data = 8'b00001100;
                4'd9: font_data = 8'b00001100;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00110000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h2A: begin // Char: 'ASTERISK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b00111100;
                4'd8: font_data = 8'b11111111;
                4'd9: font_data = 8'b00111100;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b01100110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h2B: begin // Char: 'PLUS SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b01111110;
                4'd8: font_data = 8'b01111110;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h2C: begin // Char: 'COMMA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00110000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h2D: begin // Char: 'HYPHEN-MINUS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b01111110;
                4'd8: font_data = 8'b01111110;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h2E: begin // Char: 'FULL STOP'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h2F: begin // Char: 'SOLIDUS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00001100;
                4'd3: font_data = 8'b00001100;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b11000000;
                4'd11: font_data = 8'b11000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h30: begin // Char: 'DIGIT ZERO'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11001110;
                4'd6: font_data = 8'b11011110;
                4'd7: font_data = 8'b11110110;
                4'd8: font_data = 8'b11100110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b01101100;
                4'd11: font_data = 8'b00111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h31: begin // Char: 'DIGIT ONE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00111000;
                4'd4: font_data = 8'b01111000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h32: begin // Char: 'DIGIT TWO'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111100;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b00000110;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h33: begin // Char: 'DIGIT THREE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111110;
                4'd3: font_data = 8'b01000110;
                4'd4: font_data = 8'b00001100;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00111100;
                4'd7: font_data = 8'b00000110;
                4'd8: font_data = 8'b00000110;
                4'd9: font_data = 8'b00000110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h34: begin // Char: 'DIGIT FOUR'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011100;
                4'd3: font_data = 8'b00011100;
                4'd4: font_data = 8'b00111100;
                4'd5: font_data = 8'b00111100;
                4'd6: font_data = 8'b01101100;
                4'd7: font_data = 8'b01101100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b00001100;
                4'd11: font_data = 8'b00011110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h35: begin // Char: 'DIGIT FIVE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111100;
                4'd3: font_data = 8'b11000000;
                4'd4: font_data = 8'b11000000;
                4'd5: font_data = 8'b11111000;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b00000110;
                4'd8: font_data = 8'b00000110;
                4'd9: font_data = 8'b10000110;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h36: begin // Char: 'DIGIT SIX'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b11000000;
                4'd5: font_data = 8'b11111000;
                4'd6: font_data = 8'b11101100;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b01101100;
                4'd11: font_data = 8'b00111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h37: begin // Char: 'DIGIT SEVEN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b00000110;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00110000;
                4'd10: font_data = 8'b00110000;
                4'd11: font_data = 8'b00110000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h38: begin // Char: 'DIGIT EIGHT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111100;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b01111100;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h39: begin // Char: 'DIGIT NINE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b01101110;
                4'd8: font_data = 8'b00111110;
                4'd9: font_data = 8'b00000110;
                4'd10: font_data = 8'b00001100;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h3A: begin // Char: 'COLON'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h3B: begin // Char: 'SEMICOLON'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00110000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h3C: begin // Char: 'LESS-THAN SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000011;
                4'd4: font_data = 8'b00000110;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00001100;
                4'd10: font_data = 8'b00000110;
                4'd11: font_data = 8'b00000011;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h3D: begin // Char: 'EQUALS SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111110;
                4'd6: font_data = 8'b01111110;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b01111110;
                4'd9: font_data = 8'b01111110;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h3E: begin // Char: 'GREATER-THAN SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b11000000;
                4'd4: font_data = 8'b01100000;
                4'd5: font_data = 8'b00110000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00001100;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00110000;
                4'd10: font_data = 8'b01100000;
                4'd11: font_data = 8'b11000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h3F: begin // Char: 'QUESTION MARK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111100;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h40: begin // Char: 'COMMERCIAL AT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b01111100;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11011110;
                4'd7: font_data = 8'b11011110;
                4'd8: font_data = 8'b11011110;
                4'd9: font_data = 8'b11011100;
                4'd10: font_data = 8'b11000000;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h41: begin // Char: 'LATIN CAPITAL LETTER A'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00010000;
                4'd3: font_data = 8'b00111000;
                4'd4: font_data = 8'b01111100;
                4'd5: font_data = 8'b11101110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h42: begin // Char: 'LATIN CAPITAL LETTER B'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111100;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01100110;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01111100;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b11111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h43: begin // Char: 'LATIN CAPITAL LETTER C'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b11000010;
                4'd5: font_data = 8'b11000000;
                4'd6: font_data = 8'b11000000;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b11000000;
                4'd9: font_data = 8'b11000010;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h44: begin // Char: 'LATIN CAPITAL LETTER D'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b01100110;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01101100;
                4'd11: font_data = 8'b11111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h45: begin // Char: 'LATIN CAPITAL LETTER E'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111110;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01100010;
                4'd5: font_data = 8'b01101000;
                4'd6: font_data = 8'b01111000;
                4'd7: font_data = 8'b01101000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100010;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h46: begin // Char: 'LATIN CAPITAL LETTER F'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111110;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01100010;
                4'd5: font_data = 8'b01101000;
                4'd6: font_data = 8'b01111000;
                4'd7: font_data = 8'b01101000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b01100000;
                4'd11: font_data = 8'b11110000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h47: begin // Char: 'LATIN CAPITAL LETTER G'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b11000010;
                4'd5: font_data = 8'b11000000;
                4'd6: font_data = 8'b11000000;
                4'd7: font_data = 8'b11001110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b01101110;
                4'd11: font_data = 8'b00111010;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h48: begin // Char: 'LATIN CAPITAL LETTER H'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11111110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h49: begin // Char: 'LATIN CAPITAL LETTER I'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h4A: begin // Char: 'LATIN CAPITAL LETTER J'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011110;
                4'd3: font_data = 8'b00001100;
                4'd4: font_data = 8'b00001100;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b00001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h4B: begin // Char: 'LATIN CAPITAL LETTER K'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11100110;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01101100;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b01111000;
                4'd7: font_data = 8'b01101100;
                4'd8: font_data = 8'b01101100;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b11100110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h4C: begin // Char: 'LATIN CAPITAL LETTER L'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11110000;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b01100000;
                4'd5: font_data = 8'b01100000;
                4'd6: font_data = 8'b01100000;
                4'd7: font_data = 8'b01100000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100010;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h4D: begin // Char: 'LATIN CAPITAL LETTER M'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11101110;
                4'd4: font_data = 8'b11111110;
                4'd5: font_data = 8'b11111110;
                4'd6: font_data = 8'b11010110;
                4'd7: font_data = 8'b11010110;
                4'd8: font_data = 8'b11010110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h4E: begin // Char: 'LATIN CAPITAL LETTER N'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11100110;
                4'd4: font_data = 8'b11100110;
                4'd5: font_data = 8'b11110110;
                4'd6: font_data = 8'b11110110;
                4'd7: font_data = 8'b11011110;
                4'd8: font_data = 8'b11011110;
                4'd9: font_data = 8'b11001110;
                4'd10: font_data = 8'b11001110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h4F: begin // Char: 'LATIN CAPITAL LETTER O'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111100;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h50: begin // Char: 'LATIN CAPITAL LETTER P'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111100;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01100110;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b01100000;
                4'd11: font_data = 8'b11110000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h51: begin // Char: 'LATIN CAPITAL LETTER Q'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11011110;
                4'd10: font_data = 8'b01111110;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00001100;
                4'd13: font_data = 8'b00001110;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h52: begin // Char: 'LATIN CAPITAL LETTER R'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111100;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01100110;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b01101100;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b11110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h53: begin // Char: 'LATIN CAPITAL LETTER S'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111100;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000000;
                4'd6: font_data = 8'b01110000;
                4'd7: font_data = 8'b00011100;
                4'd8: font_data = 8'b00000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h54: begin // Char: 'LATIN CAPITAL LETTER T'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111110;
                4'd3: font_data = 8'b01111110;
                4'd4: font_data = 8'b01011010;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h55: begin // Char: 'LATIN CAPITAL LETTER U'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h56: begin // Char: 'LATIN CAPITAL LETTER V'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b01111100;
                4'd10: font_data = 8'b00111000;
                4'd11: font_data = 8'b00010000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h57: begin // Char: 'LATIN CAPITAL LETTER W'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11010110;
                4'd6: font_data = 8'b11010110;
                4'd7: font_data = 8'b11010110;
                4'd8: font_data = 8'b11010110;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b01101100;
                4'd11: font_data = 8'b01101100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h58: begin // Char: 'LATIN CAPITAL LETTER X'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b01101100;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b00111000;
                4'd7: font_data = 8'b00111000;
                4'd8: font_data = 8'b01101100;
                4'd9: font_data = 8'b01101100;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h59: begin // Char: 'LATIN CAPITAL LETTER Y'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01100110;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b01100110;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01111110;
                4'd7: font_data = 8'b00111100;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h5A: begin // Char: 'LATIN CAPITAL LETTER Z'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b10000110;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b11000010;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h5B: begin // Char: 'LEFT SQUARE BRACKET'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00110000;
                4'd5: font_data = 8'b00110000;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b00110000;
                4'd9: font_data = 8'b00110000;
                4'd10: font_data = 8'b00110000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h5C: begin // Char: 'REVERSE SOLIDUS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000000;
                4'd3: font_data = 8'b11000000;
                4'd4: font_data = 8'b01100000;
                4'd5: font_data = 8'b01100000;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00001100;
                4'd11: font_data = 8'b00001100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h5D: begin // Char: 'RIGHT SQUARE BRACKET'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b00001100;
                4'd4: font_data = 8'b00001100;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b00001100;
                4'd8: font_data = 8'b00001100;
                4'd9: font_data = 8'b00001100;
                4'd10: font_data = 8'b00001100;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h5E: begin // Char: 'CIRCUMFLEX ACCENT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00010000;
                4'd3: font_data = 8'b00111000;
                4'd4: font_data = 8'b01101100;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h5F: begin // Char: 'LOW LINE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b11111111;
                4'd13: font_data = 8'b11111111;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h60: begin // Char: 'GRAVE ACCENT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h61: begin // Char: 'LATIN SMALL LETTER A'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111000;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h62: begin // Char: 'LATIN SMALL LETTER B'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11100000;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b01100000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01110110;
                4'd11: font_data = 8'b11011100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h63: begin // Char: 'LATIN SMALL LETTER C'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b11000000;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h64: begin // Char: 'LATIN SMALL LETTER D'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011100;
                4'd3: font_data = 8'b00001100;
                4'd4: font_data = 8'b00001100;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11011100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h65: begin // Char: 'LATIN SMALL LETTER E'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h66: begin // Char: 'LATIN SMALL LETTER F'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b01100100;
                4'd5: font_data = 8'b01100000;
                4'd6: font_data = 8'b11110000;
                4'd7: font_data = 8'b01100000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b01100000;
                4'd11: font_data = 8'b11110000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h67: begin // Char: 'LATIN SMALL LETTER G'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01110110;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00001100;
                4'd13: font_data = 8'b11001100;
                4'd14: font_data = 8'b01111000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h68: begin // Char: 'LATIN SMALL LETTER H'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11100000;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b01100000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b11100110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h69: begin // Char: 'LATIN SMALL LETTER I'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00111000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h6A: begin // Char: 'LATIN SMALL LETTER J'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000110;
                4'd3: font_data = 8'b00000110;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00001110;
                4'd6: font_data = 8'b00000110;
                4'd7: font_data = 8'b00000110;
                4'd8: font_data = 8'b00000110;
                4'd9: font_data = 8'b00000110;
                4'd10: font_data = 8'b00000110;
                4'd11: font_data = 8'b00000110;
                4'd12: font_data = 8'b01100110;
                4'd13: font_data = 8'b01100110;
                4'd14: font_data = 8'b00111100;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h6B: begin // Char: 'LATIN SMALL LETTER K'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11100000;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b01100000;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01101100;
                4'd8: font_data = 8'b01111000;
                4'd9: font_data = 8'b01101100;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b11100110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h6C: begin // Char: 'LATIN SMALL LETTER L'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h6D: begin // Char: 'LATIN SMALL LETTER M'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11101100;
                4'd6: font_data = 8'b11111110;
                4'd7: font_data = 8'b11010110;
                4'd8: font_data = 8'b11010110;
                4'd9: font_data = 8'b11010110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h6E: begin // Char: 'LATIN SMALL LETTER N'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11011100;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b01100110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h6F: begin // Char: 'LATIN SMALL LETTER O'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h70: begin // Char: 'LATIN SMALL LETTER P'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11011100;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b01100000;
                4'd13: font_data = 8'b01100000;
                4'd14: font_data = 8'b11110000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h71: begin // Char: 'LATIN SMALL LETTER Q'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01110110;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00001100;
                4'd13: font_data = 8'b00001100;
                4'd14: font_data = 8'b00011110;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h72: begin // Char: 'LATIN SMALL LETTER R'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11011100;
                4'd6: font_data = 8'b01110110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b01100000;
                4'd11: font_data = 8'b11110000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h73: begin // Char: 'LATIN SMALL LETTER S'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b01111100;
                4'd9: font_data = 8'b00000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h74: begin // Char: 'LATIN SMALL LETTER T'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00010000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00110000;
                4'd5: font_data = 8'b11111100;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b00110000;
                4'd9: font_data = 8'b00110000;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00011100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h75: begin // Char: 'LATIN SMALL LETTER U'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h76: begin // Char: 'LATIN SMALL LETTER V'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b01101100;
                4'd10: font_data = 8'b00111000;
                4'd11: font_data = 8'b00010000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h77: begin // Char: 'LATIN SMALL LETTER W'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11010110;
                4'd8: font_data = 8'b11010110;
                4'd9: font_data = 8'b11010110;
                4'd10: font_data = 8'b11111110;
                4'd11: font_data = 8'b01101100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h78: begin // Char: 'LATIN SMALL LETTER X'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11101110;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b00111000;
                4'd9: font_data = 8'b01111100;
                4'd10: font_data = 8'b11101110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h79: begin // Char: 'LATIN SMALL LETTER Y'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111110;
                4'd12: font_data = 8'b00001100;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b01110000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h7A: begin // Char: 'LATIN SMALL LETTER Z'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11111110;
                4'd6: font_data = 8'b10001100;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00110000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b11000010;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h7B: begin // Char: 'LEFT CURLY BRACKET'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00001110;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b01110000;
                4'd7: font_data = 8'b01110000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00001110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h7C: begin // Char: 'VERTICAL LINE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h7D: begin // Char: 'RIGHT CURLY BRACKET'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01110000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011110;
                4'd7: font_data = 8'b00011110;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b01110000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h7E: begin // Char: 'TILDE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b01110110;
                4'd4: font_data = 8'b11011100;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h7F: begin // Char: 'UNKNOWN_CHAR_127'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00010000;
                4'd6: font_data = 8'b00111000;
                4'd7: font_data = 8'b01101100;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11111110;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h80: begin // Char: 'LATIN CAPITAL LETTER C WITH CEDILLA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b11000010;
                4'd5: font_data = 8'b11000000;
                4'd6: font_data = 8'b11000000;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b11000000;
                4'd9: font_data = 8'b11000010;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000110;
                4'd13: font_data = 8'b00000110;
                4'd14: font_data = 8'b01111100;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h81: begin // Char: 'LATIN SMALL LETTER U WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11001100;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h82: begin // Char: 'LATIN SMALL LETTER E WITH ACUTE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00001100;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h83: begin // Char: 'LATIN SMALL LETTER A WITH CIRCUMFLEX'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00110000;
                4'd2: font_data = 8'b01111000;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111000;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h84: begin // Char: 'LATIN SMALL LETTER A WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11001100;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111000;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h85: begin // Char: 'LATIN SMALL LETTER A WITH GRAVE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01100000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111000;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h86: begin // Char: 'LATIN SMALL LETTER A WITH RING ABOVE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00111000;
                4'd2: font_data = 8'b01101100;
                4'd3: font_data = 8'b00111000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111000;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h87: begin // Char: 'LATIN SMALL LETTER C WITH CEDILLA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b11000000;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111110;
                4'd12: font_data = 8'b00001100;
                4'd13: font_data = 8'b00000110;
                4'd14: font_data = 8'b00111100;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h88: begin // Char: 'LATIN SMALL LETTER E WITH CIRCUMFLEX'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00110000;
                4'd2: font_data = 8'b01111000;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h89: begin // Char: 'LATIN SMALL LETTER E WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11001100;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h8A: begin // Char: 'LATIN SMALL LETTER E WITH GRAVE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01100000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h8B: begin // Char: 'LATIN SMALL LETTER I WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01100110;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00111000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h8C: begin // Char: 'LATIN SMALL LETTER I WITH CIRCUMFLEX'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00010000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00111000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h8D: begin // Char: 'LATIN SMALL LETTER I WITH GRAVE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01100000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00111000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h8E: begin // Char: 'LATIN CAPITAL LETTER A WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b11000110;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00010000;
                4'd3: font_data = 8'b00111000;
                4'd4: font_data = 8'b01111100;
                4'd5: font_data = 8'b11101110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h8F: begin // Char: 'LATIN CAPITAL LETTER A WITH RING ABOVE'
            unique case (row)
                4'd0: font_data = 8'b00111000;
                4'd1: font_data = 8'b01101100;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00111000;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11111110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h90: begin // Char: 'LATIN CAPITAL LETTER E WITH ACUTE'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00110000;
                4'd2: font_data = 8'b01100000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b11111110;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100000;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h91: begin // Char: 'LATIN SMALL LETTER AE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b01110110;
                4'd7: font_data = 8'b00110110;
                4'd8: font_data = 8'b01111110;
                4'd9: font_data = 8'b11011000;
                4'd10: font_data = 8'b11011000;
                4'd11: font_data = 8'b01101110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h92: begin // Char: 'LATIN CAPITAL LETTER AE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111110;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b11001100;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b11001110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h93: begin // Char: 'LATIN SMALL LETTER O WITH CIRCUMFLEX'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00010000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h94: begin // Char: 'LATIN SMALL LETTER O WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h95: begin // Char: 'LATIN SMALL LETTER O WITH GRAVE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01100000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h96: begin // Char: 'LATIN SMALL LETTER U WITH CIRCUMFLEX'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00110000;
                4'd2: font_data = 8'b01111000;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h97: begin // Char: 'LATIN SMALL LETTER U WITH GRAVE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01100000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h98: begin // Char: 'LATIN SMALL LETTER Y WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111110;
                4'd12: font_data = 8'b00001100;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b01110000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h99: begin // Char: 'LATIN CAPITAL LETTER O WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b11000110;
                4'd1: font_data = 8'b11000110;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b01111100;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h9A: begin // Char: 'LATIN CAPITAL LETTER U WITH DIAERESIS'
            unique case (row)
                4'd0: font_data = 8'b11000110;
                4'd1: font_data = 8'b11000110;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h9B: begin // Char: 'CENT SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00110000;
                4'd5: font_data = 8'b01111000;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b11000000;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00110000;
                4'd13: font_data = 8'b00110000;
                4'd14: font_data = 8'b00110000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h9C: begin // Char: 'POUND SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b01100100;
                4'd5: font_data = 8'b11110000;
                4'd6: font_data = 8'b01100000;
                4'd7: font_data = 8'b01100000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b11111010;
                4'd11: font_data = 8'b11001110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h9D: begin // Char: 'YEN SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01000010;
                4'd3: font_data = 8'b01100110;
                4'd4: font_data = 8'b00111100;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b01111110;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b01111110;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h9E: begin // Char: 'PESETA SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11110000;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b11001100;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b11110000;
                4'd7: font_data = 8'b11000100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11011110;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'h9F: begin // Char: 'LATIN SMALL LETTER F WITH HOOK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00001110;
                4'd4: font_data = 8'b00011011;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b01111110;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b11011000;
                4'd14: font_data = 8'b01110000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA0: begin // Char: 'LATIN SMALL LETTER A WITH ACUTE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111000;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA1: begin // Char: 'LATIN SMALL LETTER I WITH ACUTE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00001100;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00111000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA2: begin // Char: 'LATIN SMALL LETTER O WITH ACUTE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA3: begin // Char: 'LATIN SMALL LETTER U WITH ACUTE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b01100000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA4: begin // Char: 'LATIN SMALL LETTER N WITH TILDE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01110110;
                4'd2: font_data = 8'b11011100;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11011100;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b01100110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA5: begin // Char: 'LATIN CAPITAL LETTER N WITH TILDE'
            unique case (row)
                4'd0: font_data = 8'b01110110;
                4'd1: font_data = 8'b11011100;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11100110;
                4'd6: font_data = 8'b11110110;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b11011110;
                4'd9: font_data = 8'b11001110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA6: begin // Char: 'FEMININE ORDINAL INDICATOR'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111100;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b01101100;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b00111110;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b01111110;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA7: begin // Char: 'MASCULINE ORDINAL INDICATOR'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b01101100;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b00111000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b01111100;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA8: begin // Char: 'INVERTED QUESTION MARK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00110000;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b01100000;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hA9: begin // Char: 'REVERSED NOT SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b11111110;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b11000000;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hAA: begin // Char: 'NOT SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b11111110;
                4'd7: font_data = 8'b00000110;
                4'd8: font_data = 8'b00000110;
                4'd9: font_data = 8'b00000110;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hAB: begin // Char: 'VULGAR FRACTION ONE HALF'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b11000010;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b11011000;
                4'd5: font_data = 8'b00110000;
                4'd6: font_data = 8'b01100000;
                4'd7: font_data = 8'b11011100;
                4'd8: font_data = 8'b10100110;
                4'd9: font_data = 8'b00001100;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00110000;
                4'd12: font_data = 8'b01111110;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hAC: begin // Char: 'VULGAR FRACTION ONE QUARTER'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b11000010;
                4'd2: font_data = 8'b11000110;
                4'd3: font_data = 8'b11001100;
                4'd4: font_data = 8'b11011000;
                4'd5: font_data = 8'b00110000;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b11001110;
                4'd8: font_data = 8'b10010110;
                4'd9: font_data = 8'b00100110;
                4'd10: font_data = 8'b01111110;
                4'd11: font_data = 8'b00000110;
                4'd12: font_data = 8'b00000110;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hAD: begin // Char: 'INVERTED EXCLAMATION MARK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00111100;
                4'd9: font_data = 8'b00111100;
                4'd10: font_data = 8'b00111100;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hAE: begin // Char: 'LEFT-POINTING DOUBLE ANGLE QUOTATION MARK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b11011000;
                4'd7: font_data = 8'b01101100;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hAF: begin // Char: 'RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b11011000;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b00110110;
                4'd7: font_data = 8'b01101100;
                4'd8: font_data = 8'b11011000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB0: begin // Char: 'LIGHT SHADE'
            unique case (row)
                4'd0: font_data = 8'b01000100;
                4'd1: font_data = 8'b00010001;
                4'd2: font_data = 8'b01000100;
                4'd3: font_data = 8'b00010001;
                4'd4: font_data = 8'b01000100;
                4'd5: font_data = 8'b00010001;
                4'd6: font_data = 8'b01000100;
                4'd7: font_data = 8'b00010001;
                4'd8: font_data = 8'b01000100;
                4'd9: font_data = 8'b00010001;
                4'd10: font_data = 8'b01000100;
                4'd11: font_data = 8'b00010001;
                4'd12: font_data = 8'b01000100;
                4'd13: font_data = 8'b00010001;
                4'd14: font_data = 8'b01000100;
                4'd15: font_data = 8'b00010001;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB1: begin // Char: 'MEDIUM SHADE'
            unique case (row)
                4'd0: font_data = 8'b10101010;
                4'd1: font_data = 8'b01010101;
                4'd2: font_data = 8'b10101010;
                4'd3: font_data = 8'b01010101;
                4'd4: font_data = 8'b10101010;
                4'd5: font_data = 8'b01010101;
                4'd6: font_data = 8'b10101010;
                4'd7: font_data = 8'b01010101;
                4'd8: font_data = 8'b10101010;
                4'd9: font_data = 8'b01010101;
                4'd10: font_data = 8'b10101010;
                4'd11: font_data = 8'b01010101;
                4'd12: font_data = 8'b10101010;
                4'd13: font_data = 8'b01010101;
                4'd14: font_data = 8'b10101010;
                4'd15: font_data = 8'b01010101;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB2: begin // Char: 'DARK SHADE'
            unique case (row)
                4'd0: font_data = 8'b01110111;
                4'd1: font_data = 8'b11011101;
                4'd2: font_data = 8'b01110111;
                4'd3: font_data = 8'b11011101;
                4'd4: font_data = 8'b01110111;
                4'd5: font_data = 8'b11011101;
                4'd6: font_data = 8'b01110111;
                4'd7: font_data = 8'b11011101;
                4'd8: font_data = 8'b01110111;
                4'd9: font_data = 8'b11011101;
                4'd10: font_data = 8'b01110111;
                4'd11: font_data = 8'b11011101;
                4'd12: font_data = 8'b01110111;
                4'd13: font_data = 8'b11011101;
                4'd14: font_data = 8'b01110111;
                4'd15: font_data = 8'b11011101;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB3: begin // Char: 'BOX DRAWINGS LIGHT VERTICAL'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB4: begin // Char: 'BOX DRAWINGS LIGHT VERTICAL AND LEFT'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b11111000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB5: begin // Char: 'BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b11111000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b11111000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB6: begin // Char: 'BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110110;
                4'd6: font_data = 8'b00110110;
                4'd7: font_data = 8'b11110110;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB7: begin // Char: 'BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB8: begin // Char: 'BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11111000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b11111000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hB9: begin // Char: 'BOX DRAWINGS DOUBLE VERTICAL AND LEFT'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b11110110;
                4'd6: font_data = 8'b00000110;
                4'd7: font_data = 8'b11110110;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hBA: begin // Char: 'BOX DRAWINGS DOUBLE VERTICAL'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110110;
                4'd6: font_data = 8'b00110110;
                4'd7: font_data = 8'b00110110;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hBB: begin // Char: 'BOX DRAWINGS DOUBLE DOWN AND LEFT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11111110;
                4'd6: font_data = 8'b00000110;
                4'd7: font_data = 8'b11110110;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hBC: begin // Char: 'BOX DRAWINGS DOUBLE UP AND LEFT'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b11110110;
                4'd6: font_data = 8'b00000110;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hBD: begin // Char: 'BOX DRAWINGS UP DOUBLE AND LEFT SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110110;
                4'd6: font_data = 8'b00110110;
                4'd7: font_data = 8'b11111110;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hBE: begin // Char: 'BOX DRAWINGS UP SINGLE AND LEFT DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b11111000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b11111000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hBF: begin // Char: 'BOX DRAWINGS LIGHT DOWN AND LEFT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC0: begin // Char: 'BOX DRAWINGS LIGHT UP AND RIGHT'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC1: begin // Char: 'BOX DRAWINGS LIGHT UP AND HORIZONTAL'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC2: begin // Char: 'BOX DRAWINGS LIGHT DOWN AND HORIZONTAL'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC3: begin // Char: 'BOX DRAWINGS LIGHT VERTICAL AND RIGHT'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011111;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC4: begin // Char: 'BOX DRAWINGS LIGHT HORIZONTAL'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC5: begin // Char: 'BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC6: begin // Char: 'BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011111;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011111;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC7: begin // Char: 'BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110110;
                4'd6: font_data = 8'b00110110;
                4'd7: font_data = 8'b00110111;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC8: begin // Char: 'BOX DRAWINGS DOUBLE UP AND RIGHT'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110111;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00111111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hC9: begin // Char: 'BOX DRAWINGS DOUBLE DOWN AND RIGHT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00111111;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00110111;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hCA: begin // Char: 'BOX DRAWINGS DOUBLE UP AND HORIZONTAL'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b11110111;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hCB: begin // Char: 'BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11110111;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hCC: begin // Char: 'BOX DRAWINGS DOUBLE VERTICAL AND RIGHT'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110111;
                4'd6: font_data = 8'b00110000;
                4'd7: font_data = 8'b00110111;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hCD: begin // Char: 'BOX DRAWINGS DOUBLE HORIZONTAL'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hCE: begin // Char: 'BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b11110111;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11110111;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hCF: begin // Char: 'BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD0: begin // Char: 'BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110110;
                4'd6: font_data = 8'b00110110;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD1: begin // Char: 'BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD2: begin // Char: 'BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD3: begin // Char: 'BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110110;
                4'd6: font_data = 8'b00110110;
                4'd7: font_data = 8'b00111111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD4: begin // Char: 'BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011111;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011111;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD5: begin // Char: 'BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00011111;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011111;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD6: begin // Char: 'BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00111111;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD7: begin // Char: 'BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE'
            unique case (row)
                4'd0: font_data = 8'b00110110;
                4'd1: font_data = 8'b00110110;
                4'd2: font_data = 8'b00110110;
                4'd3: font_data = 8'b00110110;
                4'd4: font_data = 8'b00110110;
                4'd5: font_data = 8'b00110110;
                4'd6: font_data = 8'b00110110;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00110110;
                4'd9: font_data = 8'b00110110;
                4'd10: font_data = 8'b00110110;
                4'd11: font_data = 8'b00110110;
                4'd12: font_data = 8'b00110110;
                4'd13: font_data = 8'b00110110;
                4'd14: font_data = 8'b00110110;
                4'd15: font_data = 8'b00110110;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD8: begin // Char: 'BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hD9: begin // Char: 'BOX DRAWINGS LIGHT UP AND LEFT'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b11111000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hDA: begin // Char: 'BOX DRAWINGS LIGHT DOWN AND RIGHT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00011111;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hDB: begin // Char: 'FULL BLOCK'
            unique case (row)
                4'd0: font_data = 8'b11111111;
                4'd1: font_data = 8'b11111111;
                4'd2: font_data = 8'b11111111;
                4'd3: font_data = 8'b11111111;
                4'd4: font_data = 8'b11111111;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b11111111;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b11111111;
                4'd9: font_data = 8'b11111111;
                4'd10: font_data = 8'b11111111;
                4'd11: font_data = 8'b11111111;
                4'd12: font_data = 8'b11111111;
                4'd13: font_data = 8'b11111111;
                4'd14: font_data = 8'b11111111;
                4'd15: font_data = 8'b11111111;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hDC: begin // Char: 'LOWER HALF BLOCK'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b11111111;
                4'd8: font_data = 8'b11111111;
                4'd9: font_data = 8'b11111111;
                4'd10: font_data = 8'b11111111;
                4'd11: font_data = 8'b11111111;
                4'd12: font_data = 8'b11111111;
                4'd13: font_data = 8'b11111111;
                4'd14: font_data = 8'b11111111;
                4'd15: font_data = 8'b11111111;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hDD: begin // Char: 'LEFT HALF BLOCK'
            unique case (row)
                4'd0: font_data = 8'b11110000;
                4'd1: font_data = 8'b11110000;
                4'd2: font_data = 8'b11110000;
                4'd3: font_data = 8'b11110000;
                4'd4: font_data = 8'b11110000;
                4'd5: font_data = 8'b11110000;
                4'd6: font_data = 8'b11110000;
                4'd7: font_data = 8'b11110000;
                4'd8: font_data = 8'b11110000;
                4'd9: font_data = 8'b11110000;
                4'd10: font_data = 8'b11110000;
                4'd11: font_data = 8'b11110000;
                4'd12: font_data = 8'b11110000;
                4'd13: font_data = 8'b11110000;
                4'd14: font_data = 8'b11110000;
                4'd15: font_data = 8'b11110000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hDE: begin // Char: 'RIGHT HALF BLOCK'
            unique case (row)
                4'd0: font_data = 8'b00001111;
                4'd1: font_data = 8'b00001111;
                4'd2: font_data = 8'b00001111;
                4'd3: font_data = 8'b00001111;
                4'd4: font_data = 8'b00001111;
                4'd5: font_data = 8'b00001111;
                4'd6: font_data = 8'b00001111;
                4'd7: font_data = 8'b00001111;
                4'd8: font_data = 8'b00001111;
                4'd9: font_data = 8'b00001111;
                4'd10: font_data = 8'b00001111;
                4'd11: font_data = 8'b00001111;
                4'd12: font_data = 8'b00001111;
                4'd13: font_data = 8'b00001111;
                4'd14: font_data = 8'b00001111;
                4'd15: font_data = 8'b00001111;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hDF: begin // Char: 'UPPER HALF BLOCK'
            unique case (row)
                4'd0: font_data = 8'b11111111;
                4'd1: font_data = 8'b11111111;
                4'd2: font_data = 8'b11111111;
                4'd3: font_data = 8'b11111111;
                4'd4: font_data = 8'b11111111;
                4'd5: font_data = 8'b11111111;
                4'd6: font_data = 8'b11111111;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE0: begin // Char: 'GREEK SMALL LETTER ALPHA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01110110;
                4'd6: font_data = 8'b11011100;
                4'd7: font_data = 8'b11011000;
                4'd8: font_data = 8'b11011000;
                4'd9: font_data = 8'b11011000;
                4'd10: font_data = 8'b11011100;
                4'd11: font_data = 8'b01110110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE1: begin // Char: 'LATIN SMALL LETTER SHARP S'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b01111100;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11111100;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11111100;
                4'd12: font_data = 8'b11000000;
                4'd13: font_data = 8'b11000000;
                4'd14: font_data = 8'b01000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE2: begin // Char: 'GREEK CAPITAL LETTER GAMMA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000000;
                4'd6: font_data = 8'b11000000;
                4'd7: font_data = 8'b11000000;
                4'd8: font_data = 8'b11000000;
                4'd9: font_data = 8'b11000000;
                4'd10: font_data = 8'b11000000;
                4'd11: font_data = 8'b11000000;
                4'd12: font_data = 8'b11000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE3: begin // Char: 'GREEK SMALL LETTER PI'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11111110;
                4'd6: font_data = 8'b01101100;
                4'd7: font_data = 8'b01101100;
                4'd8: font_data = 8'b01101100;
                4'd9: font_data = 8'b01101100;
                4'd10: font_data = 8'b01101100;
                4'd11: font_data = 8'b01101100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE4: begin // Char: 'GREEK CAPITAL LETTER SIGMA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b11111110;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b01100000;
                4'd5: font_data = 8'b00110000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00110000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE5: begin // Char: 'GREEK SMALL LETTER SIGMA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111110;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE6: begin // Char: 'MICRO SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01100110;
                4'd6: font_data = 8'b01100110;
                4'd7: font_data = 8'b01100110;
                4'd8: font_data = 8'b01100110;
                4'd9: font_data = 8'b01100110;
                4'd10: font_data = 8'b01100110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b01100000;
                4'd13: font_data = 8'b01100000;
                4'd14: font_data = 8'b11000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE7: begin // Char: 'GREEK SMALL LETTER TAU'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01110110;
                4'd6: font_data = 8'b11011100;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE8: begin // Char: 'GREEK CAPITAL LETTER PHI'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b01111000;
                4'd2: font_data = 8'b00110000;
                4'd3: font_data = 8'b01111000;
                4'd4: font_data = 8'b11001100;
                4'd5: font_data = 8'b11001100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b01111000;
                4'd10: font_data = 8'b00110000;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hE9: begin // Char: 'GREEK CAPITAL LETTER THETA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111100;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11111110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hEA: begin // Char: 'GREEK CAPITAL LETTER OMEGA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01111100;
                4'd3: font_data = 8'b11000110;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b01000100;
                4'd10: font_data = 8'b01101100;
                4'd11: font_data = 8'b11101110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hEB: begin // Char: 'GREEK SMALL LETTER DELTA'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00111100;
                4'd2: font_data = 8'b01100000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11001100;
                4'd7: font_data = 8'b11001100;
                4'd8: font_data = 8'b11001100;
                4'd9: font_data = 8'b11001100;
                4'd10: font_data = 8'b11001100;
                4'd11: font_data = 8'b01111000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hEC: begin // Char: 'INFINITY'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01111110;
                4'd6: font_data = 8'b11011011;
                4'd7: font_data = 8'b11011011;
                4'd8: font_data = 8'b11011011;
                4'd9: font_data = 8'b01111110;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hED: begin // Char: 'GREEK SMALL LETTER PHI'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000010;
                4'd4: font_data = 8'b00000110;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b11001110;
                4'd7: font_data = 8'b11010110;
                4'd8: font_data = 8'b11010110;
                4'd9: font_data = 8'b11010110;
                4'd10: font_data = 8'b11100110;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b11000000;
                4'd13: font_data = 8'b10000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hEE: begin // Char: 'GREEK SMALL LETTER EPSILON'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00011100;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00110000;
                4'd5: font_data = 8'b01100000;
                4'd6: font_data = 8'b01111100;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b01100000;
                4'd9: font_data = 8'b00110000;
                4'd10: font_data = 8'b00110000;
                4'd11: font_data = 8'b00011100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hEF: begin // Char: 'INTERSECTION'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b01111100;
                4'd4: font_data = 8'b11000110;
                4'd5: font_data = 8'b11000110;
                4'd6: font_data = 8'b11000110;
                4'd7: font_data = 8'b11000110;
                4'd8: font_data = 8'b11000110;
                4'd9: font_data = 8'b11000110;
                4'd10: font_data = 8'b11000110;
                4'd11: font_data = 8'b11000110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF0: begin // Char: 'IDENTICAL TO'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b11111110;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b11111110;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b11111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF1: begin // Char: 'PLUS-MINUS SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b01111110;
                4'd7: font_data = 8'b01111110;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b01111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF2: begin // Char: 'GREATER-THAN OR EQUAL TO'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b01100000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00110000;
                4'd9: font_data = 8'b01100000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b01111110;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF3: begin // Char: 'LESS-THAN OR EQUAL TO'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00001100;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00110000;
                4'd5: font_data = 8'b01100000;
                4'd6: font_data = 8'b01100000;
                4'd7: font_data = 8'b00110000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00001100;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b01111100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF4: begin // Char: 'TOP HALF INTEGRAL'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00001110;
                4'd3: font_data = 8'b00011011;
                4'd4: font_data = 8'b00011011;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00011000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00011000;
                4'd13: font_data = 8'b00011000;
                4'd14: font_data = 8'b00011000;
                4'd15: font_data = 8'b00011000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF5: begin // Char: 'BOTTOM HALF INTEGRAL'
            unique case (row)
                4'd0: font_data = 8'b00011000;
                4'd1: font_data = 8'b00011000;
                4'd2: font_data = 8'b00011000;
                4'd3: font_data = 8'b00011000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00011000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b11011000;
                4'd10: font_data = 8'b11111000;
                4'd11: font_data = 8'b01110000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF6: begin // Char: 'DIVISION SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00011000;
                4'd5: font_data = 8'b00011000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b01111110;
                4'd8: font_data = 8'b01111110;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00011000;
                4'd11: font_data = 8'b00011000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF7: begin // Char: 'ALMOST EQUAL TO'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b01110110;
                4'd6: font_data = 8'b11011100;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b01110110;
                4'd9: font_data = 8'b11011100;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF8: begin // Char: 'DEGREE SIGN'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00111000;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b01101100;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b00111000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hF9: begin // Char: 'BULLET OPERATOR'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00011000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hFA: begin // Char: 'MIDDLE DOT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00011000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hFB: begin // Char: 'SQUARE ROOT'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00001111;
                4'd3: font_data = 8'b00001100;
                4'd4: font_data = 8'b00001100;
                4'd5: font_data = 8'b00001100;
                4'd6: font_data = 8'b00001100;
                4'd7: font_data = 8'b00001100;
                4'd8: font_data = 8'b11101100;
                4'd9: font_data = 8'b01101100;
                4'd10: font_data = 8'b00111100;
                4'd11: font_data = 8'b00011100;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hFC: begin // Char: 'SUPERSCRIPT LATIN SMALL LETTER N'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b11011000;
                4'd2: font_data = 8'b01101100;
                4'd3: font_data = 8'b01101100;
                4'd4: font_data = 8'b01101100;
                4'd5: font_data = 8'b01101100;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hFD: begin // Char: 'SUPERSCRIPT TWO'
            unique case (row)
                4'd0: font_data = 8'b01110000;
                4'd1: font_data = 8'b11001000;
                4'd2: font_data = 8'b10011000;
                4'd3: font_data = 8'b00110000;
                4'd4: font_data = 8'b01100000;
                4'd5: font_data = 8'b11001000;
                4'd6: font_data = 8'b11111000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hFE: begin // Char: 'BLACK SQUARE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b01111100;
                4'd4: font_data = 8'b01111100;
                4'd5: font_data = 8'b01111100;
                4'd6: font_data = 8'b01111100;
                4'd7: font_data = 8'b01111100;
                4'd8: font_data = 8'b01111100;
                4'd9: font_data = 8'b01111100;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        8'hFF: begin // Char: 'NO-BREAK SPACE'
            unique case (row)
                4'd0: font_data = 8'b00000000;
                4'd1: font_data = 8'b00000000;
                4'd2: font_data = 8'b00000000;
                4'd3: font_data = 8'b00000000;
                4'd4: font_data = 8'b00000000;
                4'd5: font_data = 8'b00000000;
                4'd6: font_data = 8'b00000000;
                4'd7: font_data = 8'b00000000;
                4'd8: font_data = 8'b00000000;
                4'd9: font_data = 8'b00000000;
                4'd10: font_data = 8'b00000000;
                4'd11: font_data = 8'b00000000;
                4'd12: font_data = 8'b00000000;
                4'd13: font_data = 8'b00000000;
                4'd14: font_data = 8'b00000000;
                4'd15: font_data = 8'b00000000;
                default: font_data = 8'b00000000;
            endcase
        end

        default: font_data = 8'b00000000;
    endcase
end

endmodule
