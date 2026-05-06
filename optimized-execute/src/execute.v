module execute(
    input wire clk, ALUSrc, RegDst, rst,
    input wire [1:0] WB, ALUOp,
    input wire [2:0] Mem,
    input wire [31:0] NPC, ReadData1, ReadData2, SignExtend,
    input wire [4:0] Instr_2016, Instr_1511,
    input wire [4:0] id_ex_rs,
    input wire [4:0] mem_wb_write_reg,
    input wire [31:0] mem_wb_write_data,
    input wire mem_wb_reg_write,

    output wire [1:0] ctrl_wb_out,
    output wire [2:0] ctrl_mem_out,
    output wire branch, memread, memwrite,

    output wire [31:0] add_result,
    output wire zero,
    output wire [31:0] alu_result, read_dat2out,
    output wire [4:0] five_bit_muxout
    
);
    //connecting wires
    wire [31:0] top_mux_out;
    wire [2:0] alucontrol_out;

    // forwarding wires
    wire [1:0] forwardA, forwardB;
    wire [31:0] forwarded_readdat1, forwarded_readdat2;

    // input to latch
    wire [31:0] adder_out, alu_out;
    wire [4:0] bottom_mux_out;
    wire alu_zero;
    
    ex_mem_latch u_ex_mem_latch(
        //inputs
        .rst                (rst),
        .clk             	(clk              ),
        .ctrl_wb_in      	(WB      ),
        .ctrl_mem_in     	(Mem      ),
        .adder_out       	(adder_out        ),
        .alu_zero        	(alu_zero         ),
        .alu_out            (alu_out          ),
        .read_dat2          (forwarded_readdat2),
        .mux_out            (bottom_mux_out   ),

        //outputs
        .ctrl_wb_out     	(ctrl_wb_out      ),
        .ctrl_mem_out    	(ctrl_mem_out     ),
        .branch          	(branch           ),
        .memread         	(memread          ),
        .memwrite        	(memwrite         ),
        .add_result      	(add_result       ),
        .zero            	(zero             ),
        .alu_result      	(alu_result       ),
        .read_dat2out    	(read_dat2out     ),
        .five_bit_muxout 	(five_bit_muxout  )
    );
    
    forwarding u_forwarding(
        .id_ex_rs(id_ex_rs),
        .id_ex_rt(Instr_2016),
        .ex_mem_reg_rd(five_bit_muxout),
        .mem_wb_reg_rd(mem_wb_write_reg),
        .ex_mem_reg_write(ctrl_wb_out[1]),
        .mem_wb_reg_write(mem_wb_reg_write),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    assign forwarded_readdat1 = (forwardA == 2'b10) ? alu_result :
                                (forwardA == 2'b01) ? mem_wb_write_data :
                                ReadData1;

    assign forwarded_readdat2 = (forwardB == 2'b10) ? alu_result :
                                (forwardB == 2'b01) ? mem_wb_write_data :
                                ReadData2;

    adder u_adder(
        //input
        .add_in1(NPC),
        .add_in2(SignExtend),

        //output
        .add_out(adder_out)
    );

    top_mux u_top_mux(
        //input
        .ReadData2(forwarded_readdat2),
        .SignExtend(SignExtend),
        .ALUSrc(ALUSrc),

        //output
        .top_mux_out(top_mux_out)
    );
    
    bottom_mux u_bottom_mux(
        .Instr_2016      	(Instr_2016      ),
        .Instr_1511      	(Instr_1511      ),
        .RegDst          	(RegDst          ),
        .bottom_mux_out  	(bottom_mux_out  )
    );
    
    alu u_alu(
        .rdata1    	(forwarded_readdat1  ),
        .muxoutput 	(top_mux_out  ),
        .sel       	(alucontrol_out   ),
        .result    	(alu_out     ),
        .zero      	(alu_zero     )
    );
    
    
    alucontrol u_alucontrol(
        .funct  	(SignExtend[5:0]   ),
        .aluop  	(ALUOp   ),
        .select 	(alucontrol_out  )
    );
    

endmodule