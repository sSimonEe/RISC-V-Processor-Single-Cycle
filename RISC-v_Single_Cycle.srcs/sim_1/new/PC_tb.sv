`timescale 1ns / 1ps
module PC_tb();

    logic        rst_tb;
    logic        clk_tb;
    logic [31:0] in_pc_tb;
    logic [31:0] out_pc_tb;
    
    PC dut(
        .clk(clk_tb),
        .rst(rst_tb),
        .in_pc(in_pc_tb),
        .out_pc(out_pc_tb)
    );
    
    initial begin
        clk_tb = 0;
        forever begin
            #5 clk_tb = ~clk_tb;
        end
    end
    
    initial begin
            rst_tb = 1;
            in_pc_tb = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
        #20 rst_tb = 0;
        #20 in_pc_tb = 32'b0000_0000_0000_0000_0000_0000_0000_0100;
        #60 rst_tb = 1;
        #20 in_pc_tb = 32'b0000_0000_0000_0000_0000_0000_0100_0000;
        #60 rst_tb = 0;
        #100 $stop();
    end
endmodule
