module instrMem(
    input wire clk,
    input wire [31:0] addr,
    output reg [31:0] instr
);
    parameter MEM_SIZE = 2**32;
    reg [31:0] memory [MEM_SIZE-1:0]; //32 bit word, 2^32 slots

    always @(posedge clk) begin
        instr <= memory[addr];
    end
endmodule