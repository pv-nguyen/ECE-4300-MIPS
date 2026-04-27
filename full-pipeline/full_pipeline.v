`include "../Instruction-Fetch/fetch.v"
`include "../Decode/src/decode.v"

module full_pipeline(

    input wire clk,
                rst,
); 
//FETCH OUTPUT 
wire [31:0] instr_from_IfId_latch, 
            NPC_from_IfId_latch;

//ID/EX LATCH OUTPUT 
wire [1:0] id_ex_wb; 
wire [2:0] id_ex_mem;
wire [3:0] id_ex_execute; 
wire [31:0] id_ex_npc,
            id_ex_readdat1,
            id_ex_readdat2,
            id_ex_sign_ext,
wire [4:0] id_ex_instr_2016,
            id_ex_instr_1511

//EX/MEM LATCH OUTPUT 
wire [2:0] ex_mem_wb; 
wire MemRead,
    MemWrite, 
    MemBranch,
    ex_mem_zero; 
wire [31:0] PC_from_ExMem; 
wire [31:0] ex_mem_ALU_output; 
wire [31:0] ex_mem_readdata2;
wire [4:0] ex_mem_muxout; 

//MEM/WB LATCH OUTPUT

fetch u_fetch (
        .clk (clk),
        .rst (rst), 
        .ex_mem_pc_src (PC_from_ExMem), //DONE
        .ex_mem_npc (PC_from_ExMem), 
        .if_id_instr (instr_from_IfId_latch), 
        .if_id_npc (NPC_from_IfId_latch), 
)

decode u_decode (
        .clk(clk), //DONE 
        .rst(rst), //DONE
        .wb_reg_write(wb_reg_write_tb), //FIXME
        .wb_write_reg_location(wb_write_reg_location_tb), //FIXME
        .mem_wb_write_data(mem_wb_write_data_tb), //FIXME
        .if_id_instr(instr_from_IfId_latch), //DONE
        .if_id_npc(NPC_from_IfId_latch), //DONE
        .id_ex_wb(id_ex_wb), //DONE
        .id_ex_mem(id_ex_mem), //DONE
        .id_ex_execute(id_ex_execute), //DONE
        .id_ex_npc(id_ex_npc), //DONE
        .id_ex_readdat1(id_ex_readdat1), //DONE
        .id_ex_readdat2(id_ex_readdat2), //DONE
        .id_ex_sign_ext(id_ex_sign_ext), //DONE
        .id_ex_instr_bits_20_16(id_ex_instr_2016), //DONE
        .id_ex_bits_15_11(id_ex_instr_1511) //DONE
    )

execute u_decode(
        .clk(clk), //DONE
        .WB(id_ex_wb), //DONE
        .Mem(id_ex_mem),  //DONE
        .NPC(id_ex_npc), //DONE
        .ReadData1(id_ex_readdat1), //DONE
        .ReadData2(id_ex_readdat2), //DONE
        .SignExtend(id_ex_sign_ext), //DONE
        .Instr_2016(id_ex_instr_2016), //DONE
        .Instr_1511(id_ex_instr_1511), //DONE
        .ALUOp(id_ex_execute[2:1]), //DONE
        .ALUSrc(id_ex_execute[0]), //DONE
        .RegDst(id_ex_execute[3]), //DONE
        .ctrl_wb_out(ex_mem_wb), //DONE
        .ctrl_mem_out([MemBranch, MemRead, MemWrite]), //NOTE: dont think this is right notation
        .add_result(PC_from_ExMem), //DONE
        .alu_result(ex_mem_ALU_output), //DONE
        .read_dat2out(ex_mem_readdata2), //DONE
        .five_bit_muxout(ex_mem_muxout), //DONE
        .zero(ex_mem_zero)  //DONE
    );

memory u_memory (
        .clk(clk), //FIXME
        .ex_alu_result(ex_alu_result), //FIXME
        .ex_ctrl_wb(ex_wb), //FIXME
        .ex_five_bit_muxout(ex_writereg), //FIXME 
        .ex_memwrite(ex_memwrite), //FIXME
        .ex_memread(ex_memread), //FIXME
        .ex_membranch(ex_branch), //FIXME
        .ex_Zero(Zero), //FIXME
        .ex_read_dat2(ex_read_dat2), //FIXME

        .RegWrite(RegWrite), //FIXME
        .write_data(WriteData), //FIXME
        .mem_write_reg(mem_write_reg), //FIXME
        .PCSrc(PCSrc) //FIXME
)

endmodule 