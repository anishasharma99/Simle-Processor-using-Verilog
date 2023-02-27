`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2022 16:55:37
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input rst,clk,valid, instr_valid,
    input [15:0] ir,
    output reg mux_val,
    output reg [3:0] mux_addr,
    output reg [2:0] alu_op,
    output reg alu_en,
    output [2:0] pc_addr
    );

reg cc = 1'b0;
reg [3:0] state = 4'b1111, nxt_state = 4'b1111;
reg [2:0] pc = 0;

assign pc_addr = pc;

always@(ir, state, instr_valid)
begin
    
    case (state)
        4'b1111 : 
        begin
            nxt_state <= 4'b0000;
            pc <= 3'b000;
        end
        4'b0000 : //s0
        begin
            if (instr_valid)
            begin
                nxt_state <= 4'b0001;
                mux_val <= 1'b1;
                mux_addr <= 4'b1000;
            end
            
        end
        4'b0001 : //s1
        begin
            mux_val <= 1'b0;
            mux_addr <= 4'b1011;
            case(ir[8:6])
                3'b000 : nxt_state <= 4'b0110;
                3'b001 : 
                begin
                    //buffer
                    nxt_state <= 4'b1010;
                end
                3'b010 : nxt_state <= 4'b0100;
                3'b011 : nxt_state <= 4'b0100;
                3'b100 : nxt_state <= 4'b0100;
                3'b101 : nxt_state <= 4'b0100;
                3'b110 : nxt_state <= 4'b0100;
                3'b111 : nxt_state <= 4'b0100;
                default : nxt_state <= 4'b0000;
            endcase
         end
         4'b0010: //s2
         begin
            nxt_state <= 4'b0011;
            mux_val <= 1'b1;
            mux_addr <= 4'b1000;
            
         end
         4'b0011: //s3
         begin
            nxt_state <= 4'b0000;
            pc <= pc+1;
            mux_val <= 1'b0;
            mux_addr <= {1'b0,ir[5:3]};
         end
         4'b0100: //s4
         begin
            nxt_state <= 4'b0101;
            mux_val <= 1'b1;
            mux_addr <= {1'b0,ir[5:3]};
         end
         4'b0101: //s5
         begin
            nxt_state <= 4'b0110;
            mux_val <= 1'b0;
            mux_addr <= 4'b1001;
         end
         4'b0110: //s6
         begin
            mux_val <= 1'b1;
            mux_addr <= {1'b0,ir[2:0]};
            case(ir[8:6])
                3'b000 : nxt_state <= 4'b1001;
                default : nxt_state <= 4'b0111;
            endcase
         end
         4'b0111: //s7
         begin
            alu_en <= 1'b1;
            alu_op <= ir[8:6];
            nxt_state <= 4'b1000;
            mux_val <= 1'b1;
            mux_addr <= 4'b1010;
            mux_val <= 1'bZ;
         end
         4'b1000: //s8
         begin
            alu_en <= 1'b0;
            nxt_state <= 4'b1001;
            mux_val <= 1'b1;
            mux_addr <= 4'b1010;
         end
         4'b1001: //s9
         begin
            nxt_state <= 4'b0000;
            mux_val <= 1'b0;
            mux_addr <= {1'b0,ir[5:3]};
            pc <= pc + 1'b1;
         end
         4'b1010: //buffer state for data change
         begin
            nxt_state <= 4'b0010;
            if (ir[8:6] == 3'b001)
                pc <= pc + 1'b1;
         end
         default :
         begin
         alu_op <= 3'bZZZ;
         alu_en <= 1'b0; 
         nxt_state <= 4'b0000;
         end
     endcase

end

always@(posedge clk)
begin
    if (rst)
        state <= 4'b1111;
        
    else if (!cc & valid)
        state <= nxt_state;
    
      
    cc <= ~cc;
end
endmodule
