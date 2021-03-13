// Module Name:    CPU 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This is the TopLevel of your project
// Testbench will create an instance of your CPU and test it
// You may add a LUT if needed
// Set Ack to 1 to alert testbench that your CPU finishes doing a program or all 3 programs



	 
module CPU(Reset, Start, Clk, Ack);

	input Reset;		// init/reset, active high
	input Start;		// start next program
	input Clk;			// clock -- posedge used inside design
	output reg Ack;   // done flag from DUT

	wire [10:0] PgmCtr;        // program counter
	wire [8:0] 	Instruction;   // our 9-bit instruction

	wire [3:0] 	REG1_OUT, REG2_OUT, REG_IN;  // reg_file outputs & input
	wire [7:0] 	REG1_VAL, REG2_VAL;

	wire [7:0] 	ALU_out;       	// ALU result
	wire [2:0] 	alu_op;
	wire [7:0]  ALUINPUTB;
	wire [7:0] 	REG_DATA_IN;

	wire [7:0] 	IMMEDIATE; 		// immediate from instruction - 5 bit max extended to 8 bits
	wire [7:0] 	MemReadValue;  	// data out from data_memory
	wire        WRITE_MEM,	   	// data_memory write enable
				MEM_OUTPUT,  	// Mux control whether from ALU or data_memory
				REG_WRITE,	   	// reg_file write enable
				USE_IMMEDIATE, 	// Enable immediate to indicate reg or imm for ALU
				READ_MEM,		// data_memory write		      
				WRITE_REG,
				BRANCH;	   		// to program counter: branch enable
	reg  [15:0] CycleCt;	    // standalone; NOT PC!

	// Fetch = Program Counter + Instruction ROM
	// Program Counter
	InstFetch IF1 (
		.Reset       (Reset), 
		.Start       (Start),  
		.Clk         (Clk),  
		.Branch_On   (BRANCH),  	// BRANCH enable
		.Alu_op 	 (alu_op),  
		.R2_Val	     (REG1_VAL),
		.Target      (IMMEDIATE),
		.ProgCtr     (PgmCtr)	   	// program count = index to instruction memory
	);	

	// Control decoder
	Ctrl Ctrl1 (
		.Instruction   (Instruction),    // from instr_ROM
		.branch_on     (BRANCH),		     
		.write_reg     (WRITE_REG),		  
		.write_mem	   (WRITE_MEM),
		.read_mem      (READ_MEM),
		.mem_output    (MEM_OUTPUT),
		.use_imm       (USE_IMMEDIATE),
		.reg1_out      (REG1_OUT),
		.reg2_out      (REG2_OUT),
		.reg_in        (REG_IN),
		.imm           (IMMEDIATE),
		.ALU_OP        (alu_op)
	);
  
  
	// instruction ROM
	InstROM IR1(
		.InstAddress   (PgmCtr), 
		.InstOut       (Instruction)
	);
		
	always@*							  
	begin
		Ack = (Instruction == 9'b011100000) ? 1 : 0;  // Update this to the condition you want to set done to true
	end
	
	assign REG_DATA_IN = (MEM_OUTPUT) ? MemReadValue : ALU_out;
	//Reg file
	// Modify D = *Number of bits you use for each register*
   // Width of register is 8 bits, do not modify
	RegFile #(.W(8),.D(4)) RF1 (
		.Clk          (Clk),
		.WriteEn      (WRITE_REG), 
		.reg1_out     (REG1_OUT),         
		.reg2_out     (REG2_OUT), 
		.reg_in       (REG_IN), 	       
		.DataIn       (REG_DATA_IN), 
		.DataOutReg1  (REG1_VAL), 
		.DataOutReg2  (REG2_VAL)
	);
	
	
	assign ALUINPUTB = (USE_IMMEDIATE) ? IMMEDIATE : REG2_VAL;
	// Arithmetic Logic Unit
	ALU ALU1(
	  .InputA(REG1_VAL),      	  
	  .InputB(ALUINPUTB),
	  .OP(alu_op),				  
	  .Out(ALU_out)		  			
	);
	 
	 
	 // Data Memory
	DataMem DM1(
		.Clk 		  (Clk),
		.Reset		  (Reset),
		.write_mem    (WRITE_MEM),
		.read_mem	  (READ_MEM),
		.DataAddress  (ALU_out),  
		.DataIn       (REG2_VAL), 
		.DataOut      (MemReadValue) 
	);

	
// count number of instructions executed
// Help you with debugging
	always @(posedge Clk)
	  if (Start == 1)	   // if(start)
		 CycleCt <= 0;
	  else if(Ack == 0)   // if(!halt)
		 CycleCt <= CycleCt+16'b1;

endmodule