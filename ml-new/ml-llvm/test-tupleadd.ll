; ModuleID = 'ML'

@fmt = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt1 = private unnamed_addr constant [4 x i8] c"%f\0A\00"
@fmt2 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt3 = private unnamed_addr constant [4 x i8] c"%f\0A\00"
@fmt4 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt5 = private unnamed_addr constant [4 x i8] c"%f\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main() {
entry:
  %a = alloca [3 x i32]
  %b = alloca [3 x i32]
  %c = alloca [3 x i32]
  %i = alloca i32
  store [3 x i32] [i32 1, i32 2, i32 3], [3 x i32]* %a
  store [3 x i32] [i32 1, i32 2, i32 3], [3 x i32]* %b
  %b1 = load [3 x i32]* %b
  %a2 = load [3 x i32]* %a
  %addTuples_result = call [3 x i32] @addTuples([3 x i32] %a2, [3 x i32] %b1)
  store [3 x i32] %addTuples_result, [3 x i32]* %c
  %b3 = getelementptr inbounds [3 x i32]* %b, i32 0, i32 0
  %a4 = getelementptr inbounds [3 x i32]* %a, i32 0, i32 0
  %addTuples2_result = call i32 @addTuples2(i32* %a4, i32* %b3)
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %i9 = load i32* %i
  %tmp10 = icmp slt i32 %i9, 3
  br i1 %tmp10, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i5 = load i32* %i
  %c6 = getelementptr [3 x i32]* %c, i32 0, i32 %i5
  %c7 = load i32* %c6
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmt, i32 0, i32 0), i32 %c7)
  %i8 = load i32* %i
  %tmp = add i32 %i8, 1
  store i32 %tmp, i32* %i
  br label %while

merge:                                            ; preds = %while
  ret i32 0
}

define i32 @addTuples2(i32* %x, i32* %y) {
entry:
  %x1 = alloca i32*
  store i32* %x, i32** %x1
  %y2 = alloca i32*
  store i32* %y, i32** %y2
  ret i32 3
}

define [3 x i32] @addTuples([3 x i32] %x, [3 x i32] %y) {
entry:
  %x1 = alloca [3 x i32]
  store [3 x i32] %x, [3 x i32]* %x1
  %y2 = alloca [3 x i32]
  store [3 x i32] %y, [3 x i32]* %y2
  %i = alloca i32
  %t = alloca [3 x i32]
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %i13 = load i32* %i
  %tmp14 = icmp slt i32 %i13, 3
  br i1 %tmp14, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i3 = load i32* %i
  %t4 = getelementptr [3 x i32]* %t, i32 0, i32 %i3
  %i5 = load i32* %i
  %x6 = getelementptr [3 x i32]* %x1, i32 0, i32 %i5
  %x7 = load i32* %x6
  %i8 = load i32* %i
  %y9 = getelementptr [3 x i32]* %y2, i32 0, i32 %i8
  %y10 = load i32* %y9
  %tmp = add i32 %x7, %y10
  store i32 %tmp, i32* %t4
  %i11 = load i32* %i
  %tmp12 = add i32 %i11, 1
  store i32 %tmp12, i32* %i
  br label %while

merge:                                            ; preds = %while
  %t15 = load [3 x i32]* %t
  ret [3 x i32] %t15
}
