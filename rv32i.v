`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2025 17:54:44
// Design Name: 
// Module Name: rv32i
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


module rv32i(
    input clk, reset,
    output zero
    );
    
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;
    wire less, MemWrite, ALU_src, PC_src, RegWrite, u;
    wire [2:0] Immsrc;
    wire [1:0] Ressrc, st_src, ld_src, target_sel;
    wire [3:0] alu_ctrl;
    
    control_unit ctrl_unit(opcode, funct3, funct7, zero, less, MemWrite, ALU_src, PC_src, RegWrite, u, Immsrc, Ressrc, st_src, ld_src, target_sel, alu_ctrl);
    
    Datapath datapath(PC_src, MemWrite, ALU_src, RegWrite, clk, reset, u, Immsrc, Ressrc, st_src, ld_src, target_sel, alu_ctrl, opcode, funct7, funct3, zero, less);
    
endmodule
