/**
    * writeback.sv
    * 
    * This module represents the writeback stage of a pipelined processor.
    *
    * For now, it just prints out the PC and instruction at the writeback stage.
    * It also provides placeholder outputs for the register file writeback signals.
    */
module writeback (
    input logic clk,
    input logic reset,

    // input and output the pc and instr
    input logic [31:0] mewb_pc,
    input logic [31:0] mewb_instr,

    // Output control signals (signals not registers since they'll be registered in the reg file) 
    // these are just passed to the decode stage to then use as input for the regfile
    output logic [4:0] s_wb_rd,         // destination register address
    output logic [31:0] s_wb_writedata, // data to write to destination register
    output logic s_wb_regwrite          // write enable

    );

    assign s_wb_rd = 5'b00000; // Placeholder assignment
    assign s_wb_writedata = 32'h00000000; // Placeholder assignment
    assign s_wb_regwrite = 1'b0; // Placeholder assignment

    // print out the pc and instruction at the writeback stage
    always_ff @(posedge clk) begin
        if (!reset) begin
            $display("(%0d) Writeback Stage: PC = %h, Instruction = %h", $time, mewb_pc, mewb_instr);
        end
    end
endmodule