`timescale 1ns / 1ps
module Data_Memory_tb();
    
    logic        clk_tb;        
    logic        rst_tb;        
    logic        mem_w_tb;     
    logic        mem_r_tb;      
    logic [31:0] adr_r_tb;      
    logic [31:0] data_w_tb;     
    logic [31:0] data_mem_out_tb;
    
    Data_Memory dut(
        .clk          (clk_tb),
        .rst          (rst_tb),
        .mem_w        (mem_w_tb),
        .mem_r        (mem_r_tb),
        .adr_r        (adr_r_tb),
        .data_w       (data_w_tb),
        .data_mem_out (data_mem_out_tb)
    );
    
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end
        
    initial begin
        rst_tb = 1;
        mem_w_tb = 0;
        mem_r_tb = 0;
        adr_r_tb = 32'd0;
        data_w_tb = 32'd0;
        
        #15 rst_tb = 0;
    
        // WRITING IN MEMORY
        @(posedge clk_tb);
        adr_r_tb = 32'd21;
        data_w_tb = 32'hDEAD_BEEF;
        mem_w_tb = 1;
                 
        // READING FROM MEMORY
        @(posedge clk_tb);
        mem_w_tb = 0;
        mem_r_tb = 1;
        
        @(posedge clk_tb);
        #5;
        
        if (data_mem_out_tb == 32'hDEAD_BEEF)
            $display ("TEST PASSED");
        else
            $display ("TEST FAILED");
            
        #20 $stop();
    end              
    
endmodule
