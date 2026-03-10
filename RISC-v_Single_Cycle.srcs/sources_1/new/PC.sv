`timescale 1ns / 1ps

module PC(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] in_pc,
    output logic [31:0] out_pc
    );
    
    always_ff @(posedge clk) begin
        if(rst)
            out_pc <= 32'h0;
        else
            out_pc <= in_pc;
    end  
endmodule
