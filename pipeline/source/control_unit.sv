//CPU types
`include "cpu_types_pkg.vh"

//interfaces

`include "control_unit_if.vh"

module control_unit(
	control_unit_if.ctr ctrif
);

import cpu_types_pkg::*;
	
logic bran_flag;	
always_comb begin
   ctrif.PCScr = 2'b0;
   ctrif.DataScr = 2'b0;
   ctrif.ALUScr = 2'b0;
   ctrif.RegDest = 2'b0;
   
   ctrif.memren=1'b0;
   ctrif.memwen=1'b0;
   ctrif.Regwen=1'b0;
   ctrif.halt=1'b0;
   ctrif.branch=1'b0;
   
   ctrif.ALUOP = 4'b1000;//alu op defualt value
   
  // bran_flag=1'b0;
   
   casez (ctrif.opcode)
//r type 
	RTYPE: begin
		casez(ctrif.funct)
		SLL: begin
		ctrif.ALUOP=ALU_SLL;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b10;
		ctrif.RegDest=2'b1;
		end
			
		SRL: begin
		ctrif.ALUOP=ALU_SRL;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b10;
		ctrif.RegDest=2'b1;	
		end

		ADD: begin
		ctrif.ALUOP=ALU_ADD;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end
		
		ADDU: begin
		ctrif.ALUOP=ALU_ADD;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end
	
		SUB: begin
		ctrif.ALUOP=ALU_SUB;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end

		SUBU: begin
		ctrif.ALUOP=ALU_SUB;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end

		AND: begin
		ctrif.ALUOP=ALU_AND;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end

		OR: begin
		ctrif.ALUOP=ALU_OR;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end

		XOR: begin
		ctrif.ALUOP=ALU_XOR;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end

		NOR: begin
		ctrif.ALUOP= ALU_NOR;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end

		SLT: begin
		ctrif.ALUOP=ALU_SLT;
		//if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;		
		end

		SLTU: begin
		ctrif.ALUOP=ALU_SLTU;
		   	   //if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.RegDest=2'b1;
		end
              
                JR: begin
			ctrif.PCScr=2'b10;
		end

		endcase

        end // case: RTYPE
//j type
	J: begin
		ctrif.PCScr=2'b11;		  		
	end
		
	JAL: begin
	   ctrif.PCScr=2'b11;
	   ctrif.RegDest=2'b10;
	   //if (ctrif.ihit == 1'b1)
	   ctrif.Regwen=1'b1;
	   ctrif.DataScr=2'b11;		
	end

//i type
//branch , how to choose PC mux? (without SC, LL)
	BEQ: begin
		bran_flag=1'b1;
		ctrif.ALUOP=ALU_SUB;
		ctrif.PCScr=2'b1;
	   ctrif.branch=1'b1;//ctrif.zero_flag & bran_flag;
	end

	BNE: begin
		bran_flag=1'b1;
		ctrif.ALUOP=ALU_SUB;
		ctrif.PCScr=2'b1;
	   ctrif.branch=1'b1; //ctrif.zero_flag ^ bran_flag;		
	end
//i type operation
	ADDI: begin
	   	  // if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b1;
		ctrif.ALUOP=ALU_ADD;	
	end

	ADDIU: begin
	   	   //if (ctrif.ihit == 1'b1)
	        ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b1;
		ctrif.ALUOP=ALU_ADD;	
	end

	SLTI: begin
	   	  // if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b1;
		ctrif.ALUOP=ALU_SLT;	
	end

	SLTIU: begin
	   	  // if (ctrif.ihit == 1'b1)
        	ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b1;
		ctrif.ALUOP=ALU_SLTU;
	end

	ANDI: begin
	   	   //if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b11;
		ctrif.ALUOP=ALU_AND;		
	end

	ORI: begin
	   	   //if (ctrif.ihit == 1'b1)
		ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b11;
		ctrif.ALUOP=ALU_OR;	        
	end

	XORI: begin
	   	  // if (ctrif.ihit == 1'b1)
	 	ctrif.Regwen=1'b1;
		ctrif.ALUScr=2'b11;
		ctrif.ALUOP=ALU_XOR;		
	end

	LUI: begin
	   	 //  if (ctrif.ihit == 1'b1)
        	ctrif.Regwen=1'b1;
       	        ctrif.DataScr=2'b10;
   
	end
	
	LW: begin
	   ctrif.ALUScr=2'b1;
	   ctrif.memren=1'b1;
	   ctrif.DataScr=2'b1;
	   ctrif.ALUOP=ALU_ADD;
	   //if (ctrif.dhit)
		ctrif.Regwen=1'b1;
	
		
	end

	SW: begin
	   
		ctrif.Regwen=1'b0;
		ctrif.ALUScr=2'b1;
		ctrif.memwen=1'b1;	
  		ctrif.ALUOP=ALU_ADD;       
	end


	HALT: begin
		ctrif.halt=1'b1;
	end
	
   endcase	
	
end

endmodule
