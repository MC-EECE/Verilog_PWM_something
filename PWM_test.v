module PWM_test #(parameter n = 10, parameter m = 4)( 
input CLOCK_50,  
input [1:0] KEY, 
input [17:0] SW, 
output [8:0] LEDG,
output [35:0] GPIO 
); 

 
wire s, t, h, mil; 						//declaring wires for clock inputs
wire [n-1:0] sw_period, sw_duty ; 	//declaring wires for the duty_cycle and period selection switches
 
 
assign sw_duty[7:0] = SW[7:0]; 		//assigning switch values to their respective variables
assign sw_period[9:0] = SW[17:8]; 
 
 
 
 
  PWM_core run0(  
  .reset(KEY[1]), 				//using KEY1 for reset
  .clk(mil), 						//using clock divider "mils" output for clk signal
  .dutyc_switch(sw_duty), 			//using switches 7 to 0 to select duty_cycle
  .period(sw_period), 			//using switches 17 to 8 to select the period
  .compare_result(4'b1111), 	//using binary value 1111 for compare value
  .out(LEDG[7]), 					//writing output to LEDG8
  .scope(GPIO[1])
 ); 

 
  clock_divider clock0( 				//Setting-up clock divider outputs
 	CLOCK_50, 
 	s,		//Seconds 
 	t,		//Tenths of seconds 
 	h,		//Hundredths of seconds 
 	mil	//milliseconds 
); 

 
endmodule 
