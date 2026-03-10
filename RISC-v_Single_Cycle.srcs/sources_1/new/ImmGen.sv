`timescale 1ns / 1ps
module ImmGen(
    input  logic [6:0]  opcode,
    input  logic [31:0] instruction,
    output logic [31:0] Imm_out 
    );
    
    always_comb begin 
        case(opcode)
            7'b000_0011: Imm_out = {{20{instruction[31]}}, instruction[31:20]}; //LODE
            7'b010_0011: Imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; //STORE
            7'b110_0011: Imm_out = {{19{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}; //BRANCH
            default:     Imm_out = 32'b0; 
        endcase
    end
endmodule
