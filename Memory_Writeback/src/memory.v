module memory (
    input wire mem_ctrl_out,clk, Zero,
    input wire [1:0] WB,

    output wire RegWrite,MemtoReg,
    output wire [31:0] write_data,
    output wire [4:0] mem_write_reg
);

    
    
    memWbLatch u_memWbLatch(
        .ctrl_wb         	(ctrl_wb          ),
        .clk             	(clk              ),
        .read_dat        	(read_dat         ),
        .alu_result      	(alu_result       ),
        .five_bit_muxout 	(five_bit_muxout  ),
        .RegWrite        	(RegWrite         ),
        .MemtoReg        	(MemtoReg         ),
        .read_dat_out    	(read_dat_out     ),
        .mem_alu_result  	(mem_alu_result   ),
        .mem_write_reg   	(mem_write_reg    )
    );
    
    
    AND u_AND(
        .mem_ctrl_out 	(mem_ctrl_out  ),
        .Zero         	(Zero          ),
        .PCSrc        	(PCSrc         )
    );
    
    mux u_mux(
        .PCSrc          	(PCSrc           ),
        .PC_from_ExMem  	(PC_from_ExMem   ),
        .Incremented_PC 	(Incremented_PC  ),
        .address        	(address         )
    );
    
    
    

endmodule