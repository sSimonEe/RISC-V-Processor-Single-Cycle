`timescale 1ns / 1ps
module top(
    input logic         clk,
    input logic         rst,
    output logic [31:0] ALU_Result
    );   
       
    //PC
    logic [31:0] pc_out;
    
    //PCplus4
    logic [31:0] pc_plus4_out;
    
    //MUX
    logic [31:0] out_mux_pc;
    logic [31:0] out_mux_data;
    logic [31:0] out_mux_alu;
    
    //Instruction memory
    logic [31:0] instruction;
    
    //Register file
    logic [31:0] rd1_out;
    logic [31:0] rd2_out;
    
    //Control
    logic       ALU_Src;    
    logic       Mem_to_Reg; 
    logic       RegWrite;         
    logic       mem_R;      
    logic       mem_W;      
    logic       Branch;     
    logic [1:0] ALU_op;     
    
    //ImmGen
    logic [31:0] Imm_out;
    
    //Adder
    logic [31:0] Adder_out;
    
    //ALU Control
    logic [3:0] ALU_Control_out;
    
    //ALU
    logic Zero_flag;
    
    //AND
    logic and_out;
    
    //Data memory
    logic [31:0] Read_data;
    
    //PC
    PC pc(
        .clk    (clk),
        .rst    (rst),
        .in_pc  (out_mux_pc),
        .out_pc (pc_out)
    );
    
    //PC+4
    PC_plus4 pc_plus4(
        .fromPC (pc_out),
        .nextPC (pc_plus4_out)
    );
    
    //Instruction_memory
    Instruction_memory instruction_memory(
        .clk         (clk),
        .rst         (rst),
        .r_adr       (pc_out),
        .instruction (instruction)
    );
    
    //Register_file
    Register_file reg_file(
        .rs1 (instruction[19:15]),
        .rs2 (instruction[24:20]),
        .rd  (instruction[11:7]),
        .we  (RegWrite),
        .clk (clk),
        .rst (rst),
        .wd  (out_mux_data),
        .rd1 (rd1_out),
        .rd2 (rd2_out)          
    );
    
    //immgen
    ImmGen immgen(
        .opcode      (instruction[6:0]),
        .instruction (instruction),
        .Imm_out     (Imm_out) 
    );
    
    //Adder
    ADD adder(
        .in0 (pc_out),
        .in1 (Imm_out),
        .out (Adder_out)
    );
    
    //Control
    Control control(
        .opcode     (instruction[6:0]),
        .ALU_src    ( ALU_Src),
        .mem_to_reg (Mem_to_Reg),
        .rw         (RegWrite),   
        .mem_r      (mem_R),
        .mem_w      (mem_W),
        .Branch     (Branch),    
        .ALU_op     (ALU_op)
    );
    
    //ALU_control
    ALU_control alu_control(
        .ALUop           (ALU_op),
        .fct7            (instruction[30]),
        .fct3            (instruction[14:12]),
        .out_alu_control (ALU_Control_out)
    );
    
    //MUX_ALU
    MUX mux_alu(
        .sel (ALU_Src),
        .in0 (rd2_out),
        .in1 (Imm_out),
        .out (out_mux_alu)
    );
    
    //ALU
    ALU alu(
        .in0_alu     (rd1_out),
        .in1_alu     (out_mux_alu),
        .alu_control (ALU_Control_out),
        .out_alu     (ALU_Result),
        .zero        (Zero_flag)
    );
    
    //AND
    AND and0(
        .in0 (Branch),
        .in1 (Zero_flag),
        .out (and_out)
    );
    
    //MUX_pc
    MUX mux_pc(
        .sel (and_out),
        .in0 (pc_plus4_out),
        .in1 (Adder_out),
        .out (out_mux_pc)
    );
    
    //Data_memory
    Data_Memory data_memory(
        .clk          (clk),
        .rst          (rst),
        .mem_w        (mem_W),
        .mem_r        (mem_R),
        .adr_r        (ALU_Result),
        .data_w       (rd2_out),
        .data_mem_out (Read_data)
    );
    
    //MUX_DATA
    MUX mux_data(
        .sel (Mem_to_Reg),
        .in0 (ALU_Result),
        .in1 (Read_data),
        .out (out_mux_data)
    );
endmodule
