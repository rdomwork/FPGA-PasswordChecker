module PasswordChecker_testbench();
logic key, reset;
logic [17:0] s;
logic [17:0] LED;
logic [6:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7;

PasswordChecker dut(key, reset, s, LED, seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7);

initial
begin

//tests the reset system
reset = 1; #10;
reset = 0; #10;


//tests the default case and starts testing different combinations
s = 18'b00_0000_0000_0000_0000; #10;
key = 1; #80;
key = 0; #80;

s = 18'b00_0000_1000_1100_0000; #10;
key = 1; #80;
key = 0; #80;

s = 18'hffff; #10;
key = 1; #80;
key = 0; #80;

s = 18'hef93; #10;
key = 1; #80;
key = 0; #80;

s = 18'h987a; #10;
key = 1; #80;
key = 0; #80;

s = 18'h092f; #10;
key = 1; #80;
key = 0; #80;

s = 18'h4241; #10;
key = 1; #80;
key = 0; #80;

s = 18'hef93; #10;
key = 1; #80;
key = 0; #80;

s = 18'hffff; #10;
key = 1; #80;
key = 0; #80;

s = 18'h80a1; #10;
key = 1; #80;
key = 0; #80;

s = 18'habab; #10;
key = 1; #80;
key = 0; #80;

s = 18'hffff; #10;
key = 1; #80;
key = 0; #80;

s = 18'hcdef; #10;
key = 1; #80;
key = 0; #80;
end




endmodule