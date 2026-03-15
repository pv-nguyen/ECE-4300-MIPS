module mux(
    input wire PCSrc,
    input wire [31:0] PC_from_ExMem, Incremented_PC
    output wire [31:0] address
);
    assign address = (PCSrc ? PC_from_ExMem : Incremented_PC);
endmodule