module AND (
    input wire mem_ctrl_out,Zero,
    output wire PCSrc
);
    assign PCSrc = mem_ctrl_out & Zero;
endmodule