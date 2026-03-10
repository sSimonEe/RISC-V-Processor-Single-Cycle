# RISC-V Single-Cycle Processor

## Project Overview
This repository contains the hardware implementation of a **32-bit RISC-V Single-Cycle Processor**, built from scratch using **SystemVerilog**. The project was developed, simulated, and logically verified at the waveform level using **Xilinx Vivado**.

The processor implements the datapath and control unit necessary to execute a subset of the **RV32I** base integer instruction set, successfully handling R-type, I-type, S-type, and B-type instructions (e.g., `lw`, `sw`, `add`, `sub`, `and`, `or`, `beq`).

---

## Architecture & Detailed Module Descriptions

The design is highly modular, breaking down the RISC-V architecture into its core components. Below is a breakdown of what each module does and the design decisions behind them:

### 1. Program Counter (PC) & Datapath MUXes
* **What it does:** Keeps track of the current instruction address and calculates the next one.
* **Why was this implemented this way:** Designed as a synchronous sequential block (`always_ff`). I included a dedicated multiplexer (`mux_pc`) driven by an AND gate (Branch & Zero_flag) to seamlessly switch between sequential execution (`PC + 4`) and branch targets. This keeps the timing predictable and cleanly separates the PC logic from the ALU.

### 2. Instruction Memory
* **What it does:** Acts as the ROM (Read-Only Memory) containing the machine code, outputting the 32-bit instruction corresponding to the requested address.
* **Why was this implemented this way:** Modeled with asynchronous reads (combinational logic) to ensure the instruction is fetched instantly within the same clock cycle. I used word-aligned addressing (`address[7:2]`) to correctly map the byte-addressable RISC-V PC to the 32-bit internal array indices, preventing unaligned memory access crashes.

### 3. Register File
* **What it does:** Contains the 32 general-purpose 32-bit registers (`x0` to `x31`).
* **Why was this implemented this way:** Implemented with asynchronous reads so the ALU gets its operands immediately, but synchronous writes (`always_ff`) to safely store the results only at the end of the clock cycle. Register `x0` is strictly hardwired to `0`, strictly adhering to the RISC-V ISA specifications.

### 4. ALU & ALU Control
* **What it does:** The execution engine performs arithmetic (`ADD`, `SUB`) and logical (`AND`, `OR`) operations.
* **Why was this implemented this way:** I used a two-level decoding approach (standard Patterson & Hennessy architecture). The ALU Control decodes a smaller 2-bit `ALUOp` signal from the Main Control alongside the instruction's `funct3`/`funct7` fields. This modularizes the logic, keeping the ALU purely combinational (`always_comb`) and making it much easier to debug or expand with new instructions later.

### 5. Main Control Unit
* **What it does:** The "brain" of the processor. It decodes the 7-bit opcode to generate all datapath selectors and enable signals (`MemWrite`, `RegWrite`, `Branch`, `ALUSrc`, etc.).
* **Why was this implemented this way:** Built as a large combinational `case` statement. A critical design choice was implementing a strict `default` state that drives all control signals to `0`. This prevents Vivado from synthesizing unwanted latches and avoids `Z` or `X` states propagating through the datapath during unknown opcodes.

### 6. Immediate Generator (ImmGen)
* **What it does:** Extracts immediate bits from the 32-bit instruction and sign-extends them to 32 bits based on the instruction format (I-type, S-type, B-type).
* **Why was this implemented this way:** The RISC-V instruction set scrambles immediate bits to keep source register positions constant. Extracting this "unscrambling" process into its own dedicated combinational module keeps the main datapath clean and highly readable.

---

## 📸 Hardware Schematics (RTL Elaborated Design)

Below are the RTL block designs generated directly from the SystemVerilog code, illustrating the hardware synthesis:

### 1. Top-Level Datapath
This is the complete bird's-eye view of the processor, showing how all the modules are interconnected:

<img width="960" height="564" alt="top_schematic" src="https://github.com/user-attachments/assets/fb35348f-b131-4f9f-b8fc-6551666568c6" />

### 2. Control Unit Internal Logic
The combinatorial logic that decodes the opcode and drives the processor:

<img width="960" height="564" alt="Control_schematic" src="https://github.com/user-attachments/assets/6696a1e4-4f62-4abe-98c4-236bc4d9eff3" />

### 3. ALU (Arithmetic Logic Unit)
The execution engine of the processor:

<img width="960" height="564" alt="ALU_schematic" src="https://github.com/user-attachments/assets/17796360-66f2-4ced-a56b-084f299d5358" />

## 📊 Simulation & Waveforms
The processor's functionality was strictly verified through behavioral simulation (`top_tb.sv`). 

Below is the waveform showing a successful execution sequence, including a memory load (`lw`), a memory store (`sw`), and a successful branch (`beq`) operation. Notice how the PC updates correctly and the ALU computes the expected hexadecimal values:

<img width="750" height="300" alt="top_tb_simulation" src="https://github.com/user-attachments/assets/b35028f7-6e2f-4d45-b936-289e67d7e8c4" />

---

## Development Environment
* **Hardware Description Language:** SystemVerilog
* **IDE & Synthesizer:** AMD Xilinx Vivado 2025.2
* **Simulation:** Vivado XSim

---

## References & Inspiration
This project was built for educational purposes, heavily inspired by standard academic literature and community resources. The design choices and datapath routing refer to the following:

1. **[Computer Organization and Design RISC-V Edition: The Hardware Software Interface](https://www.elsevier.com/books/computer-organization-and-design-risc-v-edition/patterson/978-0-12-812275-4)** by David A. Patterson and John L. Hennessy. *(The primary reference for the single-cycle datapath and two-level ALU decoding).*
2. **[The Official RISC-V ISA Specification](https://riscv.org/technical/specifications/)** (Volume I, Unprivileged Spec) for instruction formats, immediate unscrambling, and opcode definitions.
3. **Educational YouTube Channels:** Various community tutorials that provided useful additional understanding of the RISC-V architecture. *(For example: [Down to the Wires](https://www.youtube.com/watch?v=ZIw6Bhf43hE&list=PLbJXh4O-T_aIov-5fBxvu8BXeIFqp6VBR))*
