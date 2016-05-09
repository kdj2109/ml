/* Ocamlyacc parser ML */

%{ open Ast %}

%token SEMI COLON LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK BAR PERIOD COMMA
%token PLUS MINUS TIMES DIVIDE ASSIGN AT DOLLAR
%token EQ NEQ LT LEQ GT GEQ AND OR NOT
%token RETURN IF ELSE ELSEIF FOR WHILE
%token TRUE FALSE
%token INT FLOAT BOOL STRING CHAR VOID
%token LENGTH
%token <int> INTLIT
%token <float> FLOATLIT
%token <char> CHARLIT
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
  decls EOF { (fst $1, snd $1) }

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
    datatype ID                   { [($1, $2)] }
  | formal_list COMMA datatype ID { ($3, $4) :: $1 }

datatype:
    primitive           { DataType($1) }
  | tuple_type          { $1 }
  | matrix_type         { $1 }
  | pointer_type        { $1 }
  | double_pointer_type { $1 }
  | triple_pointer_type { $1 }

tuple_type:
  primitive LBRACK INTLIT RBRACK { TupleType($1, $3) }

matrix_type:
    primitive LBRACK INTLIT COLON INTLIT RBRACK  { MatrixType(DataType($1), $3, $5) }
  | tuple_type LBRACK INTLIT COLON INTLIT RBRACK { MatrixType($1, $3, $5) }

pointer_type:
  primitive LBRACK RBRACK { PointerType($1) }

double_pointer_type:
  primitive LBRACK RBRACK LBRACK RBRACK { DoublePointerType($1)}

triple_pointer_type:
  primitive LBRACK RBRACK LBRACK RBRACK LBRACK RBRACK { TriplePointerType($1) }

primitive:
    INT    { Int }
  | FLOAT  { Float }
  | CHAR   { Char }
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
    literals                             { $1 }
  | ID                                   { Id($1) }
  | expr PLUS   expr                     { Binop($1, Add,   $3) }
  | expr MINUS  expr                     { Binop($1, Sub,   $3) }
  | expr TIMES  expr                     { Binop($1, Mult,  $3) }
  | expr DIVIDE expr                     { Binop($1, Div,   $3) }
  | expr EQ     expr                     { Binop($1, Equal, $3) }
  | expr NEQ    expr                     { Binop($1, Neq,   $3) }
  | expr LT     expr                     { Binop($1, Less,  $3) }
  | expr LEQ    expr                     { Binop($1, Leq,   $3) }
  | expr GT     expr                     { Binop($1, Greater, $3) }
  | expr GEQ    expr                     { Binop($1, Geq,   $3) }
  | expr AND    expr                     { Binop($1, And,   $3) }
  | expr OR     expr                     { Binop($1, Or,    $3) }
  | MINUS expr %prec NEG                 { Unop(Neg, $2) }
  | NOT expr                             { Unop(Not, $2) }
  | expr ASSIGN expr                     { Assign($1, $3) }
  | ID LPAREN actuals_opt RPAREN         { Call($1, $3) }
  | LPAREN expr RPAREN                   { $2 }
  | ID LBRACK expr RBRACK                { TupleAccess($1, $3)}
  | ID LBRACK expr COLON expr RBRACK     { MatrixAccess($1, $3, $5)}
  | ID PERIOD LENGTH                     { Length($1) }
  | AT ID                                { Reference($2) }
  | DOLLAR ID                            { Dereference($2) }
  | AT AT ID                             { DoubleReference($3)}
  | AT AT AT ID                          { TripleReference($4) }
  | ID PERIOD PLUS                       { PointerIncrement($1) }

primitives:
    INTLIT    { IntLit($1) }
  | FLOATLIT  { FloatLit($1) }
  | STRINGLIT { StrLit($1) }
  | TRUE      { BoolLit(true) }
  | FALSE     { BoolLit(false) }
  | CHARLIT   { CharLit($1) }

literals:
    primitives                                                   { $1 }
  | LBRACK array_literal RBRACK                                  { TupleLiteral(List.rev $2) }
  | LBRACK BAR multiple_matrix BAR RBRACK      { MatrixLiteral(List.rev $3) }
  | LBRACK BAR tuple_multiple_matrix BAR RBRACK { MatrixLiteral(List.rev $3) }

/*matrix_list:
    literals { [$1] }
    | matrix_list COMMA literals {$3 :: $1}*/

multiple_matrix:
    | array_literal {[$1]}
    | multiple_matrix BAR array_literal {$3 :: $1}

tuple_multiple_matrix:
    | tuple_literal_list {[$1]}
    | tuple_multiple_matrix BAR tuple_literal_list {$3 :: $1}


tuple_literal_list:
    tuple_literal                          { [$1] }
  | tuple_literal_list COMMA tuple_literal { $3 :: $1 }


tuple_literal:
  LPAREN array_literal RPAREN { TupleLiteral(List.rev $2) }


array_literal:
    literals                     { [$1] }
  | array_literal COMMA literals { $3 :: $1 }

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
