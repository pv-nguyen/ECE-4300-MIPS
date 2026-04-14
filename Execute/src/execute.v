module execute(
    input wire clk,ALUSrc,RegDst,
    input wire [1:0] WB,ALUOp,
    input wire [2:0] Mem,
    input wire [31:0] NPC, ReadData1, ReadData2, SignExtend,
    input wire [4:0] Instr_2016,Instr_1511,

    output wire [1:0] ctrl_wb_out,
    output wire [2:0] ctrl_mem_out,
    output wire branch,memread,memwrite,

    output wire [31:0] add_result,
    output wire zero,
    output wire [31:0] alu_result, read_dat2out,
    output wire [4:0] five_bit_muxout
    
);
    //connecting wires
    wire [31:0] top_mux_out;
    wire [2:0] alucontrol_out;

    // input to latch
    wire [31:0] adder_out, alu_out;
    wire [4:0] bottom_mux_out;
    wire alu_zero;
    
    ex_mem_latch u_ex_mem_latch(
        //inputs
        .clk             	(clk              ),
        .ctrl_wb_in      	(WB      ),
        .ctrl_mem_in     	(Mem      ),
        .adder_out       	(adder_out        ),
        .alu_zero        	(alu_zero         ),
        .alu_out         	(alu_out          ),
        .read_dat2       	(ReadData2        ),
        .mux_out         	(bottom_mux_out   ),

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
    
    adder u_adder(
        //input
        .add_in1(NPC),
        .add_in2(SignExtend),

        //output
        .add_out(adder_out)
    );

    top_mux u_top_mux(
        //input
        .ReadData2(ReadData2),
        .SignExtend(SignExtend),
        .ALUSrc(ALUSrc),

        //output
        .top_mux_out(top_mux_out)
    );
    
    bottom_mux u_bottom_mux(
        .Instr_2016     	(Instr_2016      ),
        .Instr_1511     	(Instr_1511      ),
        .RegDst         	(RegDst          ),
        .bottom_mux_out 	(bottom_mux_out  )
    );
    
    alu u_alu(
        .rdata1    	(ReadData1  ),
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