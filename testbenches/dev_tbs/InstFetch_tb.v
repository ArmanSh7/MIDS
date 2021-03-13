`timescale 1ns/ 1ps

//Test bench
//InstFetch (Program Counter)
/*
* Reset -       reset, init, etc. -- force PC to 0 
* Start -       begin next program in series
* Clk -         PC can change on pos. edges only
* Branch_On -   jump conditionally to Target + PC
* R2_Val -      value from R2 (if r2 == 1 and it's a branch)
* Target -      jump ... "how high?"
* ProgCtr -     the program counter register itself
*/

module InstFetch_tb;
reg RESET;
reg START;
reg CLK;
reg BRANCH_ON;
reg [2:0] ALU_OP;
reg [7:0] R2_VAL;
wire [10:0] PRG_CTR;
reg  [10:0] TARGET;

InstFetch uut(
    .Reset(RESET),
    .Start(START),
    .Clk(CLK),
    .Branch_On(BRANCH_ON),
    .Alu_op(ALU_OP),
    .R2_Val(R2_VAL),
    .Target(TARGET),
    .ProgCtr(PRG_CTR)
);

initial CLK = 0;
initial forever #5 CLK = ~CLK;

initial begin 
    // Reset the InstFetch (PC) to 0
    RESET = 1;
    START = 0;
    BRANCH_ON = 0;
    ALU_OP = 0;
    R2_VAL = 0;
    TARGET = 0;
    #10
    $display("Reset to 0, Program Counter = %b", PRG_CTR);

    // Increment PC by (#50 / #10 = 5 times)
    RESET = 0;
    START = 0;
    BRANCH_ON = 0;
    ALU_OP = 0;
    R2_VAL = 0;
    TARGET = 0;
    #50
    $display("Increment PC by 5 clock cycles, Program Counter = %b", PRG_CTR);


    // Reset the InstFetch (PC) to 0
    RESET = 1;
    START = 0;
    BRANCH_ON = 0;
    ALU_OP = 0;
    R2_VAL = 0;
    TARGET = 0;
    #10
    $display("Reset to 0, Program Counter = %b", PRG_CTR);

    // Increment PC by (#30 / #10 = 3 times)
    RESET = 0;
    START = 0;
    BRANCH_ON = 0;
    ALU_OP = 0;
    R2_VAL = 0;
    TARGET = 0;
    #30
    $display("Increment PC by 3 clock cycles, Program Counter = %b", PRG_CTR);

    // Branch (offset) by 14
    RESET = 0;
    START = 0;
    BRANCH_ON = 1;
    ALU_OP = 3'b000;
    R2_VAL = 8'b00000001;
    TARGET[7:0] = 8'b00001110;
    #10
    $display("Branch by 14, Program Counter = %b", PRG_CTR);

    // Branch (offset) by -5
    RESET = 0;
    START = 0;
    BRANCH_ON = 1;
    ALU_OP = 3'b001;
    R2_VAL = 1;
    TARGET = 5;
    #10
    $display("Branch by -5, Program Counter = %b", PRG_CTR);

    // Branch (offset) by +31
    RESET = 0;
    START = 0;
    BRANCH_ON = 1;
    ALU_OP = 3'b000;
    R2_VAL = 1;
    TARGET = 31;
    #10
    $display("Branch by +31, Program Counter = %b", PRG_CTR);

    // Branch (offset) by -31
    RESET = 0;
    START = 0;
    BRANCH_ON = 1;
    ALU_OP = 3'b001;
    R2_VAL = 1;
    TARGET = 31;
    #10
    $display("Branch by -31, Program Counter = %b", PRG_CTR);

    // Hold value for 10 clock cycles
    RESET = 0;
    START = 1;
    BRANCH_ON = 0;
    ALU_OP = 0;
    R2_VAL = 0;
    TARGET = 0;
    #100
    $display("Hold value for 10 clock cycles, Program Counter = %b", PRG_CTR);

    $display("done");

end

    

endmodule 