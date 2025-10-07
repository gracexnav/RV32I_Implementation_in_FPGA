`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2025 23:07:19
// Design Name: 
// Module Name: extend
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


module extend(
    input [31:7] instr,
    input [2:0] imm_sel,
    output [31:0] imm
    );
    
    wire [31:0] i, j, s, b, u, imm_4;
    
    assign i = {{20{instr[31]}}, instr[31:20]};
    assign s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    assign b = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    assign j = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
    assign u = {instr[31:12], 12'b0};
    
    mux4 sel(i, s, b, j, imm_sel[1:0], imm_4);
    
    assign imm = imm_sel[2]? u : imm_4;
    
    
endmodule
