/* Ocamlyacc parser ML */

%{ open Ast %}

%token SEMI COLON LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK COMMA BAR
%token PLUS MINUS TIMES DIVIDE MOD ASSIGN
%token EQ NEQ LT LEQ GT GEQ AND OR NOT 
%token RETURN IF ELSE ELSEIF FOR PFOR WHILE 
%token FUNC ASYNC WAIT 
%token TRUE FALSE 
%token INT FLOAT BOOL STRING VOID TUPLE MATRIX
%token INCLUDE
%token <int> INTLIT
%token <float> FLOATLIT
%token <string> STRINGLIT
%token <string> ID
%token EOF

%nonassoc NOELSE
%nonassoc ELSE
%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%right NOT NEG

%start program
%type <Ast.program> program

%%

program:
  decls EOF { $1 }

decls:
   /* nothing */ { [], [] }
 | decls vdecl { ($2 :: fst $1), snd $1 }
 | decls fdecl { fst $1, ($2 :: snd $1) }

fdecl:
   datatype ID LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE
     { { datatype = $1;
	 fname = $2;
	 formals = $4;
	 locals = List.rev $7;
	 body = List.rev $8 } }

formals_opt:
    /* nothing */ { [] }
  | formal_list   { List.rev $1 }

formal_list:
    datatype ID                   { [($1,$2)] }
  | formal_list COMMA datatype ID { ($3,$4) :: $1 }

datatype:
    primitive { $1 }
  | primitive LT INTLIT GT { Tupletype($1, $3) }
  | primitive LBRACK INTLIT RBRACK LBRACK INTLIT RBRACK {Matrixtype($1,$3,$6)}

primitive:
    INT    { Int }
  | FLOAT  { Float }
  | STRING { String }
  | BOOL   { Bool }
  | VOID   { Void }

vdecl_list:
    /* nothing */    { [] }
  | vdecl_list vdecl { $2 :: $1 }

vdecl:
    datatype ID SEMI { ($1, $2) }

stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMI { Expr $1 }
  | RETURN SEMI { Return Noexpr }
  | RETURN expr SEMI { Return $2 }
  | LBRACE stmt_list RBRACE { Block(List.rev $2) }
  | IF LPAREN expr RPAREN stmt %prec NOELSE { If($3, $5, Block([])) }
  | IF LPAREN expr RPAREN stmt ELSE stmt    { If($3, $5, $7) }
  | FOR LPAREN expr_opt SEMI expr SEMI expr_opt RPAREN stmt
     { For($3, $5, $7, $9) }
  | WHILE LPAREN expr RPAREN stmt { While($3, $5) }

expr_opt:
    /* nothing */ { Noexpr }
  | expr          { $1 }

expr:
    literals             { $1 }
  | tuple                { $1 }
  | matrix               { $1 }
  | ID                   { Id($1) }
  | opexpr               { $1 }
  | LPAREN opexpr RPAREN { $2 }

opexpr: 
    expr PLUS   expr { Binop($1, Add,   $3) }
  | expr MINUS  expr { Binop($1, Sub,   $3) }
  | expr TIMES  expr { Binop($1, Mult,  $3) }
  | expr DIVIDE expr { Binop($1, Div,   $3) }
  | expr EQ     expr { Binop($1, Equal, $3) }
  | expr NEQ    expr { Binop($1, Neq,   $3) }
  | expr LT     expr { Binop($1, Less,  $3) }
  | expr LEQ    expr { Binop($1, Leq,   $3) }
  | expr GT     expr { Binop($1, Greater, $3) }
  | expr GEQ    expr { Binop($1, Geq,   $3) }
  | expr AND    expr { Binop($1, And,   $3) }
  | expr OR     expr { Binop($1, Or,    $3) }
  | MINUS expr %prec NEG { Unop(Neg, $2) }
  | NOT expr         { Unop(Not, $2) }
  | ID ASSIGN expr   { Assign($1, $3) }
  | ID LPAREN actuals_opt RPAREN { Call($1, $3) }

literals:
    INTLIT    { IntLit($1) }
  | FLOATLIT  { FloatLit($1) }
  | STRINGLIT { StrLit($1) }
  | TRUE      { BoolLit(true) }
  | FALSE     { BoolLit(false) }

tuple:
    LPAREN tuple_list RPAREN { Tuple($2) }

matrix:
    LBRACE multiple_matrix RBRACE {Matrix($2)}

matrix_list:     
    INTLIT { [$1] }
    | matrix_list COMMA INTLIT {$3 :: $1}
    /*1 shift-reduce error. Not sure where though*/

multiple_matrix:
    | matrix_list {[$1]}
    | multiple_matrix BAR matrix_list {$3 :: $1}

tuple_list: 
    literals { [$1] }
  | tuple_list COMMA literals { $3 :: $1 } 

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
