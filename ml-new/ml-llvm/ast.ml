(* Abstract-syntax Tree for ML *)

type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq |
          And | Or

type uop = Neg | Not

type primitive = Int | Float | String | Bool | Char | Void

type datatype =
   TupleType of primitive * int
 | MatrixType of datatype * int * int
 | DataType of primitive
 | PointerType of primitive

type var_dec = datatype * string

type include_stmt = Include of string

type expr =
    IntLit of int
  | CharLit of char
  | FloatLit of float
  | StrLit of string
  | BoolLit of bool
  | TupleAccess of string * expr
  | MatrixAccess of string * int * int
  | TupleLiteral of expr list
  | MatrixLiteral of expr list list
  | Length of string
  | Id of string
  | Binop of expr * op * expr
  | Unop of uop * expr
  | Assign of expr * expr
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

type program = var_dec list * func_decl list

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

let string_of_tuple t =
  let rec string_of_tuple_literal = function
      [] -> "]"
    | [hd] -> (match hd with
                IntLit(i) -> string_of_int i
              | FloatLit(f) -> string_of_float f
              | StrLit(s) -> s
              | CharLit(c) -> String.make 1 c
              | BoolLit(true) -> "true"
              | BoolLit(false) -> "false"
              | Id(s) -> s
              | _ -> raise( Failure("Illegal expression in tuple primitive") )) ^ string_of_tuple_literal []
    | hd::tl -> (match hd with
                    IntLit(i) -> string_of_int i ^ ", "
                  | FloatLit(f) -> string_of_float f ^ ", "
                  | StrLit(s) -> s ^ ", "
                  | CharLit(c) -> (String.make 1 c) ^ ", "
                  | BoolLit(true) -> "true" ^ ", "
                  | BoolLit(false) -> "false" ^ ", "
                  | Id(s) -> s
                  | _ -> raise( Failure("Illegal expression in tuple primitive") )) ^ string_of_tuple_literal tl
  in
  "[" ^ string_of_tuple_literal t

let string_of_matrix m r c =
  let rec string_of_matrix_literal = function
      [] -> "| " ^ string_of_int r ^ ", " ^ string_of_int c ^ "]"
    | [hd] -> (match hd with
                IntLit(i) -> string_of_int i
              | FloatLit(f) -> string_of_float f
              | StrLit(s) -> s
              | CharLit(c) -> String.make 1 c
              | BoolLit(true) -> "true"
              | BoolLit(false) -> "false"
              | Id(s) -> s
              | TupleLiteral(t) -> string_of_tuple t
              | _ -> raise( Failure("Illegal expression in matrix primitive") )) ^ string_of_matrix_literal []
    | hd::tl -> (match hd with
                    IntLit(i) -> string_of_int i ^ ", "
                  | FloatLit(f) -> string_of_float f ^ ", "
                  | StrLit(s) -> s ^ ", "
                  | CharLit(c) -> (String.make 1 c) ^ ", "
                  | BoolLit(true) -> "true" ^ ", "
                  | BoolLit(false) -> "false" ^ ", "
                  | Id(s) -> s
                  | TupleLiteral(t) -> string_of_tuple t ^ ", "
                  | _ -> raise( Failure("Illegal expression in matrix primitive") )) ^ string_of_matrix_literal tl
  in
  "[|" ^ string_of_matrix_literal m

let rec string_of_expr = function
    IntLit(i) -> string_of_int i
  | FloatLit(f) -> string_of_float f
  | StrLit(s) -> s
  | CharLit(c) -> String.make 1 c
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id(s) -> s
  | TupleLiteral(t) -> string_of_tuple t
  | MatrixLiteral(m) -> "string_of_matrix m r c"
  | TupleAccess(s, e) -> s ^ "[" ^ string_of_expr e ^ "]"
  | MatrixAccess(s, i1, i2) -> s ^ "[" ^ string_of_int i1 ^ ":" ^ string_of_int i2 ^ "]"
  | Length(s) -> "length" ^ "(" ^ s ^ ")"
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(e1, e2) -> string_of_expr e1 ^ " = " ^ string_of_expr e2
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
  | DataType(String) -> "str"
  | DataType(Char) -> "char"
  | DataType(Bool) -> "bool"
  | DataType(Void) -> "void"
  | TupleType(p, l) -> (match p with
                          Int -> "int" ^ "[" ^ string_of_int l ^ "]"
                        | Float -> "float" ^ "[" ^ string_of_int l ^ "]"
                        | Char -> "char" ^ "[" ^ string_of_int l ^ "]"
                        | String -> "string" ^ "[" ^ string_of_int l ^ "]"
                        | Bool -> "bool" ^ "[" ^ string_of_int l ^ "]"
                        | Void -> "void" ^ "[" ^ string_of_int l ^ "]")
  | MatrixType(t, l1, l2) -> (match t with
                                DataType(Int) -> "int" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                              | DataType(Float) -> "float" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                              | DataType(Char) -> "char" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                              | DataType(String) -> "string" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                              | DataType(Bool) -> "bool" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                              | DataType(Void) -> "void" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                              | TupleType(p, l) ->  (match p with
                                                        Int -> "int" ^ "[" ^ string_of_int l ^ "]" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                                                      | Float -> "float" ^ "[" ^ string_of_int l ^ "]" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                                                      | Char -> "char" ^ "[" ^ string_of_int l ^ "]" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                                                      | String -> "string" ^ "[" ^ string_of_int l ^ "]" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                                                      | Bool -> "bool" ^ "[" ^ string_of_int l ^ "]" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                                                      | Void -> "void" ^ "[" ^ string_of_int l ^ "]" ^ "[" ^ string_of_int l1 ^ ":" ^ string_of_int l2 ^ "]"
                                                    )
                              | _ -> raise ( Failure ("Illegal matrix of matrices") )
                            )
  | PointerType(Int) -> "int[]"
  | PointerType(Float) -> "float[]"
  | PointerType(String) -> "str[]"
  | PointerType(Char) -> "char[]"
  | PointerType(Bool) -> "bool[]"
  | PointerType(Void) -> "void[]"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_fdecl fdecl =
  string_of_typ fdecl.datatype ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_program (vars, funcs) =
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs)
