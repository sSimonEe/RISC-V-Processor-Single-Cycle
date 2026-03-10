`timescale 1ns / 1ps
module ImmGen_tb();

    logic [6:0]  opcode_tb;    
    logic [31:0] instruction_tb;
    logic [31:0] Imm_out_tb;
       
    ImmGen dut(
        .opcode(opcode_tb),
        .instruction(instruction_tb),
        .Imm_out(Imm_out_tb) 
    );
    
    initial begin
    
        opcode_tb = 7'b0;
        instruction_tb = 32'b0;
    
    //Test 1: LODE lw x1, 20(x0) -> 32'h0150_2083
    // 32'h0140_2083 = 32'b0000_0001_0101_0000_0010_0000_1000_0011
    // Imm_out_tb =    32'b0000_0000_0000_0000_0000_0000_0001_0101  = 32d'21
    #10 opcode_tb = 7'b000_0011;
        instruction_tb = 32'h0150_2083;
    #5  if (Imm_out_tb == 32'd21) $display("TEST 1 PASSED");
        else $display("TEST 1 FAILED");
        
    //Test 2: STORE sw x1, (x0) -> 32'hA400_2AA3
    // 32'hA400_2AA3 = 32'b1010_0100_0000_0000_0010_1010_1010_0011
    // Imm_out_tb =    32'b1111_1111_1111_1111_1111_1010_0101_0101 = 32'hFFFF_FASS
    #10 opcode_tb = 7'b010_0011;
        instruction_tb = 32'hA400_2AA3;
    #5  if (Imm_out_tb == 32'hFFFF_FA55) $display("TEST 2 PASSED");
        else $display("TEST 2 FAILED");
        
    //Test 3: BRANCH beq x2, x1, +8 -> 32'h0021_0463
    // 32'h0021_0463 = 32'b0000_0000_0010_0001_0000_0100_0110_0011
    // Imm_out_tb    = 32'b0000_0000_0000_0000_0001_
    #10 opcode_tb = 7'b110_0011;
        instruction_tb = 32'h0021_0463;
    #5  if (Imm_out_tb == 32'd8) $display("TEST 3 PASSED");
        else $display("TEST 3 FAILED");
        
    //TEST 4: add x1, x2, x3 -> 32'h0031_00B3
    #10 opcode_tb = 7'b011_011;
        instruction_tb = 32'h0031_00B3;
    #5  if (Imm_out_tb == 32'b0) $display("TEST 4 PASSED");
        else $display("TEST 4 FAILED");
        
    #20 $stop();
    end
endmodule
