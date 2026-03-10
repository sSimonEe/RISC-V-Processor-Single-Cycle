`timescale 1ns / 1ps
module AND_tb();

    logic [31:0] in0_tb;
    logic [31:0] in1_tb;
    logic [31:0] out_tb;
    

    ADD dut(
        .in0(in0_tb),
        .in1(in1_tb),
        .out(out_tb)
    );
    
    initial begin
        in0_tb = 32'b0;
        in1_tb = 32'b0;
    #10    
        in0_tb = $random;
        in1_tb = $random;
        
    #10 $stop();    
    end
endmodule
