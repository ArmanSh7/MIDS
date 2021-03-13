`timescale 1ns/ 1ps

// Module Name: Ctrl_tb
// Project Name: CSE141L
// 
// This module is a testbench for the Ctrl module. The Ctrl module
// is fed the machine code of an instruction from the MIDS ISA where it 
// translates it and sends each signal and data to the correct input.


module Ctrl_tb;
reg  [8:0] INSTRUCTION;    	// instruction input
wire BRANCH_ON, WRITE_REG, WRITE_MEM, READ_MEM, MEM_OUTPUT, USE_IMM;
wire [3:0] REG1_OUT, REG2_OUT, REG_IN;
wire [7:0] IMM;
wire [2:0] alu_op;

Ctrl uut(
    .Instruction(INSTRUCTION),	   
  	.branch_on(BRANCH_ON),
	.write_reg(WRITE_REG),
	.write_mem(WRITE_MEM),
	.read_mem(READ_MEM),
	.mem_output(MEM_OUTPUT),
	.use_imm(USE_IMM),
	.reg1_out(REG1_OUT), 
    .reg2_out(REG2_OUT), 
    .reg_in(REG_IN), 
    .imm(IMM),
	.ALU_OP(alu_op)
);

initial begin
    // R-Type -> ADD
    INSTRUCTION = 9'b000000001;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // R-Type -> SUB
    INSTRUCTION = 9'b000100010;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    
    // R-Type -> sll
    INSTRUCTION = 9'b001000011;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // R-Type -> slr
    INSTRUCTION = 9'b001100100;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // M-Type -> loi
    INSTRUCTION = 9'b010000101;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // M-Type -> lor
    INSTRUCTION = 9'b010100110;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // M-Type -> mov
    INSTRUCTION = 9'b011000111;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // B-Type -> slt
    INSTRUCTION = 9'b100001000;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // B-Type -> seq
    INSTRUCTION = 9'b100101001;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // B-Type -> b
    INSTRUCTION = 9'b101001010;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // B-Type -> halt
    INSTRUCTION = 9'b101101011;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // D-Type -> lw
    INSTRUCTION = 9'b110001100;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // D-Type -> lwi
    INSTRUCTION = 9'b110101101;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // D-Type -> sw - imm = 0
    INSTRUCTION = 9'b111001110;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);
    #10

    // D-Type -> swi 
    INSTRUCTION = 9'b111101111;
    #5
    $display("Instruction = %b", INSTRUCTION);
    $display("\tbranch_on = %b", BRANCH_ON);
    $display("\treg1_out = %b", REG1_OUT);
    $display("\treg2_out = %b", REG2_OUT);
    $display("\treg_in = %b", REG_IN);
    $display("\twrite_reg = %b", WRITE_REG);
    $display("\twrite_mem = %b", WRITE_MEM);
    $display("\tread_mem = %b", READ_MEM);
    $display("\tmem_output = %b", MEM_OUTPUT);
    $display("\tuse_imm = %b", USE_IMM);
    $display("\tALU_OP = %b", alu_op);
    $display("\timm = %b", IMM);

end

endmodule