`timescale 1ns / 1ps
module alucontrol_tb ();
    //Wire Ports
    wire [2:0] select;
    //Register Declarations
    wire [1:0] alu_op;
    wire [5:0] funct;

    alucontrol aluccontrol1 
        (
        .select(select),
        .aluop(alu_op), 
        .funct(funct) 
        );

initial 
    begin
        $dumpfile("alucontrol_tb.vcd"); 
        $dumpvars(0, alucontrol_tb);
        alu_op = 2'b00; // lwsw
        funct = 6'b100000; // select = 010
        $monitor("ALUOp = %b\tfunct = %b\tselect = %b", alu_op, funct, select);
        #1
        alu_op = 2'b01; // I-type
        funct = 6'b100000; // select = 110
        #1
        alu_op = 2'b10; // R-type, and so are all subsequent opcodes
        funct = 6'b100000; // add, therefore select = 010
        #1
        funct = 6'b100010; // select = 110
        #1
        funct = 6'b100100; // select = 000
        #1
        funct = 6'b100101; // select = 001
        #1
        funct = 6'b101010; // select = 111
        #1
        $finish;
    end
endmodule //alu_control_testbench