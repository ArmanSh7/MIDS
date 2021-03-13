`timescale 1ns/ 1ps
// Module Name: CPU_tb
// Project Name: CSE 141L
//
// This module is used to test the CPU on machine code in the MIDS ISA
// through a machine_code.txt file read into the instROM.


module CPU_tb;
reg     RESET;		// init/reset, active high
reg     START;		// start next program
reg     CLK;			// clock -- posedge used inside design
wire    ACK;   // done flag from DUT


CPU uut(
    .Reset(RESET),
    .Start(START),
    .Clk(CLK),
    .Ack(ACK)
);

initial CLK = 0;
initial forever #30 CLK = ~CLK;

always @(posedge CLK) begin
        $display("ProgCtr: %b = %d", uut.PgmCtr, uut.PgmCtr);
        $display("\tInstruction: %b", uut.Instruction);
        //$display("\tR0: %b", uut.RF1.Registers[0]);
        //$display("\tR1: %b", uut.RF1.Registers[1]);
        //$display("\tR2: %b", uut.RF1.Registers[2]);
        //$display("\tR3: %b", uut.RF1.Registers[3]);
        //$display("\tR4: %b", uut.RF1.Registers[4]);
        //$display("\tR5: %b", uut.RF1.Registers[5]);
        //$display("\tR6: %b", uut.RF1.Registers[6]);
        //$display("\tR7: %b", uut.RF1.Registers[7]);
        //$display("\tR8: %b", uut.RF1.Registers[8]);
        //$display("\tR9: %b", uut.RF1.Registers[9]);
        //$display("\tR10: %b", uut.RF1.Registers[10]);
        //$display("\tR11: %b", uut.RF1.Registers[11]);
        //$display("\tR12: %b", uut.RF1.Registers[12]);
        //$display("\tR13: %b", uut.RF1.Registers[13]);
        //$display("\tR14: %b", uut.RF1.Registers[14]);
        //$display("\tR15: %b", uut.RF1.Registers[15]);
        //$display("\tREG1_OUT: %b", uut.REG1_OUT);
        //$display("\tREG2_OUT: %b", uut.REG2_OUT);
        //$display("\tREG1_VAL: %b", uut.REG1_VAL);
        //$display("\tREG2_VAL: %b", uut.REG2_VAL);
        //$display("\tMemReadValue: %b", uut.MemReadValue);
        //$display("\tALU_OUT: %b", uut.ALU_out);
        //$display("\tMEM_OUTPUT: %b", uut.MEM_OUTPUT);
        //$display("\tREG_DATA_IN: %b", uut.REG_DATA_IN);
        //$display("\tALU_INPUTB: %b", uut.ALUINPUTB);
        //$display("\tALU_OP: %b", uut.alu_op);
        //$display("\tIMMEDIATE: %b", uut.IMMEDIATE);
        //$display("ProgCtr: %b", uut.PgmCtr);
        //$display("\tInstruction: %b", uut.Instruction);
        //$display("\tBRANCH: %b", uut.BRANCH);
        //$display("\tWRITE_REG: %b", uut.WRITE_REG);
        //$display("\tWRITE_MEM: %b", uut.WRITE_MEM);
        //$display("\tREAD_MEM: %b", uut.READ_MEM);
        //$display("\tMEM_OUTPUT: %b", uut.MEM_OUTPUT);
        //$display("\tUSE_IMMEDIATE: %b", uut.USE_IMMEDIATE);
        //$display("\tREG1_OUT: %b", uut.REG1_OUT);
        //$display("\tREG2_OUT: %b", uut.REG2_OUT);
        //$display("\tREG_IN: %b", uut.REG_IN);
        //$display("\tIMMEDIATE: %b", uut.IMMEDIATE);
        //$display("\tALU_OP: %b", uut.alu_op);
        //$display("\tREG1_VAL: %b", uut.REG1_VAL);
        //$display("\tREG2_VAL: %b", uut.REG2_VAL);
        //$stop;
end

always@*
begin
    if(ACK) begin
        $display("Finish, %b", ACK);
        $stop;
    end
    else if(uut.Instruction == 9'bxxxxxxxxx)begin
        $display("err:");
        $stop;
    end
end

initial 
begin
    RESET = 1;
    START = 0;
    #60
    RESET = 0;
    START = 0;

    //$display("DATA MEM 0: %b", uut.DM1.Core[0]);
    //$display("DATA MEM 1: %b", uut.DM1.Core[1]);
    //$display("DATA MEM 2: %b", uut.DM1.Core[2]);
    //$display("DATA MEM 3: %b", uut.DM1.Core[3]);
    //$display("DATA MEM 4: %b", uut.DM1.Core[4]);
    //$display("DATA MEM 5: %b", uut.DM1.Core[5]);
    //$display("DATA MEM 6: %b", uut.DM1.Core[6]);

    //$display("Done, %b", ACK);

    //$stop;
    
end

endmodule