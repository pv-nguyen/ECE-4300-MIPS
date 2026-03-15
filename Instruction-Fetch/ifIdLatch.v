module ifIdLatch (
    input wire clk,
    input wire [31:0] d,
    output reg [31:0] q
);
    always @(posedge clk) begin
        q <= d;
    end

endmodule