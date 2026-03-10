`timescale 1ns / 1ps
module PC_plus4(
    input  logic [31:0] fromPC,
    output logic [31:0] nextPC
    );
    
    assign nextPC = fromPC + 4;
endmodule
