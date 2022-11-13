module dataPath
	#(parameter WordSize = 8)
	(  
	input clk, reset,
	
	// Data Path I/O	
	input  [WordSize-1:0] input_text,
	input  [WordSize-1:0] key,
	input  [WordSize-1:0] mod,
	output [WordSize-1:0] output_text,
	
	// Controller I/O
	input wire load, running,   // enablers
	output wire over            // flags
	);
	
	wire [WordSize-1:0]  inMux; // from input
	wire [WordSize-1:0]  keyMux; // from input
	wire [WordSize-1:0]  modMux; // from input
	wire [WordSize-1:0]  outMux; // to output
	
	wire [WordSize-1:0] ground; 
	staticValue #(WordSize, 'hzzzz) outDefValue(ground);
	
	
	mux2to1 loadInpMux(ground, input_text, load, inMux);       // to get input from MUX
	mux2to1 loadKeyMux(ground, key,        load, keyMux);      // to get input from MUX
	mux2to1 loadModMux(ground, mod,        load, modMux);      // to get input from MUX
	mux2to1 loadOutMux(ground, outMux,     over, output_text); // to get output from MUX
	
endmodule 
	encrypt_decrypt encrypt_decrypt_state_machine(
	.base(inMux),
	.modulo(modMux),
	.exponent(keyMux),
	.clk(clk),
	.reset(reset),
	.finish(over),
	.result(outMux)
);
	
endmodule 