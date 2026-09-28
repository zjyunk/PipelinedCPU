`timescale 1ns/1ns

module EX_MEM ( Clk, Rst, Zero_EX, WB_EX, MEM_EX, WN_EX, PCplusForBranch_EX, DataOut_EX, RD2_EX,
                Zero_MEM, WB_MEM, MEM_MEM, WN_MEM, PCplusForBranch_MEM, DataOut_MEM, RD2_MEM );

  input              Clk, Rst, Zero_EX;
  input      [1:0]   WB_EX;  // RegWrite_EX, MemtoReg_EX
  input      [2:0]   MEM_EX; // Branch, MemRead_EX, MemWrite_EX
  input      [4:0]	 WN_EX;
  input      [31:0]  PCplusForBranch_EX, DataOut_EX, RD2_EX;

  output reg         Zero_MEM; 
  output reg [1:0]   WB_MEM;  // RegWrite_EX, MemtoReg_EX
  output reg [2:0]   MEM_MEM; // Branch, MemRead_EX, MemWrite_EX
  output reg [4:0]   WN_MEM;
  output reg [31:0]  PCplusForBranch_MEM, DataOut_MEM, RD2_MEM;
	
  always @( posedge Clk ) 
  begin

    if ( Rst ) 
    begin

      Zero_MEM            <= 1'b0;
      WB_MEM              <= 2'b0;
      MEM_MEM             <= 3'b0;
      PCplusForBranch_MEM <= 32'b0;
      DataOut_MEM         <= 32'b0; 
      RD2_MEM             <= 32'b0; 
      WN_MEM              <= 5'b0; 

    end

    else 
    begin

      Zero_MEM            <= Zero_EX;
      WB_MEM              <= WB_EX;
      MEM_MEM             <= MEM_EX;
      PCplusForBranch_MEM <= PCplusForBranch_EX;
      DataOut_MEM         <= DataOut_EX; 
      RD2_MEM             <= RD2_EX; 
      WN_MEM              <= WN_EX; 

    end

  end

endmodule
	
