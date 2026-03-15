module instrMem#(parameter MEM_SIZE = 2**32) (
    input wire clk, rst,
    input wire [31:0] addr,
    output reg [31:0] instr
);
    reg [31:0] memory [0:MEM_SIZE-1]; //32 bit word, 2^32 slots


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            memory[0] <= 32'hA00000AA;
            memory[1] <= 32'h10000011;
            memory[2] <= 32'h20000022;
            memory[3] <= 32'h30000033;
            memory[4] <= 32'h40000044;
            memory[5] <= 32'h50000055;
            memory[6] <= 32'h60000066;
            memory[7] <= 32'h70000077;
            memory[8] <= 32'h80000088;
            memory[9] <= 32'h90000099;
            instr <= 32'hA00000AA;
        end else begin
            instr <= memory[addr];
        end
    end
endmodule