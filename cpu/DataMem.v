// Module Name:    DataMem 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This module is your Data memory
// Similar to Instruction Memory, you may have a text file as your memory.
// You may hard code values into your memory. 
// Ex. If you just want the value 5 in memory 244 and 254 at position 16 when the program start,
// you may do so below.

module DataMem(Clk,Reset,write_mem,read_mem,DataAddress,DataIn,DataOut);
  input              Clk,
                     Reset,         // Reset ctrl sig sets all mem locations to zero
                     write_mem,     // Indicates we are writing to memory (Ctrl Sig)
                     read_mem;      // Indicates we are reading from memory (Ctrl Sig)
  input [7:0]        DataAddress,   // 8-bit-wide pointer to 256-deep memory
                     DataIn;		   // 8-bit-wide data path, also
  output reg[7:0]    DataOut;

  reg [7:0] Core[256-1:0];			   // 8x256 two-dimensional array -- the memory itself

  integer i;
/* optional way to plant constants into DataMem at startup
    initial 
      $readmemh("dataram_init.list", Core);
*/
  always@*                    // reads are combinational
  begin
    if(read_mem)
      DataOut = Core[DataAddress];
  end
  
  always @ (posedge Clk)		 // writes are sequential
/*( Reset response is needed only for initialization (see inital $readmemh above for another choice)
  if you do not need to preload your data memory with any constants, you may omit the if(Reset) and the else,
  and go straight to if(write_mem) ...
*/
	begin
    if(Reset) begin
      // you may initialize your memory w/ constants, if you wish
      for(i=0;i<256;i = i + 1)
	      Core[i] <= 0;
      Core[0] <= 8'b00001100; //! For division test - remove for final
      Core[1] <= 8'b00100000; //! For division test - remove for final
      Core[2] <= 8'b00001010; //! For division test - remove for final
      Core[16] <= 8'b00000000; //! For Square Root test - remove for final
      Core[17] <= 8'b01000000; //! For Square Root test - remove for final
	end
    else if(write_mem) 
      Core[DataAddress] <= DataIn;
	end
endmodule