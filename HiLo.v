`timescale 1ns/1ns

module HiLo( Clk, Rst, Write, Sel, Cin, HiOut, LoOut );
  // 把答案切成兩分
  // Write: 乘法完成時寫入一次
  // Sel  : 0 = MULTU 直接寫入, 1 = MADDU 累加

  input             Clk, Rst, Write, Sel;
  input      [63:0] Cin;

  output     [31:0] HiOut;
  output     [31:0] LoOut;

  reg [63:0] HiLo ;

  always@( posedge Clk )
  begin

    if ( Rst )
    begin

      HiLo <= 64'b0;

    end

    else if ( Write )
    begin

      if ( Sel )
        HiLo <= HiLo + Cin;
      else
        HiLo <= Cin;

    end

  end

  assign HiOut = HiLo[63:32] ;
  assign LoOut = HiLo[31:0] ;

endmodule
