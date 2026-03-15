module incrementer(
    input wire clk, rst,
    input wire [31:0] pc,
    output reg [31:0] incremented_pc
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            incremented_pc<=0;
        end else begin
            incremented_pc <= pc+1; //should be add 4 bytes because each instr is 4 bytes, ignore for now
        end
    end
endmodule