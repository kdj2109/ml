type token =
  | SEMI
  | COLON
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | LBRACK
  | RBRACK
  | BAR
  | PERIOD
  | COMMA
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | ASSIGN
  | AT
  | DOLLAR
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
  | WHILE
  | TRUE
  | FALSE
  | INT
  | FLOAT
  | BOOL
  | CHAR
  | VOID
  | LENGTH
  | ROWS
  | COLUMNS
  | FREE
  | INTLIT of (int)
  | FLOATLIT of (float)
  | CHARLIT of (char)
  | STRINGLIT of (string)
  | ID of (string)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
