//	Title: MIPS 5-Stage Pipelined Processor
//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)


module Mips_Pipelined( clk, rst );
	input clk, rst;
	
	// instruction bus
	wire[31:0] instrtion_IF, instrtion_ID;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct, funct_EX;
	wire [4:0] rs, rt, rt_EX, rd, rd_EX, shamt, shamt_EX;
	wire [15:0] immed;
	wire [31:0] sign_extend, unsign_extend, extend_ID, extend_EX, branch_offset;
	wire [25:0] jump_offset;
	wire [63:0] mul_ans;
	
	// datapath signals
	wire [4:0] wn_EX, wn_MEM, wn_WB;
	wire [31:0] rd_WB, rd1_ID, rd1_EX, rd2_ID, rd2_EX, rd2_MEM, rd_out_MEM, wd_WB, 
				alu_b, alu_ans, alu_out_EX, alu_out_MEM, alu_out_WB, 
				branch_addr_EX, branch_addr_MEM, jump_addr, branch_addr, pc_adddr, 
                pc, pc_final, pc_next,pc_plus4_IF, pc_plus4_ID, pc_plus4_EX, pc_plus4_MEM, 
				HiOut, LoOut;

	// control signals
	wire stall, PCSrc, BranchTaken, JumpSrc, ExtendSrc, MulStart, MulRun, HiLoWrite, HiLoSel, zero_EX, zero_MEM, JrSrc;
	wire [31:0] branch_target;
	reg         br_pending;
	reg  [31:0] br_target;
	wire [1:0] ALUOp, ALU_Out_Sel;
	wire [2:0] Operation;
	
	wire [1:0] WB_ID, WB_EX, WB_MEM, WB_WB; // { RegWrite, MemtoReg }
	wire [2:0] MEM_ID, MEM_EX, MEM_MEM;     // { Branch, MemRead, MemWrite }
	wire [3:0] EX_ID, EX_EX;                // { RegDst, ALUOp, ALUSrc }
	
	
	assign opcode = instrtion_ID[31:26];
	assign rs = instrtion_ID[25:21];
	assign rt = instrtion_ID[20:16];
	assign rd = instrtion_ID[15:11];
	assign shamt = instrtion_ID[10:6];
	assign funct = instrtion_ID[5:0];
	assign immed = instrtion_ID[15:0];
	assign jump_offset = instrtion_ID[25:0];
	
	// branch offset shifter
	assign branch_offset = extend_EX << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr = { pc_plus4_IF[31:28], jump_offset << 2 };
	
	// IF module 
	
	
	//assign pc_next = pc_final;
	
	PC PC( .Clk( clk ), .Rst( rst ), .Stall( stall ), .D_In( pc_final ), .D_Out( pc ) ); 

	Add PCAdd( .DataA( pc ), .DataB( 32'd4 ), .DataOut( pc_plus4_IF ) );	
	
	Memory InstrMem( .Clk( clk ), .MemRead( 1'b1 ), .MemWrite( 1'b0 ), .Addr( pc ), .Wd( 32'd0 ), .Rd( instrtion_IF ) );

	// 乘法 stall 期間 PC 被凍結，若此時 MEM 階段的 branch 成立，先記住目標，stall 結束後再跳
	always @( posedge clk )
	begin
		if ( rst || !stall )
			br_pending <= 1'b0;
		else if ( PCSrc )
		begin
			br_pending <= 1'b1;
			br_target  <= branch_addr_MEM;
		end
	end

	assign BranchTaken   = PCSrc | br_pending;
	assign branch_target = br_pending ? br_target : branch_addr_MEM;

	MUX_2to1 #(32) PCMUX( .Sel( BranchTaken ), .DataIn0( pc_plus4_IF ), .DataIn1( branch_target ), .DataOut( pc_adddr ) );	

	MUX_2to1 #(32) JumpMUX( .Sel( JumpSrc ), .DataIn0( pc_adddr ), .DataIn1( jump_addr ), .DataOut( pc_next ) );	
	
	MUX_2to1 #(32) JrMUX( .Sel( JrSrc ), .DataIn0( pc_next ), .DataIn1( rd1_ID ), .DataOut( pc_final ) ); // rd1_ID is rs register value
	

	IF_ID IF_ID_Reg( .Clk( clk ), .Rst( rst ), .Stall( stall ), .PCplus4_IF( pc_plus4_IF ), .Instr_IF( instrtion_IF ), .PCplus4_ID( pc_plus4_ID ), .Instr_ID( instrtion_ID ) );

	// ID module
	Control_Unit Control_Unit( .Opcode( opcode ), .Funct( funct ), .Jump( JumpSrc ), .ExtendSel( ExtendSrc ) , .JrScr( JrSrc ), .WB( WB_ID ), .MEM( MEM_ID ), .EX( EX_ID ) );

	Reg_File Reg_File( .Clk( clk ), .RegWrite( WB_WB[1] ), .RN1( rs ), .RN2( rt ), .WN( wn_WB ), .WD( wd_WB ), .RD1( rd1_ID ), .RD2( rd2_ID ) );

	Sign_Extend Sign_Extend( .Immed_In( immed ), .Ext_Immed_Out( sign_extend ) );
	
	UnSign_Extend UnSign_Extend( .Immed_In( immed ), .Ext_Immed_Out( unsign_extend ) );

	MUX_2to1 #(32) ExtendMUX( .Sel( ExtendSrc ), .DataIn0( sign_extend ), .DataIn1( unsign_extend ), .DataOut( extend_ID ) );

	ID_EX ID_EX_Reg( .Clk( clk ), .Rst( rst ), .Stall( stall ),
	                 .WB_ID( WB_ID ), .MEM_ID( MEM_ID ), .EX_ID( EX_ID ), .Rt_ID( rt ), .Rd_ID( rd ), .Shamt_ID( shamt ), 
	                 .Funct_ID( funct ), .PCplus4_ID( pc_plus4_ID ), .RD1_ID( rd1_ID ), .RD2_ID( rd2_ID ), .Ext_Immed_ID( extend_ID ),
					 .WB_EX( WB_EX ), .MEM_EX( MEM_EX ), .EX_EX( EX_EX ), .Rt_EX( rt_EX ), .Rd_EX( rd_EX ), .Shamt_EX( shamt_EX ),
					 .Funct_EX( funct_EX ), .PCplus4_EX( pc_plus4_EX ), .RD1_EX( rd1_EX ), .RD2_EX( rd2_EX ), .Ext_Immed_EX( extend_EX ) );

	// EX module 
	Add BranchAdd( .DataA( pc_plus4_EX ), .DataB( branch_offset ), .DataOut( branch_addr_EX ) );

	Multiplier Multiplier( .Clk( clk ), .Rst( rst ), .Start( MulStart ), .Run( MulRun ), .DataA( rd1_EX ), .DataB( rd2_EX ), .DataOut( mul_ans ) );

	HiLo HiLo( .Clk( clk ), .Rst( rst ), .Write( HiLoWrite ), .Sel( HiLoSel ), .Cin( mul_ans ), .HiOut( HiOut ), .LoOut( LoOut ) );

	Beq_Unit Beq_Unit( .DataA( rd1_EX ), .DataB( rd2_EX ), .DataOut( zero_EX ) );	

	MUX_2to1 #(32) ALUMUX( .Sel( EX_EX[0] ), .DataIn0( rd2_EX ), .DataIn1( extend_EX ), .DataOut( alu_b ) );

	MUX_2to1 #(5) RegMUX( .Sel(EX_EX[3]), .DataIn0( rt_EX ), .DataIn1( rd_EX ), .DataOut( wn_EX ) );

	ALU_Control_Unit ALU_Control_Unit( .Clk( clk ), .Rst( rst ), .ALUOp( EX_EX[2:1] ), .Funct( funct_EX ), 
									   .Stall( stall ), .MulStart( MulStart ), .MulRun( MulRun ), .HiLoWrite( HiLoWrite ), .HiLoSel( HiLoSel ),
									   .Sel( ALU_Out_Sel ), .SignalToALU( Operation ) );

    ALU ALU( .ALUOperation( Operation ), .Shamt( shamt_EX ), .DataA( rd1_EX ), .DataB( alu_b ), .DataOut( alu_ans ) );

	MUX_4to1 #(32) OUTMUX( .Sel( ALU_Out_Sel ), .DataIn0( alu_ans ), .DataIn1( HiOut ), .DataIn2( LoOut ), .DataIn3( 32'bX ), .DataOut( alu_out_EX ) );

	EX_MEM EX_MEM_Reg( .Clk( clk ), .Rst( rst ), 
					   .Zero_EX( zero_EX ), .WB_EX( WB_EX ), .MEM_EX( MEM_EX ), .WN_EX( wn_EX ),
					   .PCplusForBranch_EX( branch_addr_EX ), .DataOut_EX( alu_out_EX ), .RD2_EX( rd2_EX ),
					   .Zero_MEM( zero_MEM ), .WB_MEM( WB_MEM ), .MEM_MEM( MEM_MEM ), .WN_MEM( wn_MEM ), 
					   .PCplusForBranch_MEM( branch_addr_MEM ), .DataOut_MEM( alu_out_MEM ), .RD2_MEM( rd2_MEM ) );

	// MEM module 
	and BR_AND( PCSrc, MEM_MEM[2], zero_MEM );

	Memory DatMem( .Clk( clk ), .MemRead( MEM_MEM[1] ), .MemWrite( MEM_MEM[0] ), .Addr( alu_out_MEM ), .Wd( rd2_MEM ), .Rd( rd_out_MEM ) );	 

	MEM_WB MEM_WB_Reg( .Clk( clk ), .Rst( rst ), 
					   .WB_MEM( WB_MEM ), .RD_MEM( rd_out_MEM ), .ALUOut_MEM( alu_out_MEM ), .WN_MEM( wn_MEM ), 
	                   .WB_WB( WB_WB ), .RD_WB( rd_WB ), .ALUOut_WB( alu_out_WB ), .WN_WB( wn_WB ) );

	// WB module 
	MUX_2to1 #(32) WBMUX( .Sel( WB_WB[0] ), .DataIn0( alu_out_WB ), .DataIn1( rd_WB ), .DataOut( wd_WB ) );
		   
endmodule