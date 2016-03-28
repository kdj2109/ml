open Ast
open Parser

let rec pretty_print = function 
    Literal(l) -> string_of_int l

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr Scanner.token lexbuf in
  let result = pretty_print expr in
  print_endline result