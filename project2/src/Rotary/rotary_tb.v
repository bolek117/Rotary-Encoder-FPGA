`timescale 1 ns / 100 ps   
module rotary_tb;

reg push, rotl, rotr, read, clk, clr;

rotary UUT (
.rotl(rotl), 
.rotr(rotr),
.push(push),
.clk(clk),
.clr(clr),
.rotl_out(rotl_out),
.rotr_out(rotr_out),
.push_out(push_out),
.read(read));					   

//initial
	//$monitor("%t : %h%h%h <= %h, %h; %h\nState: %h%h%h", $time, rotl, rotr, push, out[3], out[4], out[5]);
	
initial begin
	clk = 1'b1;
	clr = 1'b1;
	rotl = 1'b0;
	rotr = 1'b0;
	push = 1'b0;   	
	read = 1'b0;
	
	#5 clr = 1'b0;
	repeat(2) begin
		#5 clk += 1'b1;
		push += 1'b1;
	end				
	
	repeat(2) begin
		#5 clk += 1'b1;
		read += 1'b1;
	end
	
	repeat(4) begin
		#5 clk = clk+1'b1;
		case ({rotl, rotr}) 
			2'b00: {rotl, rotr} = 2'b01;
			2'b01: {rotl, rotr} = 2'b11;
			2'b11: {rotl, rotr} = 2'b10;	
			2'b10: {rotl, rotr} = 2'b00;
		endcase
	end
	
	#5 clk += 1'b1;
	repeat(2) begin
		#5 clk += 1'b1;
		read += 1'b1;
	end
	
	{rotl, rotr} = 2'b00;
	
	repeat(4) begin
		#5 clk = clk+1'b1;
		case ({rotl, rotr}) 
			2'b00: {rotl, rotr} = 2'b10;
			2'b10: {rotl, rotr} = 2'b11;
			2'b11: {rotl, rotr} = 2'b01;	
			2'b01: {rotl, rotr} = 2'b00;
		endcase
	end			  
	
	#5 clk += 1'b1;
	repeat(2) begin
		#5 clk += 1'b1;
		read += 1'b1;
	end
	{rotl, rotr} = 2'b00;  
	
	repeat(2)
	#5 clk += 1'b1;
					   		  
	$finish;
end							
							  
endmodule