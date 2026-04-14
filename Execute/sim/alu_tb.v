`timescale 1ns / 1ps
/*
Tests alu.v
*/
module alu_tb;
// Inputs
    reg [31:0] readdata1;
    reg [31:0] muxout;
    reg [2:0] control;
    // Outputs
    wire [31:0] result;
    wire zero;
// Instantiate the Unit Under Test (UUT)
alu uut (
            .rdata1(readdata1), 
            .muxoutput(muxout), 
            .sel(control), 
            .result(result), 
            .zero(zero)
        );

initial
    begin
        $dumpfile("alu_tb.vcd"); 
        $dumpvars(0, alu_tb);
        readdata1 = 'b1010; // 10
        muxout = 'b0111; // 7
        control = 'b011;
        $display("A = %b\t B = %b", readdata1, muxout);
        $monitor("ALU_Control = %b\t result = %b\t zero = %b", control, result, zero);
        #1 
        control = 'b100;
        #1 
        control = 'b010;
        #1 
        control = 'b111; // result = 0 check slt
        #1 
        control = 'b011;
        #1 
        control = 'b110;
        #1 
        control = 'b001; // result = 'b1111, check or
        #1 
        control = 'b000; // result = 'b10, check and
        #1
        $finish;
    end
      
endmodule