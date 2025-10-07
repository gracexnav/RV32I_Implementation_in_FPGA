`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2025 22:04:44
// Design Name: 
// Module Name: dmem
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


module dmem(
    input clk, we,
    input [31:0] a, wd,
    output [31:0] rd
    );
    
    reg [31:0] RAM[63:0];
   
    assign rd = RAM[a[31:2]];
    
    always @(posedge clk)
    if (we) RAM[a[31:2]] <= wd;
    
endmodule
