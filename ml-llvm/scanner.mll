(* Ocamllex scanner for ML *)

{ open Parser }

let whitespace = [' ' '\t' '\r' '\n']
let digits = ['0'-'9']
let alphabet = ['a'-'z' 'A'-'Z']
let alphanumund = alphabet | digits | '_'
let integer = digits+
let decimal = ['.']
let float = digits* decimal digits+ | digits+ decimal digits*
let string = '\"'[^'\"']*'\"'
let id = alphabet alphanumund*

rule token = parse
  whitespace { token lexbuf }  
| "/*"       { comment lexbuf }          (* Comments *)
| "//"       { slcomment lexbuf }		 (* Single line comment *)
| '('        { LPAREN }
| ')'        { RPAREN }
| '{'        { LBRACE }
| '}'        { RBRACE }
| '['        { LBRACK } 
| ']'        { RBRACK } 
| ';'        { SEMI }
| ':'		 { COLON } 
| ','        { COMMA }
| '+'        { PLUS }
| '-'        { MINUS }
| '*'        { TIMES }
| '/'        { DIVIDE }
| '%'		 { MOD }
| "true"     { TRUE } 
| "false"    { FALSE }
| '='        { ASSIGN }
| "=="       { EQ }
| "!="       { NEQ }
| '<'        { LT }
| "<="       { LEQ }
| ">"        { GT }
| ">="       { GEQ }
| "&&"       { AND }
| "||"       { OR }
| "!"        { NOT }
| "if"       { IF }
| "elseif"   { ELSEIF}
| "else"     { ELSE }
| "for"      { FOR }
| "pfor"     { PFOR }
| "while"    { WHILE }
| "async"    { ASYNC } 
| "wait"     { WAIT }
| "return"   { RETURN }
| "int"      { INT } 
| "float"    { FLOAT } 
| "bool"     { BOOL }
| "str"      { STRING }
| "void"     { VOID }
| "#include" { INCLUDE }
| integer as lxm { LITERAL(int_of_string lxm) }
| float   as lxm { FLOATLIT(float_of_string lxm) } 
| string  as lxm { STRINGLIT(lxm) }
| id      as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("Illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/"  { token lexbuf }
| _     { comment lexbuf } 

and slcomment = parse 
  '\n'  { token lexbuf }
| _     { slcomment lexbuf }