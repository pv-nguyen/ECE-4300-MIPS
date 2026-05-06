module bottom_mux (
    input wire [4:0] Instr_2016, Instr_1511,
    input wire RegDst,
    output wire [4:0] bottom_mux_out
);
    assign bottom_mux_out = (RegDst ? Instr_1511:Instr_2016);
endmodule