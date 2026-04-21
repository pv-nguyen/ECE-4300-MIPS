module memory (
    input wire ex_membranch,ex_memwrite,ex_memread,clk, ex_Zero,
    input wire [1:0] ex_ctrl_wb,
    input wire [31:0] ex_alu_result,ex_read_dat2,
    input wire [4:0] ex_five_bit_muxout,


    output wire RegWrite,MemtoReg,PCSrc,
    output wire [31:0] write_data,
    output wire [4:0] mem_write_reg
);

    wire [31:0] data_memory_out, read_dat_out, mem_alu_result;
    
    memWbLatch u_memWbLatch(
        .ctrl_wb         	(ex_ctrl_wb          ),
        .clk             	(clk              ),
        .read_dat_in        (data_memory_out         ),
        .alu_result      	(ex_alu_result       ),
        .five_bit_muxout 	(ex_five_bit_muxout  ),

        .RegWrite        	(RegWrite         ),
        .MemtoReg        	(MemtoReg         ),
        .read_dat_out    	(read_dat_out     ),
        .mem_alu_result  	(mem_alu_result   ),
        .mem_write_reg   	(mem_write_reg    )
    );
    
    
    AND u_AND(
        .mem_ctrl_out 	(ex_membranch  ),
        .Zero         	(ex_Zero          ),
        .PCSrc        	(PCSrc         )
    );
    
    wb_mux u_wb_mux(
        .read_dat       	(read_dat_out        ),
        .mem_alu_result 	(mem_alu_result  ),
        .select         	(MemtoReg          ),
        .write_data     	(write_data      )
    );
    
    
    data_memory u_data_memory(
        .clk(clk),
        .addr       	(ex_alu_result        ),
        .write_data 	(ex_read_dat2  ),
        .memread    	(ex_memread     ),
        .memwrite   	(ex_memwrite    ),
        .read_data  	(data_memory_out   )
    );
    
    

endmodule