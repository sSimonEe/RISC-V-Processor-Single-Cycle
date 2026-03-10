`timescale 1ns / 1ps
module top_tb();

    logic        clk_tb;      
    logic        rst_tb;      
    logic [31:0] ALU_Result_tb;
    
    top dut(
        .clk        (clk_tb),
        .rst        (rst_tb),
        .ALU_Result (ALU_Result_tb)
    );
    
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end 
    
    initial begin
            rst_tb = 1;
        
        #10 rst_tb = 0; //Start
        
        //LODE ALU_Result -> 0000_0015
        dut.instruction_memory.mem[0] = 32'h0150_2083;
        
        //STORE ALU_Result -> FFFF_FA55
        dut.instruction_memory.mem[1] = 32'hA400_2AA3;
        
        //BRANCH ALU_Result -> 0000_0000
        dut.instruction_memory.mem[2] = 32'h0021_0463;
        
        //Ignored
        dut.instruction_memory.mem[3] = 32'h0031_00B3;
        
        
        #100 $stop();
    end    
endmodule
