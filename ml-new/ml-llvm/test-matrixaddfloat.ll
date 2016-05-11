; ModuleID = 'ML'

@fmt = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt1 = private unnamed_addr constant [4 x i8] c"%f\0A\00"
@fmt2 = private unnamed_addr constant [3 x i8] c"%d\00"
@fmt3 = private unnamed_addr constant [3 x i8] c"%f\00"
@fmt4 = private unnamed_addr constant [4 x i8] c"%c\0A\00"
@fmt5 = private unnamed_addr constant [3 x i8] c"%c\00"
@fmt6 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt7 = private unnamed_addr constant [4 x i8] c"%f\0A\00"
@fmt8 = private unnamed_addr constant [3 x i8] c"%d\00"
@fmt9 = private unnamed_addr constant [3 x i8] c"%f\00"
@fmt10 = private unnamed_addr constant [4 x i8] c"%c\0A\00"
@fmt11 = private unnamed_addr constant [3 x i8] c"%c\00"

declare i32 @printf(i8*, ...)

define i32 @main() {
entry:
  %a = alloca [5 x [4 x double]]
  %b = alloca [5 x [4 x double]]
  %i = alloca i32
  %j = alloca i32
  store [5 x [4 x double]] [[4 x double] [double 2.500000e+00, double 5.700000e+00, double 1.788000e+01, double 1.920000e+01], [4 x double] [double 1.711000e+01, double 1.009900e+02, double 5.556600e+02, double 6.667700e+02], [4 x double] [double 1.980000e+01, double 2.865000e+01, double 1.790000e+01, double 3.822000e+01], [4 x double] [double 1.111000e+01, double 2.222000e+01, double 3.333000e+01, double 4.444000e+01], [4 x double] [double 9.956000e+01, double 1.232000e+01, double 1.412000e+01, double 1.617000e+01]], [5 x [4 x double]]* %a
  store [5 x [4 x double]] [[4 x double] [double 2.500000e+00, double 5.700000e+00, double 1.788000e+01, double 1.920000e+01], [4 x double] [double 1.711000e+01, double 1.009900e+02, double 5.556600e+02, double 6.667700e+02], [4 x double] [double 1.980000e+01, double 2.865000e+01, double 1.790000e+01, double 3.822000e+01], [4 x double] [double 1.111000e+01, double 2.222000e+01, double 3.333000e+01, double 4.444000e+01], [4 x double] [double 9.956000e+01, double 1.232000e+01, double 1.412000e+01, double 1.617000e+01]], [5 x [4 x double]]* %b
  %b1 = getelementptr inbounds [5 x [4 x double]]* %b, i32 0, i32 0, i32 0
  %a2 = getelementptr inbounds [5 x [4 x double]]* %a, i32 0, i32 0, i32 0
  call void @addFloatMatrices(double* %a2, double* %b1, i32 5, i32 4)
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %merge, %entry
  %i14 = load i32* %i
  %tmp15 = icmp slt i32 %i14, 5
  br i1 %tmp15, label %while_body, label %merge16

while_body:                                       ; preds = %while
  store i32 0, i32* %j
  br label %while3

while3:                                           ; preds = %while_body4, %while_body
  %j10 = load i32* %j
  %tmp11 = icmp slt i32 %j10, 4
  br i1 %tmp11, label %while_body4, label %merge

while_body4:                                      ; preds = %while3
  %i5 = load i32* %i
  %j6 = load i32* %j
  %a7 = getelementptr [5 x [4 x double]]* %a, i32 0, i32 %i5, i32 %j6
  %a8 = load double* %a7
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmt1, i32 0, i32 0), double %a8)
  %j9 = load i32* %j
  %tmp = add i32 %j9, 1
  store i32 %tmp, i32* %j
  br label %while3

merge:                                            ; preds = %while3
  %i12 = load i32* %i
  %tmp13 = add i32 %i12, 1
  store i32 %tmp13, i32* %i
  br label %while

merge16:                                          ; preds = %while
  ret i32 0
}

define void @addFloatMatrices(double* %x, double* %y, i32 %r, i32 %c) {
entry:
  %x1 = alloca double*
  store double* %x, double** %x1
  %y2 = alloca double*
  store double* %y, double** %y2
  %r3 = alloca i32
  store i32 %r, i32* %r3
  %c4 = alloca i32
  store i32 %c, i32* %c4
  %len = alloca i32
  %i = alloca i32
  %r5 = load i32* %r3
  %c6 = load i32* %c4
  %tmp = mul i32 %r5, %c6
  store i32 %tmp, i32* %len
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %i21 = load i32* %i
  %len22 = load i32* %len
  %tmp23 = icmp slt i32 %i21, %len22
  br i1 %tmp23, label %while_body, label %merge

while_body:                                       ; preds = %while
  %x7 = load double** %x1
  %x8 = load double** %x1
  %x9 = load double* %x8
  %y10 = load double** %y2
  %y11 = load double* %y10
  %tmp12 = fadd double %x9, %y11
  store double %tmp12, double* %x7
  %x13 = getelementptr inbounds double** %x1, i32 0
  %x14 = load double** %x13
  %x15 = getelementptr inbounds double* %x14, i32 1
  store double* %x15, double** %x1
  %y16 = getelementptr inbounds double** %y2, i32 0
  %y17 = load double** %y16
  %y18 = getelementptr inbounds double* %y17, i32 1
  store double* %y18, double** %y2
  %i19 = load i32* %i
  %tmp20 = add i32 %i19, 1
  store i32 %tmp20, i32* %i
  br label %while

merge:                                            ; preds = %while
  ret void
}
