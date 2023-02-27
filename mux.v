`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2022 16:55:37
// Design Name: 
// Module Name: mux
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


module mux(
    input val,
    input [3:0] sel,
    output reg [15:0] lines
    );

always@(sel,val)
begin
    case(sel)
        4'b0000 : lines <= {15'bZZZZZZZZZZZZZZZ,val};
        4'b0001 : lines <= {14'bZZZZZZZZZZZZZZ,val,1'bZ};
        4'b0010 : lines <= {13'bZZZZZZZZZZZZZ,val,2'bZZ};
        4'b0011 : lines <= {12'bZZZZZZZZZZZZ,val,3'bZZZ};
        4'b0100 : lines <= {11'bZZZZZZZZZZZ,val,4'bZZZZ};
        4'b0101 : lines <= {10'bZZZZZZZZZZ,val,5'bZZZZZ};
        4'b0110 : lines <= {9'bZZZZZZZZZ,val,6'bZZZZZZ};
        4'b0111 : lines <= {8'bZZZZZZZZ,val,7'bZZZZZZZ};
        4'b1000 : lines <= {7'bZZZZZZZ,val,8'bZZZZZZZZ};
        4'b1001 : lines <= {6'bZZZZZZ,val,9'bZZZZZZZZZ};
        4'b1010 : lines <= {5'bZZZZZ,val,10'bZZZZZZZZZZ};
        4'b1011 : lines <= {4'bZZZZ,val,11'bZZZZZZZZZZZ};
        default : lines <= {val,15'bZZZZZZZZZZZZZZZ};
    endcase
end
endmodule
