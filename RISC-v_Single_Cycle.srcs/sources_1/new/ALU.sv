`timescale 1ns / 1ps
module ALU(
    input  logic [31:0] in0_alu,
    input  logic [31:0] in1_alu,
    input  logic [3:0]  alu_control,
    output logic [31:0] out_alu,
    output logic        zero
    );
    
    always_comb begin
        out_alu = 32'b0;
    
        case(alu_control)
            4'b0000: out_alu = in0_alu & in1_alu; // AND
            4'b0001: out_alu = in0_alu | in1_alu; // OR
            4'b0010: out_alu = in0_alu + in1_alu; // ADD
            4'b0110: out_alu = in0_alu - in1_alu; // SUB
            4'b0111: out_alu = (in0_alu < in1_alu) ? 32'b1 : 32'b0; // SLT
            default: out_alu = 32'b0;
        endcase 
    end
    
    assign zero = (out_alu == 32'b0); 
endmodule
