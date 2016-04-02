(* Abstract Syntax Tree and functions for printing it *)

type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq |
          And | Or

type uop = Neg | Not

type typ = Int | Float | String | Bool | Void

type bind = typ * string

type expr =
    Literal of int
  | FloatLit of float
  | StrLit of string 
  | BoolLit of bool
  | Id of string
  | Binop of expr * op * expr
  | Unop of uop * expr
  | Assign of string * expr
  | Call of string * expr list
  | Noexpr

type stmt =
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt

type func_decl = {
    typ : typ;
    fname : string;
    formals : bind list;
    locals : bind list;
    body : stmt list;
  }

type program = bind list * func_decl list

(* Pretty-printing functions *)

let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="
  | And -> "&&"
  | Or -> "||"

let string_of_uop = function
    Neg -> "-"
  | Not -> "!"

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | FloatLit(l) -> string_of_float l
  | StrLit(l) -> l 
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id(s) -> s
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""

let appendToTupleList tupleList item= List.map(fun (a,b) -> (a,b,item)) tupleList;;
let makeTupleList tupleList item= List.map(fun a -> (a,item)) tupleList;;



let rec string_of_stmt (x,numtabs) = 
  match x with
  Block(stmts) -> let extraTab=numtabs^"\t" in let myTupleList=makeTupleList stmts extraTab in
      numtabs ^ "{\n" ^ String.concat "" (List.map string_of_stmt myTupleList) ^ numtabs^ "}\n"
  | Expr(expr) -> numtabs ^ string_of_expr expr ^ ";\n";
  | Return(expr) -> numtabs ^ "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s, Block([])) -> let myStmt=(s,numtabs^"\t") in numtabs ^ "if\n\t " ^ numtabs^ "(" ^ string_of_expr e ^ ")\n" ^ string_of_stmt myStmt
  | If(e, s1, s2) ->  numtabs ^ "if\n\t" ^ numtabs ^ "(" ^ string_of_expr e ^ ")\n" ^
      string_of_stmt (s1,numtabs ^ "\t") ^ numtabs ^ "else\n" ^ string_of_stmt (s2,numtabs ^ "\t")
  | For(e1, e2, e3, s) ->
      numtabs ^ "for\n\t" ^ numtabs ^ "(" ^ string_of_expr e1  ^ " ; " ^ string_of_expr e2 ^ " ; " ^
      string_of_expr e3  ^ ")\n " ^ string_of_stmt (s,numtabs^"\t")
  | While(e, s) -> numtabs ^ "while\n\t" ^ numtabs ^ "(" ^ string_of_expr e ^ ") \n" ^ string_of_stmt (s,numtabs^"\t")
let string_of_typ = function
    Int -> "int"
  | String -> "str"
  | Float -> "float"
  | Bool -> "bool"
  | Void -> "void"

let string_of_vdecl (t, id,numtabs)= numtabs ^ string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_fdecl (fdecl,numtabs) =
  let newNumTabs=numtabs ^ "\t" in 
  let myLocals= appendToTupleList fdecl.locals newNumTabs in 
  let myBody = makeTupleList fdecl.body newNumTabs in 
  numtabs ^ string_of_typ fdecl.typ ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n" ^ numtabs ^ "{\n" ^
  String.concat "" (List.map string_of_vdecl myLocals) ^ 
  String.concat "" (List.map string_of_stmt myBody) ^ 
  numtabs ^ "}\n"

let string_of_program (vars, funcs) =
  let myList=appendToTupleList vars "\t" in
  let funcList=makeTupleList funcs "\t" in
  String.concat "" (List.map string_of_vdecl myList) ^ "program\n" ^ 
  String.concat "\n" (List.map string_of_fdecl funcList)

(* Pretty printing tree functions *)

