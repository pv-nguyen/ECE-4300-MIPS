module pc (
    input wire [31:0] in,
    output reg [31:0] out,
    input wire clk
);
    always @(posedge clk) begin
        out <= in;
    end
endmodule