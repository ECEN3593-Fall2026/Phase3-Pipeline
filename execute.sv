/**
    * execute.sv
    * 
    * This module represents the execute stage of a pipelined processor.
    *
    * For now, it just prints out the PC and instruction at the execute stage,
    * along with the values of reg1 and reg2 read from the register file,
    * and the immediate value extracted from the instruction.
    * It also prints out the instruction as a string (e.g., "add", "sub", etc.).
    */

module execute (
    input logic clk,
    input logic reset,

    // input the pc and instr
    input logic [31:0] idex_pc,
    input logic [31:0] idex_instr,

    // pass out the pc and instruction (registered)
    output logic [31:0] exme_pc,
    output logic [31:0] exme_instr,


    // inputs from decode stage (phase 3 print them out)
    input logic [31:0] idex_reg1,  // value read from rs1
    input logic [31:0] idex_reg2,  // value read from rs2
    input logic [31:0] idex_immed, // value of immediate extracted from instruction

    // phase 3 only, phase 4 will change this
      // use the get_instr_string function in instr_strings_pkg to 
      // convert to string for printing
    input instr_strings_pkg::instr_op_t idex_instr_str


    // Phase 4: outputs to memory stage (roughly defined here)
    //output logic [31:0] exme_alu_result,
    //output logic [31:0] exme_reg2,
    //output string exme_instr_str
    );

    // This package defines the instr_op_t enum and the get_instr_string function
    import instr_strings_pkg::*;

    // register pc and instr (to pass to next stage)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            exme_pc <= 32'h0;
            exme_instr <= 32'h0;
        end else begin
            exme_pc <= idex_pc;
            exme_instr <= idex_instr;
        end
    end


    // print out the pc and instruction at the execute stage (and reg1, reg2, and immed)
    always_ff @(posedge clk) begin
        if (!reset) begin
            $display("(%0d) Execute Stage: PC = %h, Instruction = %h, Reg1 = %h, Reg2 = %h, Immediate = %h, Instruction String = %s", 
                     $time, idex_pc, idex_instr, idex_reg1, idex_reg2, idex_immed, get_instr_string(idex_instr_str));
        end
    end


endmodule
