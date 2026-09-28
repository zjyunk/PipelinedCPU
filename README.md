# MIPS 5-Stage Pipelined CPU

以 Verilog 實作的 32-bit MIPS 五級管線處理器（IF / ID / EX / MEM / WB），使用 ModelSim 模擬。

## 支援指令

| 類型 | 指令 |
| --- | --- |
| R-type | `add` `sub` `and` `or` `slt` `sll` `jr` `nop` |
| 乘法 | `multu` `maddu` `mfhi` `mflo` |
| I-type | `andi` `lw` `sw` `beq` |
| J-type | `j` |

## 設計重點

- **管線暫存器**：`IF_ID`、`ID_EX`、`EX_MEM`、`MEM_WB`，控制訊號依 `WB` / `MEM` / `EX` 分組往下傳遞。
- **分支**：`beq` 由 `Beq_Unit` 在 EX 階段比較，於 MEM 階段決定是否跳轉。
- **跳躍**：`j` 與 `jr` 在 ID 階段即更新 PC。
- **乘法**：`Multiplier` 為 32 週期的 shift-add 多週期乘法器。乘法進行時 `ALU_Control_Unit` 會送出 `Stall`，凍結 PC、`IF_ID`、`ID_EX`，完成後將結果寫入 `HiLo`（`maddu` 為累加）。若 stall 期間 branch 成立，會先記住目標位址，待 stall 結束後再跳轉。
- **未實作 forwarding / hazard detection**：資料與控制相依需在程式中自行插入 `nop`。

## 檔案說明

| 檔案 | 說明 |
| --- | --- |
| `Mips_Pipelined.v` | 頂層模組，連接整個 datapath |
| `Control_Unit.v` | 主控制單元（依 opcode / funct 產生控制訊號） |
| `ALU_Control_Unit.v` | ALU 控制與乘法 stall 控制 |
| `ALU.v`、`ALU_1bit.v`、`FA.v`、`Shifter.v` | ALU 及其子元件 |
| `Multiplier.v`、`HiLo.v` | 乘法器與 Hi/Lo 暫存器 |
| `IF_ID.v`、`ID_EX.v`、`EX_MEM.v`、`MEM_WB.v` | 管線暫存器 |
| `PC.v`、`Add.v`、`MUX_2to1.v`、`MUX_4to1.v`、`Beq_Unit.v` | PC、加法器、多工器、分支比較 |
| `Reg_File.v`、`Memory.v` | 暫存器檔、指令 / 資料記憶體 |
| `Sign_Extend.v`、`UnSign_Extend.v` | 立即值擴展 |
| `tb_Pipelined.v` | Testbench |
| `instr_mem.txt` | 指令記憶體初始值（每行 1 byte，little endian） |
| `data_mem.txt` | 資料記憶體初始值 |
| `reg.txt` | 暫存器初始值 |
| `instr_mem_all.txt`、`instr_mem_test.txt` | 其他測試程式 |

## 模擬方式

在 ModelSim 中：

```tcl
vlib work
vlog *.v
vsim tb_Pipelined
run -all
```

Testbench 會以 `$readmemh` 載入 `instr_mem.txt`、`data_mem.txt`、`reg.txt`，每個 clock 印出 PC、寫回值與目前 ID 階段的指令，並輸出波形至 `mips_Pipelined.vcd`。要換測試程式，將對應內容複製到 `instr_mem.txt` 即可；模擬長度由 `tb_Pipelined.v` 中的 `$time > 230` 控制。
