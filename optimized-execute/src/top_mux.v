module top_mux(
    input wire [31:0] ReadData2, SignExtend,
    input wire ALUSrc,
    output wire [31:0] top_mux_out
);
    assign top_mux_out = (ALUSrc?SignExtend:ReadData2);

endmodule