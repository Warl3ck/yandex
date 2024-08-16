`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date: 16.12.2021 15:51:40
// Design Name: 
// Module Name: test_module
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


module test_module #(
	parameter  DATA_W = 8
	)
	(
             input logic clk_in, 
             input logic reset_in, 
             input logic [(DATA_W - 1) : 0] data_in, 
             output logic [(DATA_W - 1) : 0] out_0, 
             output logic out_valid_0, 
             output logic [(DATA_W - 1) : 0] out_1, 
             output logic out_valid_1, 
             output logic [(DATA_W - 1) : 0] out_2, 
             output logic out_valid_2, 
             output logic [(DATA_W - 1) : 0] out_3, 
             output logic out_valid_3 
); 

	reg	[DATA_W-1:0] data_reg [0:3];
	reg [DATA_W-1:0] dat_delay; 
	reg data_valid [0:3];	

	integer j;

	always_ff @(posedge clk_in)
	begin
		if (reset_in)
			dat_delay <= {DATA_W{1'b0}};
		else
			dat_delay <= data_in;
	end
	
	always_comb
	begin
	for(j = 0; j < 4; j++) begin
        if (data_reg[j] == dat_delay) 
            break;
       end
    end
    
    always_ff @(posedge clk_in) 
    begin
        if (reset_in) 
        	foreach(data_reg[i]) begin
				data_reg[i] <= {DATA_W{1'b0}};
				data_valid[i] <= 1'b0;
       end else begin
        	case (j)
            	1 : begin
            			data_reg[0:1] <= {dat_delay, data_reg[0]};
            			data_valid[0] <= 1'b1;
            		end
            	2 : begin
            			data_reg[0:2] <= {dat_delay, data_reg[0:1]};
            			data_valid[1] <= 1'b1;
            		end
            	3,4 : begin
            			data_reg <= {dat_delay, data_reg[0:2]};
            			data_valid <= {1'b1, data_valid[0:2]};
            		end
        	endcase
        end
    end
    

	assign out_0 = data_reg[0];
	assign out_1 = data_reg[1];
	assign out_2 = data_reg[2];
	assign out_3 = data_reg[3];

	assign out_valid_0 = data_valid[0];
	assign out_valid_1 = data_valid[1];
	assign out_valid_2 = data_valid[2];
	assign out_valid_3 = data_valid[3];
		
endmodule
