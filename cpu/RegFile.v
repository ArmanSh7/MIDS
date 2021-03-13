// Module Name:    RegFile 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This module is your register file.
// If you have more or less bits for your registers, update the value of D.
// Ex. If you only supports 8 registers. Set D = 3

/* parameters are compile time directives 
       this can be an any-size reg_file: just override the params!
*/
module RegFile (Clk,WriteEn,reg1_out,reg2_out,reg_in,DataIn,DataOutReg1,DataOutReg2);
	parameter W=8, D=4;  // W = data path width (Do not change); D = pointer width (You may change)
	input                Clk,
								WriteEn;
	input        [D-1:0] reg1_out,				  // address pointers
								reg2_out,
								reg_in;
	input        [W-1:0] DataIn;
	output reg   [W-1:0] DataOutReg1;			  
	output reg   [W-1:0] DataOutReg2;				

// W bits wide [W-1:0] and 2**4 registers deep 	 
reg [W-1:0] Registers[(2**D)-1:0];	  // or just registers[16-1:0] if we know D=4 always



// NOTE:
// READ is combinational
// WRITE is sequential

always@*
begin
 DataOutReg1 = Registers[reg1_out];	  
 DataOutReg2 = Registers[reg2_out];    
end

// sequential (clocked) writes 
always @ (posedge Clk)	
begin
  if (WriteEn)	                             // works just like data_memory writes
    Registers[reg_in] <= DataIn;
end
integer i;
initial begin
	for(i = 0; i < 16; i = i + 1)
		Registers[i] = 0;
	Registers[14] = 8'b11111111;
end

endmodule
