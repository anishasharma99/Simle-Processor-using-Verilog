`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2022 20:48:18
// Design Name: 
// Module Name: tb_with_mem
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


module tb_with_mem(

    );

reg rst,clk = 1'b0;
wire [15:0] d_in, d_out;
reg [15:0] data;
wire [2:0] addrr;
wire valid; 
reg clr,ld, status,nxt;

processor proc(
    .data_valid(valid),
    .rst(rst), 
    .clk(clk),
    .data_in(d_in),
    .data_out(d_out),
    .pc_addr(addrr)
    );

memory_PC mem (
    .inp_data(data),
    .clear(clr), 
    .load(ld), 
    .nxt(nxt),
    .status_ok(status), 
    .clk(clk),
    .addr(addrr),
    .ready(valid),
    .data_out(d_in)
    );

always #4 clk = ~clk;

initial
begin
#100
//load data into memory
clr = 1'b1;
status = 1'b0;
#16
clr = 1'b0;
ld = 1'b1;
nxt = 1'b0;
rst = 1'b0;
#16

//mvi
nxt = 1'b1;
data = 16'b0000000001000000 ;
#32
nxt = 1'b0;
#32
//data1
nxt = 1'b1;
data = 16'b0101010101010101 ;
#3200
nxt = 1'b0;
#32
//mv
nxt = 1'b1;
data = 16'b0000000000001000 ;
#320
nxt = 1'b0;
#32
//mvi 
nxt = 1'b1;
data = 16'b0000000001000000 ;
#3200
nxt = 1'b0;
#32
//data2
nxt = 1'b1;
data = 16'b1010101010101010 ;
#320
nxt = 1'b0;
#32
//operations
nxt = 1'b1;
//add
data = 16'b0000000010000001 ;
//sub
//data = 16'b0000000011000001 ;
//and
//data = 16'b0000000100000001 ;
//or
//data = 16'b0000000101000001 ;
//xor
//data = 16'b0000000110000001 ;
//not
//data = 16'b0000000111000001 ;

#3200
nxt = 1'b0;
#32


//okay - excecute
status = 1'b1;
#50000

rst = 1'b1;
#32
rst = 1'b0;
#100
$stop();


end

endmodule
