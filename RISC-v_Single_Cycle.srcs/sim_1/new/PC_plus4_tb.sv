`timescale 1ns / 1ps
module PC_plus4_tb();

    logic [31:0] fromPC_tb;
    logic [31:0] nextPC_tb;

    PC_plus4 dut(
        .fromPC(fromPC_tb),
        .nextPC(nextPC_tb)
    );
    
    initial begin
        fromPC_tb = 32'b0;
    end
    
    initial begin
        forever begin
         #10  fromPC_tb = nextPC_tb;
        end
    end
    
    initial begin
        #100 $stop();
    end
    
endmodule
