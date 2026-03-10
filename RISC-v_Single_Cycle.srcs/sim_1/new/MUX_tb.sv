`timescale 1ns / 1ps
module MUX_tb();

    logic        sel_tb;
    logic [31:0] in0_tb;
    logic [31:0] in1_tb;
    logic [31:0] out_tb;

    MUX dut(
        .sel(sel_tb),
        .in0(in0_tb),
        .in1(in1_tb),
        .out(out_tb)
    );
    
    initial begin
        sel_tb = 0;
        in0_tb = 32'hDEAD_BEEF;
        in1_tb = 32'h600D_C00D;
    
    //TESt 1: in0    
    #10 sel_tb = 0;
    
    //TESt 1: in1    
    #10 sel_tb = 1;  
    
    #20 $stop();     
    end
    
endmodule
