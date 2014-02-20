`timescale 1 ns / 1 ps

module rotaryQueue ( rotl, rotr, push, read, out, clk, clr);

input rotl, rotr, push, read, clk, clr;

output [2:0] out;	

reg [3:0] res;
reg busy;
	
always @(posedge clr) begin
	res = 3'b000;
	busy = 1'b0;
end
					   
always @(posedge clk or negedge clk) begin
	if (read) begin
		busy = 1'b0;
		res = 3'b000;
	end
	
	if (!busy) begin			 
		busy = 1'b1;
		res = {rotl, rotr, push};
	end
	
end

assign {out[0], out[1], out[2]} = {res[0], res[1], res[2]};

endmodule
