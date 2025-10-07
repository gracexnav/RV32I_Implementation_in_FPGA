`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2025 21:29:01
// Design Name: 
// Module Name: imem
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


module imem(
    input [31:0] a,
    input reset,
    output [31:0] instr
    );
    
    reg [31:0] RAM[63:0];
    integer i;
    
    always @(posedge reset)
    begin
    for(i = 0; i < 64; i = i + 1) begin
        RAM[i] <= 0;
    end
    RAM[0] <= 'h00000093;
    RAM[1] <= 'h00100113;
    RAM[2] <= 'h00700513;
    RAM[3] <= 'h00a05c63;
    RAM[4] <= 'h002081b3;
    RAM[5] <= 'h00010093;
    RAM[6] <= 'h00018113;
    RAM[7] <= 'hfff50513;
    RAM[8] <= 'hfedff06f;
    RAM[9] <= 'h00008513;
    end
    
    assign instr = RAM[a[31:2]];
    
endmodule
