`timescale 1ns/1ps

module fetchtb ();
    wire [31:0] ex_mem_npc = 32'h0000_0000;
    wire [31:0] if_id_instr;
    wire [31:0] if_id_npc;
    reg clk,rst;
    reg ex_mem_pc_src;
    
    fetch u_fetch(
        .clk           	(clk            ),
        .rst           	(rst            ),
        .ex_mem_pc_src 	(ex_mem_pc_src  ),
        .ex_mem_npc    	(ex_mem_npc     ),
        .if_id_instr   	(if_id_instr    ),
        .if_id_npc     	(if_id_npc      )
    );
    
    
    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end 

    initial begin

        //initial values
        $dumpfile("fetchtb.vcd");
        $dumpvars(0, fetchtb);
        rst = 1;
        ex_mem_pc_src = 0;
        #5 
        rst = 0;
        #45
        ex_mem_pc_src = 1;
        #10
        ex_mem_pc_src = 0;
        #125
        $finish;
    end

    initial begin
        $monitor("Instr = %h, Next_PC = %h",if_id_instr,if_id_npc);
    end
endmodule