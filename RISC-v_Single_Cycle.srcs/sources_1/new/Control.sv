`timescale 1ns / 1ps
module Control(
    input  logic [6:0] opcode,
    output logic       ALU_src,
    output logic       mem_to_reg,
    output logic       rw,   
    output logic       mem_r,
    output logic       mem_w,
    output logic       Branch,    
    output logic [1:0] ALU_op
    );
    
    always_comb begin
        case(opcode)
            //R-Type
            7'b0110011: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b0010_0010;
            
            //I-Type
            7'b0000011: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b1111_0000;
            
            //S-Type
            7'b0100011: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b1000_1000;
            
            //B-type
            7'b1100011: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b0000_0101;
            
            //DEFAULT
            default:    {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b0000_0000;
        endcase 
    end
endmodule
