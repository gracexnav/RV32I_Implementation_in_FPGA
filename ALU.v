`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2025 22:36:06
// Design Name: 
// Module Name: ALU
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
/*
ALU Control lines | Function
-----------------------------
        0000    ADD
        0001    SUBTRACT
        0010	XOR
        0011	OR
        0100	AND
        0101    Shift left logical
        0110    Shift right logical
        0111    Shift right arithmetic
        1000    Set on less than
        1001    Set on less than (unsigned)
*/

module ALU(
    input [31:0] in1, in2, 
    input[3:0] alu_control,
    output reg [31:0] alu_result,
    output reg z, less
    );
    
    always @(*)
    begin
        // Operating based on control input
        case(alu_control)

        4'b0000: alu_result = in1+in2;
        4'b0001: alu_result = in1-in2;
        4'b0010: alu_result = in1^in2;
        4'b0011: alu_result = in1|in2;
        4'b1000: begin 
            if(in1<in2)
            alu_result = 1;
            else
            alu_result = 0;
        end
        4'b0101: alu_result = in1<<in2;
        4'b0110: alu_result = in1>>in2;
        4'b0100: alu_result = in1&in2;
        4'b0111: alu_result = in1>>>in2;
        4'b1001: begin 
            if($unsigned(in1) < $unsigned(in2))
            alu_result = 1;
            else
            alu_result = 0;
        end

        endcase

        // Setting Zero_flag if ALU_result is zero
        if (alu_result == 0)
            z = 1'b1;
        else
            z = 1'b0;
        if(alu_result)
            less = 1;
        else
            less = 0;
        
    end
    
endmodule
