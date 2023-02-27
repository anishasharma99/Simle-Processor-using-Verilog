`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2022 16:55:37
// Design Name: 
// Module Name: processor
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


module processor(
    input rst, clk, data_valid,
    input [15:0] data_in,
    output [15:0] data_out,
    output [2:0] pc_addr
    );

wire m_val, alu_enable, inst_valid;
wire [3:0] m_addr;
wire [2:0] alu_opcode;
wire [15:0] mux_out;
wire [15:0] act_bus_in, act_bus_out, ir_out;
wire [15:0] signal_a, alu_out, bus_out, bus_in;

control_unit fsm (    .rst(rst),    .clk(clk),    .ir(ir_out),    .mux_val(m_val),    .mux_addr(m_addr),    .alu_op(alu_opcode),    .alu_en(alu_enable),    .pc_addr(pc_addr),  .valid(data_valid),    .instr_valid(inst_valid));
mux multiplexer(    .val(m_val),    .sel(m_addr),    .lines(mux_out)    );
alu alu_unit(    .en(alu_enable),    .a(signal_a),    .b(bus_out),    .op(alu_opcode),    .out(alu_out)    );
register r0 (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[0]),    .inp(bus_out),    .out(bus_in),    .out_comb(data_out));
register r1 (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[1]),    .inp(bus_out),    .out(bus_in)    );
register r2 (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[2]),    .inp(bus_out),    .out(bus_in)    );
register r3 (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[3]),    .inp(bus_out),    .out(bus_in)    );
register r4 (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[4]),    .inp(bus_out),    .out(bus_in)    );
register r5 (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[5]),    .inp(bus_out),    .out(bus_in)    );
register r6 (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[6]),    .inp(bus_out),    .out(bus_in)    );
register r7 (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[7]),    .inp(bus_out),    .out(bus_in)    );
register A (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[9]),    .inp(bus_out),     .out_comb(signal_a)    );
register G (    .din(1'b1),     .clk(clk),    .rst(rst),     .mode(mux_out[10]),    .inp(alu_out),    .out(bus_in)    );
register #(.n(16)) dinn (    .din(1'b1),     .clk(clk),    .rst(rst),     .mode(mux_out[8]),    .inp(data_in),    .out(bus_in)    ,     .inp_valid(inst_valid));
register #(.n(16)) ir (    .din(1'b0),     .clk(clk),    .rst(rst),     .mode(mux_out[11]),    .inp(bus_out),     .out_comb(ir_out)    );
register #(.n(16))  bus (    .din(1'b1),     .clk(clk),    .rst(rst),     .mode(1'bZ),    .inp(bus_in),     .out_comb(bus_out)    );


endmodule
