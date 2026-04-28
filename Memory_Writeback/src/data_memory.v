`timescale 1ns / 1ps
module data_memory (
    input wire [31:0] addr, // Memory Address
    input wire [31:0] write_data, // Memory Address Contents
    input wire memread, memwrite, clk, rst, // refer to Lab 2-2 Figure 2.2
    output reg [31:0] read_data // Output of Memory Address Contents
    );

   reg [31:0] DMEM[0:255];  // 256 (2^8) words of 32-bit memory
   integer i;

   always @(posedge clk or posedge rst) begin
        if (rst) begin
            DMEM[0] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000;
            DMEM[1] <= 32'b0000_0000_0000_0000_0000_0000_0000_0001;
            DMEM[2] <= 32'b0000_0000_0000_0000_0000_0000_0000_0010;
            DMEM[3] <= 32'b0000_0000_0000_0000_0000_0000_0000_0011;
            DMEM[4] <= 32'b0000_0000_0000_0000_0000_0000_0000_0100;
            DMEM[5] <= 32'b0000_0000_0000_0000_0000_0000_0000_0101;
        end else if (memwrite) begin
            DMEM[addr] <= write_data;
        end
    end

    always @(*) begin
        if (memread) begin
            read_data = DMEM[addr];
        end else begin
            read_data = 32'd0;
        end
    end
endmodule 
