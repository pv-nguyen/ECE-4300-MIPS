module registerFile #(parameter MEM_SIZE = 32)(
<<<<<<< HEAD
    input wire clk, rst, regwrite,
    input wire [4:0] rs, rt, rd,
    input wire [31:0] writedata,
    output reg [31:0] A_readdat1, B_readdat2,
    output reg [31:0] r1, r2, r3, r0
);
=======
    input wire clk, rst, regwrite, 
    input wire [4:0] rs, rt, rd, 
    input wire [31:0] writedata, 
    output reg [31:0] A_readdat1, B_readdat2 ,
    output wire [31:0] r1, r2, r3, r0
); 
>>>>>>> 5e6e12916a6944531cfabfef53f240305fddc27b

reg [31:0] REG [0:MEM_SIZE-1];

initial begin
    REG[0] = 'h00000000; // $zero
    REG[1] = 'h10654321;
    REG[2] = 'h00100022;
    REG[3] = 'h8C123456;
    REG[4] = 'h8F123456;
    REG[5] = 'hAD654321;
    REG[6] = 'h60000066;
    REG[7] = 'h13012345;
    REG[8] = 'hAC654321;
    REG[9] = 'h12012345;
end

<<<<<<< HEAD
always @(posedge clk) begin
    if (regwrite && rd != 5'd0) begin
        REG[rd] <= writedata;
    end
end
=======
assign r0 = REG[0];
assign r1 = REG[1];
assign r2 = REG[2];
assign r3 = REG[3];

always @(posedge clk or posedge rst) begin 
    if (rst) begin 
        A_readdat1 <= 32'd0; 
        B_readdat2 <= 32'd0; 
    end else begin 
        if (regwrite) begin 
            REG[rd] <= writedata;
        end else begin
            A_readdat1 <= REG[rs]; 
            B_readdat2 <= REG[rt]; 
        end
>>>>>>> 5e6e12916a6944531cfabfef53f240305fddc27b

always @(*) begin
    if (rst) begin
        A_readdat1 = 32'd0;
        B_readdat2 = 32'd0;
        r0 = 32'd0;
        r1 = 32'd0;
        r2 = 32'd0;
        r3 = 32'd0;
    end else begin
        A_readdat1 = REG[rs];
        B_readdat2 = REG[rt];
        r0 = REG[0];
        r1 = REG[1];
        r2 = REG[2];
        r3 = REG[3];
    end
end

endmodule 