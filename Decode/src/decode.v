module decode(
    input wire        clk,
    input wire        rst,
    input wire        wb_reg_write, 
    input wire [4:0]  wb_write_reg_location,
    input wire [31:0] mem_wb_write_data,
    input wire [31:0] if_id_instr,
                       if_id_npc,
    output wire [1:0] id_ex_wb,
    output wire [2:0] id_ex_mem,
    output wire [3:0] id_ex_execute,
    output wire [31:0] id_ex_npc,
                       id_ex_readdat1,
                       id_ex_readdat2,
                       id_ex_sign_ext,
    output wire [4:0] id_ex_instr_bits_25_21,
    output wire [4:0] id_ex_instr_bits_20_16,
                       id_ex_bits_15_11,
    output wire [31:0] r1, r2, r3, r0
);

wire [31:0] sign_ext_internal,
readdat1_internal, 
readdat2_interal; 
wire [1:0] wb_internal; 
wire [2:0] mem_internal; 
wire [3:0] ex_internal; 

signExtend SE0(
    //COMPLETE PARAMETERS
    .immediate(if_id_instr[15:0]),
    .extended(sign_ext_internal)
);

registerFile rf0(
    //COMPLETE PARAMETERS
    .clk(clk),
    .rst(rst),
    .regwrite(wb_reg_write),
    .rs(if_id_instr[25:21]),
    .rt(if_id_instr[20:16]),
    .rd(wb_write_reg_location),
    .writedata(mem_wb_write_data),
    .A_readdat1(readdat1_internal),
    .B_readdat2(readdat2_interal),
    .r1(    r1), 
    .r2(r2), 
    .r3 (r3),
    .r0(r0)
);

control c0(
    //COMPLETE PARAMETERS
    .rst(rst ),
    .opcode(if_id_instr[31:26]),
    .wb(wb_internal),
    .mem(mem_internal),
    .ex(ex_internal)
);

idExLatch iEL0(
    //COMPLETE PARAMETERS
    .clk(clk),
    .rst(rst),
    .ctl_wb(wb_internal),
    .ctl_mem(mem_internal),
    .ctl_ex(ex_internal),
    .npc(if_id_npc),
    .readdat1(readdat1_internal),
    .readdat2(readdat2_interal),
    .sign_ext(sign_ext_internal),
    .instr_bits_25_21(if_id_instr[25:21]),
    .instr_bits_20_16(if_id_instr[20:16]),
    .instr_bits_15_11(if_id_instr[15:11]),

    .wb_out(id_ex_wb),
    .mem_out(id_ex_mem),
    .ctl_out(id_ex_execute),
    .npc_out(id_ex_npc),
    .readdat1_out(id_ex_readdat1),
    .readdat2_out(id_ex_readdat2),
    .sign_ext_out(id_ex_sign_ext),
    .instr_bits_25_21_out(id_ex_instr_bits_25_21),
    .instr_bits_20_16_out(id_ex_instr_bits_20_16),
    .instr_bits_15_11_out(id_ex_bits_15_11)
);


endmodule 