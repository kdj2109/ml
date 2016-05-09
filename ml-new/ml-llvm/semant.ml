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
    | (DataType(Bool), DataType(Bool)) -> lvaluet
    | (DataType(Void), DataType(Void)) -> lvaluet
    | (TupleType(Int, l1), TupleType(Int, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(Float, l1), TupleType(Float, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(Char, l1), TupleType(Char, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(String, l1), TupleType(String, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(Bool, l1), TupleType(Bool, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TupleType(Void, l1), TupleType(Void, l2)) -> if l1 == l2 then lvaluet else if l1 == 0 then lvaluet else raise err
    | (TuplePointerType(Int), TupleType(Int, _)) -> lvaluet
    | (TuplePointerType(Float), TupleType(Float, _)) -> lvaluet
    | (TuplePointerType(Char), TupleType(Char, _)) -> lvaluet
    | (TuplePointerType(String), TupleType(String, _)) -> lvaluet
    | (TuplePointerType(Bool), TupleType(Bool, _)) -> lvaluet
    | (TuplePointerType(Void), TupleType(Void, _)) -> lvaluet
    | (TupleType(Int, _), TuplePointerType(Int)) -> lvaluet
    | (TupleType(Float, _), TuplePointerType(Float)) -> lvaluet
    | (TupleType(Char, _), TuplePointerType(Float)) -> lvaluet
    | (TupleType(String, _), TuplePointerType(String)) -> lvaluet
    | (TupleType(Bool, _), TuplePointerType(Bool)) -> lvaluet
    | (TupleType(Void, _), TuplePointerType(Void)) -> lvaluet
    | (MatrixType(DataType(Int), _, _), MatrixPointerType(Int)) -> lvaluet
    | (MatrixType(DataType(Float), _, _), MatrixPointerType(Float)) -> lvaluet
    | (MatrixPointerType(Int), MatrixType(DataType(Int), _, _)) -> lvaluet
    | (MatrixPointerType(Float), MatrixType(DataType(Float), _, _)) -> lvaluet
    | (MatrixType(TupleType(Int, _), _, _), MatrixTuplePointerType(Int)) -> lvaluet
    | (MatrixType(TupleType(Float, _), _, _), MatrixTuplePointerType(Float)) -> lvaluet
    | (MatrixTuplePointerType(Int), MatrixType(TupleType(Int, _), _, _)) -> lvaluet
    | (MatrixTuplePointerType(Float), MatrixType(TupleType(Float, _), _, _)) -> lvaluet
    | (MatrixType(DataType(Int), r1, c1), MatrixType(DataType(Int), r2, c2)) -> if r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(DataType(Float), r1, c1), MatrixType(DataType(Float), r2, c2)) -> if r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(TupleType(Int, d1), r1, c1), MatrixType(TupleType(Int, d2), r2, c2)) -> if d1 == d2 && r1 == r2 && c1 == c2 then lvaluet else raise err
    | (MatrixType(TupleType(Float, d1), r1, c1), MatrixType(TupleType(Float, d2), r2, c2)) -> if d1 == d2 && r1 == r2 && c1 == c2 then lvaluet else raise err
    | (TuplePointerType(Int), TuplePointerType(Int)) -> lvaluet
    | (TuplePointerType(Float), TuplePointerType(Float)) -> lvaluet
    | (TuplePointerType(Char), TuplePointerType(Char)) -> lvaluet
    | (TuplePointerType(String), TuplePointerType(String)) -> lvaluet
    | (TuplePointerType(Bool), TuplePointerType(Bool)) -> lvaluet
    | (TuplePointerType(Void), TuplePointerType(Void)) -> lvaluet
    | (MatrixPointerType(Int), MatrixPointerType(Int)) -> lvaluet
    | (MatrixPointerType(Float), MatrixPointerType(Float)) -> lvaluet
    | (MatrixTuplePointerType(Int), MatrixTuplePointerType(Int)) -> lvaluet
    | (MatrixTuplePointerType(Float), MatrixTuplePointerType(Float)) -> lvaluet
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

  let matrix_acces_type = function
      MatrixType(t, _, _) -> t
    | _ -> raise (Failure ("illegal matrix access") ) in

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
      DataType(Int) -> TuplePointerType(Int)
    | DataType(Float) -> TuplePointerType(Float)
    | DataType(Char) -> TuplePointerType(Char)
    | DataType(String) -> TuplePointerType(String)
    | DataType(Bool) -> TuplePointerType(Bool)
    | DataType(Void) -> TuplePointerType(Void)
    | TupleType(t, _) -> type_of_pointer (DataType(t))
    | MatrixType(t, _, _) -> (match t with
                                DataType(t) -> MatrixPointerType(t)
                              | TupleType(t, _) -> MatrixTuplePointerType(t)
                              | _ -> raise (Failure ("illegal matrix pointer type"))
                             )
    | _ -> raise ( Failure ("illegal pointer type") )
  in

  let pointer_type = function
    | TuplePointerType(Int) -> DataType(Int)
    | TuplePointerType(Float) -> DataType(Float)
    | TuplePointerType(Char) -> DataType(Char)
    | TuplePointerType(String) -> DataType(String)
    | TuplePointerType(Bool) -> DataType(Bool)
    | TuplePointerType(Void) -> DataType(Void)
    | MatrixPointerType(t) -> DataType(t)
    | MatrixTuplePointerType(t) -> DataType(t)
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
  | MatrixAccess(s, _, _) -> matrix_acces_type (type_of_identifier s)
  | PointerIncrement(s) -> type_of_identifier s
  | Length(s) -> (match (type_of_identifier s) with TupleType(_, _) -> DataType(Int) | _ -> raise(Failure ("illegal expression in arguments of length()")))
  | TupleReference(s) -> type_of_pointer (type_of_identifier s)
  | Dereference(s) -> pointer_type (type_of_identifier s)
  | MatrixReference(s) -> type_of_pointer (type_of_identifier s)
  | MatrixTupleReference(s) -> type_of_pointer (type_of_identifier s)
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
                                                                                   | _ -> raise ( Failure ("cannot access a non-tuple type") )
                                                                                 )
                                                                | _ -> raise ( Failure ("expression is not of type int") )
                                                             )
                                      | MatrixAccess(s, _, _) -> (match (type_of_identifier s) with
                                                                      MatrixType(t, _, _) -> (match t with
                                                                                                    DataType(Int) -> DataType(Int)
                                                                                                  | DataType(Float) -> DataType(Float)
                                                                                                  | DataType(Char) -> DataType(Char)
                                                                                                  | DataType(String) -> DataType(String)
                                                                                                  | DataType(Bool) -> DataType(Bool)
                                                                                                  | DataType(Void) -> DataType(Void)
                                                                                                  | TupleType(p, l) -> TupleType(p, l)
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
                                                                                   | _ -> raise ( Failure ("cannot access a non-tuple type") )
                                                                                 )
                                                                | _ -> raise ( Failure ("expression is not of datatype int") )
                                                             )
                                      | MatrixAccess(s, _, _) -> (match (type_of_identifier s) with
                                                                      MatrixType(t, _, _) -> (match t with
                                                                                                  DataType(Int) -> DataType(Int)
                                                                                                | DataType(Float) -> DataType(Float)
                                                                                                | DataType(Char) -> DataType(Char)
                                                                                                | DataType(String) -> DataType(String)
                                                                                                | DataType(Bool) -> DataType(Bool)
                                                                                                | DataType(Void) -> DataType(Void)
                                                                                                | TupleType(p, l) -> TupleType(p, l)
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
