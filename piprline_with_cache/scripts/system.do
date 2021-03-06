onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/prif/halt_ex
add wave -noupdate /system_tb/DUT/CPU/DP/prif/halt_mem
add wave -noupdate /system_tb/DUT/CPU/DP/huif/exmem_en
add wave -noupdate /system_tb/DUT/CPU/DP/huif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/huif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/instr
add wave -noupdate /system_tb/DUT/CPU/DP/pc
add wave -noupdate /system_tb/DUT/CPU/DP/pc_nxt
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/PR/prif/pc_if
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/PR/prif/pc_id
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/PR/prif/pc_ex
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/PR/prif/pc_mem
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/PR/prif/pc_wb
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate /system_tb/DUT/CPU/DP/huif/flush_idex
add wave -noupdate /system_tb/DUT/CPU/DP/huif/flush_ifid
add wave -noupdate /system_tb/DUT/CPU/DP/prif/PCScr_mem
add wave -noupdate /system_tb/DUT/CPU/DP/PR/prif/instr_mem
add wave -noupdate /system_tb/DUT/CPU/DP/RF/reg_file
add wave -noupdate /system_tb/DUT/CPU/DP/prif/opcode_ex
add wave -noupdate /system_tb/DUT/CPU/DP/prif/opcode_mem
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/portOut
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/zero_flag
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/opcode_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/PCScr_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/dataScr_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/ALUScr_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/RegDest_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/memren_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/memwen_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/Regwen_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/halt_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/branch_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/ALUOP_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/rdat1_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/rdat2_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/pc_ex
add wave -noupdate -group EX /system_tb/DUT/CPU/DP/prif/instr_ex
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/opcode_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/dmemren
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/dmemwen
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/branch_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/Regwen_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/halt_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/zero_flag_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/PCScr_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/dataScr_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/pc_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/pc_bran_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/dmemaddr
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/dmemstore
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/instr_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/regwrite_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/imm_mem
add wave -noupdate -group mem /system_tb/DUT/CPU/DP/prif/dmemload
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -expand -group RAM /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -expand -group RAM /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/portA
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/portB
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/portOut
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/neg_flag
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/zero_flag
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/of_flag
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/ALUOP
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/dhit
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/ihit
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/halt
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/ptAScr
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/ptBScr
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/opcode_ex
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/regwrite_mem
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/regwrite_wb
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/rs
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/rt
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/rs_ex
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/rt_ex
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/regwen_mem
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/regwen_wb
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/memren_ex
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/ifid_en
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/idex_en
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/exmem_en
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/memwb_en
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/pc_en
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/dmemren
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/flush_idex
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/flush_ifid
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/flush_exmem
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/branch
add wave -noupdate -group {hazard } /system_tb/DUT/CPU/DP/huif/Regwen
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/halt
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/ihit
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/imemREN
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/imemload
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/imemaddr
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/dhit
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/datomic
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/dmemREN
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/dmemWEN
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/flushed
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/dmemload
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/dmemstore
add wave -noupdate -group dcif /system_tb/DUT/CPU/CM/dcif/dmemaddr
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/CLK
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/daddr
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/data
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/hit_cnt
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/i
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/index
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/left1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/left2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/left_dirty
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/left_dirty_nxt
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/left_en
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/left_tag
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/left_tag_nxt
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/left_valid
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/lru
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/lru_nxt
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/nRST
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/right1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/right2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/right_dirty
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/right_dirty_nxt
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/right_en
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/right_tag
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/right_tag_nxt
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/right_valid
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/state
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/state_nxt
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/w1b1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/w1b2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/w2b1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/w2b2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/word1_en
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/word2_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {27000000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3724161591 ps} {3725108970 ps}
