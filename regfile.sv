/**
 * regfile.sv
 * 
 * A simple register file module with 32 registers, each 32 bits wide.
 * Supports two read ports and one write port.
 * On reset, initializes registers to known values for easier debugging.
 */

module regfile (
    input logic clk,
    input logic reset,

    // Write register address and data
    input logic we, // write enable
    input logic [4:0] w_addr,
    input logic [31:0] w_data,

    // Read register addresses
    input logic [4:0] r_addr1,
    input logic [4:0] r_addr2,
    
    // Read register data outputs
    output logic [31:0] r_data1,
    output logic [31:0] r_data2
    );

    // Register file array
    // first [31:0] (after logic) defines the data width, the second defines the depth or number of entries
    logic [31:0] registers [31:0];

    // Read operations (combinational)
    always_comb begin
        r_data1 = registers[r_addr1];
        r_data2 = registers[r_addr2];
    end

    // Write operation (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize registers to zero on reset
            for (int i = 0; i < 32; i++) begin
                registers[i] <= {16'hA, 16'(i)}; // upper 16 bits = 0xA, lower 16 bits = i
                         // done this way so I can tell that we're reading something
            end
        end else if (we) begin
            registers[w_addr] <= w_data;
        end
    end

endmodule