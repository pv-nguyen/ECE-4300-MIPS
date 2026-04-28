`timescale 1ns / 1ps

`include "../Instruction-Fetch/fetch.v"
`include "../Instruction-Fetch/ifIdLatch.v"
`include "../Instruction-Fetch/incrementer.v"
`include "../Instruction-Fetch/instrMem.v"
`include "../Instruction-Fetch/mux.v"
`include "../Instruction-Fetch/pc.v"

`include "../Decode/src/decode.v"
`include "../Decode/src/control.v"
`include "../Decode/src/idExLatch.v"
`include "../Decode/src/registerFile.v"
`include "../Decode/src/signExtend.v"

`include "../Execute/src/execute.v"
`include "../Execute/src/adder.v"
`include "../Execute/src/alu.v"
`include "../Execute/src/alucontrol.v"
`include "../Execute/src/bottom_mux.v"
`include "../Execute/src/ex_mem_latch.v"
`include "../Execute/src/top_mux.v"

`include "../Memory_Writeback/src/memory.v"
`include "../Memory_Writeback/src/and.v"
`include "../Memory_Writeback/src/data_memory.v"
`include "../Memory_Writeback/src/memWbLatch.v"
`include "../Memory_Writeback/src/mux.v"

module full_pipeline(
    input wire clk, rst
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
            id_ex_sign_ext;
wire [4:0] id_ex_instr_2016,
            id_ex_instr_1511;

//EX/MEM LATCH OUTPUT 
wire [1:0] ex_mem_wb; 
wire MemRead,
    MemWrite, 
    MemBranch,
    ex_mem_zero; 
wire [31:0] PC_from_ExMem; 
wire [31:0] ex_mem_ALU_output; 
wire [31:0] ex_mem_readdata2;
wire [4:0] ex_mem_muxout; 

//MEM/WB LATCH OUTPUT
wire mem_wb_RegWrite;
wire mem_wb_PCSrc;
wire [31:0] mem_wb_write_data; 
wire [4:0] mem_wb_write_reg;

fetch u_fetch (
        .clk (clk),
        .rst (rst), 
        .ex_mem_pc_src (mem_wb_PCSrc), //DONE
        .ex_mem_npc (PC_from_ExMem), 
        .if_id_instr (instr_from_IfId_latch), 
        .if_id_npc (NPC_from_IfId_latch)
);

decode u_decode (
        .clk(clk), //DONE 
        .rst(rst), //DONE
        .wb_reg_write(mem_wb_RegWrite), //DONE
        .wb_write_reg_location(mem_wb_write_reg), //DONE
        .mem_wb_write_data(mem_wb_write_data), //DONE
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
    );

execute u_execute(
        .rst(rst),
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
        .ctrl_mem_out({MemBranch, MemRead, MemWrite}), //NOTE: dont think this is right notation
        .add_result(PC_from_ExMem), //DONE
        .alu_result(ex_mem_ALU_output), //DONE
        .read_dat2out(ex_mem_readdata2), //DONE
        .five_bit_muxout(ex_mem_muxout), //DONE
        .zero(ex_mem_zero)  //DONE
    );

memory u_memory (
        .clk(clk), //DONE
        .ex_alu_result(ex_mem_ALU_output), //DONE
        .ex_ctrl_wb(ex_mem_wb), //DONE
        .ex_five_bit_muxout(ex_mem_muxout), //DONE 
        .ex_memwrite(MemWrite), //DONE
        .ex_memread(MemRead), //DONE
        .ex_membranch(MemBranch), //DONE
        .ex_Zero(ex_mem_zero), //DONE
        .ex_read_dat2(ex_mem_readdata2), //DONE

        .RegWrite(mem_wb_RegWrite), //DONE
        .write_data(mem_wb_write_data), //DONE
        .mem_write_reg(mem_wb_write_reg), //DONE
        .PCSrc(mem_wb_PCSrc) //DONE
);

endmodule 