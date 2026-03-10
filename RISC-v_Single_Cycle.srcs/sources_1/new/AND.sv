`timescale 1ns / 1ps
module AND(
    input  logic in0,
    input  logic in1,
    output logic out
    );
    
    assign out = in0 & in1;
endmodule
