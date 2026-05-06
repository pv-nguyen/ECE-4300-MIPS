module executeTB;
    reg clk;
    reg [1:0] ctlwb_in; 
    reg [2:0] ctlm_in;
    reg [31:0] npc, rdata1, rdata2, s_extend;
    reg [4:0] instr_2016, instr_1511;
    reg [1:0] alu_op;
    wire [5:0] funct;
    reg alusrc, regdst;
    reg [4:0] id_ex_rs;
    reg [4:0] mem_wb_write_reg;
    reg [31:0] mem_wb_write_data;
    reg mem_wb_reg_write;

    wire [1:0] ctlwb_out; 
    wire [2:0] ctlm_out;
    wire [31:0] adder_out, alu_result_out, rdata2_out;
    wire [4:0] muxout_out;
    wire zero;

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
        .id_ex_rs(id_ex_rs),
        .mem_wb_write_reg(mem_wb_write_reg),
        .mem_wb_write_data(mem_wb_write_data),
        .mem_wb_reg_write(mem_wb_reg_write),
        .ctrl_wb_out(ctlwb_out),
        .ctrl_mem_out(ctlm_out),
        .add_result(adder_out),
        .alu_result(alu_result_out),
        .read_dat2out(rdata2_out),
        .five_bit_muxout(muxout_out),
        .zero(zero)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    assign funct = s_extend[5:0];
    initial begin
        $dumpfile("executeTB.vcd");
        $dumpvars(0, executeTB);
        // Initialize inputs
        ctlwb_in = 2'b11; 
        ctlm_in = 3'b010;
        npc = 32'd100;
        rdata1 = 32'd20; 
        rdata2 = 32'd12; 
        s_extend = 32'b100000; //32
        instr_2016 = 5'd5; 
        instr_1511 = 5'd10;
        alu_op = 2'b10;
        alusrc = 0; 
        regdst = 1;
        id_ex_rs = 5'd0;
        mem_wb_write_reg = 5'd0;
        mem_wb_write_data = 32'd0;
        mem_wb_reg_write = 1'b0;

        #10;
        ctlwb_in = 2'b10; //test that WB and MEM go straight to output
        ctlm_in = 3'b000;

        #10;
        npc = 32'd200; //test that the adder works, goes from 104 to 204

        #10; 
        alu_op = 2'b10;    //test the ALU, substract R-type, should give 20-12 = 8
        s_extend = 32'b100010; //sign extend 100010 => subtract

        #10;
        rdata2 = 32'd20; //test that changing rdata 2 makes ALU subtract 20-20 = 0, test 0 flag

        #10;
        s_extend = 32'b100100; //test AND
        rdata1 = 32'b111000;
        rdata2 = 32'b001111;

        #10;
        s_extend = 32'b100101; //test OR
        rdata1 = 32'b000111;
        rdata2 = 32'b111000;

        #10;
        s_extend = 32'b101010; //test Set on Less than
        rdata1 = 32'd30;
        rdata2 = 32'd50;

        #10;
        rdata1 = 32'd60;

        #10;
        alu_op = 2'b01; //test BEQ, should subtract, 60-50 = 10

        #10;
        alu_op = 2'b00; //test LW & SW, should add 60+50 =110;

        #10;
        alu_op = 2'b10; //go back to R-Type


        #10;
        alusrc = 1; //test the mux, ALU now does 20-4 = 16

        #10;
        s_extend = 32'd20; //test changing sign extend, ADD_RESULT now 220, ALU now does 20-20 = 0;


        #10;
        regdst = 0; //test fivebitmuxout changes from Instr_2016 (5) to Instr_1511 (10)

        
        #15;

        $finish;
    end
endmodule