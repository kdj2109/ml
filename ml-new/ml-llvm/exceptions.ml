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
exception InvalidUseOfLength

(* Matrix Exceptions *)

exception UnsupportedMatrixofMatrices
exception UnsupportedMatrixType
exception InvalidUseOfRows
exception InvalidUseOfColumns

(* Assignment Exceptions *)

exception IllegalAssignment
