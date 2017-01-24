// interface include
`include "caches_if.vh"
`include "datapath_cache_if.vh"
// CPU types
`include "cpu_types_pkg.vh"

module dcache(
	input logic CLK, nRST,
	datapath_cache_if dcif,
	caches_if.dcache cif 
	);

	import cpu_types_pkg::*;
	dcachef_t daddr;

	typedef enum logic [4:0] {IDLE, READ_CHECK, MEM_READ1, MEM_READ2, READ_HIT, READ_DIRTY1, READ_DIRTY2, WRITE_CHECK, WRITE_HIT, WRITE_DIRTY1, WRITE_DIRTY2, WRITE_SAVE, HALT, CHECK_DIRTY, FLUSH1, FLUSH2, COUNT} StateType;
	StateType state,  state_nxt;
	//current
	logic [7:0][31:0]	left1, left2, right1, right2;	//data
	logic [7:0]		left_valid = 7'b0;
	logic [7:0]		right_valid = 7'b0;
	logic [7:0]		left_dirty, right_dirty, lru;
	logic [7:0][25:0]	left_tag, right_tag;
	logic			left_en, right_en, word1_en, word2_en;
	
	//next
	logic [31:0] 		data, hit_cnt='0, hit_cnt_nxt = 32'b0;
	logic 			left_valid_nxt, right_valid_nxt, left_dirty_nxt, right_dirty_nxt, lru_nxt;
	logic [25:0]		left_tag_nxt, right_tag_nxt;
	logic			w1b1, w1b2, w2b1, w2b2;
	logic [3:0]		index;
	
	//assign daddr=dcif.dmemaddr; //input from datapath
	assign left_en = (left_tag[daddr.idx] == daddr.tag);
	assign right_en = (right_tag[daddr.idx] == daddr.tag);
	assign word1_en = !daddr.blkoff;
	assign word2_en = daddr.blkoff;

	logic [4:0] index_cnt, index_cnt_nxt;
	always_ff @(posedge CLK, negedge nRST) begin
		if(!nRST)
			index_cnt 	<= '0;
		else		
			index_cnt 	<= index_cnt_nxt;
	end
	//-------------------------------------------
	int i;	
	always_ff @ (posedge CLK, negedge nRST) begin
		if (!nRST) begin
			state <= IDLE;
			daddr <= 32'b0; //input from datapath
			left1 		<= '0;
			left2		<= '0;
			right1		<= '0;
			right2	 	<= '0;
			left_valid	<= '0;
			right_valid	<= '0;
			left_dirty 	<= '0;
			right_dirty	<= '0;
			lru		<= '0;
			left_tag 	<= '0;
			right_tag 	<= '0;
			hit_cnt		<= 32'b0;
		end else begin
			state			<= state_nxt;
			daddr 			<= dcif.dmemaddr; //input from datapath
			left1[daddr.idx] 	<= (w1b1)? data : left1[daddr.idx];
			left2[daddr.idx]	<= (w1b2)? data : left2[daddr.idx];
			right1[daddr.idx]	<= (w2b1)? data : right1[daddr.idx];
			right2[daddr.idx]	<= (w2b2)? data : right2[daddr.idx];
			left_valid[daddr.idx]	<= left_valid_nxt;
			right_valid[daddr.idx]	<= right_valid_nxt;
			left_dirty[daddr.idx] 	<= left_dirty_nxt;
			right_dirty[daddr.idx]	<= right_dirty_nxt;
			lru[daddr.idx]		<= lru_nxt;
			left_tag[daddr.idx] 	<= left_tag_nxt;
			right_tag[daddr.idx] 	<= right_tag_nxt;
			hit_cnt			<= hit_cnt_nxt;
		end
	end
	
	always_comb begin
		state_nxt = state;
		left_valid_nxt = left_valid[daddr.idx];
		right_valid_nxt = right_valid[daddr.idx];
		left_dirty_nxt = left_dirty[daddr.idx];
		right_dirty_nxt = right_dirty[daddr.idx];
		lru_nxt = lru[daddr.idx];
		left_tag_nxt = left_tag[daddr.idx];
		right_tag_nxt = right_tag[daddr.idx];
		w1b1 = 1'b0;
		w1b2 = 1'b0;
		w2b1 = 1'b0;
		w2b2 = 1'b0;
		data = 32'b0;
 	    	cif.dWEN = 1'b0;
		cif.dREN = 1'b0;
        	cif.daddr = 32'b0;
		cif.dstore = 32'b0;
		index_cnt_nxt = index_cnt;
		hit_cnt_nxt = hit_cnt;
 		dcif.dhit  = 1'b0;
		dcif.dmemload = 32'b0;
		dcif.flushed = 1'b0;

		case(state)
			IDLE: begin
				if (dcif.dmemREN)
					state_nxt = READ_CHECK;
				else if (dcif.dmemWEN)
					state_nxt = WRITE_CHECK;
				else if (dcif.halt) begin
					index_cnt_nxt = 4'b0;
					state_nxt = CHECK_DIRTY;
				end else
					state_nxt = IDLE;	
			end

			READ_CHECK: begin
				if (((left_tag[daddr.idx]==daddr.tag)&& left_valid[daddr.idx]) ||((right_tag[daddr.idx]==daddr.tag)&& right_valid[daddr.idx])) begin
					state_nxt = READ_HIT;
					hit_cnt_nxt = hit_cnt + 1;
				end else if (!lru[daddr.idx]) begin
					if (left_dirty[daddr.idx])
						state_nxt = READ_DIRTY1;
					else
						state_nxt = MEM_READ1;
				end else if (lru[daddr.idx]) begin
					if(right_dirty[daddr.idx])
						state_nxt = READ_DIRTY1;
					else
						state_nxt = MEM_READ1;
				end else
					state_nxt = READ_CHECK; 		
			end
			
			MEM_READ1: begin
				cif.dREN = 1'b1;
				cif.daddr = {daddr.tag,daddr.idx,1'b0,2'b00};
				data = cif.dload;
				if (!lru[daddr.idx])
					w1b1 = 1'b1;
				else
					w2b1 = 1'b1;
				if (!cif.dwait)
					state_nxt = MEM_READ2;
				else
					state_nxt = MEM_READ1;
			end
			MEM_READ2: begin
				cif.dREN = 1'b1;
				cif.daddr = {daddr.tag,daddr.idx,1'b1,2'b00};;
				data = cif.dload;
				if (!lru[daddr.idx]) begin
					w1b2 = 1'b1;
					left_tag_nxt = daddr.tag;
				end else begin
					w2b2 = 1'b1;
					right_tag_nxt = daddr.tag;
				end
				if (!cif.dwait)
					state_nxt = READ_HIT;
				else
					state_nxt = MEM_READ2;
			end

			READ_HIT: begin
	     		dcif.dhit = 1'b1;
				state_nxt = IDLE;
				if (left_en && word1_en) begin
					dcif.dmemload = left1[daddr.idx];
					lru_nxt = 1;
					left_valid_nxt = 1'b1;
				end else if (left_en && word2_en) begin
					dcif.dmemload = left2[daddr.idx];
					lru_nxt = 1;
					left_valid_nxt = 1'b1;
				end else if (right_en && word1_en) begin
					dcif.dmemload = right1[daddr.idx];
					lru_nxt = 0;
					right_valid_nxt = 1'b1;
				end else begin
					dcif.dmemload = right2[daddr.idx];
					lru_nxt = 0;
					right_valid_nxt = 1'b1;
				end									
			end

			READ_DIRTY1: begin
				if (!cif.dwait)
					state_nxt = READ_DIRTY2;
				else
					state_nxt = READ_DIRTY1;
				cif.dWEN = 1'b1;
				if (!lru[daddr.idx]) begin
					cif.dstore = left1[daddr.idx];
					cif.daddr = {left_tag[daddr.idx],daddr.idx,1'b0,2'b00};
				end else begin
					cif.daddr = {right_tag[daddr.idx],daddr.idx,1'b0,2'b00};
					cif.dstore = right1[daddr.idx];
				end
			end
			READ_DIRTY2: begin
				if (!cif.dwait)
					state_nxt = MEM_READ1;
				else
					state_nxt = READ_DIRTY2;
				cif.dWEN = 1'b1;
				if (!lru[daddr.idx]) begin
					cif.dstore = left2[daddr.idx];
					cif.daddr = {left_tag[daddr.idx],daddr.idx,1'b1,2'b00};
					left_dirty_nxt = 1'b0;
				end else begin
					cif.daddr = {right_tag[daddr.idx],daddr.idx,1'b1,2'b00};
					cif.dstore = right2[daddr.idx];
					right_dirty_nxt = 1'b0;
				end
			end
			WRITE_CHECK: begin
				if (((left_tag[daddr.idx]==daddr.tag)&& left_valid[daddr.idx]) ||((right_tag[daddr.idx]==daddr.tag)&& right_valid[daddr.idx])) begin
					state_nxt = WRITE_HIT;
					hit_cnt_nxt = hit_cnt + 1;
				end else if (!lru[daddr.idx]) begin
					if (left_dirty[daddr.idx])
						state_nxt = WRITE_DIRTY1;
					else
						state_nxt = WRITE_SAVE;
				end else if (lru[daddr.idx]) begin
					if(right_dirty[daddr.idx])
						state_nxt = WRITE_DIRTY1;
					else
						state_nxt = WRITE_SAVE;
				end else
					state_nxt = WRITE_CHECK;
			end
			WRITE_HIT: begin
				dcif.dhit = 1'b1;
				state_nxt = IDLE;
				if (left_en && word1_en) begin
					data = dcif.dmemstore;
					lru_nxt = 1;
					left_valid_nxt = 1'b1;
					left_dirty_nxt = 1'b1;
					w1b1 = 1;
				end else if (left_en && word2_en) begin
					data = dcif.dmemstore;
					lru_nxt = 1;
					left_valid_nxt = 1'b1;
					left_dirty_nxt = 1'b1;
					w1b2 = 1;
				end else if (right_en && word1_en) begin
					data = dcif.dmemstore;
					lru_nxt = 0;
					right_valid_nxt = 1'b1;
					right_dirty_nxt = 1'b1;
					w2b1 = 1;
				end else begin
					data = dcif.dmemstore;
					lru_nxt = 0;
					right_valid_nxt = 1'b1;
					right_dirty_nxt = 1'b1;
					w2b2 = 1;
				end
			end
			WRITE_DIRTY1: begin
				if (!cif.dwait)
					state_nxt = WRITE_DIRTY2;
				else
					state_nxt = WRITE_DIRTY1;
				cif.dWEN = 1'b1;
				if (!lru[daddr.idx]) begin
					cif.dstore = left1[daddr.idx];
					cif.daddr = {left_tag[daddr.idx],daddr.idx,1'b0,2'b00};
				end else begin
					cif.daddr = {right_tag[daddr.idx],daddr.idx,1'b0,2'b00};
					cif.dstore = right1[daddr.idx];
				end
			end
			WRITE_DIRTY2: begin
				if (!cif.dwait)
					state_nxt = WRITE_SAVE;
				else
					state_nxt = WRITE_DIRTY2;
				cif.dWEN = 1'b1;
				if (!lru[daddr.idx]) begin
					cif.dstore = left2[daddr.idx];
					cif.daddr = {left_tag[daddr.idx],daddr.idx,1'b1,2'b00};
					left_tag_nxt = daddr.tag;
				end else begin
					cif.daddr = {right_tag[daddr.idx],daddr.idx,1'b1,2'b00};
					cif.dstore = right2[daddr.idx];
					right_tag_nxt = daddr.tag;
				end
			end
			WRITE_SAVE: begin
				if (!lru[daddr.idx]) begin
					left_tag_nxt = daddr.tag;
					if (word1_en) 
						w1b2 = 1'b1;
					else
						w1b1 = 1'b1;
				end else begin
					right_tag_nxt = daddr.tag;
					if (word1_en) 
						w2b2 = 1'b1;
					else
						w2b1 = 1'b1;
				end
				cif.dREN = 1'b1;
				cif.daddr = {daddr.tag,daddr.idx,!daddr.blkoff,2'b00};
				data = cif.dload;
				if (!cif.dwait)
					state_nxt = WRITE_HIT;
				else
					state_nxt = WRITE_SAVE;
			end

			CHECK_DIRTY: begin
				if (index_cnt == 5'b10000) begin
					state_nxt = COUNT;
				end else begin		
				if (!index_cnt[3]) begin
					if (left_dirty[index_cnt[2:0]]) begin
						state_nxt = FLUSH1;
					end else begin
						index_cnt_nxt = index_cnt+1;
						state_nxt = CHECK_DIRTY;
					end
				end else begin
					if (right_dirty[index_cnt[2:0]]) begin
						state_nxt = FLUSH1;
					end else begin
						index_cnt_nxt = index_cnt+1;
						state_nxt = CHECK_DIRTY;
					end
				end
			       
			    end
			end 
			FLUSH1: begin
				if (!cif.dwait)
					state_nxt = FLUSH2;
				else
					state_nxt = FLUSH1;
				cif.dWEN = 1'b1;
				if (!index_cnt[3]) begin
					cif.dstore = left1[index_cnt[2:0]];
					cif.daddr = {left_tag[index_cnt[2:0]],index_cnt[2:0],1'b0,2'b00};
					
				end else begin
					cif.daddr = {right_tag[index_cnt[2:0]],index_cnt[2:0],1'b0,2'b00};
					cif.dstore = right1[index_cnt[2:0]];
				end
				
			end
			FLUSH2: begin
				if (!cif.dwait) begin
					state_nxt = CHECK_DIRTY;
					index_cnt_nxt = index_cnt+1;
				end else
					state_nxt = FLUSH2;
				cif.dWEN = 1'b1;
				if (!index_cnt[3]) begin
					cif.dstore = left2[index_cnt[2:0]];
					cif.daddr = {left_tag[index_cnt[2:0]],index_cnt[2:0],1'b1,2'b00};
				end else begin
					cif.daddr = {right_tag[index_cnt[2:0]],index_cnt[2:0],1'b1,2'b00};
					cif.dstore = right2[index_cnt[2:0]];
				end
			end
			COUNT: begin
				cif.dWEN = 1'b1;
				cif.dstore = hit_cnt;
				cif.daddr = 32'h3100;
				if (!cif.dwait) begin
					state_nxt = HALT;
				end else
					state_nxt = COUNT;
			end
			HALT: begin
				dcif.flushed = 1'b1;
				state_nxt = HALT;
			end
		endcase
	end
endmodule

