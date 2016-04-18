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

open Parsing;;
let _ = parse_error;;
# 3 "parser.mly"
 open Ast 
# 57 "parser.ml"
let yytransl_const = [|
  257 (* SEMI *);
  258 (* COLON *);
  259 (* LPAREN *);
  260 (* RPAREN *);
  261 (* LBRACE *);
  262 (* RBRACE *);
  263 (* LBRACK *);
  264 (* RBRACK *);
  265 (* COMMA *);
  266 (* PLUS *);
  267 (* MINUS *);
  268 (* TIMES *);
  269 (* DIVIDE *);
  270 (* MOD *);
  271 (* ASSIGN *);
  272 (* EQ *);
  273 (* NEQ *);
  274 (* LT *);
  275 (* LEQ *);
  276 (* GT *);
  277 (* GEQ *);
  278 (* AND *);
  279 (* OR *);
  280 (* NOT *);
  281 (* RETURN *);
  282 (* IF *);
  283 (* ELSE *);
  284 (* ELSEIF *);
  285 (* FOR *);
  286 (* PFOR *);
  287 (* WHILE *);
  288 (* FUNC *);
  289 (* ASYNC *);
  290 (* WAIT *);
  291 (* TRUE *);
  292 (* FALSE *);
  293 (* INT *);
  294 (* FLOAT *);
  295 (* BOOL *);
  296 (* STRING *);
  297 (* CHAR *);
  298 (* VOID *);
  299 (* INCLUDE *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  300 (* INTLIT *);
  301 (* FLOATLIT *);
  302 (* CHARLIT *);
  303 (* STRINGLIT *);
  304 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\004\000\004\000\005\000\003\000\003\000\
\003\000\007\000\009\000\009\000\012\000\012\000\008\000\008\000\
\014\000\013\000\013\000\013\000\013\000\013\000\013\000\010\000\
\010\000\006\000\011\000\011\000\015\000\015\000\015\000\015\000\
\015\000\015\000\015\000\015\000\017\000\017\000\016\000\016\000\
\016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
\016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
\016\000\016\000\020\000\020\000\020\000\020\000\020\000\020\000\
\018\000\018\000\021\000\021\000\019\000\019\000\022\000\022\000\
\000\000"

let yylen = "\002\000\
\003\000\000\000\001\000\001\000\002\000\003\000\000\000\002\000\
\002\000\009\000\000\000\001\000\002\000\004\000\001\000\001\000\
\004\000\001\000\001\000\001\000\001\000\001\000\001\000\000\000\
\002\000\003\000\000\000\002\000\002\000\002\000\003\000\003\000\
\005\000\007\000\009\000\005\000\000\000\001\000\001\000\001\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\002\000\002\000\003\000\004\000\
\003\000\004\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\003\000\001\000\003\000\000\000\001\000\001\000\003\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\073\000\007\000\000\000\004\000\000\000\
\000\000\005\000\006\000\018\000\019\000\022\000\021\000\020\000\
\023\000\001\000\008\000\009\000\000\000\000\000\016\000\000\000\
\000\000\026\000\000\000\000\000\000\000\000\000\000\000\017\000\
\013\000\000\000\000\000\024\000\000\000\000\000\014\000\025\000\
\000\000\000\000\000\000\000\000\027\000\010\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\062\000\063\000\059\000\
\060\000\064\000\061\000\000\000\028\000\000\000\039\000\065\000\
\000\000\000\000\000\000\000\000\053\000\054\000\030\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\029\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\057\000\032\000\066\000\000\000\031\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\043\000\044\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\056\000\000\000\058\000\000\000\000\000\036\000\000\000\
\000\000\000\000\034\000\000\000\000\000\035\000"

let yydgoto = "\002\000\
\004\000\005\000\009\000\006\000\007\000\019\000\020\000\021\000\
\030\000\038\000\042\000\031\000\022\000\023\000\061\000\062\000\
\099\000\063\000\102\000\064\000\068\000\103\000"

let yysindex = "\024\000\
\215\254\000\000\237\254\000\000\000\000\215\254\000\000\034\255\
\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\017\255\053\255\000\000\052\255\
\024\255\000\000\202\255\062\255\030\255\057\255\063\255\000\000\
\000\000\084\255\202\255\000\000\049\255\202\255\000\000\000\000\
\055\255\093\255\104\255\066\255\000\000\000\000\066\255\066\255\
\066\255\047\255\106\255\112\255\118\255\000\000\000\000\000\000\
\000\000\000\000\000\000\005\255\000\000\092\000\000\000\000\000\
\014\000\120\255\021\001\001\255\000\000\000\000\000\000\106\000\
\066\255\066\255\066\255\066\255\086\255\066\255\000\000\066\255\
\066\255\066\255\066\255\066\255\066\255\066\255\066\255\066\255\
\066\255\066\255\066\255\000\000\000\000\000\000\066\255\000\000\
\243\000\021\001\135\255\007\001\021\001\103\255\133\255\139\255\
\021\001\051\255\051\255\000\000\000\000\060\001\060\001\122\255\
\122\255\122\255\122\255\048\001\035\001\021\001\201\255\066\255\
\201\255\000\000\066\255\000\000\116\255\120\000\000\000\021\001\
\201\255\066\255\000\000\144\255\201\255\000\000"

let yyrindex = "\000\000\
\007\000\000\000\000\000\000\000\000\000\013\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\109\255\000\000\000\000\
\000\000\000\000\155\255\000\000\000\000\000\000\156\255\000\000\
\000\000\000\000\000\000\000\000\000\000\147\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\249\255\000\000\000\000\000\000\000\000\
\000\000\000\000\076\255\000\000\000\000\000\000\000\000\000\000\
\000\000\160\255\000\000\158\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\023\255\000\000\000\000\012\255\000\000\159\255\000\000\
\048\255\055\000\078\000\000\000\000\000\058\255\235\000\143\000\
\166\000\189\000\212\000\149\000\010\255\079\255\000\000\000\000\
\000\000\000\000\000\000\000\000\174\255\000\000\000\000\013\255\
\000\000\165\255\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\164\000\136\000\000\000\244\255\
\000\000\000\000\130\000\000\000\000\000\000\000\243\255\212\255\
\054\000\000\000\000\000\000\000\000\000\000\000"

let yytablesize = 593
let yytable = "\065\000\
\018\000\003\000\067\000\069\000\070\000\072\000\002\000\076\000\
\094\000\095\000\052\000\077\000\003\000\052\000\029\000\071\000\
\072\000\052\000\052\000\078\000\071\000\072\000\037\000\038\000\
\001\000\041\000\038\000\008\000\097\000\098\000\100\000\101\000\
\052\000\105\000\011\000\106\000\107\000\108\000\109\000\110\000\
\111\000\112\000\113\000\114\000\115\000\116\000\117\000\071\000\
\055\000\044\000\118\000\055\000\026\000\047\000\027\000\055\000\
\055\000\048\000\045\000\025\000\034\000\045\000\082\000\083\000\
\024\000\045\000\045\000\028\000\044\000\032\000\049\000\035\000\
\047\000\045\000\045\000\126\000\048\000\033\000\128\000\045\000\
\045\000\054\000\055\000\067\000\067\000\098\000\068\000\068\000\
\036\000\049\000\056\000\057\000\058\000\059\000\060\000\044\000\
\039\000\045\000\046\000\047\000\054\000\055\000\043\000\048\000\
\026\000\125\000\122\000\127\000\073\000\056\000\057\000\058\000\
\059\000\060\000\074\000\131\000\049\000\050\000\051\000\134\000\
\075\000\052\000\044\000\053\000\045\000\093\000\047\000\054\000\
\055\000\104\000\048\000\080\000\081\000\082\000\083\000\120\000\
\056\000\057\000\058\000\059\000\060\000\123\000\129\000\049\000\
\050\000\051\000\124\000\133\000\052\000\027\000\053\000\027\000\
\027\000\027\000\054\000\055\000\015\000\027\000\011\000\012\000\
\037\000\069\000\070\000\056\000\057\000\058\000\059\000\060\000\
\037\000\010\000\027\000\027\000\027\000\040\000\066\000\027\000\
\033\000\027\000\033\000\033\000\033\000\027\000\027\000\132\000\
\033\000\000\000\000\000\000\000\000\000\000\000\027\000\027\000\
\027\000\027\000\027\000\000\000\000\000\033\000\033\000\033\000\
\000\000\000\000\033\000\044\000\033\000\045\000\000\000\047\000\
\033\000\033\000\000\000\048\000\000\000\000\000\000\000\000\000\
\000\000\033\000\033\000\033\000\033\000\033\000\000\000\000\000\
\049\000\050\000\051\000\000\000\000\000\052\000\000\000\053\000\
\000\000\000\000\000\000\054\000\055\000\000\000\012\000\013\000\
\014\000\015\000\016\000\017\000\056\000\057\000\058\000\059\000\
\060\000\040\000\000\000\000\000\040\000\000\000\000\000\000\000\
\040\000\040\000\040\000\040\000\040\000\040\000\000\000\000\000\
\040\000\040\000\040\000\040\000\040\000\040\000\040\000\040\000\
\000\000\092\000\000\000\000\000\000\000\000\000\000\000\080\000\
\081\000\082\000\083\000\000\000\000\000\084\000\085\000\086\000\
\087\000\088\000\089\000\090\000\091\000\012\000\013\000\014\000\
\015\000\016\000\017\000\002\000\002\000\002\000\002\000\002\000\
\002\000\003\000\003\000\003\000\003\000\003\000\003\000\041\000\
\000\000\000\000\041\000\000\000\000\000\000\000\041\000\041\000\
\041\000\041\000\000\000\000\000\000\000\000\000\041\000\041\000\
\041\000\041\000\041\000\041\000\041\000\041\000\042\000\000\000\
\000\000\042\000\000\000\000\000\000\000\042\000\042\000\042\000\
\042\000\000\000\000\000\000\000\079\000\042\000\042\000\042\000\
\042\000\042\000\042\000\042\000\042\000\080\000\081\000\082\000\
\083\000\000\000\096\000\084\000\085\000\086\000\087\000\088\000\
\089\000\090\000\091\000\080\000\081\000\082\000\083\000\000\000\
\130\000\084\000\085\000\086\000\087\000\088\000\089\000\090\000\
\091\000\080\000\081\000\082\000\083\000\000\000\000\000\084\000\
\085\000\086\000\087\000\088\000\089\000\090\000\091\000\047\000\
\000\000\000\000\047\000\000\000\000\000\051\000\047\000\047\000\
\051\000\000\000\000\000\000\000\051\000\051\000\047\000\047\000\
\047\000\047\000\047\000\047\000\047\000\047\000\048\000\000\000\
\000\000\048\000\051\000\051\000\000\000\048\000\048\000\000\000\
\000\000\000\000\000\000\000\000\000\000\048\000\048\000\048\000\
\048\000\048\000\048\000\048\000\048\000\049\000\000\000\000\000\
\049\000\000\000\000\000\000\000\049\000\049\000\000\000\000\000\
\000\000\000\000\000\000\000\000\049\000\049\000\049\000\049\000\
\049\000\049\000\049\000\049\000\050\000\000\000\000\000\050\000\
\000\000\000\000\000\000\050\000\050\000\000\000\000\000\000\000\
\000\000\000\000\000\000\050\000\050\000\050\000\050\000\050\000\
\050\000\050\000\050\000\046\000\000\000\000\000\046\000\000\000\
\000\000\000\000\046\000\046\000\000\000\000\000\119\000\000\000\
\000\000\000\000\046\000\046\000\080\000\081\000\082\000\083\000\
\046\000\046\000\084\000\085\000\086\000\087\000\088\000\089\000\
\090\000\091\000\121\000\000\000\000\000\000\000\000\000\000\000\
\080\000\081\000\082\000\083\000\000\000\000\000\084\000\085\000\
\086\000\087\000\088\000\089\000\090\000\091\000\080\000\081\000\
\082\000\083\000\000\000\000\000\084\000\085\000\086\000\087\000\
\088\000\089\000\090\000\091\000\080\000\081\000\082\000\083\000\
\000\000\000\000\084\000\085\000\086\000\087\000\088\000\089\000\
\090\000\080\000\081\000\082\000\083\000\000\000\000\000\084\000\
\085\000\086\000\087\000\088\000\089\000\080\000\081\000\082\000\
\083\000\000\000\000\000\000\000\000\000\086\000\087\000\088\000\
\089\000"

let yycheck = "\044\000\
\000\000\043\001\047\000\048\000\049\000\050\000\000\000\003\001\
\008\001\009\001\001\001\007\001\000\000\004\001\027\000\004\001\
\004\001\008\001\009\001\015\001\009\001\009\001\035\000\001\001\
\001\000\038\000\004\001\047\001\073\000\074\000\075\000\076\000\
\023\001\078\000\001\001\080\000\081\000\082\000\083\000\084\000\
\085\000\086\000\087\000\088\000\089\000\090\000\091\000\001\001\
\001\001\003\001\095\000\004\001\001\001\007\001\003\001\008\001\
\009\001\011\001\001\001\007\001\004\001\004\001\012\001\013\001\
\048\001\008\001\009\001\044\001\003\001\008\001\024\001\009\001\
\007\001\016\001\017\001\120\000\011\001\048\001\123\000\022\001\
\023\001\035\001\036\001\008\001\009\001\130\000\008\001\009\001\
\005\001\024\001\044\001\045\001\046\001\047\001\048\001\003\001\
\048\001\005\001\006\001\007\001\035\001\036\001\048\001\011\001\
\001\001\119\000\004\001\121\000\003\001\044\001\045\001\046\001\
\047\001\048\001\003\001\129\000\024\001\025\001\026\001\133\000\
\003\001\029\001\003\001\031\001\005\001\006\001\007\001\035\001\
\036\001\044\001\011\001\010\001\011\001\012\001\013\001\001\001\
\044\001\045\001\046\001\047\001\048\001\009\001\027\001\024\001\
\025\001\026\001\008\001\004\001\029\001\003\001\031\001\005\001\
\006\001\007\001\035\001\036\001\048\001\011\001\004\001\004\001\
\001\001\004\001\004\001\044\001\045\001\046\001\047\001\048\001\
\004\001\006\000\024\001\025\001\026\001\038\000\045\000\029\001\
\003\001\031\001\005\001\006\001\007\001\035\001\036\001\130\000\
\011\001\255\255\255\255\255\255\255\255\255\255\044\001\045\001\
\046\001\047\001\048\001\255\255\255\255\024\001\025\001\026\001\
\255\255\255\255\029\001\003\001\031\001\005\001\255\255\007\001\
\035\001\036\001\255\255\011\001\255\255\255\255\255\255\255\255\
\255\255\044\001\045\001\046\001\047\001\048\001\255\255\255\255\
\024\001\025\001\026\001\255\255\255\255\029\001\255\255\031\001\
\255\255\255\255\255\255\035\001\036\001\255\255\037\001\038\001\
\039\001\040\001\041\001\042\001\044\001\045\001\046\001\047\001\
\048\001\001\001\255\255\255\255\004\001\255\255\255\255\255\255\
\008\001\009\001\010\001\011\001\012\001\013\001\255\255\255\255\
\016\001\017\001\018\001\019\001\020\001\021\001\022\001\023\001\
\255\255\004\001\255\255\255\255\255\255\255\255\255\255\010\001\
\011\001\012\001\013\001\255\255\255\255\016\001\017\001\018\001\
\019\001\020\001\021\001\022\001\023\001\037\001\038\001\039\001\
\040\001\041\001\042\001\037\001\038\001\039\001\040\001\041\001\
\042\001\037\001\038\001\039\001\040\001\041\001\042\001\001\001\
\255\255\255\255\004\001\255\255\255\255\255\255\008\001\009\001\
\010\001\011\001\255\255\255\255\255\255\255\255\016\001\017\001\
\018\001\019\001\020\001\021\001\022\001\023\001\001\001\255\255\
\255\255\004\001\255\255\255\255\255\255\008\001\009\001\010\001\
\011\001\255\255\255\255\255\255\001\001\016\001\017\001\018\001\
\019\001\020\001\021\001\022\001\023\001\010\001\011\001\012\001\
\013\001\255\255\001\001\016\001\017\001\018\001\019\001\020\001\
\021\001\022\001\023\001\010\001\011\001\012\001\013\001\255\255\
\001\001\016\001\017\001\018\001\019\001\020\001\021\001\022\001\
\023\001\010\001\011\001\012\001\013\001\255\255\255\255\016\001\
\017\001\018\001\019\001\020\001\021\001\022\001\023\001\001\001\
\255\255\255\255\004\001\255\255\255\255\001\001\008\001\009\001\
\004\001\255\255\255\255\255\255\008\001\009\001\016\001\017\001\
\018\001\019\001\020\001\021\001\022\001\023\001\001\001\255\255\
\255\255\004\001\022\001\023\001\255\255\008\001\009\001\255\255\
\255\255\255\255\255\255\255\255\255\255\016\001\017\001\018\001\
\019\001\020\001\021\001\022\001\023\001\001\001\255\255\255\255\
\004\001\255\255\255\255\255\255\008\001\009\001\255\255\255\255\
\255\255\255\255\255\255\255\255\016\001\017\001\018\001\019\001\
\020\001\021\001\022\001\023\001\001\001\255\255\255\255\004\001\
\255\255\255\255\255\255\008\001\009\001\255\255\255\255\255\255\
\255\255\255\255\255\255\016\001\017\001\018\001\019\001\020\001\
\021\001\022\001\023\001\001\001\255\255\255\255\004\001\255\255\
\255\255\255\255\008\001\009\001\255\255\255\255\004\001\255\255\
\255\255\255\255\016\001\017\001\010\001\011\001\012\001\013\001\
\022\001\023\001\016\001\017\001\018\001\019\001\020\001\021\001\
\022\001\023\001\004\001\255\255\255\255\255\255\255\255\255\255\
\010\001\011\001\012\001\013\001\255\255\255\255\016\001\017\001\
\018\001\019\001\020\001\021\001\022\001\023\001\010\001\011\001\
\012\001\013\001\255\255\255\255\016\001\017\001\018\001\019\001\
\020\001\021\001\022\001\023\001\010\001\011\001\012\001\013\001\
\255\255\255\255\016\001\017\001\018\001\019\001\020\001\021\001\
\022\001\010\001\011\001\012\001\013\001\255\255\255\255\016\001\
\017\001\018\001\019\001\020\001\021\001\010\001\011\001\012\001\
\013\001\255\255\255\255\255\255\255\255\018\001\019\001\020\001\
\021\001"

let yynames_const = "\
  SEMI\000\
  COLON\000\
  LPAREN\000\
  RPAREN\000\
  LBRACE\000\
  RBRACE\000\
  LBRACK\000\
  RBRACK\000\
  COMMA\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  MOD\000\
  ASSIGN\000\
  EQ\000\
  NEQ\000\
  LT\000\
  LEQ\000\
  GT\000\
  GEQ\000\
  AND\000\
  OR\000\
  NOT\000\
  RETURN\000\
  IF\000\
  ELSE\000\
  ELSEIF\000\
  FOR\000\
  PFOR\000\
  WHILE\000\
  FUNC\000\
  ASYNC\000\
  WAIT\000\
  TRUE\000\
  FALSE\000\
  INT\000\
  FLOAT\000\
  BOOL\000\
  STRING\000\
  CHAR\000\
  VOID\000\
  INCLUDE\000\
  EOF\000\
  "

let yynames_block = "\
  INTLIT\000\
  FLOATLIT\000\
  CHARLIT\000\
  STRINGLIT\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'includes) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'decls) in
    Obj.repr(
# 37 "parser.mly"
                     ( (_1, fst _2, snd _2) )
# 422 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "parser.mly"
                 ( [] )
# 428 "parser.ml"
               : 'includes))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'include_list) in
    Obj.repr(
# 41 "parser.mly"
                 ( List.rev _1 )
# 435 "parser.ml"
               : 'includes))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'include_decl) in
    Obj.repr(
# 44 "parser.mly"
                              ( [_1] )
# 442 "parser.ml"
               : 'include_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'include_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'include_decl) in
    Obj.repr(
# 45 "parser.mly"
                              ( _2 :: _1 )
# 450 "parser.ml"
               : 'include_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 48 "parser.mly"
                         ( Include(_2) )
# 457 "parser.ml"
               : 'include_decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 51 "parser.mly"
                 ( [], [] )
# 463 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'decls) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl) in
    Obj.repr(
# 52 "parser.mly"
               ( (_2 :: fst _1), snd _1 )
# 471 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'decls) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'fdecl) in
    Obj.repr(
# 53 "parser.mly"
               ( fst _1, (_2 :: snd _1) )
# 479 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 8 : 'datatype) in
    let _2 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'formals_opt) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 57 "parser.mly"
     ( { datatype = _1;
	       fname = _2;
	       formals = _4;
	       locals = List.rev _7;
	       body = List.rev _8 } )
# 494 "parser.ml"
               : 'fdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 64 "parser.mly"
                  ( [] )
# 500 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formal_list) in
    Obj.repr(
# 65 "parser.mly"
                  ( List.rev _1 )
# 507 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'datatype) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 68 "parser.mly"
                                  ( [(_1, _2)] )
# 515 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'formal_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'datatype) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 69 "parser.mly"
                                  ( (_3, _4) :: _1 )
# 524 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'primitive) in
    Obj.repr(
# 72 "parser.mly"
                ( DataType(_1) )
# 531 "parser.ml"
               : 'datatype))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'tuple_type) in
    Obj.repr(
# 73 "parser.mly"
                ( _1 )
# 538 "parser.ml"
               : 'datatype))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'primitive) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : int) in
    Obj.repr(
# 76 "parser.mly"
                                   ( TupleType(_1, _3) )
# 546 "parser.ml"
               : 'tuple_type))
; (fun __caml_parser_env ->
    Obj.repr(
# 79 "parser.mly"
           ( Int )
# 552 "parser.ml"
               : 'primitive))
; (fun __caml_parser_env ->
    Obj.repr(
# 80 "parser.mly"
           ( Float )
# 558 "parser.ml"
               : 'primitive))
; (fun __caml_parser_env ->
    Obj.repr(
# 81 "parser.mly"
           ( Char )
# 564 "parser.ml"
               : 'primitive))
; (fun __caml_parser_env ->
    Obj.repr(
# 82 "parser.mly"
           ( String )
# 570 "parser.ml"
               : 'primitive))
; (fun __caml_parser_env ->
    Obj.repr(
# 83 "parser.mly"
           ( Bool )
# 576 "parser.ml"
               : 'primitive))
; (fun __caml_parser_env ->
    Obj.repr(
# 84 "parser.mly"
           ( Void )
# 582 "parser.ml"
               : 'primitive))
; (fun __caml_parser_env ->
    Obj.repr(
# 87 "parser.mly"
                     ( [] )
# 588 "parser.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'vdecl_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl) in
    Obj.repr(
# 88 "parser.mly"
                     ( _2 :: _1 )
# 596 "parser.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'datatype) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 91 "parser.mly"
                     ( (_1, _2) )
# 604 "parser.ml"
               : 'vdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 94 "parser.mly"
                   ( [] )
# 610 "parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 95 "parser.mly"
                   ( _2 :: _1 )
# 618 "parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 98 "parser.mly"
              ( Expr _1 )
# 625 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 99 "parser.mly"
                ( Return Noexpr )
# 631 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 100 "parser.mly"
                     ( Return _2 )
# 638 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 101 "parser.mly"
                            ( Block(List.rev _2) )
# 645 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 102 "parser.mly"
                                            ( If(_3, _5, Block([])) )
# 653 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 103 "parser.mly"
                                            ( If(_3, _5, _7) )
# 662 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 6 : 'expr_opt) in
    let _5 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'expr_opt) in
    let _9 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 105 "parser.mly"
     ( For(_3, _5, _7, _9) )
# 672 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 106 "parser.mly"
                                  ( While(_3, _5) )
# 680 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 109 "parser.mly"
                  ( Noexpr )
# 686 "parser.ml"
               : 'expr_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 110 "parser.mly"
                  ( _1 )
# 693 "parser.ml"
               : 'expr_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literals) in
    Obj.repr(
# 113 "parser.mly"
                                 ( _1 )
# 700 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 114 "parser.mly"
                                 ( Id(_1) )
# 707 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 115 "parser.mly"
                                 ( Binop(_1, Add,   _3) )
# 715 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 116 "parser.mly"
                                 ( Binop(_1, Sub,   _3) )
# 723 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 117 "parser.mly"
                                 ( Binop(_1, Mult,  _3) )
# 731 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 118 "parser.mly"
                                 ( Binop(_1, Div,   _3) )
# 739 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 119 "parser.mly"
                                 ( Binop(_1, Equal, _3) )
# 747 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 120 "parser.mly"
                                 ( Binop(_1, Neq,   _3) )
# 755 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 121 "parser.mly"
                                 ( Binop(_1, Less,  _3) )
# 763 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 122 "parser.mly"
                                 ( Binop(_1, Leq,   _3) )
# 771 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 123 "parser.mly"
                                 ( Binop(_1, Greater, _3) )
# 779 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 124 "parser.mly"
                                 ( Binop(_1, Geq,   _3) )
# 787 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 125 "parser.mly"
                                 ( Binop(_1, And,   _3) )
# 795 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 126 "parser.mly"
                                 ( Binop(_1, Or,    _3) )
# 803 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 127 "parser.mly"
                                 ( Unop(Neg, _2) )
# 810 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 128 "parser.mly"
                                 ( Unop(Not, _2) )
# 817 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 129 "parser.mly"
                                 ( Assign(_1, _3) )
# 825 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'actuals_opt) in
    Obj.repr(
# 130 "parser.mly"
                                 ( Call(_1, _3) )
# 833 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 131 "parser.mly"
                                 ( _2 )
# 840 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : int) in
    Obj.repr(
# 132 "parser.mly"
                                 ( TupleAccess(_1, _3))
# 848 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 135 "parser.mly"
              ( IntLit(_1) )
# 855 "parser.ml"
               : 'primitives))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 136 "parser.mly"
              ( FloatLit(_1) )
# 862 "parser.ml"
               : 'primitives))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 137 "parser.mly"
              ( StrLit(_1) )
# 869 "parser.ml"
               : 'primitives))
; (fun __caml_parser_env ->
    Obj.repr(
# 138 "parser.mly"
              ( BoolLit(true) )
# 875 "parser.ml"
               : 'primitives))
; (fun __caml_parser_env ->
    Obj.repr(
# 139 "parser.mly"
              ( BoolLit(false) )
# 881 "parser.ml"
               : 'primitives))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 140 "parser.mly"
              ( CharLit(_1) )
# 888 "parser.ml"
               : 'primitives))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'primitives) in
    Obj.repr(
# 143 "parser.mly"
               ( _1 )
# 895 "parser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'tuple_primitive) in
    Obj.repr(
# 144 "parser.mly"
                                  ( TuplePrimitive(List.rev _2) )
# 902 "parser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 147 "parser.mly"
                               ( [_1] )
# 909 "parser.ml"
               : 'tuple_primitive))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'tuple_primitive) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 148 "parser.mly"
                               ( _3 :: _1 )
# 917 "parser.ml"
               : 'tuple_primitive))
; (fun __caml_parser_env ->
    Obj.repr(
# 151 "parser.mly"
                  ( [] )
# 923 "parser.ml"
               : 'actuals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'actuals_list) in
    Obj.repr(
# 152 "parser.mly"
                  ( List.rev _1 )
# 930 "parser.ml"
               : 'actuals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 155 "parser.mly"
                            ( [_1] )
# 937 "parser.ml"
               : 'actuals_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'actuals_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 156 "parser.mly"
                            ( _3 :: _1 )
# 945 "parser.ml"
               : 'actuals_list))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
