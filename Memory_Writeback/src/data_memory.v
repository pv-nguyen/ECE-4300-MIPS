`timescale 1ns / 1ps
module data_memory (
    input wire [31:0] addr, // Memory Address
    input wire [31:0] write_data, // Memory Address Contents
    input wire memread, memwrite,clk, rst, // refer to Lab 2-2 Figure 2.2
    output reg [31:0] read_data // Output of Memory Address Contents
    );
// Register Declaration
   reg [31:0] DMEM[0:255];  // 256 (2^8) words of 32-bit memory
   integer i;

//     initial begin
//             read_data <= 0;
//         //  Initialize DMEM[0-5] from data.txt
//         //  This is testing the MIPS datapath (lab 6)
//             $readmemb("../src/data.txt",DMEM);
//             for (i = 0; i < 6; i = i + 1)
//                 $display("\tDMEM[%0d] = %0b", i, DMEM[i]);
//    end
   
   always@(posedge clk or posedge rst) begin
        if (rst) begin 
            DMEM[0] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000;
            DMEM[1] <= 32'b0000_0000_0000_0000_0000_0000_0000_0001;
            DMEM[2] <= 32'b0000_0000_0000_0000_0000_0000_0000_0010;
            DMEM[3] <= 32'b0000_0000_0000_0000_0000_0000_0000_0011;
            DMEM[4] <= 32'b0000_0000_0000_0000_0000_0000_0000_0100;
            DMEM[5] <= 32'b0000_0000_0000_0000_0000_0000_0000_0101;
        end
        if (memread) begin
                read_data <= DMEM[addr]; //grabs data at the address specified by the addr wire 
        end
        if (memwrite) begin
                DMEM[addr] <= write_data; //writes data to address specified by addr wire
        end
    end
endmodule 
