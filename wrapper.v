`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2022 13:00:44
// Design Name: 
// Module Name: wrapper
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


module wrapper(
    input clk, rst, clr, ld, status, nxt, addr_mux,
    input [15:0] data_in,
    output [15:0] data_r0, 
    output reg [2:0] address
    );
    
wire valid;
wire [15:0] d_in;
wire [2:0] addrr, ld_addr, ex_addr;

processor proc(
    .data_valid(valid),
    .rst(rst), 
    .clk(clk),
    .data_in(d_in),
    .data_out(data_r0),
    .pc_addr(addrr)
    );

memory_PC mem (
    .inp_data(data_in),
    .clear(clr), 
    .load(ld), 
    .nxt(nxt),
    .status_ok(status), 
    .clk(clk),
    .addr(addrr),
    .ready(valid),
    .data_out(d_in),
    .load_addr(ld_addr)
    );

always@(*)
begin
    if (addr_mux)
        address <= addrr;
    else
        address <= ld_addr;
end
endmodule
