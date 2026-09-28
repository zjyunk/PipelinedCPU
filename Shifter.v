`timescale 1ns/1ns

module Shifter( dataA, dataB, Signal, dataOut, reset );
    input reset;
    input [31:0] dataA;
    input [31:0] dataB;
    input [5:0] Signal;
    output [31:0] dataOut;

    parameter SLL = 6'b000000;

    wire [31:0] stage1, stage2, stage3, stage4, stage5;

    // Stage 1: Shift by 16 if dataB[4] is 1
    MUX_2to1 #(1) mux1_0 (.Sel(dataB[4]), .DataIn0(dataA[0]), .DataIn1(1'b0), .DataOut(stage1[0]));
    MUX_2to1 #(1) mux1_1 (.Sel(dataB[4]), .DataIn0(dataA[1]), .DataIn1(1'b0), .DataOut(stage1[1]));
    MUX_2to1 #(1) mux1_2 (.Sel(dataB[4]), .DataIn0(dataA[2]), .DataIn1(1'b0), .DataOut(stage1[2]));
    MUX_2to1 #(1) mux1_3 (.Sel(dataB[4]), .DataIn0(dataA[3]), .DataIn1(1'b0), .DataOut(stage1[3]));
    MUX_2to1 #(1) mux1_4 (.Sel(dataB[4]), .DataIn0(dataA[4]), .DataIn1(1'b0), .DataOut(stage1[4]));
    MUX_2to1 #(1) mux1_5 (.Sel(dataB[4]), .DataIn0(dataA[5]), .DataIn1(1'b0), .DataOut(stage1[5]));
    MUX_2to1 #(1) mux1_6 (.Sel(dataB[4]), .DataIn0(dataA[6]), .DataIn1(1'b0), .DataOut(stage1[6]));
    MUX_2to1 #(1) mux1_7 (.Sel(dataB[4]), .DataIn0(dataA[7]), .DataIn1(1'b0), .DataOut(stage1[7]));
    MUX_2to1 #(1) mux1_8 (.Sel(dataB[4]), .DataIn0(dataA[8]), .DataIn1(1'b0), .DataOut(stage1[8]));
    MUX_2to1 #(1) mux1_9 (.Sel(dataB[4]), .DataIn0(dataA[9]), .DataIn1(1'b0), .DataOut(stage1[9]));
    MUX_2to1 #(1) mux1_10(.Sel(dataB[4]), .DataIn0(dataA[10]), .DataIn1(1'b0), .DataOut(stage1[10]));
    MUX_2to1 #(1) mux1_11(.Sel(dataB[4]), .DataIn0(dataA[11]), .DataIn1(1'b0), .DataOut(stage1[11]));
    MUX_2to1 #(1) mux1_12(.Sel(dataB[4]), .DataIn0(dataA[12]), .DataIn1(1'b0), .DataOut(stage1[12]));
    MUX_2to1 #(1) mux1_13(.Sel(dataB[4]), .DataIn0(dataA[13]), .DataIn1(1'b0), .DataOut(stage1[13]));
    MUX_2to1 #(1) mux1_14(.Sel(dataB[4]), .DataIn0(dataA[14]), .DataIn1(1'b0), .DataOut(stage1[14]));
    MUX_2to1 #(1) mux1_15(.Sel(dataB[4]), .DataIn0(dataA[15]), .DataIn1(1'b0), .DataOut(stage1[15]));
    MUX_2to1 #(1) mux1_16(.Sel(dataB[4]), .DataIn0(dataA[16]), .DataIn1(dataA[0]), .DataOut(stage1[16]));
    MUX_2to1 #(1) mux1_17(.Sel(dataB[4]), .DataIn0(dataA[17]), .DataIn1(dataA[1]), .DataOut(stage1[17]));
    MUX_2to1 #(1) mux1_18(.Sel(dataB[4]), .DataIn0(dataA[18]), .DataIn1(dataA[2]), .DataOut(stage1[18]));
    MUX_2to1 #(1) mux1_19(.Sel(dataB[4]), .DataIn0(dataA[19]), .DataIn1(dataA[3]), .DataOut(stage1[19]));
    MUX_2to1 #(1) mux1_20(.Sel(dataB[4]), .DataIn0(dataA[20]), .DataIn1(dataA[4]), .DataOut(stage1[20]));
    MUX_2to1 #(1) mux1_21(.Sel(dataB[4]), .DataIn0(dataA[21]), .DataIn1(dataA[5]), .DataOut(stage1[21]));
    MUX_2to1 #(1) mux1_22(.Sel(dataB[4]), .DataIn0(dataA[22]), .DataIn1(dataA[6]), .DataOut(stage1[22]));
    MUX_2to1 #(1) mux1_23(.Sel(dataB[4]), .DataIn0(dataA[23]), .DataIn1(dataA[7]), .DataOut(stage1[23]));
    MUX_2to1 #(1) mux1_24(.Sel(dataB[4]), .DataIn0(dataA[24]), .DataIn1(dataA[8]), .DataOut(stage1[24]));
    MUX_2to1 #(1) mux1_25(.Sel(dataB[4]), .DataIn0(dataA[25]), .DataIn1(dataA[9]), .DataOut(stage1[25]));
    MUX_2to1 #(1) mux1_26(.Sel(dataB[4]), .DataIn0(dataA[26]), .DataIn1(dataA[10]), .DataOut(stage1[26]));
    MUX_2to1 #(1) mux1_27(.Sel(dataB[4]), .DataIn0(dataA[27]), .DataIn1(dataA[11]), .DataOut(stage1[27]));
    MUX_2to1 #(1) mux1_28(.Sel(dataB[4]), .DataIn0(dataA[28]), .DataIn1(dataA[12]), .DataOut(stage1[28]));
    MUX_2to1 #(1) mux1_29(.Sel(dataB[4]), .DataIn0(dataA[29]), .DataIn1(dataA[13]), .DataOut(stage1[29]));
    MUX_2to1 #(1) mux1_30(.Sel(dataB[4]), .DataIn0(dataA[30]), .DataIn1(dataA[14]), .DataOut(stage1[30]));
    MUX_2to1 #(1) mux1_31(.Sel(dataB[4]), .DataIn0(dataA[31]), .DataIn1(dataA[15]), .DataOut(stage1[31]));

    // Stage 2: Shift by 8 if dataB[3] is 1
    MUX_2to1 #(1) mux2_0 (.Sel(dataB[3]), .DataIn0(stage1[0]), .DataIn1(1'b0), .DataOut(stage2[0]));
    MUX_2to1 #(1) mux2_1 (.Sel(dataB[3]), .DataIn0(stage1[1]), .DataIn1(1'b0), .DataOut(stage2[1]));
    MUX_2to1 #(1) mux2_2 (.Sel(dataB[3]), .DataIn0(stage1[2]), .DataIn1(1'b0), .DataOut(stage2[2]));
    MUX_2to1 #(1) mux2_3 (.Sel(dataB[3]), .DataIn0(stage1[3]), .DataIn1(1'b0), .DataOut(stage2[3]));
    MUX_2to1 #(1) mux2_4 (.Sel(dataB[3]), .DataIn0(stage1[4]), .DataIn1(1'b0), .DataOut(stage2[4]));
    MUX_2to1 #(1) mux2_5 (.Sel(dataB[3]), .DataIn0(stage1[5]), .DataIn1(1'b0), .DataOut(stage2[5]));
    MUX_2to1 #(1) mux2_6 (.Sel(dataB[3]), .DataIn0(stage1[6]), .DataIn1(1'b0), .DataOut(stage2[6]));
    MUX_2to1 #(1) mux2_7 (.Sel(dataB[3]), .DataIn0(stage1[7]), .DataIn1(1'b0), .DataOut(stage2[7]));
    MUX_2to1 #(1) mux2_8 (.Sel(dataB[3]), .DataIn0(stage1[8]), .DataIn1(stage1[0]), .DataOut(stage2[8]));
    MUX_2to1 #(1) mux2_9 (.Sel(dataB[3]), .DataIn0(stage1[9]), .DataIn1(stage1[1]), .DataOut(stage2[9]));
    MUX_2to1 #(1) mux2_10(.Sel(dataB[3]), .DataIn0(stage1[10]), .DataIn1(stage1[2]), .DataOut(stage2[10]));
    MUX_2to1 #(1) mux2_11(.Sel(dataB[3]), .DataIn0(stage1[11]), .DataIn1(stage1[3]), .DataOut(stage2[11]));
    MUX_2to1 #(1) mux2_12(.Sel(dataB[3]), .DataIn0(stage1[12]), .DataIn1(stage1[4]), .DataOut(stage2[12]));
    MUX_2to1 #(1) mux2_13(.Sel(dataB[3]), .DataIn0(stage1[13]), .DataIn1(stage1[5]), .DataOut(stage2[13]));
    MUX_2to1 #(1) mux2_14(.Sel(dataB[3]), .DataIn0(stage1[14]), .DataIn1(stage1[6]), .DataOut(stage2[14]));
    MUX_2to1 #(1) mux2_15(.Sel(dataB[3]), .DataIn0(stage1[15]), .DataIn1(stage1[7]), .DataOut(stage2[15]));
    MUX_2to1 #(1) mux2_16(.Sel(dataB[3]), .DataIn0(stage1[16]), .DataIn1(stage1[8]), .DataOut(stage2[16]));
    MUX_2to1 #(1) mux2_17(.Sel(dataB[3]), .DataIn0(stage1[17]), .DataIn1(stage1[9]), .DataOut(stage2[17]));
    MUX_2to1 #(1) mux2_18(.Sel(dataB[3]), .DataIn0(stage1[18]), .DataIn1(stage1[10]), .DataOut(stage2[18]));
    MUX_2to1 #(1) mux2_19(.Sel(dataB[3]), .DataIn0(stage1[19]), .DataIn1(stage1[11]), .DataOut(stage2[19]));
    MUX_2to1 #(1) mux2_20(.Sel(dataB[3]), .DataIn0(stage1[20]), .DataIn1(stage1[12]), .DataOut(stage2[20]));
    MUX_2to1 #(1) mux2_21(.Sel(dataB[3]), .DataIn0(stage1[21]), .DataIn1(stage1[13]), .DataOut(stage2[21]));
    MUX_2to1 #(1) mux2_22(.Sel(dataB[3]), .DataIn0(stage1[22]), .DataIn1(stage1[14]), .DataOut(stage2[22]));
    MUX_2to1 #(1) mux2_23(.Sel(dataB[3]), .DataIn0(stage1[23]), .DataIn1(stage1[15]), .DataOut(stage2[23]));
    MUX_2to1 #(1) mux2_24(.Sel(dataB[3]), .DataIn0(stage1[24]), .DataIn1(stage1[16]), .DataOut(stage2[24]));
    MUX_2to1 #(1) mux2_25(.Sel(dataB[3]), .DataIn0(stage1[25]), .DataIn1(stage1[17]), .DataOut(stage2[25]));
    MUX_2to1 #(1) mux2_26(.Sel(dataB[3]), .DataIn0(stage1[26]), .DataIn1(stage1[18]), .DataOut(stage2[26]));
    MUX_2to1 #(1) mux2_27(.Sel(dataB[3]), .DataIn0(stage1[27]), .DataIn1(stage1[19]), .DataOut(stage2[27]));
    MUX_2to1 #(1) mux2_28(.Sel(dataB[3]), .DataIn0(stage1[28]), .DataIn1(stage1[20]), .DataOut(stage2[28]));
    MUX_2to1 #(1) mux2_29(.Sel(dataB[3]), .DataIn0(stage1[29]), .DataIn1(stage1[21]), .DataOut(stage2[29]));
    MUX_2to1 #(1) mux2_30(.Sel(dataB[3]), .DataIn0(stage1[30]), .DataIn1(stage1[22]), .DataOut(stage2[30]));
    MUX_2to1 #(1) mux2_31(.Sel(dataB[3]), .DataIn0(stage1[31]), .DataIn1(stage1[23]), .DataOut(stage2[31]));

    // Stage 3: Shift by 4 if dataB[2] is 1
    MUX_2to1 #(1) mux3_0 (.Sel(dataB[2]), .DataIn0(stage2[0]), .DataIn1(1'b0), .DataOut(stage3[0]));
    MUX_2to1 #(1) mux3_1 (.Sel(dataB[2]), .DataIn0(stage2[1]), .DataIn1(1'b0), .DataOut(stage3[1]));
    MUX_2to1 #(1) mux3_2 (.Sel(dataB[2]), .DataIn0(stage2[2]), .DataIn1(1'b0), .DataOut(stage3[2]));
    MUX_2to1 #(1) mux3_3 (.Sel(dataB[2]), .DataIn0(stage2[3]), .DataIn1(1'b0), .DataOut(stage3[3]));
    MUX_2to1 #(1) mux3_4 (.Sel(dataB[2]), .DataIn0(stage2[4]), .DataIn1(stage2[0]), .DataOut(stage3[4]));
    MUX_2to1 #(1) mux3_5 (.Sel(dataB[2]), .DataIn0(stage2[5]), .DataIn1(stage2[1]), .DataOut(stage3[5]));
    MUX_2to1 #(1) mux3_6 (.Sel(dataB[2]), .DataIn0(stage2[6]), .DataIn1(stage2[2]), .DataOut(stage3[6]));
    MUX_2to1 #(1) mux3_7 (.Sel(dataB[2]), .DataIn0(stage2[7]), .DataIn1(stage2[3]), .DataOut(stage3[7]));
    MUX_2to1 #(1) mux3_8 (.Sel(dataB[2]), .DataIn0(stage2[8]), .DataIn1(stage2[4]), .DataOut(stage3[8]));
    MUX_2to1 #(1) mux3_9 (.Sel(dataB[2]), .DataIn0(stage2[9]), .DataIn1(stage2[5]), .DataOut(stage3[9]));
    MUX_2to1 #(1) mux3_10(.Sel(dataB[2]), .DataIn0(stage2[10]), .DataIn1(stage2[6]), .DataOut(stage3[10]));
    MUX_2to1 #(1) mux3_11(.Sel(dataB[2]), .DataIn0(stage2[11]), .DataIn1(stage2[7]), .DataOut(stage3[11]));
    MUX_2to1 #(1) mux3_12(.Sel(dataB[2]), .DataIn0(stage2[12]), .DataIn1(stage2[8]), .DataOut(stage3[12]));
    MUX_2to1 #(1) mux3_13(.Sel(dataB[2]), .DataIn0(stage2[13]), .DataIn1(stage2[9]), .DataOut(stage3[13]));
    MUX_2to1 #(1) mux3_14(.Sel(dataB[2]), .DataIn0(stage2[14]), .DataIn1(stage2[10]), .DataOut(stage3[14]));
    MUX_2to1 #(1) mux3_15(.Sel(dataB[2]), .DataIn0(stage2[15]), .DataIn1(stage2[11]), .DataOut(stage3[15]));
    MUX_2to1 #(1) mux3_16(.Sel(dataB[2]), .DataIn0(stage2[16]), .DataIn1(stage2[12]), .DataOut(stage3[16]));
    MUX_2to1 #(1) mux3_17(.Sel(dataB[2]), .DataIn0(stage2[17]), .DataIn1(stage2[13]), .DataOut(stage3[17]));
    MUX_2to1 #(1) mux3_18(.Sel(dataB[2]), .DataIn0(stage2[18]), .DataIn1(stage2[14]), .DataOut(stage3[18]));
    MUX_2to1 #(1) mux3_19(.Sel(dataB[2]), .DataIn0(stage2[19]), .DataIn1(stage2[15]), .DataOut(stage3[19]));
    MUX_2to1 #(1) mux3_20(.Sel(dataB[2]), .DataIn0(stage2[20]), .DataIn1(stage2[16]), .DataOut(stage3[20]));
    MUX_2to1 #(1) mux3_21(.Sel(dataB[2]), .DataIn0(stage2[21]), .DataIn1(stage2[17]), .DataOut(stage3[21]));
    MUX_2to1 #(1) mux3_22(.Sel(dataB[2]), .DataIn0(stage2[22]), .DataIn1(stage2[18]), .DataOut(stage3[22]));
    MUX_2to1 #(1) mux3_23(.Sel(dataB[2]), .DataIn0(stage2[23]), .DataIn1(stage2[19]), .DataOut(stage3[23]));
    MUX_2to1 #(1) mux3_24(.Sel(dataB[2]), .DataIn0(stage2[24]), .DataIn1(stage2[20]), .DataOut(stage3[24]));
    MUX_2to1 #(1) mux3_25(.Sel(dataB[2]), .DataIn0(stage2[25]), .DataIn1(stage2[21]), .DataOut(stage3[25]));
    MUX_2to1 #(1) mux3_26(.Sel(dataB[2]), .DataIn0(stage2[26]), .DataIn1(stage2[22]), .DataOut(stage3[26]));
    MUX_2to1 #(1) mux3_27(.Sel(dataB[2]), .DataIn0(stage2[27]), .DataIn1(stage2[23]), .DataOut(stage3[27]));
    MUX_2to1 #(1) mux3_28(.Sel(dataB[2]), .DataIn0(stage2[28]), .DataIn1(stage2[24]), .DataOut(stage3[28]));
    MUX_2to1 #(1) mux3_29(.Sel(dataB[2]), .DataIn0(stage2[29]), .DataIn1(stage2[25]), .DataOut(stage3[29]));
    MUX_2to1 #(1) mux3_30(.Sel(dataB[2]), .DataIn0(stage2[30]), .DataIn1(stage2[26]), .DataOut(stage3[30]));
    MUX_2to1 #(1) mux3_31(.Sel(dataB[2]), .DataIn0(stage2[31]), .DataIn1(stage2[27]), .DataOut(stage3[31]));

    // Stage 4: Shift by 2 if dataB[1] is 1
    MUX_2to1 #(1) mux4_0 (.Sel(dataB[1]), .DataIn0(stage3[0]), .DataIn1(1'b0), .DataOut(stage4[0]));
    MUX_2to1 #(1) mux4_1 (.Sel(dataB[1]), .DataIn0(stage3[1]), .DataIn1(1'b0), .DataOut(stage4[1]));
    MUX_2to1 #(1) mux4_2 (.Sel(dataB[1]), .DataIn0(stage3[2]), .DataIn1(stage3[0]), .DataOut(stage4[2]));
    MUX_2to1 #(1) mux4_3 (.Sel(dataB[1]), .DataIn0(stage3[3]), .DataIn1(stage3[1]), .DataOut(stage4[3]));
    MUX_2to1 #(1) mux4_4 (.Sel(dataB[1]), .DataIn0(stage3[4]), .DataIn1(stage3[2]), .DataOut(stage4[4]));
    MUX_2to1 #(1) mux4_5 (.Sel(dataB[1]), .DataIn0(stage3[5]), .DataIn1(stage3[3]), .DataOut(stage4[5]));
    MUX_2to1 #(1) mux4_6 (.Sel(dataB[1]), .DataIn0(stage3[6]), .DataIn1(stage3[4]), .DataOut(stage4[6]));
    MUX_2to1 #(1) mux4_7 (.Sel(dataB[1]), .DataIn0(stage3[7]), .DataIn1(stage3[5]), .DataOut(stage4[7]));
    MUX_2to1 #(1) mux4_8 (.Sel(dataB[1]), .DataIn0(stage3[8]), .DataIn1(stage3[6]), .DataOut(stage4[8]));
    MUX_2to1 #(1) mux4_9 (.Sel(dataB[1]), .DataIn0(stage3[9]), .DataIn1(stage3[7]), .DataOut(stage4[9]));
    MUX_2to1 #(1) mux4_10(.Sel(dataB[1]), .DataIn0(stage3[10]), .DataIn1(stage3[8]), .DataOut(stage4[10]));
    MUX_2to1 #(1) mux4_11(.Sel(dataB[1]), .DataIn0(stage3[11]), .DataIn1(stage3[9]), .DataOut(stage4[11]));
    MUX_2to1 #(1) mux4_12(.Sel(dataB[1]), .DataIn0(stage3[12]), .DataIn1(stage3[10]), .DataOut(stage4[12]));
    MUX_2to1 #(1) mux4_13(.Sel(dataB[1]), .DataIn0(stage3[13]), .DataIn1(stage3[11]), .DataOut(stage4[13]));
    MUX_2to1 #(1) mux4_14(.Sel(dataB[1]), .DataIn0(stage3[14]), .DataIn1(stage3[12]), .DataOut(stage4[14]));
    MUX_2to1 #(1) mux4_15(.Sel(dataB[1]), .DataIn0(stage3[15]), .DataIn1(stage3[13]), .DataOut(stage4[15]));
    MUX_2to1 #(1) mux4_16(.Sel(dataB[1]), .DataIn0(stage3[16]), .DataIn1(stage3[14]), .DataOut(stage4[16]));
    MUX_2to1 #(1) mux4_17(.Sel(dataB[1]), .DataIn0(stage3[17]), .DataIn1(stage3[15]), .DataOut(stage4[17]));
    MUX_2to1 #(1) mux4_18(.Sel(dataB[1]), .DataIn0(stage3[18]), .DataIn1(stage3[16]), .DataOut(stage4[18]));
    MUX_2to1 #(1) mux4_19(.Sel(dataB[1]), .DataIn0(stage3[19]), .DataIn1(stage3[17]), .DataOut(stage4[19]));
    MUX_2to1 #(1) mux4_20(.Sel(dataB[1]), .DataIn0(stage3[20]), .DataIn1(stage3[18]), .DataOut(stage4[20]));
    MUX_2to1 #(1) mux4_21(.Sel(dataB[1]), .DataIn0(stage3[21]), .DataIn1(stage3[19]), .DataOut(stage4[21]));
    MUX_2to1 #(1) mux4_22(.Sel(dataB[1]), .DataIn0(stage3[22]), .DataIn1(stage3[20]), .DataOut(stage4[22]));
    MUX_2to1 #(1) mux4_23(.Sel(dataB[1]), .DataIn0(stage3[23]), .DataIn1(stage3[21]), .DataOut(stage4[23]));
    MUX_2to1 #(1) mux4_24(.Sel(dataB[1]), .DataIn0(stage3[24]), .DataIn1(stage3[22]), .DataOut(stage4[24]));
    MUX_2to1 #(1) mux4_25(.Sel(dataB[1]), .DataIn0(stage3[25]), .DataIn1(stage3[23]), .DataOut(stage4[25]));
    MUX_2to1 #(1) mux4_26(.Sel(dataB[1]), .DataIn0(stage3[26]), .DataIn1(stage3[24]), .DataOut(stage4[26]));
    MUX_2to1 #(1) mux4_27(.Sel(dataB[1]), .DataIn0(stage3[27]), .DataIn1(stage3[25]), .DataOut(stage4[27]));
    MUX_2to1 #(1) mux4_28(.Sel(dataB[1]), .DataIn0(stage3[28]), .DataIn1(stage3[26]), .DataOut(stage4[28]));
    MUX_2to1 #(1) mux4_29(.Sel(dataB[1]), .DataIn0(stage3[29]), .DataIn1(stage3[27]), .DataOut(stage4[29]));
    MUX_2to1 #(1) mux4_30(.Sel(dataB[1]), .DataIn0(stage3[30]), .DataIn1(stage3[28]), .DataOut(stage4[30]));
    MUX_2to1 #(1) mux4_31(.Sel(dataB[1]), .DataIn0(stage3[31]), .DataIn1(stage3[29]), .DataOut(stage4[31]));

    // Stage 5: Shift by 1 if dataB[0] is 1
    MUX_2to1 #(1) mux5_0 (.Sel(dataB[0]), .DataIn0(stage4[0]), .DataIn1(1'b0), .DataOut(stage5[0]));
    MUX_2to1 #(1) mux5_1 (.Sel(dataB[0]), .DataIn0(stage4[1]), .DataIn1(stage4[0]), .DataOut(stage5[1]));
    MUX_2to1 #(1) mux5_2 (.Sel(dataB[0]), .DataIn0(stage4[2]), .DataIn1(stage4[1]), .DataOut(stage5[2]));
    MUX_2to1 #(1) mux5_3 (.Sel(dataB[0]), .DataIn0(stage4[3]), .DataIn1(stage4[2]), .DataOut(stage5[3]));
    MUX_2to1 #(1) mux5_4 (.Sel(dataB[0]), .DataIn0(stage4[4]), .DataIn1(stage4[3]), .DataOut(stage5[4]));
    MUX_2to1 #(1) mux5_5 (.Sel(dataB[0]), .DataIn0(stage4[5]), .DataIn1(stage4[4]), .DataOut(stage5[5]));
    MUX_2to1 #(1) mux5_6 (.Sel(dataB[0]), .DataIn0(stage4[6]), .DataIn1(stage4[5]), .DataOut(stage5[6]));
    MUX_2to1 #(1) mux5_7 (.Sel(dataB[0]), .DataIn0(stage4[7]), .DataIn1(stage4[6]), .DataOut(stage5[7]));
    MUX_2to1 #(1) mux5_8 (.Sel(dataB[0]), .DataIn0(stage4[8]), .DataIn1(stage4[7]), .DataOut(stage5[8]));
    MUX_2to1 #(1) mux5_9 (.Sel(dataB[0]), .DataIn0(stage4[9]), .DataIn1(stage4[8]), .DataOut(stage5[9]));
    MUX_2to1 #(1) mux5_10(.Sel(dataB[0]), .DataIn0(stage4[10]), .DataIn1(stage4[9]), .DataOut(stage5[10]));
    MUX_2to1 #(1) mux5_11(.Sel(dataB[0]), .DataIn0(stage4[11]), .DataIn1(stage4[10]), .DataOut(stage5[11]));
    MUX_2to1 #(1) mux5_12(.Sel(dataB[0]), .DataIn0(stage4[12]), .DataIn1(stage4[11]), .DataOut(stage5[12]));
    MUX_2to1 #(1) mux5_13(.Sel(dataB[0]), .DataIn0(stage4[13]), .DataIn1(stage4[12]), .DataOut(stage5[13]));
    MUX_2to1 #(1) mux5_14(.Sel(dataB[0]), .DataIn0(stage4[14]), .DataIn1(stage4[13]), .DataOut(stage5[14]));
    MUX_2to1 #(1) mux5_15(.Sel(dataB[0]), .DataIn0(stage4[15]), .DataIn1(stage4[14]), .DataOut(stage5[15]));
    MUX_2to1 #(1) mux5_16(.Sel(dataB[0]), .DataIn0(stage4[16]), .DataIn1(stage4[15]), .DataOut(stage5[16]));
    MUX_2to1 #(1) mux5_17(.Sel(dataB[0]), .DataIn0(stage4[17]), .DataIn1(stage4[16]), .DataOut(stage5[17]));
    MUX_2to1 #(1) mux5_18(.Sel(dataB[0]), .DataIn0(stage4[18]), .DataIn1(stage4[17]), .DataOut(stage5[18]));
    MUX_2to1 #(1) mux5_19(.Sel(dataB[0]), .DataIn0(stage4[19]), .DataIn1(stage4[18]), .DataOut(stage5[19]));
    MUX_2to1 #(1) mux5_20(.Sel(dataB[0]), .DataIn0(stage4[20]), .DataIn1(stage4[19]), .DataOut(stage5[20]));
    MUX_2to1 #(1) mux5_21(.Sel(dataB[0]), .DataIn0(stage4[21]), .DataIn1(stage4[20]), .DataOut(stage5[21]));
    MUX_2to1 #(1) mux5_22(.Sel(dataB[0]), .DataIn0(stage4[22]), .DataIn1(stage4[21]), .DataOut(stage5[22]));
    MUX_2to1 #(1) mux5_23(.Sel(dataB[0]), .DataIn0(stage4[23]), .DataIn1(stage4[22]), .DataOut(stage5[23]));
    MUX_2to1 #(1) mux5_24(.Sel(dataB[0]), .DataIn0(stage4[24]), .DataIn1(stage4[23]), .DataOut(stage5[24]));
    MUX_2to1 #(1) mux5_25(.Sel(dataB[0]), .DataIn0(stage4[25]), .DataIn1(stage4[24]), .DataOut(stage5[25]));
    MUX_2to1 #(1) mux5_26(.Sel(dataB[0]), .DataIn0(stage4[26]), .DataIn1(stage4[25]), .DataOut(stage5[26]));
    MUX_2to1 #(1) mux5_27(.Sel(dataB[0]), .DataIn0(stage4[27]), .DataIn1(stage4[26]), .DataOut(stage5[27]));
    MUX_2to1 #(1) mux5_28(.Sel(dataB[0]), .DataIn0(stage4[28]), .DataIn1(stage4[27]), .DataOut(stage5[28]));
    MUX_2to1 #(1) mux5_29(.Sel(dataB[0]), .DataIn0(stage4[29]), .DataIn1(stage4[28]), .DataOut(stage5[29]));
    MUX_2to1 #(1) mux5_30(.Sel(dataB[0]), .DataIn0(stage4[30]), .DataIn1(stage4[29]), .DataOut(stage5[30]));
    MUX_2to1 #(1) mux5_31(.Sel(dataB[0]), .DataIn0(stage4[31]), .DataIn1(stage4[30]), .DataOut(stage5[31]));

    assign dataOut = reset ? 32'b0 : (Signal == SLL) ? stage5 : 32'b0;
 
endmodule




