`timescale 1ns / 1ps
module ALU_control(
    input  logic [1:0] ALUop,
    input  logic       fct7,
    input  logic [2:0] fct3,
    output logic [3:0] out_alu_control
    );
    
    always_comb begin
        casez({ALUop, fct7, fct3})
            // ALUop = 00 -> Load / Store / ADDI (ADD)
            6'b00_?_???: out_alu_control = 4'b0010;
            
            //ALUop = 01 -> Branch (SUB)
            6'b01_?_???: out_alu_control = 4'b0110;
            
            //ALUop = 10 -> R
            6'b10_0_000: out_alu_control = 4'b0010; // ADD
            6'b10_1_000: out_alu_control = 4'b0110; // SUB
            6'b10_0_111: out_alu_control = 4'b0000; // AND
            6'b10_0_110: out_alu_control = 4'b0001; // OR
            6'b10_0_010: out_alu_control = 4'b0111; // SLT
            
            default: out_alu_control = 4'b0010;
        endcase
    end
endmodule
