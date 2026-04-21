module memoryTB();
    reg clk,ex_memwrite, ex_memread, ex_branch, Zero;
    reg [31:0] ex_alu_result, ex_read_dat2;
    reg [4:0] ex_writereg;
    reg [1:0] ex_wb;

    wire [31:0] WriteData;
    wire RegWrite;
    wire [31:0] ALUResult_out;
    wire [4:0] mem_write_reg;
    wire [1:0] WBControl_out;
    wire PCSrc;



    memory uut (
        .clk(clk),
        .ex_alu_result(ex_alu_result),
        .ex_ctrl_wb(ex_wb),
        .ex_five_bit_muxout(ex_writereg),
        .ex_memwrite(ex_memwrite),
        .ex_memread(ex_memread),
        .ex_membranch(ex_branch),
        .ex_Zero(Zero),
        .ex_read_dat2(ex_read_dat2),

        .RegWrite(RegWrite),
        .write_data(WriteData),
        .mem_write_reg(mem_write_reg),
        .PCSrc(PCSrc)
    );


    initial begin
        $dumpfile("memoryTB.vcd"); 
        $dumpvars(0, memoryTB);

        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Mem Read
        ex_alu_result = 32'h00000004;
        ex_read_dat2 = 32'h12345678;
        ex_writereg = 5'h02;
        ex_wb = 2'b01;
        ex_memwrite = 0;
        ex_memread = 1;
        ex_branch = 0;
        Zero = 0;

        #10; 
        ex_alu_result = 32'h00000003;
        #10;
        ex_alu_result = 32'h00000002;
        #10;
        ex_memwrite = 1;
        #10;
        ex_read_dat2 = 32'h67;
        #10;
        ex_read_dat2 = 32'h21;
        #10;
        ex_memwrite = 0;
        #10;
        ex_read_dat2 = 32'h76;
        #10;
        ex_wb = 2'b10;
        #10;
        ex_alu_result = 32'h04;
        #10;
        ex_writereg = 5'h01;
        #10;
        ex_branch = 1;
        #10;
        Zero = 1;
        #10;
        ex_wb = 2'b11;
        #10;
        ex_memread = 0;
        #10;
        ex_alu_result = 32'h03;

        $finish;
    end
endmodule

