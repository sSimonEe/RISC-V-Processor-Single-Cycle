`timescale 1ns / 1ps
module ADD_tb();
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
        
        //Test 1
        #10 in0_tb = 32'hDE9B_C294;
            in1_tb = 32'h0011_FC5B;
        
        //Test 2
        #10 in0_tb = 32'hFFFF_FFFF;
            in1_tb = 32'h0000_0001;        
        
        #10 $stop();
    end
endmodule
