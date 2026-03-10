`timescale 1ns / 1ps
module Instruction_memory(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] r_adr,
    output logic [31:0] instruction
    );
    
    logic [31:0] mem[63:0];
    
    always @(posedge clk) begin
        if(rst) begin
            for(int k = 0; k < 64; k = k + 1) begin
                mem[k] <= 32'd0;
            end 
        end
        else
            instruction <= mem[r_adr[7:2]];
    end
endmodule
