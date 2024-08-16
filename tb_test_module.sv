`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2021 17:44:05
// Design Name: 
// Module Name: tb_test_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_test_module();

	localparam  DATA_WIDTH = 8;
	localparam	PERIOD_CLK = 10.0ns;

	bit clk_i = 1'b0;
	bit	reset_i;

	
	bit [DATA_WIDTH-1:0] out_0, out_1, out_2, out_3 ;
	bit out_valid_0, out_valid_1, out_valid_2,  out_valid_3;	
	bit [DATA_WIDTH-1:0] data_i;
	bit [DATA_WIDTH-1:0] data_array [1:40];

	event reset_done;
	event seq_0_done, seq_1_done;
	
  
	always #(PERIOD_CLK/2) clk_i <= ~clk_i;
	
	initial begin
		reset_i <= 1'b1;
		#110ns
		@(posedge clk_i)
		reset_i <= 1'b0;
		// #PERIOD_CLK
		// #2
		// reset_i = 1'b1;
		// #(PERIOD_CLK*6)
		// reset_i = 1'b0;
		-> reset_done;
		@(seq_0_done)
		#1ns
		reset_i <= 1'b1;
		#110ns
		@(posedge clk_i)
		reset_i <= 1'b0;
		-> reset_done;
		@(seq_1_done)
		@(posedge clk_i)
		reset_i <= 1'b1;
		#110ns
		@(posedge clk_i)
		reset_i <= 1'b0;
		-> reset_done;
	end

	initial begin
		data_i <= 8'h0;
		@(reset_done);
		foreach(data_array[i]) begin
			data_i <= data_array[i]; 
			@(posedge clk_i)
			if (i == 22)
		    break;
		end
			 -> seq_0_done;
			  data_i <= 0;
			 @(reset_done)
			 for (int i = 23; i < 30; i++) begin
			     @(posedge clk_i)
			     data_i <= data_array[i];
			end
			
			-> seq_1_done;
			@(posedge clk_i)
			 data_i <= 0;
			@(reset_done)
			 for (int i = 30; i < 41; i++) begin
			     @(posedge clk_i)
			     data_i <= data_array[i];
			end
			
//		end
	end

    initial begin
        $readmemh("data_1.txt", data_array, 1, 40);
    end
    
    



	// always @(posedge clk_i)
	// begin
	// 	if (reset_i)
	// 		data_i <= 8'h0;
	// 	else	
	// 		#2 	
	// 	 	data_i <= $random;
	// end
	

	// initial begin	
	// 	@(count == 8) // ����� ������ ������������������ (1,2)
	// 	#1
	// 	$display("DATA_1:", out_0, out_1, out_2, out_3);
	// 	$display("VALID_1:", out_valid_0, out_valid_1, out_valid_2, out_valid_3);
	// 	@(count == 18) // ����� ������ ������������������ (1,2,3,4)
	// 	#1
	// 	$display("DATA_2:", out_0, out_1, out_2, out_3);
	// 	$display("VALID_2:", out_valid_0, out_valid_1, out_valid_2, out_valid_3);	
	// end
	
test_module #(.DATA_W(DATA_WIDTH))
test_module_inst
	(	
		.clk_in			(clk_i),
        .reset_in		(reset_i), 
        .data_in		(data_i),
        .out_0			(out_0),
        .out_valid_0	(out_valid_0), 
        .out_1			(out_1), 
        .out_valid_1	(out_valid_1), 
        .out_2			(out_2),
        .out_valid_2	(out_valid_2), 
        .out_3			(out_3), 
        .out_valid_3 	(out_valid_3)
	);
	
endmodule
