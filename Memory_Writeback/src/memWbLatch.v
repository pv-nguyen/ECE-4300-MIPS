module memWbLatch (
    input wire [1:0] ctrl_wb, 
    input wire clk,
    input wire [31:0] read_dat_in, alu_result,
    input wire [4:0] five_bit_muxout,

    output reg RegWrite, MemtoReg,
    output reg [31:0] read_dat_out,mem_alu_result,
    output reg[4:0] mem_write_reg
);

    always @(posedge clk) begin
        RegWrite <= ctrl_wb[1];
        MemtoReg <= ctrl_wb[0];
        read_dat_out <= read_dat;
        mem_alu_result <= alu_result;
        mem_write_reg <= five_bit_muxout;
    end

endmodule