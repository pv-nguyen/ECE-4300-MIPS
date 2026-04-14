module ex_mem_latch(
    input wire clk,
    input wire [1:0] ctrl_wb_in,
    input wire [2:0] ctrl_mem_in,
    input wire [31:0] adder_out,
    input wire alu_zero,
    input wire [31:0] alu_out, read_dat2,
    input wire [4:0] mux_out,

    output reg [1:0] ctrl_wb_out,
    output reg [2:0] ctrl_mem_out,
    output reg branch, memread, memwrite, //output of M control line from ID/EX latch

    output reg [31:0] add_result,
    output reg zero,
    output reg [31:0] alu_result, read_dat2out,
    output reg [4:0] five_bit_muxout
    );

    always @(posedge clk) begin
        ctrl_wb_out <= ctrl_wb_in;
        ctrl_mem_out <= ctrl_mem_in;

        branch <= ctrl_mem_in[2];
        memread <= ctrl_mem_in[1];
        memwrite <= ctrl_mem_in[0];

        add_result <= adder_out;
        zero <= alu_zero;
        alu_result <= alu_out;
        read_dat2out <= read_dat2;
        five_bit_muxout <= mux_out;
        
    end

endmodule