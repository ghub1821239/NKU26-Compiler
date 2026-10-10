# AscendNPU IR VecAdd — MLIR 中端转换实验

本目录提供官方 VecAdd 样例及三次独立 MLIR Pass 的输出，便于查看原始 IR 与转换结果。所有 `.mlir` 文件均保留原有实验内容，未重新生成或改写。

## 文件

| 文件 | 用途 |
| --- | --- |
| `input/vecadd_hir.mlir` | 官方 AscendNPU-IR v1.1.0 VecAdd 原始 HIVM HIR |
| `output/vecadd_lower_to_loops.mlir` | 运行 `hivm-lower-to-loops` 的输出：操作结构未发生变化 |
| `output/vecadd_alloca.mlir` | 运行 `hivm-memref-alloc-to-alloca` 的输出：3 处 `memref.alloc` 改为 `memref.alloca` |
| `output/vecadd_standard_calls.mlir` | 运行 `convert-hivm-to-std` 的输出：load/vadd/store 改为 4 次函数调用 |
| `run.sh` | 在已安装相应工具的 Linux 环境中重新运行这三个独立 Pass |

## 来源与运行环境

- 输入源：<https://github.com/Ascend/AscendNPU-IR/blob/v1.1.0/bishengir/test/Integration/HIVM/VecAdd/add.mlir>
- 实验工具：`bishengir-opt 1.1.0`（工具版本输出所含 LLVM 版本为 19.1.7）
- 实验环境：Ubuntu 22.04，Linux x86-64

三个 Pass **分别以原始 `input/vecadd_hir.mlir` 为输入**，并非连续执行的 Pipeline。
`output/vecadd_standard_calls.mlir` 仍含 `hivm.hir.pointer_cast`，且新加入的库函数仅有声明，没有在本实验中链接和运行；未生成 NPU 设备二进制，也未进行上板验证。

## 复现

需要安装能识别 AscendNPU IR HIVM 方言及以上 Pass 的 `bishengir-opt` 1.1.0。将本目录复制到 Linux 后执行：

```bash
bash run.sh /absolute/path/to/bishengir-opt
```

也可以在 `PATH` 已配置该工具时直接执行 `bash run.sh`。脚本只读取 `input/` 文件，将重新生成的结果写入**新的** `reproduced/` 目录，不覆盖打包的 `output/` 实际实验结果。

原始文件与输出记录对应的 Pass 已在实验环境中执行成功，退出码均为 0。
