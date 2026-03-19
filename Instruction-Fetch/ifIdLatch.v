module ifIdLatch (
    input wire clk,rst,
    input wire [31:0] d,
    output reg [31:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 1;
        end else begin
            q<=d;
        end
    end

endmodule