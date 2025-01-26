//////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010 Gandhi Puvvada, EE-Systems, VSoE, USC
//
// This design exercise, its solution, and its test-bench are confidential items.
// They are University of Southern California's (USC's) property. All rights are reserved.
// Students in our courses have right only to complete the exercise and submit it as part of their course work.
// They do not have any right on our exercise/solution or even on their completed solution as the solution contains our exercise.
// Students would be violating copyright laws besides the University's Academic Integrity rules if they post or convey to anyone
// either our exercise or our solution or their solution. 
// 
// THIS COPYRIGHT NOTICE MUST BE RETAINED AS PART OF THIS FILE (AND ITS SOLUTION AND/OR ANY OTHER DERIVED FILE) AT ALL TIMES.
//
//////////////////////////////////////////////////////////////////////////////
//
// A student would be violating the University's Academic Integrity rules if he/she gets help in writing or debugging the code 
// from anyone other than the help from his/her lab partner or his/her teaching team members in completing the exercise(s). 
// However he/she can discuss with felllow students the method of solving the exercise. 
// But writing the code or debugging the code should not be with the help of others. 
// One should never share the code or even look at the code of others (code from classmates or seniors 
// or any code or solution posted online or on GitHub).
// 
// THIS NOTICE OF ACADEMIC INTEGRITY MUST BE RETAINED AS PART OF THIS FILE (AND ITS SOLUTION AND/OR ANY OTHER DERIVED FILE) AT ALL TIMES.
//
//////////////////////////////////////////////////////////////////////////////



// EE457 RTL Exercises
// min_max_finder_part1.v (Part 1 uses two comparison units)
// Written by Nasir Mohyuddin, Gandhi Puvvada 
// June 5, 2010, 1/20/2025
// Given an array of 16 unsigned 8-bit numbers, we need to find the minimum and the maximum number.

 
// Students: Please complete the code for the Data path and State transition operations in LOAD and COMPUTE states
`timescale 1 ns / 100 ps

module min_max_finder_part1 (Start, Clk, Reset, 
				           Qi, Ql, Qc, Qd, Min, Max);

input Start, Clk, Reset;
output [7:0] Min, Max;
output Qi, Ql, Qc, Qd;

reg [7:0] M [0:15]; 
reg [3:0] state;
reg [7:0] Min;
reg [7:0] Max;
reg [3:0] I;

localparam 
INI  = 	4'b0001, // "Initial" state
LOAD = 	4'b0010, // "Load Max and Min with 1st Element" state
COMP = 	4'b0100, // "Compare each number with Min and Max and Update Min/Max if needed" state
DONE = 	4'b1000; // "Done finding Min and Max" state
         
         
assign {Qd, Qc, Ql, Qi} = state;

always @(posedge Clk, posedge Reset) 

  begin  : CU_n_DU
    if (Reset)
       begin
         I <= 4'bXXXX;
	     Min <= 8'bXXXXXXXX;
	     Max <= 8'bXXXXXXXX;
         state <= INI;
	  end
    else
       begin
           case (state)
	        INI	: 
	          begin
		         // state transitions in the control unit
		        if (Start)
		           state <= LOAD;
		         // RTL operations in the Data Path            	              
		        I <= 0;
	          end
	        LOAD	:  	// complete the code for the Data path and State transition operations
	          begin
				Min <= M[I];
				Max <= M[I];
				I <= I + 1;

				state <= COMP;      
 	          end
	        
	        COMP :		// complete the code for the Data path and State transition operations
	          begin 
					if(Min > M[I])
						Min <= M[I];
					if(Max < M[I])
						Max <= M[I];
					I <= I + 1;

					if(I == 15)
						state <= DONE;
	          end
	        
	        DONE	:
	          begin  
		         // state transitions in the control unit
		           state <= INI; // Transit to INI state unconditionally
		       end    
      endcase
    end 
  end 
endmodule  // min_max_finder_part1
 
