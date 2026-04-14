module executeTB;
    reg clk;
    reg [1:0] ctlwb_in; 
    reg [2:0] ctlm_in;
    reg [31:0] npc, rdata1, rdata2, s_extend;
    reg [4:0] instr_2016, instr_1511;
    reg [1:0] alu_op;
    reg [5:0] funct;
    reg alusrc, regdst;

    wire [1:0] ctlwb_out; 
    wire [2:0] ctlm_out;
    wire [31:0] adder_out, alu_result_out, rdata2_out;
    wire [4:0] muxout_out;

    execute dut(
        .clk(clk),
        .WB(ctlwb_in),
        .Mem(ctlm_in),
        .NPC(npc),
        .ReadData1(rdata1),
        .ReadData2(rdata2),
        .SignExtend(s_extend),
        .Instr_2016(instr_2016),
        .Instr_1511(instr_1511),
        .ALUOp(alu_op),
        .ALUSrc(alusrc),
        .RegDst(regdst),
        .ctrl_wb_out(ctlwb_out),
        .ctrl_mem_out(ctlm_out),
        .add_result(adder_out),
        .alu_result(alu_result_out),
        .read_dat2out(rdata2_out),
        .five_bit_muxout(muxout_out)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("executeTB.vcd");
        $dumpvars(0, executeTB);
        // Initialize inputs
        ctlwb_in = 2'b10; ctlm_in = 2'b01;
        npc = 32'd100; rdata1 = 32'd10; rdata2 = 32'd20; s_extend = 32'd4;
        instr_2016 = 5'd5; instr_1511 = 5'd10;
        alu_op = 2'b10; funct = 6'b100000;
        alusrc = 1; regdst = 1;

        #15;

        // Modify inputs to test different scenarios
        alusrc = 0; regdst = 0;
        s_extend = 32'd8;
        alu_op = 2'b01; funct = 6'b100010;

        #15;

        $finish;
    end
endmodule