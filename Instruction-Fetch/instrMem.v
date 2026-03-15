module instrMem#(parameter MEM_SIZE = 2**32) (
    input wire clk,
    input wire [31:0] addr,
    output reg [31:0] instr
);
    reg [31:0] memory [MEM_SIZE-1:0]; //32 bit word, 2^32 slots

    assign memory[0] = 8'hA00000AA;
    assign memory[1] = 10000011;
    assign memory[2] = 20000022;
    assign memory[3] = 30000033;
    assign memory[4] = 40000044;
    assign memory[5] = 50000055;
    assign memory[6] = 60000066;
    assign memory[7] = 70000077;
    assign memory[8] = 80000088;
    assign memory[9] = 90000099;

    always @(posedge clk) begin
        instr <= memory[addr];
    end
endmodule