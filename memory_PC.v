`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2022 20:01:59
// Design Name: 
// Module Name: memory_PC
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


module memory_PC #(parameter n = 16, m=8)(
    input [n-1:0] inp_data,
    input clear, load, nxt, status_ok, clk,
    input [2:0] addr,
    output reg [2:0] load_addr,
    output reg ready,
    output reg [n-1:0] data_out
    );
    
    
reg [n-1:0] memory [0:m-1];
reg [2:0] counter = 0;
reg valid;
reg prev_nxt = 0;

always@(posedge clk)
begin

//clear data
if (clear)
begin
    ready <= 1'b0;
    memory[0] <= {(n){1'bZ}};
    memory[1] <= {(n){1'bZ}};
    memory[2] <= {(n){1'bZ}};
    memory[3] <= {(n){1'bZ}};
    memory[4] <= {(n){1'bZ}};
    memory[5] <= {(n){1'bZ}};
    memory[6] <= {(n){1'bZ}};
    memory[7] <= {(n){1'bZ}};
    
    counter <= 3'b000;
end

//load data
if ((!status_ok)&(load))
begin
    ready <= 1'b0;
    if(valid)
        begin
            memory[counter-1] <= inp_data;
            load_addr <= counter-1;
            valid <= 1'b0;
        end
end

//need to pass through debounce circuit <trigger only the transition>
if ((!prev_nxt)&(nxt))
begin
    valid <= 1'b1;
    counter <= counter + 1'b1;
end
prev_nxt <= nxt;

//send data
if (status_ok)
begin
    ready <= 1'b1;
    data_out <= memory[addr];
end



end

//always@(addr)
//begin
////send data
//if (status_ok)
//begin
//    if ((addr[0] == 0)|((addr[0] == 1)))
//    data_out <= memory[addr];
//end

//end


endmodule
