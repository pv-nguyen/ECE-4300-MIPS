`timescale 1ns / 1ps
/*
Takes in rdata1 as its input as well as "b," which is the output of top_mux.
It outputs result, later known as aluout, and zero, which is then aluzero for ex_mem.v.
This handles the logical and arithmetic correspondence.
*/
module alu(
            input wire [31:0] rdata1, // source from register
            input wire [31:0] muxoutput, // target from register
            input wire [2:0] sel,// select from alu_control
            output wire [31:0] result, // goes to MEM Data memory and MEM/WB latch
            output wire zero // goes to MEM Branch
            );

// Based on Lab 3-2 Instruction Operation and ALU control
parameter ALUadd = 3'b010,
        ALUsub = 3'b110,
        ALUand = 3'b000,     
        ALUor = 3'b001,
        ALUslt = 3'b111;

// Handles negative inputs
wire sign_mismatch; // 1 bit

assign sign_mismatch = 1'b0; // Set this up so that the ALUslt conditions match
assign sign_mismatch = rdata1[31]^muxoutput[31]; //XOR operation; only returns 1 if bits are different 
   
initial
    result = 4'b0000;
    always@*
        case(control)
            ALUadd: result = rdata1 + muxoutput;
            ALUsub: result = rdata1 - muxoutput;
            ALUand: result = rdata1 & muxoutput; // changed to bit-wise AND, should not be logical AND
            ALUor: result = rdata1 | muxoutput; // changes to bit-wise OR,  should not be logical OR
            ALUslt: result = rdata1 < muxoutput ? 1 - sign_mismatch : 0 + sign_mismatch; // (0)
            default: result = 32'bX; // control = ALUx | *
        endcase
    // check to see if result is equal to zero. if it is assign it true (1), false (0) otherwise, meaning it is a non-zero number
    /* result = (condition1) ? rA :
    (condition2) ? rB :
                                    rC) */
    assign zero = (result == 0) ? 1 : 0;
endmodule
//If the input information does not correspond to any valid instruction,
//aluop = 2'b11 which sets control = ALUx = 3'b011 
//and ALU output is 32 x's