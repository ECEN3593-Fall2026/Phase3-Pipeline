/**
    * mem.sv
    * 
    * This module represents the memory stage of a pipelined processor.
    *
    * For now, it just prints out the PC and instruction at the memory stage.
    */

module mem (
    input logic clk,
    input logic reset,

    // input and output the pc and instr
    input logic [31:0] exme_pc,
    input logic [31:0] exme_instr,

    // pass out the pc and instruction (registered)
    output logic [31:0] mewb_pc,
    output logic [31:0] mewb_instr

    );

    // register pc and instr (to pass to next stage)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            mewb_pc <= 32'h0;
            mewb_instr <= 32'h0;
        end else begin
            mewb_pc <= exme_pc;
            mewb_instr <= exme_instr;
        end
    end

    // print out the pc and instruction at the memory stage
    always_ff @(posedge clk) begin
        if (!reset) begin
            $display("(%0d) Memory Stage: PC = %h, Instruction = %h", $time, exme_pc, exme_instr);
        end
    end
endmodule