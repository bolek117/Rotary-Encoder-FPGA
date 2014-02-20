//-----------------------------------------------------------------------------
//
// Title       : simple
// Design      : project2
// Author      : 
// Company     : 
//
//-----------------------------------------------------------------------------
//
// File        : d:\Program Files (x86)\Aldec\Designs\proj2\project2\src\simple.v
// Generated   : Sun Jan 19 15:12:18 2014
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {simple}}
module simple (a, b, y);
//}} End of automatically maintained section

input a, b;
output y;

assign y = a & b;

endmodule
