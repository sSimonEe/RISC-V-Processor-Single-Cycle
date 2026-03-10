`timescale 1ns / 1ps
module Instruction_memory_tb();

    logic        clk_tb;
    logic        rst_tb;
    logic [31:0] r_adr_tb;
    logic [31:0] instruction_tb;

    Instruction_memory dut(
        .clk(clk_tb),
        .rst(rst_tb),
        .r_adr(r_adr_tb),     
        .instruction(instruction_tb)
    );
    
    initial begin
        clk_tb = 0;
        forever begin
            #5 clk_tb = ~clk_tb;
        end 
    end
    
    initial begin
        rst_tb = 1;        
        r_adr_tb = 32'b0;      
        
    #10 rst_tb = 0;
       
    dut.mem[0] = 32'h0150_2083; //PC = 0
    dut.mem[1] = 32'hA400_2AA3; //PC = 4
    dut.mem[2] = 32'h0021_0463; //PC = 8
    dut.mem[3] = 32'h0031_00B3; //PC = 12
    
    //TEST 1
    #10 r_adr_tb = 32'd0;
        @(posedge clk_tb)
    #5  if (instruction_tb == 32'h0150_2083) $display("Test 1 PASSED");
        else $display("TEST 1 FAILED");
    
    //TEST 2
    #10 r_adr_tb = 32'd4;
        @(posedge clk_tb)
    #5  if (instruction_tb == 32'hA400_2AA3) $display("Test 2 PASSED");
        else $display("TEST 2 FAILED");
    
    //TEST 3
    #10 r_adr_tb = 32'd8;
        @(posedge clk_tb)
    #5  if (instruction_tb == 32'h0021_0463) $display("Test 3 PASSED");
        else $display("TEST 3 FAILED");
    
    //TEST 4
    #10 r_adr_tb = 32'd12;
        @(posedge clk_tb)
    #5  if (instruction_tb == 32'h0031_00B3) $display("Test 4 PASSED");
        else $display("TEST 4 FAILED");
    
    #20 $stop();            
    end
endmodule
