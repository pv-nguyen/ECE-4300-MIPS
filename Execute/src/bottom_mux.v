module bottom_mux (
    input wire [4:0] Instr_2016, Instr_1511,
    input wire RegDst,
    output wire bottom_mux_out
);
    assign bottom_mux_out = (RegDst ? Instr_511:Instr_2016);
endmodule