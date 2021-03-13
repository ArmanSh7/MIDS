`timescale 1ns/ 1ps

//Test bench
//Arithmetic Logic Unit
/*
* INPUT: A, B
* op: 000, A PLUS B
* op: 001, A SUB B
* op: 010, A << B
* op: 011, A >> B
* op: 100, (A < B) ? 1 : 0
* op: 101, (A == B) ? 1 : 0
* OUTPUT A op B
* equal: is A == B?
* even: is the output even?
*/


module ALU_tb;
reg [ 7:0] INPUTA;    	// data inputs
reg [ 7:0] INPUTB;
reg [ 2:0] op;			// ALU opcode, part of microcode
wire[ 7:0] OUT;		  
 
 
reg [ 7:0] expected;
 
// CONNECTION
ALU uut(
  .InputA(INPUTA),      	  
  .InputB(INPUTB),
  .OP(op),				  
  .Out(OUT)		  			
    );
	 
initial begin

	INPUTA = 1;
	INPUTB = 1; 
	op= 'b000; 		// ADD
	test_alu_func; 	// void function call
	#5;

	INPUTA = 8'b11111111;
	INPUTB = 1; 
	op= 'b000; 		// ADD w/ overflow
	test_alu_func; 	// void function call
	#5;
	
	INPUTA = 4;
	INPUTB = 1;
	op= 'b001; 		// SUB
	test_alu_func; 	// void function call
	#5;

	INPUTA = 8;
	INPUTB = 2;
	op= 'b010; 		// SLL
	test_alu_func; 	// void function call
	#5;

	INPUTA = 4;
	INPUTB = 1;
	op= 'b011; 		// SLR
	test_alu_func; 	// void function call
	#5;

	INPUTA = 4;
	INPUTB = 1;
	op= 'b100; 		// SLT
	test_alu_func; 	// void function call
	#5;

	INPUTA = 4;
	INPUTB = 4;
	op= 'b100; 		// SLT
	test_alu_func; 	// void function call
	#5;

	INPUTA = 1;
	INPUTB = 4;
	op= 'b100; 		// SLT
	test_alu_func; 	// void function call
	#5;

	INPUTA = 4;
	INPUTB = 1;
	op= 'b101; 		// SEQ
	test_alu_func; 	// void function call
	#5;

	INPUTA = 4;
	INPUTB = 4;
	op= 'b101; 		// SEQ
	test_alu_func; 	// void function call
	#5;

	INPUTA = 1;
	INPUTB = 4;
	op= 'b101; 		// SEQ
	test_alu_func; 	// void function call
	#5;
	end
	
	task test_alu_func;
	begin
	  case (op)
		0: expected = INPUTA + INPUTB;
		1: expected = INPUTA - INPUTB;
		2: expected = INPUTA << INPUTB;
		3: expected = INPUTA >> INPUTB;
		4: expected = (INPUTA < INPUTB) ? 1 : 0;	// SLT
		5: expected = (INPUTA == INPUTB) ? 1 : 0;   // SEQ
	  endcase
	  #1; if(expected == OUT)
		begin
			$display("%t YAY!! inputs = %h %h, opcode = %b, output = %b, expected = %b",$time, INPUTA,INPUTB,op,OUT,expected);
		end
	    else begin $display("%t FAIL! inputs = %h %h, opcode = %b, output = %b, expected = %b",$time, INPUTA,INPUTB,op,OUT,expected);end
		
	end
	endtask



endmodule