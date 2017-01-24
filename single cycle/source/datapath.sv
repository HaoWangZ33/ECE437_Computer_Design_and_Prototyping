/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

//interface
`include "register_file_if.vh"
`include "alu_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"


// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
 
);
// import types
  import cpu_types_pkg::*;

  register_file_if rfif();
  alu_if aluif();
  control_unit_if cuif();
  request_unit_if ruif();
   
 
    	
//intruction declaration
  word_t instr;

// pc init
  parameter PC_INIT = 0;

  register_file RF (CLK, nRST, rfif);
  alu ALU (aluif);
  control_unit CU (cuif);
  request_unit RU (CLK, nRST, ruif);

//value needed for PC
   word_t pc, pc_nxt;
// logic      check_dhit, check_dhit_nxt;
   
//PC
   logic      pc_enable;
   assign pc_enable = dpif.ihit && (~dpif.dhit);
   
  always_ff @(posedge CLK, negedge nRST) begin
	if (nRST == 1'b0 ) 
		pc <= PC_INIT;
	else if (pc_enable)
	  pc <= pc_nxt;
     

  end	       

  always_comb begin
		casez (cuif.PCScr) 
		0: begin
			pc_nxt= pc+4;
		end
		1: begin
	  		if (cuif.branch == 1'b0)
				pc_nxt=pc+4;
			else
			  if (instr[15])
	  		    pc_nxt=({{16{1'b1}},instr[15:0]}<<2)+4+pc;
			  else
			    pc_nxt=({{16{1'b0}},instr[15:0]}<<2)+4+pc;
		end
		2: begin
			pc_nxt=rfif.rdat1;
		end
		3: begin
		   	pc_nxt={pc[31:28], instr[25:0],2'b00}; 
		end
		endcase	      
  end

//control unit
  assign cuif.opcode=opcode_t'(instr[31:26]);
  assign cuif.funct=funct_t'(instr[5:0]);
  assign cuif.zero_flag=aluif.zero_flag;
  assign cuif.dhit=dpif.dhit;
   assign cuif.ihit = dpif.ihit;
   

//register file
  assign rfif.WEN=cuif.Regwen;
  assign rfif.rsel1=instr[25:21];
  assign rfif.rsel2=instr[20:16];
  
  always_comb begin
	casez(cuif.RegDest) 
	0: begin
		rfif.wsel=instr[20:16];
	end
	1: begin
		rfif.wsel=instr[15:11];
	end
	2: begin
		rfif.wsel=5'b11111;
	end
	3: begin
	   rfif.wsel='0;//latch
	end
        endcase

	casez(cuif.DataScr)
        0: begin
		rfif.wdat=aluif.portOut;
	end
	1: begin
      
	     	rfif.wdat=dpif.dmemload;
        end
	2: begin
		rfif.wdat={instr[15:0], {16{1'b0}}};
	end
	3: begin
		rfif.wdat=pc+4;
	end
	endcase	
  end


//ALU
  assign aluif.portA=rfif.rdat1;
  assign aluif.ALUOP=cuif.ALUOP;
  always_comb begin
	casez(cuif.ALUScr)
	0: begin
		aluif.portB=rfif.rdat2;
	end
	1: begin
		if (instr[15])
			aluif.portB={{16{1'b1}},instr[15:0]};
		else
			aluif.portB={{16{1'b0}},instr[15:0]};
	end
	2: begin
		aluif.portB={{16{1'b0}},instr[10:6]};
        end
        3: begin
		aluif.portB={{16{1'b0}},instr[15:0]};
	end
	endcase
  end
//halt
   logic halt_nxt;
   always_ff @(posedge CLK, negedge nRST) begin
      dpif.halt <= halt_nxt;
   end
   always_comb begin
      halt_nxt = 0;
      
      if (cuif.halt)
      halt_nxt=cuif.halt;
      
      end
//datapath   
assign dpif.imemREN=1'b1;
assign dpif.imemaddr=pc;
assign dpif.dmemREN=ruif.dmemren;
assign dpif.dmemWEN=ruif.dmemwen;
assign dpif.dmemstore=rfif.rdat2;
assign dpif.dmemaddr=aluif.portOut;	
assign instr=dpif.imemload;

assign ruif.memren=cuif.memren;
assign ruif.memwen=cuif.memwen;
assign ruif.ihit=dpif.ihit;
assign ruif.dhit=dpif.dhit;
   

   
  
endmodule
