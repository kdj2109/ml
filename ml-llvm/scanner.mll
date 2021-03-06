(* Ocamllex scanner for ML *)

{ open Parser 

  let un_esc s = 
	Scanf.sscanf ("\"" ^ s ^ "\"") "%S%!" (fun x -> x)

}

let whitespace = [' ' '\t' '\r' '\n']
let esc = '\\' ['\\' ''' '"' 'n' 'r' 't']
let esc_ch = ''' (esc)'''
let ascii = ([' '-'!' '#'-'[' ']'-'~'])
let digits = ['0'-'9']
let alphabet = ['a'-'z' 'A'-'Z']
let alphanumund = alphabet | digits | '_'
let integer = digits+
let decimal = ['.']
let float = digits* decimal digits+ | digits+ decimal digits*
let string = '"' ( (ascii | esc)* as s) '"'
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
| '|'		 { BAR }
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
| "elseif"   { ELSEIF }
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
| "tuple"    { TUPLE }
| "#include" { INCLUDE }
| integer as lxm { INTLIT(int_of_string lxm) }
| float   as lxm { FLOATLIT(float_of_string lxm) } 
| string      { STRINGLIT(un_esc s) }
| id      as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("Illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/"  { token lexbuf }
| _     { comment lexbuf } 

and slcomment = parse 
  '\n'  { token lexbuf }
| _     { slcomment lexbuf }
