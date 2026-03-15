module incrementer(
    input wire clk,
    input wire [31:0] pc,
    output reg [31:0] incremented_pc
);
    always @(posedge clk) begin
        incremented_pc <= pc+1; //should be add 4 bytes because each instr is 4 bytes, ignore for now
    end
endmodule