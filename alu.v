`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2022 16:55:37
// Design Name: 
// Module Name: alu
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


module alu  #(parameter n = 16)(
    input en,
    input [n-1:0] a,b,
    input [2:0] op,
    output reg [n-1:0] out
    );

always@(a,b,op,en)
begin

if (en)
begin
    case(op)
        3'b010 : out <= a + b;
        3'b011 : out <= a - b;
        3'b100 : out <= a & b;
        3'b101 : out <= a | b;
        3'b110 : out <= a ^ b;
        3'b111 : out <= ~a;
        default : out <= 8'bZZZZZZZZ;
     endcase
end
end

endmodule
