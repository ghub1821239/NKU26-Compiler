#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPT="${1:-${BISHENGIR_OPT:-}}"
if [[ -z "$OPT" ]]; then
  OPT="$(command -v bishengir-opt || true)"
fi
if [[ -z "$OPT" || ! -x "$OPT" ]]; then
  echo "用法: bash run.sh /absolute/path/to/bishengir-opt" >&2
  exit 2
fi

INPUT="$ROOT/input/vecadd_hir.mlir"
DEST="$ROOT/reproduced"
if [[ -e "$DEST" ]]; then
  echo "输出目录已存在，为避免覆盖请先自行备份或指定新的工作目录: $DEST" >&2
  exit 3
fi
mkdir "$DEST"
"$OPT" --version

timeout 60s "$OPT" --hivm-lower-to-loops "$INPUT" -o "$DEST/vecadd_lower_to_loops.mlir"
timeout 60s "$OPT" --hivm-memref-alloc-to-alloca "$INPUT" -o "$DEST/vecadd_alloca.mlir"
timeout 60s "$OPT" --convert-hivm-to-std "$INPUT" -o "$DEST/vecadd_standard_calls.mlir"

echo "三项独立 Pass 已执行；输出位于 $DEST"
