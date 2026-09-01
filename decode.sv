/**
    * decode.sv
    * 
    * This module represents the decode stage of a pipelined processor.
    * It decodes the instruction, reads from the register file, extracts immediate values,
    * and passes necessary information to the next stage.
    *
    * For Phase 3, it also determines the instruction type as an enum for printing.
    */
module decode (
    input logic clk,
    input logic reset,


    // from previous stage
    input logic [31:0] ifid_pc,
    input logic [31:0] ifid_instr,

    // write back signals
    input logic        wb_regwrite, // write enable signal
    input logic [4:0]  wb_rd,       // destination register address
    input logic [31:0] wb_writedata, // data to write back


    // to next stage

    // pass out the pc and instruction (registered)
    output logic [31:0] idex_pc,
    output logic [31:0] idex_instr,

    // register outputs and immediate values 
    output logic [31:0] idex_reg1,  // value read from rs1
    output logic [31:0] idex_reg2,  // value read from rs2
    output logic [31:0] idex_immed, // immediate value extracted from instruction

    // Phase 3: just pass the string of the op (as an enum) to the next stage for printing
       // e.g., OP_ADD, OP_SUB, etc.  (which translate to "add", "sub", etc. for printing
       //       using the get_instr_string function in instr_strings_pkg)
    // Phase 4 control signals will be :  aluop, alusrc2, regwrite, halt
    output instr_strings_pkg::instr_op_t idex_instr_str
    );

    // This package defines the instr_op_t enum and the get_instr_string function
    import instr_strings_pkg::*;


    logic [6:0]  s_id_opc;
    logic [4:0]  s_id_rd;
    logic [2:0]  s_id_fun3;
    logic [4:0]  s_id_rs1;
    logic [4:0]  s_id_rs2;
    logic [6:0]  s_id_fun7;
    logic [31:0] s_id_immedi;
    logic [31:0] s_id_immedb;
    logic [31:0] s_id_immeds;
    logic [31:0] s_id_immedj;
    logic [31:0] s_id_immedu;
    logic [31:0] s_id_immed;
    

    // New signals for Phsae 3: register file outputs (the data read from rs1 and rs2)
    // (hint: you'll then need to assign these to the outputs in an always_ff block)
    logic [31:0] s_id_reg1;
    logic [31:0] s_id_reg2;    


    // instantiate the register file
    regfile regfile_inst (
        .clk(clk),
        .reset(reset),
        .we(wb_regwrite),
        .w_addr(wb_rd),
        .w_data(wb_writedata),
        .r_addr1(s_id_rs1),
        .r_addr2(s_id_rs2),
        .r_data1(s_id_reg1),
        .r_data2(s_id_reg2)
    );


    typedef enum  logic [6:0] {
        R_TYPE=7'b0110011, 
        I_TYPE_ALU=7'b0010011, 
        I_TYPE_LOAD=7'b0000011, 
        I_TYPE_ECALL=7'b1110011,
        I_TYPE_JUMP=7'b1100111, 
        S_TYPE=7'b0100011,
        B_TYPE=7'b1100011,
        J_TYPE=7'b1101111,
        U_TYPE_LUI=7'b0110111,
        U_TYPE_AUIPC=7'b0010111} opcodes_t;

    // to use this enum in a case statement, convert the logic vector (s_id_opc) to an opcode type
    // you'll assign s_id_opc below based on s_id_instr
    opcodes_t opc;


    instr_op_t instr_string; // note updated type for Phase 3

/***** START PRIVATE CODE ******/

   // Your Phase 2 code for decoding the instruction should be nearly copy/paste
   // main things it needs to do:

   // extract fields from the instruction
   // set instr_string based on opcode and funct3/funct7
     //  note: it's type instr_op_t from instr_strings_pkg, so OP_ADD, OP_SUB, etc. 
   // register outputs to next stage
    
    
/***** END YOUR CODE ******/

    // PROVIDED FOR PHASE 3 
    // Prints out the decoded instruction in human-readable format
    always_ff @(posedge reset or posedge clk ) begin : PrintDecodedInstructions
        if (reset) begin
            // Do nothing on reset
        end else begin
            // For R_TYPE 
            // pc=0x0000, instr=0x12345678: add x1, x2, x3  (where those correspond to rd, rs1, rs2) 
            // For I_TYPE_ALU 
            // pc=0x0000, instr=0x12345678: addi x1, x2, 13  (where those correspond to rd, rs1, imm in decimal)
            // Note: %0d prints signed decimal with zero padding. 
            case(opc) 
                R_TYPE:     $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (R-type):  %s x%0d, x%0d, x%0d", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rd, s_id_rs1, s_id_rs2);
                I_TYPE_ALU: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (I-type ALU):  %s x%0d, x%0d, %0d", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rd, s_id_rs1, s_id_immed);
                I_TYPE_LOAD: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (I-type LOAD):  %s x%0d, %0d(x%0d)", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rd, s_id_immed, s_id_rs1);
                I_TYPE_JUMP: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (I-type JUMP):  %s x%0d, x%0d, 0x%0h", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rd, s_id_rs1, s_id_immed);
                I_TYPE_ECALL: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (I-type ECALL/EBREAK):  %s", $time, ifid_pc, ifid_instr, get_instr_string(instr_string));
                S_TYPE: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (S-type):  %s x%0d, %0d(x%0d)", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rs2, s_id_immed,s_id_rs1);
                B_TYPE: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (B-type):  %s x%0d, x%0d, 0x%0h", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rs1, s_id_rs2, s_id_immed);
                J_TYPE: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (J-type):  %s x%0d, %0h", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rd, s_id_immed);
                U_TYPE_LUI: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (U-type LUI):  %s x%0d, 0x%0h", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rd, s_id_immed);
                U_TYPE_AUIPC: $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (U-type AUIPC):  %s x%0d, 0x%0h", $time, ifid_pc, ifid_instr, get_instr_string(instr_string), s_id_rd, s_id_immed);
                default:    $display("(%0d) Decode stage: pc=0x%h, instr=0x%h (other)", $time, ifid_pc, ifid_instr); 
            endcase
        end 
    end


endmodule

