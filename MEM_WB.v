`timescale 1ns/1ns

module MEM_WB ( Clk, Rst, WB_MEM,  RD_MEM,  ALUOut_MEM,  WN_MEM, WB_WB, RD_WB, ALUOut_WB, WN_WB );
								  
  input Clk, Rst;
	
  input [1:0]  WB_MEM;
  input [4:0]	 WN_MEM;
  input [31:0] RD_MEM, ALUOut_MEM;
	
  output reg [1:0]  WB_WB;
  output reg [4:0]  WN_WB;
  output reg [31:0] RD_WB, ALUOut_WB;
   
  always @( posedge Clk ) 
  begin

    if ( Rst ) 
    begin

      WB_WB    <= 2'b0;
      RD_WB    <= 32'b0;
      ALUOut_WB  <= 32'b0; 
      WN_WB    <= 5'b0;

    end

    else 
    begin

      WB_WB    <=  WB_MEM;
      RD_WB    <=  RD_MEM;
      ALUOut_WB  <=  ALUOut_MEM; 
      WN_WB    <=  WN_MEM;

    end

  end

endmodule