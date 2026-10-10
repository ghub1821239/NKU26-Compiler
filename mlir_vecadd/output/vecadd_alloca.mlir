module {
  func.func @add(%arg0: memref<16xi16, #hivm.address_space<gm>>, %arg1: memref<16xi16, #hivm.address_space<gm>>, %arg2: memref<16xi16, #hivm.address_space<gm>>) attributes {hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>} {
    %alloca = memref.alloca() : memref<16xi16, #hivm.address_space<ub>>
    hivm.hir.load ins(%arg0 : memref<16xi16, #hivm.address_space<gm>>) outs(%alloca : memref<16xi16, #hivm.address_space<ub>>)
    %alloca_0 = memref.alloca() : memref<16xi16, #hivm.address_space<ub>>
    hivm.hir.load ins(%arg1 : memref<16xi16, #hivm.address_space<gm>>) outs(%alloca_0 : memref<16xi16, #hivm.address_space<ub>>)
    %alloca_1 = memref.alloca() : memref<16xi16, #hivm.address_space<ub>>
    hivm.hir.vadd ins(%alloca, %alloca_0 : memref<16xi16, #hivm.address_space<ub>>, memref<16xi16, #hivm.address_space<ub>>) outs(%alloca_1 : memref<16xi16, #hivm.address_space<ub>>)
    hivm.hir.store ins(%alloca_1 : memref<16xi16, #hivm.address_space<ub>>) outs(%arg2 : memref<16xi16, #hivm.address_space<gm>>)
    return
  }
}

