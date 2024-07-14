module PasswordChecker_wrapper(input  logic [3:0] KEY,
							   input  logic [17:0] SW,
							   output logic [17:0] LEDR,
							   output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

PasswordChecker pw(~KEY[0], ~KEY[3], SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
							   
endmodule