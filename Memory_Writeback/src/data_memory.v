`timescale 1ns / 1ps
module data_memory (
    input wire [31:0] addr, // Memory Address
    input wire [31:0] write_data, // Memory Address Contents
    input wire memread, memwrite,clk, // refer to Lab 2-2 Figure 2.2
    output reg [31:0] read_data // Output of Memory Address Contents
    );
// Register Declaration
   reg [31:0] DMEM[0:255];  // 256 (2^8) words of 32-bit memory
   integer i;

initial 
    begin
        read_data <= 0;
    //  Initialize DMEM[0-5] from data.txt
    //  This is testing the MIPS datapath (lab 6)
        $readmemb("../src/data.txt",DMEM);
        for (i = 0; i < 6; i = i + 1)
            $display("\tDMEM[%0d] = %0b", i, DMEM[i]);
   end
   
   always@(posedge clk) begin
        if (memread) // load
            begin
                read_data <= DMEM[addr]; //grabs data at the address specified by the addr wire 
            end
        if (memwrite) // store
            begin
                DMEM[addr] <= write_data; //writes data to address specified by addr wire
            end
        end
endmodule 
