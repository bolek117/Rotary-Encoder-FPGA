//-----------------------------------------------------------------------------
//
// Title       : rotary
// Design      : project2
// Author      : 
// Company     : 
//
//-----------------------------------------------------------------------------
//
// File        : d:\Program Files (x86)\Aldec\Designs\proj2\project2\src\rotary.v
// Generated   : Sun Jan 19 14:30:23 2014
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps
						   
module rotary (rotl, rotr, push, clk, clr, rotl_out, rotr_out, push_out, read);				 
	
parameter START = 3'b000;	//0
parameter R1 = 3'b001;		//1
parameter R2 = 3'b010;		//2
parameter R3 = 3'b011;		//3
parameter L1 = 3'b101;		//5
parameter L2 = 3'b110;		//6
parameter L3 = 3'b111;		//7
parameter ENDL = 2'b01;
parameter ENDR = 2'b10;
					    			  
output rotl_out, rotr_out, push_out;

input rotl, rotr, push, clk, clr, read;
reg [2:0] state;	   
reg [1:0] resRot;
//reg rotl_r, rotr_r, push_r;	
reg [3:0] res;
reg busy;

// variables initialization
always @(posedge clr) begin
	state = START;
	resRot = 2'b00;
	//rotl_r = 1'b0;
	//rotr_r = 1'b0;
	//push_r = 1'b0;	
	res = 3'b000;
	busy = 1'b0;
end

always @(posedge clk or negedge clk) begin	   		
	
	if (read == 1'b1) begin
		busy = 1'b0;
		res = 3'b000;
	end
	
	if (busy == 1'b0) begin
		if (push) begin
			busy = 1'b1;
			res[2] = 1'b1;
		end
		/*else
			res[2] <= 1'b0;*/
		
		resRot = 2'b00;
		
		case(state)
			START: begin
				case ({rotr, rotl})
					2'b01: state <= R1;
					2'b10: state <= L1;
					default: state <= START; 
				endcase
			end
			R1: begin
				case ({rotr, rotl})
					2'b11: state <= R2;
					2'bx0: state <= START;
					default: state <= R1; 
				endcase
			end
			R2: begin
				case ({rotr, rotl})
					2'b10: state <= R3;
					2'b0x: state <= R1;
					default: state <= R2; 
				endcase
			end							
			R3: begin
				case ({rotr, rotl})
					2'b00: begin
						state <= START;
						resRot = ENDR;
					end			 
					2'bx1: state <= R2;
					default: state <= R3; 
				endcase
			end				   
			
			L1: begin
				case ({rotr, rotl})
					2'b11: state <= L2;
					2'b0x: state <= START;
					default: state <= L1; 
				endcase
			end
			L2: begin
				case ({rotr, rotl})
					2'b01: state <= L3;
					2'bx0: state <= L1;
					default: state <= L2; 
				endcase
			end							
			L3: begin
				case ({rotr, rotl})
					2'b00: begin
						state <= START;
						resRot = ENDL;
					end	
					2'b1x: state <= L2;
					default: state <= L3; 
				endcase
			end
		endcase
		
		case(resRot)
			ENDR: begin
				res[0] = 1'b1;
				busy = 1'b1;
			end
			
			ENDL: begin
				res[1] = 1'b1;  
				busy = 1'b1;
			end
			
			/*default: begin
				res[0] = 1'b0;
				res[1] = 1'b0;
			end	*/
		endcase			 
	end
		
end											  

assign rotl_out = res[0];
assign rotr_out = res[1];
assign push_out = res[2];

endmodule
