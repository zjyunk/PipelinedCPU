/*
	Title:	ALU Control Unit
	Author: Garfield (Computer System and Architecture Lab, ICE, CYCU)
	Input Port
		1. ALUOp: 00 = add (LW/SW), 01 = and (ANDI), 10 = R-type, 11 = MADDU
		2. Funct: 如果是其他指令則用這邊6碼判斷
	Output Port
		1. SignalToALU: 最後解碼完成之指令
		2. Stall: 乘法在 EX 階段未完成時為 1，凍結 PC / IF_ID / ID_EX
		3. MulStart / MulRun: 控制乘法器載入與運算
		4. HiLoWrite / HiLoSel: 乘法完成時寫入 HiLo（0 = 覆寫, 1 = 累加）
		5. Sel: 選擇 ALU / Hi / Lo 輸出
*/

module ALU_Control_Unit( Clk, Rst, ALUOp, Funct, Stall, MulStart, MulRun, HiLoWrite, HiLoSel, Sel, SignalToALU );

  input       Clk, Rst;
  input [1:0] ALUOp;
  input [5:0] Funct;

  output           Stall, MulStart, MulRun, HiLoWrite, HiLoSel;
  output reg [1:0] Sel;
  output reg [2:0] SignalToALU;

  reg  [5:0] counter ;
  wire       IsMul ;

  // symbolic constants for instruction function code
  parameter SLL   = 6'b000000; // 0
  parameter MFHI  = 6'b010000; // 16
  parameter MFLO  = 6'b010010; // 18
  parameter MULTU = 6'b011001; // 25
  parameter MADDU = 6'b000001; // 01 (opcode 28)
  parameter ADD   = 6'b100000; // 32
  parameter SUB   = 6'b100010; // 34
  parameter AND   = 6'b100100; // 36
  parameter OR    = 6'b100101; // 37
  parameter SLT   = 6'b101010; // 42

  // symbolic constants for ALU Operations
  parameter ALU_and   = 3'b000;
  parameter ALU_or    = 3'b001;
  parameter ALU_add   = 3'b010;
  parameter ALU_sub   = 3'b110;
  parameter ALU_sll   = 3'b011;
  parameter ALU_slt   = 3'b111;
  parameter ALU_andi  = 3'b101;

  // 乘法週期: counter 0 載入, 1~32 運算, 33 寫入 HiLo 並放行 pipeline
  parameter MUL_DONE  = 6'd33;

  assign IsMul = ( ALUOp == 2'b10 && Funct == MULTU ) || ( ALUOp == 2'b11 && Funct == MADDU );

  always@( posedge Clk )
  begin

    if ( Rst || !IsMul || counter == MUL_DONE )
      counter <= 6'd0;
    else
      counter <= counter + 6'd1;

  end

  assign Stall     = IsMul && ( counter != MUL_DONE );
  assign MulStart  = IsMul && ( counter == 6'd0 );
  assign MulRun    = IsMul && ( counter != 6'd0 ) && ( counter != MUL_DONE );
  assign HiLoWrite = IsMul && ( counter == MUL_DONE );
  assign HiLoSel   = ( ALUOp == 2'b11 );   // MADDU 累加

  always @( ALUOp or Funct )
  begin

    Sel = 2'b00;
    SignalToALU = 3'bxxx;

    case ( ALUOp )

      2'b00 : SignalToALU = ALU_add;
      2'b01 : SignalToALU = ALU_andi;
      2'b10 :
      case ( Funct )

        ADD  : SignalToALU = ALU_add;
        SUB  : SignalToALU = ALU_sub;
        AND  : SignalToALU = ALU_and;
        OR   : SignalToALU = ALU_or;
        SLT  : SignalToALU = ALU_slt;
        SLL  : SignalToALU = ALU_sll;
        MFHI : Sel = 2'b01;
        MFLO : Sel = 2'b10;
        default SignalToALU = 3'bxxx;

      endcase

      default SignalToALU = 3'bxxx;

    endcase

  end

endmodule
