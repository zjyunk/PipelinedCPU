/*
	Title: MIPS Single-Cycle Control Unit
	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. opcode: 輸入的指令代號，據此產生對應的控制訊號
	Output Port
		1. RegDst: 控制RFMUX
		2. ALUSrc: 控制ALUMUX
		3. MemtoReg: 控制WRMUX
		4. RegWrite: 控制暫存器是否可寫入
		5. MemRead:  控制記憶體是否可讀出
		6. MemWrite: 控制記憶體是否可寫入
		7. Branch: 與ALU輸出的zero訊號做AND運算控制PCMUX
		8. ALUOp: 輸出至ALU Control
*/

`timescale 1ns/1ns

module Control_Unit( Opcode, Funct, Jump, ExtendSel, JrScr, WB, MEM, EX );

  input      [5:0] Opcode, Funct; // 輸入Opcode 和 Funct
  output reg       Jump, ExtendSel, JrScr; // 輸出控制訊號
  output reg [1:0] WB;  // 寫回階段控制訊號: RegWrite, MemtoReg
  output reg [2:0] MEM; // 記憶體階段控制訊號: Branch, MemRead, MemWrite
  output reg [3:0] EX;  // 執行階段控制訊號: RegDst, ALUOp, ALUSrc
  // 定義各種指令的操作碼

  parameter R_FORMAT = 6'd0;
  parameter J        = 6'd2;  
  parameter BEQ      = 6'd4;  
  parameter ANDI    = 6'd12;  
  parameter MADDU    = 6'd28;
  parameter LW       = 6'd35;
  parameter SW       = 6'd43;
  parameter MULTU = 6'd25;
  
  parameter JR       = 6'd8;  // Function code for JR (within R_FORMAT)

  always @( Opcode or Funct )
  begin

    case ( Opcode )

      R_FORMAT : 
      begin

        if( Funct == JR )
        begin
        // JR 指令控制訊號設定
          Jump      = 1'b0;	
          ExtendSel = 1'b0;
          JrScr      = 1'b1;  // Activate JrSrc signal
          WB        = 2'b0x;   // RegWrite, MemtoReg
          MEM       = 3'b000;  // Branch, MemRead, MemWrite
          EX        = 4'bx000; // RegDst, ALUOp, ALUSrc

        end
        else if( Funct == MULTU )
        begin
          // MULTU 指令控制訊號設定
          Jump      = 1'b0;	
          ExtendSel = 1'b0;
          JrScr     = 1'b0;
          WB        = 2'b0x;   // RegWrite, MemtoReg
          MEM       = 3'b000;  // Branch, MemRead, MemWrite
          EX        = 4'bx100; // RegDst, ALUOp, ALUSrc

        end
        else
        begin
          // 其他R_FORMAT控制訊號設定
          Jump      = 1'b0;	
          ExtendSel = 1'b0;
          JrScr     = 1'b0;
          WB        = 2'b10;   // RegWrite, MemtoReg
          MEM       = 3'b000;  // Branch, MemRead, MemWrite
          EX        = 4'b1100; // RegDst, ALUOp, ALUSrc

        end

      end
	  
	  ANDI :
      begin
        // ANDI 指令控制訊號設定
        Jump      = 1'b0;
        ExtendSel = 1'b1;
        JrScr     = 1'b0;
        WB        = 2'b10;   // RegWrite, MemtoReg
        MEM       = 3'b000;  // Branch, MemRead, MemWrite
        EX        = 4'b0011; // RegDst, ALUOp, ALUSrc

      end

      J :
      begin
        // J 指令控制訊號設定
        Jump      = 1'b1;
        ExtendSel = 1'b1;
        JrScr     = 1'b0;
        WB        = 2'b0x;   // RegWrite, MemtoReg
        MEM       = 3'b000;  // Branch, MemRead, MemWrite
        EX        = 4'bx000; // RegDst, ALUOp, ALUSrc

      end

      BEQ :
      begin
        // BEQ 指令控制訊號設定 (比較由 Beq_Unit 處理)
        Jump      = 1'b0;
        ExtendSel = 1'b0;
        JrScr     = 1'b0;
        WB        = 2'b0x;   // RegWrite, MemtoReg
        MEM       = 3'b100;  // Branch, MemRead, MemWrite
        EX        = 4'bx000; // RegDst, ALUOp, ALUSrc

      end


      MADDU :
      begin
        // MADDU 指令控制訊號設定
        Jump      = 1'b0;
        ExtendSel = 1'b0;
        JrScr     = 1'b0;
        WB        = 2'b0x;   // RegWrite, MemtoReg
        MEM       = 3'b000;  // Branch, MemRead, MemWrite
        EX        = 4'bx110; // RegDst, ALUOp, ALUSrc
	      
      end

      LW :
      begin
        // LW 指令控制訊號設定
        Jump      = 1'b0;
        ExtendSel = 1'b0; // sign extend (offset 可為負)
        JrScr     = 1'b0;
        WB        = 2'b11;   // RegWrite, MemtoReg
        MEM       = 3'b010;  // Branch, MemRead, MemWrite
        EX        = 4'b0001; // RegDst, ALUOp, ALUSrc

      end

      SW :
      begin
        // SW 指令控制訊號設定
        Jump      = 1'b0;
        ExtendSel = 1'b0; // sign extend (offset 可為負)
        JrScr     = 1'b0;
        WB        = 2'b0x;   // RegWrite, MemtoReg
        MEM       = 3'b001;  // Branch, MemRead, MemWrite
        EX        = 4'bx001; // RegDst, ALUOp, ALUSrc

      end

      default
      begin
        // 未實作的操作碼預設控制訊號設定
        $display("control_single unimplemented opcode %d", Opcode);
        Jump      = 1'bx;
        ExtendSel = 1'bx;
        JrScr     = 1'b0;
        WB        = 2'bxx;    // RegWrite, MemtoReg
        MEM       = 3'bxxx;   // Branch, MemRead, MemWrite
        EX        = 4'bxxxx;  // RegDst, ALUOp, ALUSrc

      end

    endcase

  end

endmodule