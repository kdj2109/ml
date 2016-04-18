type token =
  | SEMI
  | COLON
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | LBRACK
  | RBRACK
  | COMMA
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | MOD
  | ASSIGN
  | EQ
  | NEQ
  | LT
  | LEQ
  | GT
  | GEQ
  | AND
  | OR
  | NOT
  | RETURN
  | IF
  | ELSE
  | ELSEIF
  | FOR
  | PFOR
  | WHILE
  | FUNC
  | ASYNC
  | WAIT
  | TRUE
  | FALSE
  | INT
  | FLOAT
  | BOOL
  | STRING
  | CHAR
  | VOID
  | INCLUDE
  | INTLIT of (int)
  | FLOATLIT of (float)
  | CHARLIT of (char)
  | STRINGLIT of (string)
  | ID of (string)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
