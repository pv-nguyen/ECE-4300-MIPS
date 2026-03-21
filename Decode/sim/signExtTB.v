timescale 1ns / 1ps 
include "../src/signExtend.v"

module signExtTB {

}; 

reg [15:0] immediate; 
wire [31:0] extended;

signExtend u_signExtend(
    .immediate 	(immediate  ),
    .extended  	(extended   )
);

initial begin
    $dumpfile("signExtTB.vcd"); 
    $dumpvars(0, signExtTB); 
end

inital begin
    immediate = 16'b1000000000000011 
    #1; 
    immediate = 16'b0000111100001111
    #1; 
    immediate = 16'b0011001100110011
    #1; 
    $$display("Test Complete");
    $finish;

end