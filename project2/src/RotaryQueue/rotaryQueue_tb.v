`timescale 1 ns / 1 ps

module rotaryQueue_tb;										
	
reg clk, rotl, rotr, push, read;

rotaryQueue UUT(
.rotl(rotl),
.rotr(rotr),
.push(push),
.read(read),
.out(out),
.clk(clk),
.clr(clr));

initial begin
	
	clk = 1'b0;	
	rotl = 1'b0;
	rotr = 1'b0;
	push = 1'b0;			   
	read = 1'b0;
	
	repeat(5) begin	
		{rotl, rotr, push} += 1'b1;
		repeat(3) #10 clk += 1'b1;
		read = 1'b1;
		clk += 1'b1;
		read = 1'b0;
	end		  	 
	
end

endmodule
