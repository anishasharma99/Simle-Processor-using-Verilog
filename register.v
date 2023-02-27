`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2022 16:55:37
// Design Name: 
// Module Name: register
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


module register #(parameter n = 16) (
    
    input din, clk, rst, mode,
    input [n-1:0] inp,
    output reg [n-1:0] out,
    output [n-1:0] out_comb,
    output reg inp_valid
    );
    
reg t1;
reg [n-1:0] stored = {(n){1'bZ}};

assign out_comb = stored;


always@(clk, din, inp, rst, mode)
begin
    if ((!mode)&(!din)&clk)
    begin
        stored <= inp;
    end
    
    if (din)
    begin
        if ((inp[0] == 1'b0)|(inp[0] == 1'b1))
            begin
            stored <= inp;
            inp_valid <= 1'b1;
            end
        else
            inp_valid <= 1'b0;
    end
    
    if (rst)
    begin
        stored <= {(n){1'bZ}};
    end
    
    
    if (mode)
        out <= stored;
    else 
        out <= {(n){1'bZ}};
    
end


endmodule
