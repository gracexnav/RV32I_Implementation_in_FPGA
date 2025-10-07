`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2025 20:43:47
// Design Name: 
// Module Name: Reg_mem
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


module Reg_mem(
    input clk, we, reset,
    input [4:0] a1, a2, a3,
    input [31:0] wd,
    output [31:0] rd1, rd2
    );
    
    reg [31:0] rf[31:0];
    integer i;
    
    assign rd1 = (a1 != 0)? rf[a1]:0;
    assign rd2 = (a2 != 0)? rf[a2]:0;
    
    
    always @(posedge clk) begin
    if (reset) begin
    for(i = 0; i < 32; i = i + 1) begin
        rf[i] <= 0;
    end
    end
    if (we) rf[a3] <= wd;
    end
endmodule
