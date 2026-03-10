`timescale 1ns / 1ps
module Register_file(
    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,
    input  logic        we,
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] wd,
    output logic [31:0] rd1,
    output logic [31:0] rd2          
    );
    
    logic [31:0] register [31:0]; //32 registers each with 32b

    
    always_ff @(posedge clk) begin
        if(rst) begin
            for(int k = 0; k < 32; k = k + 1) begin
                register[k] <= 32'd0;
            end
        end
        else if(we && (rd != 5'b00000)) begin
            register[rd] <= wd;
        end
    end
    
    assign rd1 = (rs1 == 5'b0) ? 32'b0 : register[rs1];
    assign rd2 = (rs2 == 5'b0) ? 32'b0 : register[rs2];
    
endmodule
