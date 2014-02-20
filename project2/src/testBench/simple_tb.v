`timescale 1 ns / 100 ps   
module simple_tb;
	
wire y;
reg a, b;
reg clk;

simple UUT (
.a(a), 
.b(b),
.y(y));					   

initial
	$monitor("%t : %h <= %h & %h", $time, y, a, b);
	
initial begin
	a = 1'b0;
	b = 1'b0;		 
	clk = 1'b0;
	
	repeat(6) begin
		#10 {a, b} = {a, b} + 1;
		clk <= clk+1;
	end
	
	
	$finish;		  
	
end		 

endmodule