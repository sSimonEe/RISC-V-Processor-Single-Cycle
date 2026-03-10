`timescale 1ns / 1ps
module ALU_control_tb();

    logic [1:0] ALUop_tb;         
    logic       fct7_tb;          
    logic [2:0] fct3_tb;          
    logic [3:0] out_alu_control_tb;
    
    ALU_control dut(
        .ALUop           (ALUop_tb),
        .fct7            (fct7_tb),
        .fct3            (fct3_tb),
        .out_alu_control (out_alu_control_tb)
    );
    
    initial begin
        ALUop_tb = 2'b00;
        fct7_tb = 0; 
        fct3_tb = 3'b0;
    #10;
         
    //Test 1: Lode / Store
    #10 ALUop_tb = 2'b00;
        fct7_tb = $random; 
        fct3_tb = $random; 
    #5  if (out_alu_control_tb == 4'b0010) $display("TEST 1 PASSED"); 
            else $display("TEST 1 FAILED"); 
           
    //Test 2: Branch
    #10 ALUop_tb = 2'b01;
        fct7_tb = $random; 
        fct3_tb = $random;
    #5  if (out_alu_control_tb == 4'b0110) $display("TEST 2 PASSED"); 
            else $display("TEST 2 FAILED"); 
        
    //Test 3: ADD
    #10 ALUop_tb = 2'b10;
        fct7_tb = 0; 
        fct3_tb = 3'b0;
    #5  if (out_alu_control_tb == 4'b0010) $display("TEST 3 PASSED"); 
            else $display("TEST 3 FAILED"); 
            
    //Test 4: SUB
    #10 ALUop_tb = 2'b10;
        fct7_tb = 1; 
        fct3_tb = 3'b0; 
   #5   if (out_alu_control_tb == 4'b0110) $display("TEST 4 PASSED"); 
            else $display("TEST 4 FAILED");
        
    //Test 5: AND
    #10 ALUop_tb = 2'b10;
        fct7_tb = 0; 
        fct3_tb = 3'b111;
    #5  if (out_alu_control_tb == 4'b0000) $display("TEST 5 PASSED"); 
            else $display("TEST 5 FAILED"); 
        
    //Test 6: OR
    #10 ALUop_tb = 2'b10;
        fct7_tb = 0; 
        fct3_tb = 3'b110;
    #5  if (out_alu_control_tb == 4'b0001) $display("TEST 6 PASSED"); 
            else $display("TEST 6 FAILED");
             
    //Test 7: SLT
    #10 ALUop_tb = 2'b10;
        fct7_tb = 0; 
        fct3_tb = 3'b010;
    #5  if (out_alu_control_tb == 4'b0111) $display("TEST 7 PASSED"); 
            else $display("TEST 7 FAILED");
             
    #10 $stop();
    end
endmodule
