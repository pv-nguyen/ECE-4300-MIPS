module fetch(
    input wire clk,rst,ex_mem_pc_src,
    input wire [31:0] ex_mem_npc,
    output wire [31:0] if_id_instr, if_id_npc
);

    // output declaration of module pc
    wire [31:0] pc_out;
    wire [31:0] instr;
    wire [31:0] incremented_pc;
    wire [31:0] pc_next;
    
    pc u_pc(
        .in  	(pc_next   ),
        .out 	(pc_out  ),
        .clk 	(clk  )
    );
    
    instrMem #(.MEM_SIZE 	(2**16)) u_instrMem(
        .clk   	(clk    ),
        .rst    (rst    ), 
        .addr  	(pc_out   ),
        .instr 	(instr  )
    );
    
    incrementer u_incrementer(
        .pc             	(pc_out      ),
        .incremented_pc 	(incremented_pc  )
    );
    
    mux u_mux(
        .Incremented_PC(incremented_pc),
        .PCSrc(ex_mem_pc_src),
        .PC_from_ExMem(ex_mem_npc),
        .address 	(pc_next  )
    );
    
    ifIdLatch u_instrMem_Latch(
        .rst    (       rst) ,
        .clk 	(clk  ),
        .d   	(instr    ),
        .q   	(if_id_instr    )
    );
    
    ifIdLatch u_incremented_pc_Latch(
        .rst    (rst  ),
        .clk 	(clk  ),
        .d   	(incremented_pc    ),
        .q   	(if_id_npc    )
    );
    
    

endmodule
