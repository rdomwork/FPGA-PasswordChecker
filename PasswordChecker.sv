module PasswordChecker(input  logic key, reset,
					   input  logic [17:0] s,
					   output logic [17:0] LED,
					   output logic [6:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7);

//initialises the numbers	
bit unlocked;		   
logic [3:0] n1, n2, n3, n4;
logic [4:0] account;
int b_active;

//logic [15:0] password
logic [15:0] password_attempt;


//sets the values of numbers = the binary value of s segments
assign n1 = s[3:0];
assign n2 = s[7:4];
assign n3 = s[11:8];
assign n4 = s[15:12];

//if implemented, this system can be improved on using class objects

//hardwired passcodes since this system does not use memory.
/*
assign password0 = 16'hef93;
assign password1 = 16'h459a;
assign password2 = 16'h649b;
assign password3 = 16'hc9c9;
assign password4 = 16'hc35f;
assign password5 = 16'hf42a;
assign password6 = 16'hbaba;
assign password7 = 16'habab;
assign password8 = 16'h8973;
assign password9 = 16'h9090;
assign password10 = 16'h80a1;
assign password11 = 16'hdaff;
assign password12 = 16'hcdef;
assign password13 = 16'habcd;
assign password14 = 16'h0202;
assign password15 = 16'h0001;
*/

//combines all the password inputs
assign password_attempt = {n4, n3, n2, n1};

//shows which bits are lit up
assign LED = s;
assign b_active = (n1[3] + n1[2] + n1[1] + n1[0] + n2[3] + n2[2] + n2[1] + n2[0] +n3[3] + n3[2] + n3[1] + n3[0] + n4[3] + n4[2] + n4[1] + n4[0]);

//instance of seven segment display module
changing_sevenSeg segment_display(unlocked, b_active, n1, n2, n3, n4, account, seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7);
					   
always_ff @ (posedge key, posedge reset)
	if(reset)
	begin
		//relocks the device to be analysed again
		unlocked <= 0;
		account <= 16;
	end
	else
	begin
	//this can be improved upon, not needing this long of a case statement
	case(password_attempt)
	//saved passwords
	(16'hef93):begin
			   unlocked <= 1;
			   account <= 0;
			   end

	(16'h459a):begin
			  unlocked <= 1;
			  account <= 1;
			  end

	(16'h649b):begin
			  unlocked <= 1;
			  account <= 2;
			  end

	(16'hc9c9):begin
			  unlocked <= 1;
			  account <= 3;
			  end

	(16'hc35f):begin
			  unlocked <= 1;
			  account <= 4;
			  end

	(16'hf42a):begin
			  unlocked <= 1;
			  account <= 5;
			  end

	(16'hbaba):begin
			  unlocked <= 1;
			  account <= 6;
			  end

	(16'habab):begin
			  unlocked <= 1;
			  account <= 7;
			  end

	(16'h8973):begin
			  unlocked <= 1;
			  account <= 8;
			  end

	(16'h9090):begin
			  unlocked <= 1;
			  account <= 9;
			  end

	(16'h80a1):begin
			  unlocked <= 1;
			  account <= 10;
			  end

	(16'hdaff):begin
			  unlocked <= 1;
			  account <= 11;
			  end

	(16'hcdef):begin
			  unlocked <= 1;
			  account <= 12;
			  end

	(16'habcd):begin
			  unlocked <= 1;
			  account <= 13;
			  end
			  
	(16'h0202):begin
			  unlocked <= 1;
			  account <= 14;
			  end
			  
	(16'h0001):begin
			  unlocked <= 1;
			  account <= 15;
			  end
			  
	default:  begin
			  unlocked <= 0;
			  account <= 16;
			  end

	endcase
	end
				   
					   
endmodule

module changing_sevenSeg(input  logic unlocked,
					     input  int b_active,
						 input  logic [3:0] n1, n2, n3, n4,
						 input  logic [4:0] account,
						 output logic [6:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7);
	//displays account number
	always_comb
	case (account)
	(4'b0000):	seg7 = 7'b100_0000;
	(4'b0001):	seg7 = 7'b111_1001;
	(4'b0010):	seg7 = 7'b010_0100;
	(4'b0011):	seg7 = 7'b011_0000;
	(4'b0100):	seg7 = 7'b001_1001;
	(4'b0101):	seg7 = 7'b001_0010;
	(4'b0110):	seg7 = 7'b000_0010;
	(4'b0111):	seg7 = 7'b111_1000;
	(4'b1000):	seg7 = 7'b000_0000;
	(4'b1001):	seg7 = 7'b001_1000;
	(4'b1010):	seg7 = 7'b000_1000;
	(4'b1011):	seg7 = 7'b000_0011;
	(4'b1100):	seg7 = 7'b010_0111;
	(4'b1101):	seg7 = 7'b010_0001;
	(4'b1110):	seg7 = 7'b000_0110;
	(4'b1111):	seg7 = 7'b000_1110;

	default:	seg7 = 7'b011_1111;
	endcase
	
	//Changing segment display
	//case statements to represent the number count
	always_comb
	case (n1)
	(4'b0000):	seg0 = 7'b100_0000;
	(4'b0001):	seg0 = 7'b111_1001;
	(4'b0010):	seg0 = 7'b010_0100;
	(4'b0011):	seg0 = 7'b011_0000;
	(4'b0100):	seg0 = 7'b001_1001;
	(4'b0101):	seg0 = 7'b001_0010;
	(4'b0110):	seg0 = 7'b000_0010;
	(4'b0111):	seg0 = 7'b111_1000;
	(4'b1000):	seg0 = 7'b000_0000;
	(4'b1001):	seg0 = 7'b001_1000;
	(4'b1010):	seg0 = 7'b000_1000;
	(4'b1011):	seg0 = 7'b000_0011;
	(4'b1100):	seg0 = 7'b010_0111;
	(4'b1101):	seg0 = 7'b010_0001;
	(4'b1110):	seg0 = 7'b000_0110;
	(4'b1111):	seg0 = 7'b000_1110;

	default:	seg0 = 7'b000_0000;
	endcase
	
	always_comb
	case (n2)
	(4'b0000):	seg1 = 7'b100_0000;
	(4'b0001):	seg1 = 7'b111_1001;
	(4'b0010):	seg1 = 7'b010_0100;
	(4'b0011):	seg1 = 7'b011_0000;
	(4'b0100):	seg1 = 7'b001_1001;
	(4'b0101):	seg1 = 7'b001_0010;
	(4'b0110):	seg1 = 7'b000_0010;
	(4'b0111):	seg1 = 7'b111_1000;
	(4'b1000):	seg1 = 7'b000_0000;
	(4'b1001):	seg1 = 7'b001_1000;
	(4'b1010):	seg1 = 7'b000_1000;
	(4'b1011):	seg1 = 7'b000_0011;
	(4'b1100):	seg1 = 7'b010_0111;
	(4'b1101):	seg1 = 7'b010_0001;
	(4'b1110):	seg1 = 7'b000_0110;
	(4'b1111):	seg1 = 7'b000_1110;

	default:	seg1 = 7'b000_0000;
	endcase
	
	always_comb
	case (n3)
	(4'b0000):	seg2 = 7'b100_0000;
	(4'b0001):	seg2 = 7'b111_1001;
	(4'b0010):	seg2 = 7'b010_0100;
	(4'b0011):	seg2 = 7'b011_0000;
	(4'b0100):	seg2 = 7'b001_1001;
	(4'b0101):	seg2 = 7'b001_0010;
	(4'b0110):	seg2 = 7'b000_0010;
	(4'b0111):	seg2 = 7'b111_1000;
	(4'b1000):	seg2 = 7'b000_0000;
	(4'b1001):	seg2 = 7'b001_1000;
	(4'b1010):	seg2 = 7'b000_1000;
	(4'b1011):	seg2 = 7'b000_0011;
	(4'b1100):	seg2 = 7'b010_0111;
	(4'b1101):	seg2 = 7'b010_0001;
	(4'b1110):	seg2 = 7'b000_0110;
	(4'b1111):	seg2 = 7'b000_1110;

	default:	seg2 = 7'b000_0000;
	endcase
	
	always_comb
	case (n4)
	(4'b0000):	seg3 = 7'b100_0000;
	(4'b0001):	seg3 = 7'b111_1001;
	(4'b0010):	seg3 = 7'b010_0100;
	(4'b0011):	seg3 = 7'b011_0000;
	(4'b0100):	seg3 = 7'b001_1001;
	(4'b0101):	seg3 = 7'b001_0010;
	(4'b0110):	seg3 = 7'b000_0010;
	(4'b0111):	seg3 = 7'b111_1000;
	(4'b1000):	seg3 = 7'b000_0000;
	(4'b1001):	seg3 = 7'b001_1000;
	(4'b1010):	seg3 = 7'b000_1000;
	(4'b1011):	seg3 = 7'b000_0011;
	(4'b1100):	seg3 = 7'b010_0111;
	(4'b1101):	seg3 = 7'b010_0001;
	(4'b1110):	seg3 = 7'b000_0110;
	(4'b1111):	seg3 = 7'b000_1110;

	default:	seg3 = 7'b000_0000;
	endcase
	
	//unchanging segment
	assign seg5 = 7'b000_0011;
	
	always_comb
	case (b_active)
	(4'b0000):	seg4 = 7'b100_0000;
	(4'b0001):	seg4 = 7'b111_1001;
	(4'b0010):	seg4 = 7'b010_0100;
	(4'b0011):	seg4 = 7'b011_0000;
	(4'b0100):	seg4 = 7'b001_1001;
	(4'b0101):	seg4 = 7'b001_0010;
	(4'b0110):	seg4 = 7'b000_0010;
	(4'b0111):	seg4 = 7'b111_1000;
	(4'b1000):	seg4 = 7'b000_0000;
	(4'b1001):	seg4 = 7'b001_1000;
	(4'b1010):	seg4 = 7'b000_1000;
	(4'b1011):	seg4 = 7'b000_0011;
	(4'b1100):	seg4 = 7'b010_0111;
	(4'b1101):	seg4 = 7'b010_0001;
	(4'b1110):	seg4 = 7'b000_0110;
	(4'b1111):	seg4 = 7'b000_1110;

	default:	seg4 = 7'b000_0000;
	endcase

	//displays whether the account is locked or unlocked
	always_comb
	case (unlocked)
	1'b0:		seg6 = 7'b100_0111;
	1'b1:		seg6 = 7'b100_0001;
	
	default:    seg6 = 7'b100_0000;
	endcase
	
endmodule