(* Ocamllex scanner for ML *)

{ open Parser }

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf }  (* Whitespace *)
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
| "func"     { FUNC }
| "async"    { ASYNC } 
| "wait"     { WAIT }
| "return"   { RETURN }
| "int"      { INT } 
| "float"    { FLOAT } 
| "bool"     { BOOL }
| "str"      { STRING }
| "void"     { VOID }
| "#include" { INCLUDE }
| ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
| ['0'-'9']*['.']['0'-'9']+ as lxm { FLOATLIT(float_of_string lxm) } 
| ['0'-'9']+['.']['0'-'9']* as lxm { FLOATLIT(float_of_string lxm) }
| '\"'[^'\"']*'\"' as lxm { STRINGLIT(lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("Illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/"  { token lexbuf }
| _     { comment lexbuf } 

and slcomment = parse 
  '\n'  { token lexbuf }
| _     { slcomment lexbuf }  