// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// 

// ! TODO: add, sub, shift left, shift right, set equal, set less than

	 
module ALU(InputA,InputB,OP,Out);

	input [ 7:0] InputA;
	input [ 7:0] InputB;
	input [ 2:0] OP;
	output reg [7:0] Out; // logic in SystemVerilog

	always@* // always_comb in systemverilog
	begin 
		Out = 0;
		case (OP)
		3'b000: Out = InputA + InputB; 				// ADD
		3'b001: Out = InputA - InputB; 				// SUB	
		3'b010: Out = InputA << InputB;				// Shift Left
		3'b011: Out = InputA >> InputB;				// Shift Right
		3'b100: Out = (InputA < InputB) ? 1 : 0;   	// Set Less Than
		3'b101: Out = (InputA == InputB) ? 1 : 0;	// Set Equal
		default: Out = 0;
	  endcase
	
	end 

	// always@*							  // assign Zero = !Out;
	// begin
	// 	case(Out)
	// 		'b0     : Zero = 1'b1;
	// 		default : Zero = 1'b0;
    //   endcase
	// end


endmodule