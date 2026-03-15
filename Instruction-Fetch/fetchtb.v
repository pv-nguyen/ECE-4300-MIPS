``timescale 1ns/1ps

module fetchtb ();
    
    wire [31:0] if_id_instr;
    wire [31:0] if_id_npc;
    reg clk;
    
    fetch u_fetch(
        .ex_mem_npc  	(ex_mem_npc   ),
        .if_id_instr 	(if_id_instr  ),
        .if_id_npc   	(if_id_npc    )
    );
    
    
    always #5 clk = ~clk;

    initial begin

        //initial values
        clk = 0;
    end

    initial begin
        $$monitor("Instr = %h","PC = %h",if_id_instr,if_id_npc);
    end
endmodule