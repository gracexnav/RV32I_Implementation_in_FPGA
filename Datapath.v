`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2025 21:42:14
// Design Name: 
// Module Name: Datapath
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


module Datapath(
    input PCsrc, MemWrite, ALU_src, RegWrite, clk, reset, u,
    input [2:0] Immsrc,
    input [1:0] Ressrc, st_src, ld_src, target_sel,
    input [3:0] alu_ctrl,
    output [6:0] opcode, funct7,
    output [2:0] funct3,
    output zero, less
    );
    
    wire [31:0] pc_next, pcPlus4, instr, PCTarget, wd, rd1, rd2, srcB, rd;
    wire [31:0] pc_current, imm, alu_result, wd_dmem, rd_res, added_part;
    
    PC pc(pc_next, clk, reset, pc_current);
    
    addr pc_plus_4(pc_current, 4, pcPlus4);
    
    mux4 pc_target_mux(rd1, pc_current, 0, 0, target_sel, added_part);
    
    addr pc_target(added_part, imm, PCTarget);
    
    mux2 PCNxt(pcPlus4, PCTarget, PCsrc, pc_next);
    
    imem Imem(pc_current, reset, instr);
    
    assign opcode = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];
    
    Reg_mem register(clk, RegWrite, reset, instr[19:15], instr[24:20], instr[11:7], wd, rd1, rd2);
    
    extend extend_unit(instr[31:7], Immsrc, imm);
    
    mux2 alu_src(rd2, imm, ALU_src, srcB);
    
    ALU alu(rd1, srcB, alu_ctrl, alu_result, zero, less);
    
    mux4 store_sel(rd2,{16'b0, rd2[15:0]}, {24'b0, rd2[7:0]}, rd2, st_src, wd_dmem);
    
    dmem data_mem(clk, MemWrite, alu_result, wd_dmem, rd);
    
    data_sign_extend load_sel(u, rd, ld_src, rd_res);
    
    mux4 res_sel(alu_result, rd_res, pcPlus4, PCTarget, Ressrc, wd);
    
endmodule
