/* Ocamlyacc parser ML */

%{ open Ast %}

%token SEMI COLON LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK COMMA
%token PLUS MINUS TIMES DIVIDE MOD ASSIGN
%token EQ NEQ LT LEQ GT GEQ AND OR NOT 
%token RETURN IF ELSE ELSEIF FOR PFOR WHILE 
%token FUNC ASYNC WAIT 
%token TRUE FALSE 
%token INT FLOAT BOOL STRING CHAR VOID 
%token INCLUDE
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
  includes decls EOF { ($1, fst $2, snd $2) }

includes: 
   /* nothing */ { [] }
 | include_list  { List.rev $1 } 

include_list:
    include_decl              { [$1] }
  | include_list include_decl { $2 :: $1 }

include_decl:
  INCLUDE STRINGLIT SEMI { Include($2) } 

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
    primitive   { DataType($1) }
  | tuple_type  { $1 } 
  | matrix_type { $1 } 

tuple_type: 
  primitive LBRACK INTLIT RBRACK { TupleType($1, $3) }

matrix_type: 
    primitive LBRACK INTLIT COLON INTLIT RBRACK { MatrixType(DataType($1), $3, $5) }
  | tuple_type LBRACK INTLIT COLON INTLIT RBRACK { MatrixType($1, $3, $5) }

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
  | ID LBRACK INTLIT RBRACK              { TupleAccess($1, $3)} 
  | ID LBRACK INTLIT COLON INTLIT RBRACK { MatrixAccess($1, $3, $5)}

primitives:
    INTLIT    { IntLit($1) }
  | FLOATLIT  { FloatLit($1) }
  | STRINGLIT { StrLit($1) }
  | TRUE      { BoolLit(true) }
  | FALSE     { BoolLit(false) }
  | CHARLIT   { CharLit($1) } 

literals:
    primitives { $1 }
  | LBRACK array_primitive RBRACK { ArrayPrimitive(List.rev $2) } 

array_primitive: 
    expr                       { [$1] }
  | array_primitive COMMA expr { $3 :: $1 } 

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
