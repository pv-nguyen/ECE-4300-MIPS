module forwarding(
    input wire [4:0] id_ex_rs,
    input wire [4:0] id_ex_rt,
    input wire [4:0] ex_mem_reg_rd,
    input wire [4:0] mem_wb_reg_rd,
    input wire ex_mem_reg_write,
    input wire mem_wb_reg_write,
    output wire [1:0] forwardA,
    output wire [1:0] forwardB
);

    assign forwardA = (ex_mem_reg_write && ex_mem_reg_rd != 5'd0 && ex_mem_reg_rd == id_ex_rs) ? 2'b10 :
                      (mem_wb_reg_write && mem_wb_reg_rd != 5'd0 && mem_wb_reg_rd == id_ex_rs) ? 2'b01 :
                      2'b00;

    assign forwardB = (ex_mem_reg_write && ex_mem_reg_rd != 5'd0 && ex_mem_reg_rd == id_ex_rt) ? 2'b10 :
                      (mem_wb_reg_write && mem_wb_reg_rd != 5'd0 && mem_wb_reg_rd == id_ex_rt) ? 2'b01 :
                      2'b00;

endmodule
