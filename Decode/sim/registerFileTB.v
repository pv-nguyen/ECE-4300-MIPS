`timescale 1ns/1ps

module registerFileTB(); 

wire [31:0] A_readdat1, B_readdat2; 
reg clk, rst, regWrite;
reg [4:0] rs, rt, rd; 
reg [31:0] writedata; 

registerFile DUT (
    .A_readdat1(A_readdat1), 
    .B_readdat2(B_readdat2), 
    .clk(clk), 
    .rst(rst), 
    .regwrite(regWrite), 
    .rs(rs),
    .rt(rt), 
    .rd(rd), 
    .writedata(writedata)
);

initial begin 
    $dumpfile("registerFileTB.vcd"); 
    $dumpvars(0, registerFileTB);
end

initial begin 
    clk = 0; 
    forever #1 clk = ~clk;
end

initial begin
    regWrite = 0; 
    rst = 1; 
    rs = 0; 
    rt = 2;
    rd = 2; 
    writedata = 32'hAAAAAAAA; 
    #10; 
    rst = 0;
    #10; 
    regWrite = 1;
    #10; 
    regWrite = 0;
    #10;
    $display("Test Complete"); 
    $finish; 
end

initial begin 
    $monitor ("Time = %0t A=%h B = %h regwrite=%b, rst=%b", 
    $time, A_readdat1, B_readdat2, regWrite, rst); 
end

endmodule 