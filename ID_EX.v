`timescale 1ns/1ns

module ID_EX( Clk, Rst, Stall, WB_ID, MEM_ID, EX_ID, Rt_ID, Rd_ID, Shamt_ID, Funct_ID, PCplus4_ID, RD1_ID, RD2_ID, Ext_Immed_ID,
              WB_EX, MEM_EX, EX_EX, Rt_EX, Rd_EX, Shamt_EX, Funct_EX, PCplus4_EX, RD1_EX, RD2_EX, Ext_Immed_EX );

  input             Clk, Rst, Stall;
  input      [1:0]  WB_ID;  // RegWrite_ID, MemtoReg_ID
  input      [2:0]  MEM_ID; // Branch_ID, MemRead_ID, MemWrite_ID
  input      [3:0]  EX_ID;  // RegDst_ID, ALUSrc_ID
  input      [4:0]  Rt_ID, Rd_ID;
  input      [4:0]  Shamt_ID;
  input      [5:0]  Funct_ID;
  input      [31:0] PCplus4_ID, RD1_ID, RD2_ID, Ext_Immed_ID;


  output reg [1:0]  WB_EX;  // RegWrite_EX, MemtoReg_EX
  output reg [2:0]  MEM_EX; // Branch_EX, MemRead_EX, MemWrite_EX
  output reg [3:0]  EX_EX;  // RegDst_EX, ALUSrc_EX
  output reg [4:0]  Rt_EX, Rd_EX;
  output reg [4:0]  Shamt_EX;
  output reg [5:0]  Funct_EX;
  output reg [31:0] PCplus4_EX, RD1_EX, RD2_EX, Ext_Immed_EX;
  
  always@( posedge Clk )
  begin

    if( Rst )
    begin

      WB_EX        <= 0;
      MEM_EX       <= 0;
      EX_EX        <= 0;
      Rt_EX        <= 0;    
      Rd_EX        <= 0;
      Shamt_EX     <= 0;
      Funct_EX     <= 0;
      PCplus4_EX   <= 0;
      RD1_EX       <= 0;
      RD2_EX       <= 0;
      Ext_Immed_EX <= 0;
		 
    end

    else if( Stall )
    begin

      WB_EX        <= WB_EX;
      MEM_EX       <= MEM_EX;
      EX_EX        <= EX_EX;
      Rt_EX        <= Rt_EX;
      Rd_EX        <= Rd_EX;
      Shamt_EX     <= Shamt_EX;
      Funct_EX     <= Funct_EX;
      PCplus4_EX   <= PCplus4_EX;
      RD1_EX       <= RD1_EX;
      RD2_EX       <= RD2_EX;
      Ext_Immed_EX <= Ext_Immed_EX;

    end

    else  
    begin

      WB_EX        <= WB_ID;
      MEM_EX       <= MEM_ID;
      EX_EX        <= EX_ID;
      Rt_EX        <= Rt_ID;
      Rd_EX        <= Rd_ID;
      Shamt_EX     <= Shamt_ID;
      Funct_EX     <= Funct_ID;
      PCplus4_EX   <= PCplus4_ID;
      RD1_EX       <= RD1_ID;
      RD2_EX       <= RD2_ID;
      Ext_Immed_EX <= Ext_Immed_ID;

    end

  end
  
endmodule