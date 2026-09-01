package instr_strings_pkg;


// Define an enumeration for instruction operations (took in order from riscv-card.pdf)
typedef enum logic [7:0] {
   OP_ADD, OP_SUB, OP_XOR, OP_OR, OP_AND, OP_SLL, OP_SRL, OP_SRA, OP_SLT, OP_SLTU,
   OP_ADDI, OP_XORI, OP_ORI, OP_ANDI, OP_SLLI, OP_SRLI, OP_SRAI, OP_SLTI, OP_SLTIU,
    OP_LB, OP_LH, OP_LW, OP_LBU, OP_LHU,
    OP_SB, OP_SH, OP_SW,
    OP_BEQ, OP_BNE, OP_BLT, OP_BGE, OP_BLTU, OP_BGEU,
    OP_JAL, OP_JALR,
    OP_LUI, OP_AUIPC,
    OP_ECALL,
    OP_EBREAK,
    OP_UNKNOWN
} instr_op_t;


// Function to get the string representation of an instruction operation (for printing)
// e.g., input OP_ADD returns "add"
function string get_instr_string(instr_op_t op);
   case (op)
       OP_ADD:    return "add";
       OP_SUB:    return "sub";
       OP_XOR:    return "xor";
       OP_OR:     return "or";
       OP_AND:    return "and";
       OP_SLL:    return "sll";
       OP_SRL:    return "srl";
       OP_SRA:    return "sra";
       OP_SLT:    return "slt";
       OP_SLTU:   return "sltu";
       OP_ADDI:   return "addi";
       OP_XORI:   return "xori";
       OP_ORI:    return "ori";
       OP_ANDI:   return "andi";
       OP_SLLI:   return "slli";
       OP_SRLI:   return "srli";
       OP_SRAI:   return "srai";
       OP_SLTI:   return "slti";
       OP_SLTIU:  return "sltiu";
       OP_LB:     return "lb";
       OP_LH:     return "lh";
       OP_LW:     return "lw";
       OP_LBU:    return "lbu";
       OP_LHU:    return "lhu";
       OP_SB:     return "sb";
       OP_SH:     return "sh";
       OP_SW:     return "sw";
       OP_BEQ:    return "beq";
       OP_BNE:    return "bne";
       OP_BLT:    return "blt";
       OP_BGE:    return "bge";
       OP_BLTU:   return "bltu";
       OP_BGEU:   return "bgeu";
       OP_JAL:    return "jal";
       OP_JALR:   return "jalr";
       OP_LUI:    return "lui";
       OP_AUIPC:  return "auipc";
       OP_ECALL:  return "ecall";
       OP_EBREAK:return "ebreak";
       default:    return "unknown";
    endcase
endfunction


endpackage : instr_strings_pkg