`timescale 1ns/1ns

module Beq_Unit( DataA, DataB, DataOut );

    input [31:0] DataA, DataB;

    output       DataOut ;

    assign DataOut = ( DataA == DataB ) ? 1'b1 : 1'b0;

endmodule