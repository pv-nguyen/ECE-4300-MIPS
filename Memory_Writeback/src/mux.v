module wb_mux(
    input wire [31:0] read_dat, mem_alu_result,
    input wire select,
    output wire [31:0] write_data
);
    assign write_data = (select ? read_dat : mem_alu_result);
endmodule