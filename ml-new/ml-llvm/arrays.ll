; ModuleID = 'arrays.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"

@_ZZ4mainE7balance = private unnamed_addr constant [5 x i32] [i32 1000, i32 2, i32 3, i32 17, i32 50], align 16

; Function Attrs: nounwind ssp uwtable
define i32* @_Z10getAveragePii(i32* %arr, i32 %size) #0 {
  %1 = alloca i32*, align 8
  %2 = alloca i32, align 4
  store i32* %arr, i32** %1, align 8
  store i32 %size, i32* %2, align 4
  %3 = load i32*, i32** %1, align 8
  ret i32* %3
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %balance = alloca [5 x i32], align 16
  store i32 0, i32* %1, align 4
  %2 = bitcast [5 x i32]* %balance to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* bitcast ([5 x i32]* @_ZZ4mainE7balance to i8*), i64 20, i32 16, i1 false)
  %3 = getelementptr inbounds [5 x i32], [5 x i32]* %balance, i32 0, i32 0
  %4 = call i32* @_Z10getAveragePii(i32* %3, i32 5)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
