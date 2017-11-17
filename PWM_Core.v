module PWM_core #(parameter n = 10, parameter m = 4)( 
input reset, clk,
input [n-2:0] dutyc_switch,
input [n-1:0] period,
input [m-1:0] compare_result,
 output reg out,
 output reg scope
);


reg [n-2:0] duty_cycle, counter;


always@(posedge clk or negedge reset) //Activating hardware at rising edge of clock or falling edge of reset
begin
	
	
   if(~reset) //checking for reset signal (reset driven low)
		begin
			counter <= 32'b1; 		//assigning 32 "ones" to the counter
			duty_cycle <= 32'b0;		//assigning 32 "zeros" to the duty_cycle
		end
	
	else if(counter == period) //checking for counter equal to period
		begin
			counter <= 32'b1;			//if equal, assigning 32 "ones" to the counter
		end
	
	else 
		begin
			counter <= counter + 1'b1;														//Incrementing counter, counting
			if(compare_result[0]) duty_cycle[7:0] <= dutyc_switch[7:0];

		end
	
end 


always@(posedge clk)				//Activating hardware at rising edge of clock
begin
	if(counter <= duty_cycle)	//checking if counter is less than or equal to duty_cycle
		begin
		out = 1'b1;					//if counter is less than or equal to duty_cycle, output 1
		scope = 1'b1;
		end
	else 
		begin
		out = 1'b0;					//if counter is not less than or equal to duty_cycle, output 0
		scope = 1'b0;
		end
end

endmodule
