module instr_strings_pkg_test;
    import instr_strings_pkg::*;

    initial begin
        instr_op_t op;
        string op_str;

        op = OP_ADD;
        op_str = get_instr_string(op);
        $display("Instruction OP_ADD as string: %s", op_str); // Expected output


    end

endmodule