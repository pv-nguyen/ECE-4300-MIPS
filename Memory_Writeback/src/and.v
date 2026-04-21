module AND (
    input wire mem_ctrl_out,Zero,
    output wire PCSrc
);
    assign PCSrc = memctrlout & Zero;
endmodule