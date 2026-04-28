module memWbLatch (
    input wire [1:0] ctrl_wb,
    input wire clk,
    input wire rst,
    input wire [31:0] read_dat_in, alu_result,
    input wire [4:0] five_bit_muxout,

    output reg RegWrite, MemtoReg,
    output reg [31:0] read_dat_out, mem_alu_result,
    output reg [4:0] mem_write_reg
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RegWrite <= 1'b0;
            MemtoReg <= 1'b0;
            read_dat_out <= 32'd0;
            mem_alu_result <= 32'd0;
            mem_write_reg <= 5'd0;
        end else begin
            RegWrite <= ctrl_wb[1];
            MemtoReg <= ctrl_wb[0];
            read_dat_out <= read_dat_in;
            mem_alu_result <= alu_result;
            mem_write_reg <= five_bit_muxout;
        end
    end
endmodule