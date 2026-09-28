`timescale 1ns/1ns

/*
	Title: 32-bit Unsigned Shift-Add Multiplier (multi-cycle)
	Input Port
		1. Start: 載入被乘數/乘數，PROD 清為 { 0, 乘數 }
		2. Run  : 每個 clock 做一次「加法 + 右移」，共 32 次
	Output Port
		1. DataOut: 64-bit 乘積（Run 滿 32 次後有效）
*/

module Multiplier( Clk, Rst, Start, Run, DataA, DataB, DataOut );

  input         Clk, Rst, Start, Run;
  input  [31:0] DataA ;  // 被乘數 (multiplicand)
  input  [31:0] DataB ;  // 乘數   (multiplier)

  output [63:0] DataOut ;

  reg  [31:0] MCND ;
  reg  [64:0] PROD ;     // 多 1 bit 存高位加法的進位
  wire [32:0] upper ;

  // PROD[0] 為 1 時，高 32 位加上被乘數（33 bit 保留進位）
  assign upper = PROD[0] ? ( { 1'b0, PROD[63:32] } + { 1'b0, MCND } ) : { 1'b0, PROD[63:32] } ;

  always@( posedge Clk )
  begin

    if ( Rst )
    begin

      MCND <= 32'b0 ;
      PROD <= 65'b0 ;

    end

    else if ( Start )
    begin

      MCND <= DataA ;
      PROD <= { 33'b0, DataB } ;

    end

    else if ( Run )
    begin

      // 加法結果與低位一起右移 1 bit
      PROD <= { 1'b0, upper, PROD[31:1] } ;

    end

  end

  assign DataOut = PROD[63:0] ;

endmodule
