// Module Name:    Ctrl 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This module is the control decoder (combinational, not clocked)
// Out of all the files, you'll probably write the most lines of code here
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
// There may be more outputs going to other modules

module Ctrl (Instruction, branch_on, write_reg, write_mem, read_mem, mem_output, use_imm, reg1_out, reg2_out, reg_in, imm, ALU_OP);

  	input[ 8:0] Instruction;	   // machine code
  	output reg branch_on,
			write_reg,
			write_mem,
			read_mem,
			mem_output,
			use_imm;
	output reg [3:0] reg1_out, reg2_out, reg_in;
	output reg [7:0] imm;
	output reg [2:0] ALU_OP;

	// jump on right shift that generates a zero
	always@*
	begin
		branch_on = 0;
		reg1_out = 4'b0000;
		reg2_out = 4'b0000;
		reg_in = 4'b0000;
		write_reg = 0;
		write_mem = 0;
		read_mem = 0;
		mem_output = 0;
		use_imm = 0;
		ALU_OP = 3'b000;
		imm[4:0] = Instruction[4:0];
		imm[7:5] = 0;
		
		if(Instruction[8:7] ==  2'b00) // R-Type Instructions 
		begin
			branch_on = 0;
			reg1_out = Instruction[3:0];
			reg2_out = 1;
			reg_in = 2;
			write_reg = 1;
			write_mem = 0;
			read_mem = 0;
			mem_output = 0;
			use_imm = 0;
			ALU_OP[1:0] = Instruction[6:5];
			ALU_OP[2] = 0;
		end //End of R-Type

	  	else if(Instruction[8:7] == 2'b01) //M-Type Instruction
		begin
			if(Instruction[6:5] == 2'b00)  // Check if loi instruction 
			begin
				write_reg = 1;
				reg1_out = 0;  
				reg2_out = 0;   
				reg_in = 1;   
				use_imm = 1;  
				ALU_OP = 3'b000; 
			end
			else if(Instruction[6:5] == 2'b01)  // Check if lor instruction
			begin
				reg1_out = Instruction[3:0];  
				reg2_out = 0;   
				reg_in = 1;
				write_reg = 1;   
				use_imm = 0;  
				ALU_OP = 3'b000; 
			end
			else if(Instruction[6:5] == 2'b10)  // Check if mov instruction
			begin
				reg1_out = 2;  
				reg2_out = 0;   
				reg_in = Instruction[3:0];   
				write_reg = 1;
				use_imm = 0; 
				ALU_OP = 3'b000; 
			end
			// Set for all M-Type instructions no matter operation
			branch_on = 0;  
			write_reg = 1;  
			write_mem = 0;  
			read_mem = 0;  
			mem_output = 0; 
		end  //End of M-Type

		else if(Instruction[8:7] == 2'b10) //B-Type Instructions 
		begin  
			ALU_OP[1:0] = Instruction[6:5];
			ALU_OP[2] = 1;
			write_mem = 0;
			read_mem = 0;
			mem_output = 0;
			branch_on = 0;
			use_imm = 0;
			if(Instruction[6:5] == 2'b00) //slt 
			begin 
			    reg1_out = Instruction[3:0];
				reg2_out = 1;
				reg_in = 2;
				write_reg = 1;
			end
			else if(Instruction[6:5] == 2'b01) //seq 
			begin 
			 
			    reg1_out = Instruction[3:0];
				reg2_out = 1;
				reg_in = 2;
				write_reg = 1;
			end
			else if(Instruction[6:5] == 2'b10) //bp
			begin 
			    reg2_out = Instruction[3:0];
				reg1_out = 2;
				branch_on = 1;
				reg_in = 0;
				write_reg = 0;
				use_imm = 1;
				ALU_OP = 3'b000;
			end
			else if(Instruction[6:5] == 2'b11) //bn
			begin 
			    reg2_out = Instruction[3:0];
				reg1_out = 2;
				branch_on = 1;
				reg_in = 0;
				write_reg = 0;
				use_imm = 1;
				ALU_OP = 3'b001;
			end
		end //End of B-Type

		else if(Instruction[8:7] == 2'b11) //D-Type Instructions 
		begin  
			branch_on = 0;
			reg2_out = Instruction[3:0];
			reg_in = 2;
			use_imm = 1;
			ALU_OP = 3'b000;
			
			if(Instruction[6:5] == 2'b00) //lw 
			begin  
				reg1_out = 1;
				write_reg = 1;
				write_mem = 0;
				read_mem = 1;
				mem_output = 1;
			end
			else if(Instruction[6:5] == 2'b01) //lwi
			begin  
				reg1_out = 0;
				write_reg = 1;
				write_mem = 0;
				read_mem = 1;
				mem_output = 1;
			end
			else if(Instruction[6:5] == 2'b10)	//sw
			begin 
				reg1_out = 1;
				write_reg = 0;
				write_mem = 1;
				read_mem = 0;
				mem_output = 0;
				imm = 8'b00000000;
			end
			else if(Instruction[6:5] == 2'b11) //swi
			begin  
				reg1_out = 0;
				reg2_out = 1;
				write_reg = 0;
				write_mem = 1;
				read_mem = 0;
				mem_output = 0;
			end
		end	 //End of D-Type
	end  //End of always block

endmodule

