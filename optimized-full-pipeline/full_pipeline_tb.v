`timescale 1ns / 1ps

module full_pipeline_tb ();
    reg clk;
    reg rst;

    full_pipeline uut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        $dumpfile("full_pipeline_tb.vcd");
        $dumpvars(0, full_pipeline_tb);

        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    initial begin
        rst = 1;
        #10 rst = 0;
        #200 $finish;
    end
    
    
endmodule

