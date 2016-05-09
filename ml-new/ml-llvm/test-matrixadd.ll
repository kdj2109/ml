; ModuleID = 'ML'

@fmt = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt1 = private unnamed_addr constant [4 x i8] c"%f\0A\00"
@fmt2 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt3 = private unnamed_addr constant [4 x i8] c"%f\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main() {
entry:
  %a = alloca [3 x [4 x i32]]
  %b = alloca [2 x [2 x i32]]
  %c = alloca [3 x i32]
  %i = alloca i32
  store [3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 3, i32 4, i32 5, i32 6], [4 x i32] [i32 7, i32 8, i32 9, i32 8]], [3 x [4 x i32]]* %a
  store [2 x [2 x i32]] [[2 x i32] [i32 5, i32 7], [2 x i32] [i32 9, i32 15]], [2 x [2 x i32]]* %b
  %a1 = getelementptr inbounds [3 x [4 x i32]]* %a, i32 0, i32 0, i32 0
  ret i32 0
}

define i32** @addTuples2(i32** %z, i32** %y) {
entry:
  %z1 = alloca i32**
  store i32** %z, i32*** %z1
  %y2 = alloca i32**
  store i32** %y, i32*** %y2
  %z3 = load i32*** %z1
  ret i32** %z3
}
