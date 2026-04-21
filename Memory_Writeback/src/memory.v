module memory (
    input wire membranch,memwrite,memread,clk, Zero,
    input wire [1:0] ctrl_wb,
    input wire [31:0] alu_result,read_dat2,
    input wire [4:0] five_bit_muxout,


    output wire RegWrite,MemtoReg,PCSrc,
    output wire [31:0] write_data,
    output wire [4:0] mem_write_reg
);

    wire [31:0] data_memory_out, read_dat_out, mem_alu_result;
    
    memWbLatch u_memWbLatch(
        .ctrl_wb         	(ctrl_wb          ),
        .clk             	(clk              ),
        .read_dat_in        (data_memory_out         ),
        .alu_result      	(alu_result       ),
        .five_bit_muxout 	(five_bit_muxout  ),

        .RegWrite        	(RegWrite         ),
        .MemtoReg        	(MemtoReg         ),
        .read_dat_out    	(read_dat_out     ),
        .mem_alu_result  	(mem_alu_result   ),
        .mem_write_reg   	(mem_write_reg    )
    );
    
    
    AND u_AND(
        .mem_ctrl_out 	(membranch  ),
        .Zero         	(Zero          ),
        .PCSrc        	(PCSrc         )
    );
    
    wb_mux u_wb_mux(
        .read_dat       	(read_dat_out        ),
        .mem_alu_result 	(mem_alu_result  ),
        .select         	(MemtoReg          ),
        .write_data     	(write_data      )
    );
    
    
    data_memory u_data_memory(
        .addr       	(alu_result        ),
        .write_data 	(read_dat2  ),
        .memread    	(memread     ),
        .memwrite   	(memwrite    ),
        .read_data  	(data_memory_out   )
    );
    
    

endmodule