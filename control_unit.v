`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2025 23:32:10
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input z, less,
    output reg MemWrite, ALUsrc, PCsrc, RegWrite, u,
    output reg [2:0] Immsrc,
    output reg [1:0] Ressrc, st_src, ld_src, target_sel,
    output reg [3:0] alu_ctrl
    );
    
    always @(*)
    begin
        case(opcode)
            7'b0110011: begin //R type instructions
                RegWrite = 1;
                ALUsrc = 1'b0;
                Ressrc = 2'b00;
                PCsrc = 0;
                MemWrite = 0;
                Immsrc = 'hx;
                target_sel = 'hx;
                case(funct3)
                    0: begin
                        if (funct7 == 'h00)
                        alu_ctrl = 4'b0000; //ADD
                        else if(funct7 == 'h20)
                        alu_ctrl = 4'b0001; //SUB
                    end
                    1: alu_ctrl = 4'b0101; //SLL
                    2: alu_ctrl = 4'b1000; //SLT
                    3: alu_ctrl = 4'b1001; //SLTU
                    4: alu_ctrl = 4'b0010; //XOR
                    5: begin
                        if (funct7 == 'h00)
                        alu_ctrl = 4'b0110; //SRL
                        else if (funct7 == 'h20)
                        alu_ctrl = 4'b0111; //SRA
                    end
                    6: alu_ctrl = 4'b0011; //OR
                    7: alu_ctrl = 4'b0100; //AND
               endcase
               end
           7'b0010011: begin //I type instructions
               RegWrite = 1;
               Immsrc = 3'b000;
               ALUsrc = 1'b1;
               Ressrc = 2'b00;
               PCsrc = 0;
               MemWrite = 0;
               target_sel = 'hx;
               case(funct3)
                   0: alu_ctrl = 4'b0000; //ADDI
                   1: alu_ctrl = 4'b0101; //SLLI
                   2: alu_ctrl = 4'b1000; //SLTI
                   3: alu_ctrl = 4'b1001; //SLTUI
                   4: alu_ctrl = 4'b0010; //XORI
                   5: begin
                       if(funct7 == 'h00)
                       alu_ctrl = 4'b0110; //SRLI
                       else if(funct7 == 'h20)
                       alu_ctrl = 4'b0111; //SRAI
                   end
                   6: alu_ctrl = 4'b0011; //ORI
                   7: alu_ctrl = 4'b0100; //ANDI
               endcase
           end
           
           7'b0000011: begin // Load instr
           RegWrite = 1;
           ALUsrc = 1'b1;
           Immsrc = 3'b000;
           alu_ctrl = 4'b0000;
           Ressrc = 2'b01;
           MemWrite = 0;
           PCsrc = 0;
           target_sel = 'hx;
           case(funct3)
           0: begin u = 0; ld_src = 2'b10; end
           1: begin u = 0; ld_src = 2'b01; end
           2: begin u = 0; ld_src = 2'b00; end
           4: begin u = 1; ld_src = 2'b10; end
           5: begin u = 1; ld_src = 2'b01; end
           endcase
           end
           
           7'b0100011: begin //S type
           Immsrc = 3'b001;
           ALUsrc = 1'b1;
           MemWrite = 1'b1;
           alu_ctrl = 4'b0000;
           Ressrc = 'hx;
           RegWrite = 0;
           PCsrc = 0;
           target_sel = 'hx;
           case(funct3)
               0: st_src = 2'b10;
               1: st_src = 2'b01;
               2: st_src = 2'b00;
           endcase
           end
           
           7'b1100011: begin //B type
           Immsrc = 3'b010;
           ALUsrc = 1'b0;
           alu_ctrl = 4'b0001;
           RegWrite = 0;
           MemWrite = 0;
           Ressrc = 'hx;
           target_sel = 2'b01;
           case(funct3)
           0: PCsrc = z? 1 : 0;
           1: PCsrc = (~z)? 1 : 0;
           4: begin alu_ctrl = 4'b1000; PCsrc = (less)? 1 : 0; end
           5: begin alu_ctrl = 4'b1000; PCsrc = (~less)? 1 : 0; end
           6: begin alu_ctrl = 4'b1001; PCsrc = (less) ? 1 : 0; end
           7: begin alu_ctrl = 4'b1001; PCsrc = (~less) ? 1 : 0; end
           endcase
           end
           
           7'b1101111: begin //j type
           RegWrite = 1;
           Immsrc = 3'b011;
           PCsrc = 1;
           Ressrc = 2'b10;
           MemWrite = 0;
           ALUsrc = 'hx;
           alu_ctrl = 'hx;
           target_sel = 2'b01;
           end
           
           7'b1100111: begin //jalr instr
           RegWrite = 1;
           Immsrc = 3'b000;
           PCsrc = 1;
           Ressrc = 2'b10;
           MemWrite = 0;
           ALUsrc = 'hx;
           alu_ctrl = 'hx;
           target_sel =  2'b00;
           end
           
           7'b0110111: begin //lui instr
           RegWrite = 1;
           Immsrc = 3'b100;
           PCsrc = 0;
           Ressrc = 2'b11;
           MemWrite = 0;
           ALUsrc = 'hx;
           alu_ctrl = 'hx;
           target_sel = 2'b10;
           end
           
           7'b0010111: begin //auipc instr
           RegWrite = 1;
           Immsrc = 3'b100;
           PCsrc = 0;
           Ressrc = 2'b11;
           MemWrite = 0;
           ALUsrc = 'hx;
           alu_ctrl = 'hx;
           target_sel = 2'b01;
           end
           
    endcase
    end
endmodule
