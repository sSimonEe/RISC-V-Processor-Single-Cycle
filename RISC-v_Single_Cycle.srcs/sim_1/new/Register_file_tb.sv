`timescale 1ns / 1ps
module Register_file_tb();
    
    logic [4:0]  rs1_tb;
    logic [4:0]  rs2_tb;
    logic [4:0]  rd_tb; 
    logic        we_tb; 
    logic        clk_tb;
    logic        rst_tb;
    logic [31:0] wd_tb; 
    logic [31:0] rd1_tb;
    logic [31:0] rd2_tb;
    
    Register_file dut(
        .rs1(rs1_tb),
        .rs2(rs2_tb),
        .rd(rd_tb),
        .we(we_tb),
        .clk(clk_tb),
        .rst(rst_tb),
        .wd(wd_tb),
        .rd1(rd1_tb),
        .rd2(rd2_tb)          
    );
    
    initial begin
        clk_tb = 0;
        forever begin
            #5 clk_tb = ~clk_tb;
        end
    end
    
    initial begin
        rs1_tb = 5'd0;
        rs2_tb = 5'd0;
        rd_tb = 5'd0; 
        we_tb = 0; 
        rst_tb = 1;
        wd_tb = 32'd0;
        
        #15 rst_tb = 0; 
        
        //TEST 1 Writing in register 22
        rd_tb = 5'd22; 
        wd_tb = 32'hDEAD_BEEF; 
        we_tb = 1;
        @(posedge clk_tb);
        #1 we_tb = 0;
        
        //TEST 2 Reading from register 22
        rs1_tb = 5'd22;
        #5 
        if (rd1_tb == 32'hDEAD_BEEF) $display("TEST 2 PASSED"); 
        else $display("TEST 2 FAILED");
        
        //TEST 3 Attempting to write in x0
        rd_tb = 5'd0;
        wd_tb = 32'hFFFF_FFFF;
        we_tb = 1;
        @(posedge clk_tb);
        #1 we_tb = 0;
           rs1_tb = 5'd0;
        #5 if (rd1_tb == 32'h0) $display("TEST 3 PASSED"); 
           else $display("TEST 3 FAILED");
          
        #20 $stop();     
    end
endmodule
