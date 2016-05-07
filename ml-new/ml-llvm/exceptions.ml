(* Binop Exceptions *) 

exception UnsupportedBinaryOperationOnTypes of string * string 
exception UnsuppotedBinOp

(* Unop Exceptions *) 

exception UnsupportedUnaryOperationOnType of string 
exception UnsupportedUnaryOperationOnFloat

(* Tuple Exceptions *)

exception UnsupportedTupleOfTuples
exception UnsupportedTupleType
exception InvalidTuplePointerType

(* Matrix Exceptions *)

exception UnsupportedMatrixofMatrices
exception UnsupportedMatrixType

(* Assignment Exceptions *)

exception IllegalAssignment