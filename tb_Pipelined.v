/*
	Title: MIPS Single Cycle CPU Testbench
	Author: Selene (Computer System and Architecture Lab, ICE, CYCU) 
*/
module tb_Pipelined();
	reg clk, rst;

	parameter cycle_count = 16;
	
	// ????????10ns  
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		$dumpfile("mips_Pipelined.vcd");
		$dumpvars(0,tb_Pipelined);
		rst = 1'b1;
		/*
			??????????"instr_mem.txt, data_mem.txt"?????
			????1 Byte??????????????
			??Little Endian??
		*/
		$readmemh("instr_mem.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		// ????????????????????
		$readmemh("reg.txt", CPU.Reg_File.file_array );
		#10;
		rst = 1'b0;
	end

	always @( posedge clk ) begin
		$display( "%d, PC:", $time/10-1, CPU.pc );
		if ( CPU.opcode == 6'd0 ) begin
			$display( "%d, wd: %d", $time/10-1, CPU.wd_WB );
			if ( CPU.funct == 6'd32 ) $display( "%d, ADD\n", $time/10-1 );
			else if ( CPU.funct == 6'd34 ) $display( "%d, SUB\n", $time/10-1 );
			else if ( CPU.funct == 6'd36 ) $display( "%d, AND\n", $time/10-1 );
			else if ( CPU.funct == 6'd37 ) $display( "%d, OR\n", $time/10-1 );
			else if ( CPU.funct == 6'd0 )
			begin
				if ( CPU.rs == 5'd0 && CPU.rt == 5'd0 && CPU.rd == 5'd0 && CPU.shamt == 5'd0 )
					$display( "%d, NOP\n", $time/10-1 );
				else if ( CPU.shamt != 5'd0 ) $display( "%d, SLL\n", $time/10-1 );
			end
			else if ( CPU.funct == 6'd42 ) $display( "%d, SLT\n", $time/10-1 );
			else if ( CPU.funct == 6'd25 ) $display( "%d, MULTU\n", $time/10-1 );
			else if ( CPU.funct == 6'd16 ) $display( "%d, MFHI\n", $time/10-1 );
			else if ( CPU.funct == 6'd18 ) $display( "%d, MFLO\n", $time/10-1 );
			else if ( CPU.funct == 6'd8 ) $display( "%d, JR\n", $time/10-1 );
		end
		else if ( CPU.opcode == 6'd35 ) $display( "%d, LW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd43 ) $display( "%d, SW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd4 ) $display( "%d, BEQ\n", $time/10-1 );
		else if ( CPU.opcode == 6'd2 ) $display( "%d, J\n", $time/10-1 );
		else if ( CPU.opcode == 6'd12 ) $display( "%d, ANDI\n", $time/10-1 );

		if ( $time > 230 )
		  $stop();
	end
	
	Mips_Pipelined CPU( clk, rst );
	
endmodule