`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2022 20:12:00
// Design Name: 
// Module Name: tb
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


module tb(
    
    );
    
reg rst,clk;
reg [15:0] d_in;
wire [15:0] d_out;

processor proc(
    .rst(rst), 
    .clk(clk),
    .data_in(d_in),
    .data_out(d_out)
    );
 
 
initial
begin
clk = 1'b0;

d_in = 16'b0000000001000000;
#35
//data1
d_in = 16'b0000000101010101;
#30
d_in = 16'b0000000000001000;
#70
d_in = 16'b0000000001000000;
#35
//data2
d_in = 16'b0000000000101010;
#30

d_in = 16'b0000000010000001;
#128

$stop();


end

always #4 clk = ~clk;

endmodule
