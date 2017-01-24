/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc 

   assign ccif.dload=ccif.ramload;
   assign ccif.iload=ccif.ramload;
   assign ccif.ramstore=ccif.dstore;
   assign ccif.ramWEN=ccif.dWEN[0];
   assign ccif.ramREN=(ccif.dREN[0]|| ccif.iREN[0]) && !ccif.dWEN[0];
   assign ccif.ramaddr=(ccif.dWEN==1'b1 || ccif.dREN==1'b1)?ccif.daddr :ccif.iaddr ; 

   always_comb begin
      ccif.dwait[0]=1;
      ccif.iwait[0]=1; 
      casez(ccif.ramstate)
	FREE: begin
	   ccif.dwait=1'b1;
	   ccif.iwait=1'b1;
	end
	ERROR: begin
	   ccif.dwait=1'b1;
	   ccif.iwait=1'b1;
	end
	BUSY: begin
	   ccif.dwait=1'b1;
	   ccif.iwait=1'b1;
	end
	ACCESS: begin
	   if (ccif.dWEN==1'b1 || ccif.dREN==1'b1) begin
	      ccif.dwait=1'b0;
	      ccif.iwait=1'b1;
	   end
	   else if (ccif.iREN==1'b1) begin
	      ccif.dwait=1'b1;
	      ccif.iwait=1'b0;
	   end	

	end
	default: begin
	   ccif.dwait[0]=1;
	   ccif.iwait[0]=1; 
	end	
      endcase            	   
   end     
endmodule
