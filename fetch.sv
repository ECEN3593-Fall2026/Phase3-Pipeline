/**
    * fetch.sv
    * 
    * This module represents the fetch stage of a pipelined processor.
    * It fetches instructions from instruction memory based on the program counter (PC)
    * and passes the fetched instruction and PC to the next stage.
    */

module fetch (
    input logic clk, 
    input logic reset, 

    // To/from the instruction memory (assumed combinational)    
    input logic [31:0] instruction_data,
    output logic [31:0] instruction_address,

    // passing to the next stage
    output logic [31:0] ifid_pc,
    output logic [31:0] ifid_instr

    );
    // Program Counter 
    logic [31:0] pc;
    // Instruction 
    logic [31:0] s_id_instr;

    /** Your code here **/
    // Main three things it needs to do:
    // increment the program counter
    // assign to the instruction address to fetch the instruction
    // register the outputs to pass to the next stage


endmodule

