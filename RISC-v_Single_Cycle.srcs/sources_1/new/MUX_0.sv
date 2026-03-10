`timescale 1ns / 1ps
module MUX(
    input  logic        sel,
    input  logic [31:0] in0,
    input  logic [31:0] in1,
    output logic [31:0] out
    );
    
    assign out = (sel == 0) ? in0 : in1;
endmodule
