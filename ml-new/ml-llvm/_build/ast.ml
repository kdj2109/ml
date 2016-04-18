(* Abstract-syntax Tree for ML *)

type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq |
          And | Or

type uop = Neg | Not

type primitive = Int | Float | String | Bool | Char | Void 

type datatype = 
   TupleType of primitive * int 
 | DataType of primitive

type var_dec = datatype * string

type include_stmt = Include of string 

type expr =
    IntLit of int 
  | CharLit of char
  | FloatLit of float 
  | StrLit of string 
  | BoolLit of bool 
  | TupleAccess of string * int 
  | TuplePrimitive of expr list 
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
    datatype : datatype;
    fname : string;
    formals : var_dec list;
    locals : var_dec list;
    body : stmt list;
  }

type program = include_stmt list * var_dec list * func_decl list 

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

let string_of_tuple l = 
  let rec string_of_tuple_primitive = function 
      [] -> "]"
    | [hd] -> (match hd with 
                IntLit(i) -> string_of_int i
              | FloatLit(f) -> string_of_float f
              | StrLit(s) -> s
              | CharLit(c) -> String.make 1 c
              | BoolLit(true) -> "true"
              | BoolLit(false) -> "false"
              | Id(s) -> s
              | _ -> raise( Failure("Illegal expression in tuple primitive") )) ^ string_of_tuple_primitive []
    | hd::tl -> (match hd with 
                    IntLit(i) -> string_of_int i ^ ", "
                  | FloatLit(f) -> string_of_float f ^ ", "
                  | StrLit(s) -> s ^ ", "
                  | CharLit(c) -> (String.make 1 c) ^ ", "
                  | BoolLit(true) -> "true" ^ ", "
                  | BoolLit(false) -> "false" ^ ", "
                  | Id(s) -> s
                  | _ -> raise( Failure("Illegal expression in tuple primitive") )) ^ string_of_tuple_primitive tl 
  in 
  "[" ^ string_of_tuple_primitive l

let rec string_of_expr = function
    IntLit(i) -> string_of_int i
  | FloatLit(f) -> string_of_float f 
  | StrLit(s) -> s 
  | CharLit(c) -> String.make 1 c  
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id(s) -> s
  | TuplePrimitive(l) -> string_of_tuple l
  | TupleAccess(s, i) -> s ^ "[" ^ string_of_int i ^ "]"
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""

let rec string_of_stmt = function
    Block(stmts) ->
      "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | If(e, s1, s2) ->  "if (" ^ string_of_expr e ^ ")\n" ^
      string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | For(e1, e2, e3, s) ->
      "for (" ^ string_of_expr e1  ^ " ; " ^ string_of_expr e2 ^ " ; " ^
      string_of_expr e3  ^ ") " ^ string_of_stmt s
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s

let string_of_typ = function
    DataType(Int) -> "int"
  | DataType(Float) -> "float" 
  | DataType(String) -> "string" 
  | DataType(Char) -> "char" 
  | DataType(Bool) -> "bool"
  | DataType(Void) -> "void"
  | TupleType(p, l) -> (match p with
                          Int -> "int" ^ "[" ^ (string_of_int l) ^ "]"
                        | Float -> "float" ^ "[" ^ (string_of_int l) ^ "]"
                        | Char -> "char" ^ "[" ^ (string_of_int l) ^ "]"
                        | String -> "string" ^ "[" ^ (string_of_int l) ^ "]"
                        | Bool -> "bool" ^ "[" ^ (string_of_int l) ^ "]"
                        | Void -> "void" ^ "[" ^ (string_of_int l) ^ "]")

let string_of_include_stmts = function 
  Include(filename) -> "#include" ^ " " ^ filename ^ ";\n"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_fdecl fdecl =
  string_of_typ fdecl.datatype ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_program (includes, vars, funcs) =
  String.concat ""   (List.map string_of_include_stmts includes) ^ "\n" ^ 
  String.concat "\n" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs)
