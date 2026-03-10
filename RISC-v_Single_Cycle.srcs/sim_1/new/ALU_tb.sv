`timescale 1ns / 1ps
module ALU_tb();
    logic [31:0] in0_alu_tb;    
    logic [31:0] in1_alu_tb;    
    logic [3:0]  alu_control_tb;
    logic [31:0] out_alu_tb;
    logic        zero_tb;        
    
    ALU dut(
        .in0_alu     (in0_alu_tb),
        .in1_alu     (in1_alu_tb),
        .alu_control (alu_control_tb),
        .out_alu     (out_alu_tb),
        .zero        (zero_tb)
        );
        
    initial begin
        //initial values
        in0_alu_tb = 32'b0;
        in1_alu_tb = 32'b0;
        alu_control_tb = 4'b0;
            
        //TEST 1: AND
        #10 alu_control_tb = 4'b0000;
            in0_alu_tb = 32'hAAAA_BBBB;
            in1_alu_tb = 32'hAAAA_BBBB;    
           
        //TEST 2: OR
        #10 alu_control_tb = 4'b0001;
            in0_alu_tb = 32'hAAAA_BBBB;
            in1_alu_tb = 32'h5555_4444;
            
        //TEST 3: ADD
        #10 alu_control_tb = 4'b0010;
            in0_alu_tb = 32'hDEAD_BEEF;
            in1_alu_tb = 32'h0000_0001;
            
        //TEST 4: SUB
        #10 alu_control_tb = 4'b0110;
            in0_alu_tb = 32'hDEAD_BEF0;
            in1_alu_tb = 32'h0000_0001;
            
        // TEST 5: SLT
        #10 alu_control_tb = 4'b0111; 
            in0_alu_tb = 32'd10;
            in1_alu_tb = 32'd5;
            
        //TEST 6: SLT
        #10 alu_control_tb = 4'b0111;
            in0_alu_tb = 32'd5;
            in1_alu_tb = 32'd10;
        
        // TEST 7: SUB with ZERO
        #10 alu_control_tb = 4'b0110;        
            in0_alu_tb = 32'd100;
            in1_alu_tb = 32'd100;
            
        #20 $stop();
    end
endmodule
