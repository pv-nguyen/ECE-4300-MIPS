module fetch(
    input wire clk,rst,ex_mem_pc_src
    input wire [31:0] ex_mem_npc,
    output wire [31:0] if_id_instr, [31:0] if_id_npc
);

    // output declaration of module pc
    wire [31:0] instr_addr;
    
    pc u_pc(
        .in  	(next_addr   ),
        .out 	(instr_addr  ),
        .clk 	(clk  )
    );
    
    // output declaration of module instrMem
    reg [31:0] instr;
    
    instrMem #(.MEM_SIZE 	(2**32)) u_instrMem(
        .clk   	(clk    ),
        .addr  	(instr_addr   ),
        .instr 	(instr  )
    );
    
    // output declaration of module incrementer
    reg [31:0] incremented_pc = 0;
    
    incrementer u_incrementer(
        .clk            	(clk             ),
        .pc             	(instr_addr      ),
        .incremented_pc 	(incremented_pc  )
    );
    
    // output declaration of module mux
    wire [31:0] next_addr;
    
    mux u_mux(
        .PCSrc(ex_mem_pc_src),
        .PC_from_ExMem(ex_mem_npc),
        .address 	(next_addr  )
    );
    

    ifIdLatch u_instrMem_Latch(
        .clk 	(clk  ),
        .d   	(instr    ),
        .q   	(if_id_instr    )
    );
    
    ifIdLatch u_incremented_pc_Latch(
        .clk 	(clk  ),
        .d   	(incremented_pc    ),
        .q   	(if_id_npc    )
    );
    
    

endmodule