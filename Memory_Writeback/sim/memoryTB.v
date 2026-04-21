module memoryTB();
    reg clk;
    reg [31:0] ALUResult, WriteData;
    reg [4:0] WriteReg;
    reg [1:0] WB;
    reg MemWrite, MemRead, Branch, Zero;
    wire [31:0] ReadData, ALUResult_out;
    wire [4:0] WriteReg_out;
    wire [1:0] WBControl_out;
    wire PCSrc;

    memory uut (
        .clk(clk),
        .alu_result(ALUResult),
        .write_data(WriteData),
        .mem_write_reg(WriteReg),
        .ctrl_wb(WBControl),
        .memwrite(MemWrite),
        .memread(MemRead),
        .membranch(Branch),
        .Zero(Zero),
        .read_dat2(ReadData),
        .RegWrite(WriteReg_out),
        .write_data(WriteDate_out), 
        .mem_write_reg(MemWriteReg) 
    );
    initial begin
        $dumpfile("memoryTB.vcd"); 
        $dumpvars(0, memoryTB);

        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
     // Mem Read
    ALUResult = 32'h00000004;
    WriteData = 32'h12345678;
    WriteReg = 5'h02;
    WBControl = 2'b01;
    MemWrite = 0;
    MemRead = 1;
    Branch = 0;
    Zero = 0;

    #10; 

    // Mem Write
    MemWrite = 1;
    MemRead = 0;
    #10; // Allow write to occur
    MemWrite = 0;
    MemRead = 1;
    #10; // Verify write by reading back

    // Branch
    Branch = 1;
    Zero = 1;
    #10; // Check PCSrc

    $finish;
end
endmodule

