`timescale 1ns / 1ps
module Control_tb();

    logic [6:0] opcode_tb;
    logic       ALU_src_tb;
    logic       mem_to_reg_tb;
    logic       rw_tb;
    logic       mem_r_tb;
    logic       mem_w_tb;
    logic       Branch_tb;  
    logic [1:0] ALU_op_tb;   
            
    Control dut(
        .opcode     (opcode_tb),
        .ALU_src    (ALU_src_tb),
        .Branch     (Branch_tb),
        .mem_r      (mem_r_tb),
        .mem_w      (mem_w_tb),
        .mem_to_reg (mem_to_reg_tb),
        .ALU_op     (ALU_op_tb),
        .rw         (rw_tb)
    );
    
    initial begin
        opcode_tb = 7'b0;
        
    // TEST 1: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b0010_0010    
    #10 opcode_tb = 7'b0110011;
    #5;
    if ({ALU_src_tb, mem_to_reg_tb, rw_tb, mem_r_tb, mem_w_tb, Branch_tb, ALU_op_tb} == 8'b0010_0010) $display("TEST 1 PASSED");
    else $display("TEST 1 FAILED");
    
    // TEST 2: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b1111_0000 
    #10 opcode_tb = 7'b0000011;
    #5;
    if ({ALU_src_tb, mem_to_reg_tb, rw_tb, mem_r_tb, mem_w_tb, Branch_tb, ALU_op_tb} == 8'b1111_0000) $display("TEST 2 PASSED");
    else $display("TEST 2 FAILED");
      
    // TEST 3: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b1000_1000 
    #10 opcode_tb = 7'b0100011;
    #5; 
    if ({ALU_src_tb, mem_to_reg_tb, rw_tb, mem_r_tb, mem_w_tb, Branch_tb, ALU_op_tb} == 8'b1000_1000) $display("TEST 3 PASSED");
    else $display("TEST 3 FAILED");
    
    // TEST 4: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b0000_0101 
    #10 opcode_tb = 7'b1100011;
    #5; 
    if ({ALU_src_tb, mem_to_reg_tb, rw_tb, mem_r_tb, mem_w_tb, Branch_tb, ALU_op_tb} == 8'b0000_0101) $display("TEST 4 PASSED");
    else $display("TEST 4 FAILED");
    
    // TEST 5: {ALU_src, mem_to_reg, rw, mem_r, mem_w, Branch, ALU_op} = 8'b0000_0000 
    #10 opcode_tb = 7'b1111111;
    #5;   
    if ({ALU_src_tb, mem_to_reg_tb, rw_tb, mem_r_tb, mem_w_tb, Branch_tb, ALU_op_tb} == 8'b0000_0000) $display("TEST 5 PASSED");
    else $display("TEST 5 FAILED");
    
    #10 $stop();
    end

endmodule
