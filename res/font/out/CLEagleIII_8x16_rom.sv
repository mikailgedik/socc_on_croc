module font_rom (
    input logic [7:0] char_code, // CP437 character code
    input logic [3:0] row,       // Row index (0-15)
    output logic [7:0] font_data  // Font data
);

always_comb begin
    font_data = 8'b00000000;

    unique case (char_code)

        8'h00: begin // Name: 'Null'
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

        8'h01: begin // Name: 'White Smiling Face'
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

        8'h02: begin // Name: 'Black Smiling Face'
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

        8'h03: begin // Name: 'Black Heart Suit'
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

        8'h04: begin // Name: 'Black Diamond Suit'
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

        8'h05: begin // Name: 'Black Club Suit'
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

        8'h06: begin // Name: 'Black Spade Suit'
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

        8'h07: begin // Name: 'Bullet'
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

        8'h08: begin // Name: 'Inverse Bullet'
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

        8'h09: begin // Name: 'White Circle'
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

        8'h0A: begin // Name: 'Inverse White Circle'
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

        8'h0B: begin // Name: 'Male Sign'
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

        8'h0C: begin // Name: 'Female Sign'
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

        8'h0D: begin // Name: 'Eighth Note'
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

        8'h0E: begin // Name: 'Beamed Eighth Notes'
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

        8'h0F: begin // Name: 'Sun with Rays'
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

        8'h10: begin // Name: 'Right-Pointing Triangle'
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

        8'h11: begin // Name: 'Left-Pointing Triangle'
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

        8'h12: begin // Name: 'Up-Down Arrow'
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

        8'h13: begin // Name: 'Double Exclamation Mark'
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

        8'h14: begin // Name: 'Pilcrow Sign'
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

        8'h15: begin // Name: 'Section Sign'
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

        8'h16: begin // Name: 'Black Rectangle'
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

        8'h17: begin // Name: 'Up-Down Arrow with Base'
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

        8'h18: begin // Name: 'Upwards Arrow'
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

        8'h19: begin // Name: 'Downwards Arrow'
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

        8'h1A: begin // Name: 'Rightwards Arrow'
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

        8'h1B: begin // Name: 'Leftwards Arrow'
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

        8'h1C: begin // Name: 'Right Angle'
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

        8'h1D: begin // Name: 'Left Right Arrow'
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

        8'h1E: begin // Name: 'Upwards Triangle'
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

        8'h1F: begin // Name: 'Downwards Triangle'
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

        8'h20: begin // Name: 'Space'
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

        8'h21: begin // Name: 'Exclamation Mark'
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

        8'h22: begin // Name: 'Quotation Mark'
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

        8'h23: begin // Name: 'Number Sign'
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

        8'h24: begin // Name: 'Dollar Sign'
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

        8'h25: begin // Name: 'Percent Sign'
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

        8'h26: begin // Name: 'Ampersand'
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

        8'h27: begin // Name: 'Apostrophe'
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

        8'h28: begin // Name: 'Left Parenthesis'
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

        8'h29: begin // Name: 'Right Parenthesis'
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

        8'h2A: begin // Name: 'Asterisk'
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

        8'h2B: begin // Name: 'Plus Sign'
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

        8'h2C: begin // Name: 'Comma'
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

        8'h2D: begin // Name: 'Hyphen-Minus'
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

        8'h2E: begin // Name: 'Full Stop'
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

        8'h2F: begin // Name: 'Slash'
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

        8'h30: begin // Name: 'Digit Zero'
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

        8'h31: begin // Name: 'Digit One'
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

        8'h32: begin // Name: 'Digit Two'
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

        8'h33: begin // Name: 'Digit Three'
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

        8'h34: begin // Name: 'Digit Four'
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

        8'h35: begin // Name: 'Digit Five'
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

        8'h36: begin // Name: 'Digit Six'
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

        8'h37: begin // Name: 'Digit Seven'
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

        8'h38: begin // Name: 'Digit Eight'
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

        8'h39: begin // Name: 'Digit Nine'
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

        8'h3A: begin // Name: 'Colon'
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

        8'h3B: begin // Name: 'Semicolon'
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

        8'h3C: begin // Name: 'Less-Than Sign'
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

        8'h3D: begin // Name: 'Equals Sign'
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

        8'h3E: begin // Name: 'Greater-Than Sign'
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

        8'h3F: begin // Name: 'Question Mark'
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

        8'h40: begin // Name: 'At Sign'
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

        8'h41: begin // Name: 'Uppercase A'
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

        8'h42: begin // Name: 'Uppercase B'
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

        8'h43: begin // Name: 'Uppercase C'
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

        8'h44: begin // Name: 'Uppercase D'
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

        8'h45: begin // Name: 'Uppercase E'
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

        8'h46: begin // Name: 'Uppercase F'
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

        8'h47: begin // Name: 'Uppercase G'
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

        8'h48: begin // Name: 'Uppercase H'
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

        8'h49: begin // Name: 'Uppercase I'
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

        8'h4A: begin // Name: 'Uppercase J'
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

        8'h4B: begin // Name: 'Uppercase K'
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

        8'h4C: begin // Name: 'Uppercase L'
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

        8'h4D: begin // Name: 'Uppercase M'
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

        8'h4E: begin // Name: 'Uppercase N'
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

        8'h4F: begin // Name: 'Uppercase O'
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

        8'h50: begin // Name: 'Uppercase P'
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

        8'h51: begin // Name: 'Uppercase Q'
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

        8'h52: begin // Name: 'Uppercase R'
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

        8'h53: begin // Name: 'Uppercase S'
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

        8'h54: begin // Name: 'Uppercase T'
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

        8'h55: begin // Name: 'Uppercase U'
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

        8'h56: begin // Name: 'Uppercase V'
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

        8'h57: begin // Name: 'Uppercase W'
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

        8'h58: begin // Name: 'Uppercase X'
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

        8'h59: begin // Name: 'Uppercase Y'
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

        8'h5A: begin // Name: 'Uppercase Z'
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

        8'h5B: begin // Name: 'Left Square Bracket'
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

        8'h5C: begin // Name: 'Backslash'
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

        8'h5D: begin // Name: 'Right Square Bracket'
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

        8'h5E: begin // Name: 'Circumflex Accent'
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

        8'h5F: begin // Name: 'Underscore'
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

        8'h60: begin // Name: 'Grave Accent'
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

        8'h61: begin // Name: 'Lowercase a'
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

        8'h62: begin // Name: 'Lowercase b'
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

        8'h63: begin // Name: 'Lowercase c'
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

        8'h64: begin // Name: 'Lowercase d'
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

        8'h65: begin // Name: 'Lowercase e'
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

        8'h66: begin // Name: 'Lowercase f'
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

        8'h67: begin // Name: 'Lowercase g'
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

        8'h68: begin // Name: 'Lowercase h'
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

        8'h69: begin // Name: 'Lowercase i'
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

        8'h6A: begin // Name: 'Lowercase j'
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

        8'h6B: begin // Name: 'Lowercase k'
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

        8'h6C: begin // Name: 'Lowercase l'
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

        8'h6D: begin // Name: 'Lowercase m'
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

        8'h6E: begin // Name: 'Lowercase n'
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

        8'h6F: begin // Name: 'Lowercase o'
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

        8'h70: begin // Name: 'Lowercase p'
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

        8'h71: begin // Name: 'Lowercase q'
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

        8'h72: begin // Name: 'Lowercase r'
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

        8'h73: begin // Name: 'Lowercase s'
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

        8'h74: begin // Name: 'Lowercase t'
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

        8'h75: begin // Name: 'Lowercase u'
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

        8'h76: begin // Name: 'Lowercase v'
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

        8'h77: begin // Name: 'Lowercase w'
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

        8'h78: begin // Name: 'Lowercase x'
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

        8'h79: begin // Name: 'Lowercase y'
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

        8'h7A: begin // Name: 'Lowercase z'
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

        8'h7B: begin // Name: 'Left Curly Bracket'
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

        8'h7C: begin // Name: 'Vertical Line'
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

        8'h7D: begin // Name: 'Right Curly Bracket'
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

        8'h7E: begin // Name: 'Tilde'
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

        8'h7F: begin // Name: 'House'
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

        8'h80: begin // Name: 'Latin Capital C with Cedilla'
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

        8'h81: begin // Name: 'Latin Small U with Diaeresis'
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

        8'h82: begin // Name: 'Latin Small E with Acute'
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

        8'h83: begin // Name: 'Latin Small A with Circumflex'
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

        8'h84: begin // Name: 'Latin Small A with Diaeresis'
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

        8'h85: begin // Name: 'Latin Small A with Grave'
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

        8'h86: begin // Name: 'Latin Small A with Ring Above'
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

        8'h87: begin // Name: 'Latin Small C with Cedilla'
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

        8'h88: begin // Name: 'Latin Small E with Circumflex'
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

        8'h89: begin // Name: 'Latin Small E with Diaeresis'
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

        8'h8A: begin // Name: 'Latin Small E with Grave'
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

        8'h8B: begin // Name: 'Latin Small I with Diaeresis'
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

        8'h8C: begin // Name: 'Latin Small I with Circumflex'
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

        8'h8D: begin // Name: 'Latin Small I with Grave'
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

        8'h8E: begin // Name: 'Latin Capital A with Diaeresis'
            unique case (row)
                4'd0: font_data = 8'b11000110;
                4'd1: font_data = 8'b11000110;
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

        8'h8F: begin // Name: 'Latin Capital A with Ring Above'
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

        8'h90: begin // Name: 'Latin Capital E with Acute'
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

        8'h91: begin // Name: 'Latin Small Ash (ae)'
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

        8'h92: begin // Name: 'Latin Capital Ash (AE)'
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

        8'h93: begin // Name: 'Latin Small O with Circumflex'
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

        8'h94: begin // Name: 'Latin Small O with Diaeresis'
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

        8'h95: begin // Name: 'Latin Small O with Grave'
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

        8'h96: begin // Name: 'Latin Small U with Circumflex'
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

        8'h97: begin // Name: 'Latin Small U with Grave'
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

        8'h98: begin // Name: 'Latin Small Y with Diaeresis'
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

        8'h99: begin // Name: 'Latin Capital O with Diaeresis'
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

        8'h9A: begin // Name: 'Latin Capital U with Diaeresis'
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

        8'h9B: begin // Name: 'Cent Sign'
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

        8'h9C: begin // Name: 'Pound Sign'
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

        8'h9D: begin // Name: 'Yen Sign'
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

        8'h9E: begin // Name: 'Peseta Sign'
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

        8'h9F: begin // Name: 'Latin Small F with Hook / Florin'
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

        8'hA0: begin // Name: 'Latin Small A with Acute'
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

        8'hA1: begin // Name: 'Latin Small I with Acute'
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

        8'hA2: begin // Name: 'Latin Small O with Acute'
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

        8'hA3: begin // Name: 'Latin Small U with Acute'
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

        8'hA4: begin // Name: 'Latin Small N with Tilde'
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

        8'hA5: begin // Name: 'Latin Capital N with Tilde'
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

        8'hA6: begin // Name: 'Feminine Ordinal Indicator'
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

        8'hA7: begin // Name: 'Masculine Ordinal Indicator'
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

        8'hA8: begin // Name: 'Inverted Question Mark'
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

        8'hA9: begin // Name: 'Reversed Not Sign'
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

        8'hAA: begin // Name: 'Not Sign'
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

        8'hAB: begin // Name: 'Vulgar Fraction One Half'
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

        8'hAC: begin // Name: 'Vulgar Fraction One Quarter'
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

        8'hAD: begin // Name: 'Inverted Exclamation Mark'
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

        8'hAE: begin // Name: 'Left-Pointing Double Angle Quotation Mark'
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

        8'hAF: begin // Name: 'Right-Pointing Double Angle Quotation Mark'
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

        8'hB0: begin // Name: 'Light Shade'
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

        8'hB1: begin // Name: 'Medium Shade'
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

        8'hB2: begin // Name: 'Dark Shade'
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

        8'hB3: begin // Name: 'Box Drawings Light Vertical'
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

        8'hB4: begin // Name: 'Box Drawings Light Vertical and Left'
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

        8'hB5: begin // Name: 'Box Drawings Vertical Single and Left Double'
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

        8'hB6: begin // Name: 'Box Drawings Vertical Double and Left Single'
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

        8'hB7: begin // Name: 'Box Drawings Down Double and Left Single'
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

        8'hB8: begin // Name: 'Box Drawings Down Single and Left Double'
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

        8'hB9: begin // Name: 'Box Drawings Double Vertical and Left'
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

        8'hBA: begin // Name: 'Box Drawings Double Vertical'
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

        8'hBB: begin // Name: 'Box Drawings Double Down and Left'
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

        8'hBC: begin // Name: 'Box Drawings Double Up and Left'
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

        8'hBD: begin // Name: 'Box Drawings Up Double and Left Single'
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

        8'hBE: begin // Name: 'Box Drawings Up Single and Left Double'
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

        8'hBF: begin // Name: 'Box Drawings Light Down and Left'
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

        8'hC0: begin // Name: 'Box Drawings Light Up and Right'
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

        8'hC1: begin // Name: 'Box Drawings Light Up and Horizontal'
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

        8'hC2: begin // Name: 'Box Drawings Light Down and Horizontal'
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

        8'hC3: begin // Name: 'Box Drawings Light Vertical and Right'
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

        8'hC4: begin // Name: 'Box Drawings Light Horizontal'
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

        8'hC5: begin // Name: 'Box Drawings Light Vertical and Horizontal'
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

        8'hC6: begin // Name: 'Box Drawings Vertical Single and Right Double'
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

        8'hC7: begin // Name: 'Box Drawings Vertical Double and Right Single'
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

        8'hC8: begin // Name: 'Box Drawings Double Up and Right'
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

        8'hC9: begin // Name: 'Box Drawings Double Down and Right'
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

        8'hCA: begin // Name: 'Box Drawings Double Up and Horizontal'
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

        8'hCB: begin // Name: 'Box Drawings Double Down and Horizontal'
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

        8'hCC: begin // Name: 'Box Drawings Double Vertical and Right'
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

        8'hCD: begin // Name: 'Box Drawings Double Horizontal'
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

        8'hCE: begin // Name: 'Box Drawings Double Vertical and Horizontal'
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

        8'hCF: begin // Name: 'Box Drawings Up Single and Horizontal Double'
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

        8'hD0: begin // Name: 'Box Drawings Up Double and Horizontal Single'
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

        8'hD1: begin // Name: 'Box Drawings Down Single and Horizontal Double'
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

        8'hD2: begin // Name: 'Box Drawings Down Double and Horizontal Single'
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

        8'hD3: begin // Name: 'Box Drawings Up Double and Right Single'
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

        8'hD4: begin // Name: 'Box Drawings Up Single and Right Double'
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

        8'hD5: begin // Name: 'Box Drawings Down Single and Right Double'
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

        8'hD6: begin // Name: 'Box Drawings Down Double and Right Single'
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

        8'hD7: begin // Name: 'Box Drawings Vertical Double and Horizontal Single'
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

        8'hD8: begin // Name: 'Box Drawings Vertical Single and Horizontal Double'
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

        8'hD9: begin // Name: 'Box Drawings Light Up and Left'
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

        8'hDA: begin // Name: 'Box Drawings Light Down and Right'
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

        8'hDB: begin // Name: 'Full Block'
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

        8'hDC: begin // Name: 'Lower Half Block'
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

        8'hDD: begin // Name: 'Left Half Block'
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

        8'hDE: begin // Name: 'Right Half Block'
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

        8'hDF: begin // Name: 'Upper Half Block'
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

        8'hE0: begin // Name: 'Greek Small Alpha'
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

        8'hE1: begin // Name: 'Greek Small Beta / Latin Small Sharp S'
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

        8'hE2: begin // Name: 'Greek Capital Gamma'
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

        8'hE3: begin // Name: 'Greek Small Pi'
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

        8'hE4: begin // Name: 'Greek Capital Sigma'
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

        8'hE5: begin // Name: 'Greek Small Sigma'
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

        8'hE6: begin // Name: 'Micro Sign / Mu'
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

        8'hE7: begin // Name: 'Greek Small Tau'
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

        8'hE8: begin // Name: 'Greek Capital Phi'
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

        8'hE9: begin // Name: 'Greek Capital Theta'
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

        8'hEA: begin // Name: 'Greek Capital Omega'
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

        8'hEB: begin // Name: 'Greek Small Delta'
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

        8'hEC: begin // Name: 'Infinity'
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

        8'hED: begin // Name: 'Greek Small Phi'
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

        8'hEE: begin // Name: 'Greek Small Epsilon'
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

        8'hEF: begin // Name: 'Intersection'
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

        8'hF0: begin // Name: 'Identical To'
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

        8'hF1: begin // Name: 'Plus-Minus Sign'
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

        8'hF2: begin // Name: 'Greater-Than or Equal To'
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

        8'hF3: begin // Name: 'Less-Than or Equal To'
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

        8'hF4: begin // Name: 'Top Half Integral'
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

        8'hF5: begin // Name: 'Bottom Half Integral'
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

        8'hF6: begin // Name: 'Division Sign'
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

        8'hF7: begin // Name: 'Almost Equal To'
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

        8'hF8: begin // Name: 'Degree Sign'
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

        8'hF9: begin // Name: 'Bullet Operator'
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

        8'hFA: begin // Name: 'Middle Dot'
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

        8'hFB: begin // Name: 'Square Root'
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

        8'hFC: begin // Name: 'Superscript Latin Small N'
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

        8'hFD: begin // Name: 'Superscript Two'
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

        8'hFE: begin // Name: 'Black Square'
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

        8'hFF: begin // Name: 'Non-breaking Space'
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
