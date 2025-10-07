`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 22:28:21
// Design Name: 
// Module Name: data_sign_extend
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


module data_sign_extend(
    input u,
    input [31:0] rd,
    input [1:0] ld_src,
    output [31:0] rd_sign
    );
    
    wire [31:0] half, byte;
    
    assign half = u? {16'b0, rd[15:0]} : {{16{rd[15]}}, rd[15:0]};
    assign byte = u? {24'b0, rd[7:0]} : {{24{rd[7]}}, rd[7:0]};
    
    mux4 ld_sel(rd, half, byte, rd, ld_src, rd_sign);
    
endmodule
