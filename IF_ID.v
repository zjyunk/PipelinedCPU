`timescale 1ns/1ns

module IF_ID( Clk, Rst, Stall, PCplus4_IF, Instr_IF, PCplus4_ID, Instr_ID );

  input             Clk, Rst, Stall;
  input      [31:0] PCplus4_IF, Instr_IF;   // 從 IF 階段來的信號 

  output reg [31:0] PCplus4_ID, Instr_ID;   // 傳遞到 ID 階段的信號
  
  always@( posedge Clk )
  begin
    
    if( Rst ) 
    begin

      PCplus4_ID <= 0;
      Instr_ID   <= 0;

    end

    else if ( !Stall )
    begin

      PCplus4_ID <= PCplus4_IF;
      Instr_ID   <= Instr_IF;

    end

  end
  
endmodule