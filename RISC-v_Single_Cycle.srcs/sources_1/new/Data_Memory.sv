`timescale 1ns / 1ps
module Data_Memory(
    input  logic        clk,
    input  logic        rst,
    input  logic        mem_w,
    input  logic        mem_r,
    input  logic [31:0] adr_r,
    input  logic [31:0] data_w,
    output logic [31:0] data_mem_out
    );
    
    logic [31:0] data_mem [63:0];
    
    always_ff @(posedge clk) begin
        if(rst) begin
            for (int k = 0; k < 64; k = k + 1) begin
                data_mem[k] <= 32'b0;
            end
        end
        else if(mem_w) begin
            data_mem[adr_r[7:2]] <= data_w; //2^6 = 64
        end           
    end
    
    assign data_mem_out = (mem_r) ? data_mem[adr_r[7:2]] : 32'b0;        
endmodule
