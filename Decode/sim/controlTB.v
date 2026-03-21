`timescale 1ns / 1ps
module controlTB;

    wire [1:0] wb; 
    wire [2:0] mem; 
    wire [3:0] ex; 
    reg clk, rst; 
    reg [5:0] opcode; 

    control DUT (
        .wb(wb), 
        .mem(mem), 
        .ex(ex), 
        .clk(clk), 
        .rst(rst), 
        .opcode(opcode)
    ); 

    initial begin 
        $dumpfile("controlTB.vcd"); 
        $dumpvars(0, controlTB);
        end

    parameter RTYPE = 6'b000000; 
    parameter LW = 6'b100011;
    parameter SW = 6'b101011; 
    parameter BEQ = 6'b000100; 
    parameter NOP = 6'b100000; 

    initial begin 
        clk = 0; 
        forever #1 clk = ~clk; 
    end

    initial begin 
        rst = 1; 
        opcode = RTYPE; 
        #2; 

        rst = 0; 
        #2; 
        opcode = LW; 
        #2; 
        opcode = SW; 
        #2;
        opcode = BEQ; 
        #2; 
        opcode = NOP;
        #2;
        opcode = 6'b111100;
        #2;
        $display("Test Complete"); 

        $finish;   
    end

    initial begin 
        $monitor("Time=%0t opcode=%b wb=%b mem=%b ex=%b rst=%b", 
        $time, opcode, wb, mem, ex, rst);

    end
endmodule 