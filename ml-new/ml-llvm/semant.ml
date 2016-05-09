(* Semantic checking for the ML compiler *)

open Ast

module StringMap = Map.Make(String)

(* Semantic checking of a program. Returns void if successful,
   throws an exception if something is wrong.

   Check each global variable, then check each function *)

let check (globals, functions) =

  (* Raise an exception if the given list has a duplicate *)
  let report_duplicate exceptf list =
    let rec helper = function
	n1 :: n2 :: _ when n1 = n2 -> raise (Failure (exceptf n1))
      | _ :: t -> helper t
      | [] -> ()
    in helper (List.sort compare list)
  in

  (* Raise an exception if a given binding is to a void type *)
  let check_not_void exceptf = function
      (DataType(Void), n) -> raise (Failure (exceptf n))
    | _ -> ()
  in

  let check_assign lvaluet rvaluet err =
    match (lvaluet, rvaluet) with
      (DataType(Int), DataType(Int)) -> lvaluet
    | (DataType(Float), DataType(Float)) -> lvaluet
    | (DataType(Char), DataType(Char)) -> lvaluet
    | (DataType(String), DataType(String)) -> lvaluet
    | (DataType(String), DataType(String)) -> lvaluet
    | (DataType(Bool), DataType(Bool)) -> lvaluet
    | (DataType(Void), DataType(Void)) -> lvaluet
    | (TupleType(Int, l1), TupleType(Int, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(Float, l1), TupleType(Float, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(Char, l1), TupleType(Char, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(String, l1), TupleType(String, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(Bool, l1), TupleType(Bool, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(Void, l1), TupleType(Void, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (DataType(Int), TupleType(Int, _)) -> lvaluet
    | (PointerType(Int), TupleType(Int, _)) -> lvaluet
    | (PointerType(Float), TupleType(Float, _)) -> lvaluet
    | (PointerType(Char), TupleType(Char, _)) -> lvaluet
    | (PointerType(String), TupleType(String, _)) -> lvaluet
    | (PointerType(Bool), TupleType(Bool, _)) -> lvaluet
    | (PointerType(Void), TupleType(Void, _)) -> lvaluet
    | (TupleType(Int, _), PointerType(Int)) -> lvaluet
    | (TupleType(Float, _), PointerType(Float)) -> lvaluet
    | (TupleType(Char, _), PointerType(Float)) -> lvaluet
    | (TupleType(String, _), PointerType(String)) -> lvaluet
    | (TupleType(Bool, _), PointerType(Bool)) -> lvaluet
    | (TupleType(Void, _), PointerType(Void)) -> lvaluet
    | (MatrixType(DataType(Int), r1, c1), MatrixType(DataType(Int), r2, c2)) -> if r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(DataType(Float), r1, c1), MatrixType(DataType(Float), r2, c2)) -> if r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(DataType(Char), r1, c1), MatrixType(DataType(Char), r2, c2)) -> if r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(DataType(String), r1, c1), MatrixType(DataType(String), r2, c2)) -> if r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(DataType(Void), r1, c1), MatrixType(DataType(Void), r2, c2)) -> if r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(TupleType(Int, d1), r1, c1), MatrixType(TupleType(Int, d2), r2, c2)) -> if d1 == d2 && r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(TupleType(Float, d1), r1, c1), MatrixType(TupleType(Float, d2), r2, c2)) -> if d1 == d2 && r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(TupleType(Char, d1), r1, c1), MatrixType(TupleType(Char, d2), r2, c2)) -> if d1 == d2 && r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(TupleType(String, d1), r1, c1), MatrixType(TupleType(String, d2), r2, c2)) -> if d1 == d2 && r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(TupleType(Bool, d1), r1, c1), MatrixType(TupleType(Bool, d2), r2, c2)) -> if d1 == d2 && r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(TupleType(Void, d1), r1, c1), MatrixType(TupleType(Void, d2), r2, c2)) -> if d1 == d2 && r1 == r2 && c1 == c2 then lvaluet else raise err
    | (PointerType(Int), PointerType(Int)) -> lvaluet
    | (PointerType(Float), PointerType(Float)) -> lvaluet
    | (PointerType(Char), PointerType(Char)) -> lvaluet
    | (PointerType(String), PointerType(String)) -> lvaluet
    | (PointerType(Bool), PointerType(Bool)) -> lvaluet
    | (PointerType(Void), PointerType(Void)) -> lvaluet
    | (DoublePointerType(Int), DoublePointerType(Int)) -> lvaluet
    | (DoublePointerType(Float), DoublePointerType(Float)) -> lvaluet
    | (DoublePointerType(Char), DoublePointerType(Char)) -> lvaluet
    | (DoublePointerType(String), DoublePointerType(String)) -> lvaluet
    | (DoublePointerType(Bool), DoublePointerType(Bool)) -> lvaluet
    | (DoublePointerType(Void), DoublePointerType(Void)) -> lvaluet
    | _ -> raise err
  in

  (**** Checking Global Variables ****)

  List.iter (check_not_void (fun n -> "illegal void global " ^ n)) globals;

  report_duplicate (fun n -> "duplicate global " ^ n) (List.map snd globals);

  (**** Checking Functions ****)

  if List.mem "print" (List.map (fun fd -> fd.fname) functions)
  then raise (Failure ("function print may not be defined")) else ();

  if List.mem "open" (List.map (fun fd -> fd.fname) functions)
  then raise (Failure ("function open may not be defined")) else ();

  report_duplicate (fun n -> "duplicate function " ^ n)
  (List.map (fun fd -> fd.fname) functions);

  (* Function declaration for a named function *)
  let built_in_decls =  StringMap.add "print"
  { datatype = DataType(Void); fname = "print"; formals = [(DataType(Int), "x")];
  locals = []; body = [] } (StringMap.add "printb"
    { datatype = DataType(Void); fname = "printb"; formals = [(DataType(Bool), "x")];
    locals = []; body = [] } (StringMap.add "prints"
      { datatype = DataType(Void); fname = "prints"; formals = [(DataType(String), "s")];
      locals = []; body = [] } (StringMap.add "printf"
        { datatype = DataType(Void); fname = "printf"; formals = [(DataType(Float), "x")];
      locals = []; body = [] } (StringMap.singleton "open"
        { datatype = DataType(Void); fname = "open"; formals= [(DataType(String), "s")];
      locals = []; body = []}))))
  in

  let function_decls = List.fold_left (fun m fd -> StringMap.add fd.fname fd m)
  built_in_decls functions
  in

  let function_decl s = try StringMap.find s function_decls
  with Not_found -> raise (Failure ("unrecognized function " ^ s))
  in

  let _ = function_decl "main" in (* Ensure "main" is defined *)

  let check_function func =

    List.iter (check_not_void (fun n -> "illegal void formal " ^ n ^
      " in " ^ func.fname)) func.formals;

    report_duplicate (fun n -> "duplicate formal " ^ n ^ " in " ^ func.fname)
    (List.map snd func.formals);

    List.iter (check_not_void (fun n -> "illegal void local " ^ n ^
      " in " ^ func.fname)) func.locals;

    report_duplicate (fun n -> "duplicate local " ^ n ^ " in " ^ func.fname)
    (List.map snd func.locals);

    (* Type of each variable (global, formal, or local *)
      let symbols = List.fold_left (fun m (t, n) -> StringMap.add n t m)
      StringMap.empty (globals @ func.formals @ func.locals )
    in

    let type_of_identifier s =
    try StringMap.find s symbols
  with Not_found -> raise (Failure ("undeclared identifier " ^ s))
  in

  let type_of_tuple t =
    match (List.hd t) with
      IntLit _ -> TupleType(Int, List.length t)
    | FloatLit _ -> TupleType(Float, List.length t)
    | CharLit _ -> TupleType(Char, List.length t)
    | StrLit _ -> TupleType(String, List.length t)
    | BoolLit _ -> TupleType(Bool, List.length t)
    | Id s -> TupleType((match (type_of_identifier s) with
                            DataType(Int) -> Int
                          | DataType(Float) -> Float
                          | DataType(Char) -> Char
                          | DataType(String) -> String
                          | DataType(Bool) -> Bool
                          | _ -> raise (Failure ("illegal tuple type"))), List.length t)
    | _ -> raise (Failure ("illegal tuple type")) in

  let access_type = function
      TupleType(Int, _) -> DataType(Int)
    | TupleType(Float, _) -> DataType(Float)
    | TupleType(Char, _) -> DataType(Char)
    | TupleType(String, _) -> DataType(String)
    | TupleType(Bool, _) -> DataType(Void)
    | _ -> raise (Failure ("illegal access type")) in

  let type_of_matrix m r c =
    match (List.hd (List.hd m)) with
        IntLit _ -> MatrixType(DataType(Int), r, c)
      | FloatLit _ -> MatrixType(DataType(Float), r, c)
      | CharLit _ -> MatrixType(DataType(Char), r, c)
      | StrLit _ -> MatrixType(DataType(String), r, c)
      | BoolLit _ -> MatrixType(DataType(Bool), r, c)
      | Id s -> (match (type_of_identifier s) with
                    DataType(Int) -> MatrixType(DataType(Int), r, c)
                  | DataType(Float) -> MatrixType(DataType(Float), r, c)
                  | DataType(Char) -> MatrixType(DataType(Char), r, c)
                  | DataType(String) -> MatrixType(DataType(String), r, c)
                  | DataType(Bool) -> MatrixType(DataType(Bool), r, c)
                  | DataType(Void) -> MatrixType(DataType(Void), r, c)
                  | TupleType(p, l) -> (match p with
                                            Int -> MatrixType(TupleType(Int, l), r, c)
                                          | Float -> MatrixType(TupleType(Float, l), r, c)
                                          | Char -> MatrixType(TupleType(Char, l), r, c)
                                          | String -> MatrixType(TupleType(String, l), r, c)
                                          | Bool -> MatrixType(TupleType(Bool, l), r, c)
                                          | Void -> MatrixType(TupleType(Void, l), r, c)
                                       )
                  | _ -> raise (Failure ("illegal matrix type"))
                )
      | TupleLiteral t -> MatrixType((type_of_tuple) t, r, c)
      | _ -> raise (Failure ("illegal matrix type"))
  in

  let rec type_of_pointer = function
      DataType(Int) -> PointerType(Int)
    | DataType(Float) -> PointerType(Float)
    | DataType(Char) -> PointerType(Char)
    | DataType(String) -> PointerType(String)
    | DataType(Bool) -> PointerType(Bool)
    | DataType(Void) -> PointerType(Void)
    | TupleType(t, _) -> type_of_pointer (DataType(t))
    | MatrixType(t, _, _) ->  DoublePointerType(Int)
    | _ -> raise ( Failure ("illegal pointer type") ) in

  let pointer_type = function
    | PointerType(Int) -> DataType(Int)
    | PointerType(Float) -> DataType(Float)
    | PointerType(Char) -> DataType(Char)
    | PointerType(String) -> DataType(String)
    | PointerType(Bool) -> DataType(Bool)
    | PointerType(Void) -> DataType(Void)
    | _ -> raise ( Failure ("cannot dereference a non-pointer type") ) in

  (* Return the type of an expression or throw an exception *)
  let rec expr = function
    IntLit _ -> DataType(Int)
  | FloatLit _ -> DataType(Float)
  | CharLit _ -> DataType(Char)
  | StrLit _ -> DataType(String)
  | BoolLit _ -> DataType(Bool)
  | Id s -> type_of_identifier s
  | TupleLiteral t -> type_of_tuple t
  | MatrixLiteral m -> type_of_matrix m (List.length m) (List.length (List.hd m))
  | TupleAccess(s, _) -> access_type (type_of_identifier s)
  | MatrixAccess(s, _, _) -> type_of_identifier s
  | PointerIncrement(s) -> type_of_identifier s
  | Length(s) -> (match (type_of_identifier s) with TupleType(_, _) -> DataType(Int) | _ -> raise(Failure ("illegal expression in arguments of length()")))
  | Reference(s) -> type_of_pointer (type_of_identifier s)
  | Dereference(s) -> pointer_type (type_of_identifier s)
  | DoubleReference(s) -> DoublePointerType(Int)
  | Binop(e1, op, e2) as e -> let t1 = expr e1 and t2 = expr e2 in
  (match op with
      Add | Sub | Mult | Div when t1 = DataType(Int) && t2 = DataType(Int) -> DataType(Int)
    | Add | Sub | Mult | Div when t1 = DataType(Float) && t2 = DataType(Float) -> DataType(Float)
    | Equal | Neq when t1 = t2 -> DataType(Bool)
    | Less | Leq | Greater | Geq when t1 = DataType(Int) && t2 = DataType(Int) -> DataType(Bool)
    | Less | Leq | Greater | Geq when t1 = DataType(Float) && t2 = DataType(Float) -> DataType(Float)
    | And | Or when t1 = DataType(Bool) && t2 = DataType(Bool) -> DataType(Bool)
    | _ -> raise (Failure ("illegal binary operator " ^
      string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
      string_of_typ t2 ^ " in " ^ string_of_expr e))
  )
  | Unop(op, e) as ex -> let t = expr e in
  (match op with
      Neg when t = DataType(Int) -> DataType(Int)
    | Neg when t = DataType(Float) -> DataType(Float)
    | Not when t = DataType(Bool) -> DataType(Bool)
    | _ -> raise (Failure ("illegal unary operator " ^ string_of_uop op ^
      string_of_typ t ^ " in " ^ string_of_expr ex)))
  | Noexpr -> DataType(Void)
  | Assign(e1, e2) as ex -> let lt = (match e1 with
                                        TupleAccess(s, e) -> (match (expr e) with
                                                                DataType(Int) -> (match (type_of_identifier s) with
                                                                                    TupleType(p, _) -> (match p with
                                                                                                          Int -> DataType(Int)
                                                                                                        | Float -> DataType(Float)
                                                                                                        | Char -> DataType(Char)
                                                                                                        | String -> DataType(String)
                                                                                                        | Bool -> DataType(Bool)
                                                                                                        | Void -> DataType(Void)
                                                                                                       )
                                                                                 )
                                                                | _ -> raise ( Failure ("expression is not of type int") )
                                                             )
                                      | MatrixAccess(s, i1, i2) -> (match (type_of_identifier s) with
                                                                      MatrixType(t, l1, l2) -> (match t with
                                                                                                    DataType(Int) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Int)
                                                                                                  | DataType(Float) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Float)
                                                                                                  | DataType(Char) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Char)
                                                                                                  | DataType(String) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(String)
                                                                                                  | DataType(Bool) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Bool)
                                                                                                  | DataType(Void) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Void)
                                                                                                  | TupleType(p, l) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else TupleType(p, l)
                                                                                                  | _ -> raise ( Failure ("illegal matrix of matrices") )
                                                                                                )
                                                                      | _ -> raise ( Failure ("cannot access a primitive") )
                                                                   )
                                      | _ -> expr e1)
                            and rt = (match e2 with
                                        TupleAccess(s, e) -> (match (expr e) with
                                                                DataType(Int) -> (match (type_of_identifier s) with
                                                                                    TupleType(p, _) -> (match p with
                                                                                                          Int -> DataType(Int)
                                                                                                        | Float -> DataType(Float)
                                                                                                        | Char -> DataType(Char)
                                                                                                        | String -> DataType(String)
                                                                                                        | Bool -> DataType(Bool)
                                                                                                        | Void -> DataType(Void)
                                                                                                       )
                                                                                 )
                                                                | _ -> raise ( Failure ("expression is not have of int") )
                                                             )
                                      | MatrixAccess(s, i1, i2) -> (match (type_of_identifier s) with
                                                                      MatrixType(t, l1, l2) -> (match t with
                                                                                                  DataType(Int) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Int)
                                                                                                | DataType(Float) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Float)
                                                                                                | DataType(Char) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Char)
                                                                                                | DataType(String) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(String)
                                                                                                | DataType(Bool) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Bool)
                                                                                                | DataType(Void) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else DataType(Void)
                                                                                                | TupleType(p, l) -> if i1 > l1 - 1 || i2 > l2 - 1 then raise ( Failure ("accessing out of bounds element") ) else TupleType(p, l)
                                                                                                | _ -> raise ( Failure ("illegal matrix of matrices") )
                                                                                              )
                                                                      | _ -> raise ( Failure ("cannot access a primitive") )
                                                                   )
                                      | _ -> expr e2) in
  check_assign lt rt (Failure ("illegal assignment " ^ string_of_typ lt ^
    " = " ^ string_of_typ rt ^ " in " ^
  string_of_expr ex))
  | Call(fname, actuals) as call -> let fd = function_decl fname in
  if List.length actuals != List.length fd.formals then
   raise (Failure ("expecting " ^ string_of_int
     (List.length fd.formals) ^ " arguments in " ^ string_of_expr call))
  else
   List.iter2 (fun (ft, _) e -> let et = expr e in
    ignore (check_assign ft et
      (Failure ("illegal actual argument found " ^ string_of_typ et ^
        " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e))))
   fd.formals actuals;
   fd.datatype
  in

  let check_bool_expr e =
    match (expr e) with
      DataType(Bool) -> ()
    | _ -> raise (Failure ("expected Boolean expression in " ^ string_of_expr e))
  in

  (* Verify a statement or throw an exception *)
  let rec stmt = function
  Block sl -> let rec check_block = function
  [Return _ as s] -> stmt s
  | Return _ :: _ -> raise (Failure "nothing may follow a return")
  | Block sl :: ss -> check_block (sl @ ss)
  | s :: ss -> stmt s ; check_block ss
  | [] -> ()
  in check_block sl
  | Expr e -> ignore (expr e)
  | Return e -> let t = expr e in if t = func.datatype then () else
  raise (Failure ("return gives " ^ string_of_typ t ^ " expected " ^
   string_of_typ func.datatype ^ " in " ^ string_of_expr e))

  | If(p, b1, b2) -> check_bool_expr p; stmt b1; stmt b2
  | For(e1, e2, e3, st) -> ignore (expr e1); check_bool_expr e2;
  ignore (expr e3); stmt st
  | While(p, s) -> check_bool_expr p; stmt s
  in

  stmt (Block func.body)

  in
  List.iter check_function functions
