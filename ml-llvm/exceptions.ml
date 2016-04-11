(* Binop Exceptions *) 

exception UnsupportedBinaryOperationOnTypes of string * string 

(* Unop Exceptions *) 

exception UnsupportedUnaryOperationOnType of string 
exception UnsupportedUnaryOperationOnFloat