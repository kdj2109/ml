(* Code generation: translate takes a semantically checked AST and
produces LLVM IR

LLVM tutorial: Make sure to read the OCaml version of the tutorial

http://llvm.org/docs/tutorial/index.html

Detailed documentation on the OCaml LLVM library:

http://llvm.moe/
http://llvm.moe/ocaml/

*)
module L = Llvm
module A = Ast
open Exceptions

module StringMap = Map.Make(String)

let translate (globals, functions) =
  let context = L.global_context () in
  let the_module = L.create_module context "ML"
  and i32_t     = L.i32_type   context
  and float_t   = L.double_type context
  and i8_t      = L.i8_type    context
  and pointer_t = L.pointer_type
  and array_t   = L.array_type
  and i1_t      = L.i1_type    context
  and void_t    = L.void_type  context in

  let ltype_of_typ = function
      A.DataType(A.Int)      -> i32_t
    | A.DataType(A.Float)    -> float_t
    | A.DataType(A.Char)     -> i8_t
    | A.DataType(A.String)   -> pointer_t i8_t
    | A.DataType(A.Bool)     -> i1_t
    | A.DataType(A.Void)     -> void_t
    | A.TupleType(typ, size) -> (match typ with
                                   A.Int    -> array_t i32_t size
                                 | A.Float  -> array_t float_t size
                                 | A.Char   -> array_t i8_t size
                                 | A.String -> array_t (pointer_t i8_t) size
                                 | A.Bool   -> array_t i1_t size
                                 | A.Void   -> array_t void_t size)
    | A.MatrixType(typ, size1, size2) -> (match typ with
                                            A.DataType(A.Int) -> array_t (array_t i32_t size2) size1
                                          | A.DataType(A.Float) -> array_t (array_t float_t size2) size1
                                          (*| A.DataType(A.Char) -> array_t i8_t (size1 * size2)
                                          | A.DataType(A.String) -> array_t (pointer_t i8_t) (size1 * size2)
                                          | A.DataType(A.Bool) -> array_t i1_t (size1 * size2)
                                          | A.DataType(A.Void) -> array_t void_t (size1 * size2)*)
                                          | A.TupleType(typ1, size3) -> (match typ1 with
                                                                         | A.Int -> array_t (array_t (array_t i32_t size3) size2) size1
                                                                         | A.Float -> array_t (array_t (array_t float_t size3) size2) size1
                                                                         | _ -> raise (UnsupportedMatrixType)
                                                                         (*| A.Char -> array_t i8_t (size1 * size2 * size3)
                                                                         | A.String -> array_t (pointer_t i8_t) (size1 * size2 * size3)
                                                                         | A.Bool -> array_t i1_t (size1 * size2 * size3)
                                                                         | A.Void -> array_t void_t (size1 * size2 * size3)*)
                                                                        )
                                          | _ -> raise ( UnsupportedMatrixType )
                                         )
    | A.TuplePointerType(t) | A.MatrixPointerType(t) | A.MatrixTuplePointerType(t) -> (match t with
                                                                                         A.Int -> pointer_t i32_t
                                                                                       | A.Float -> pointer_t float_t
                                                                                       | A.Char -> pointer_t i8_t
                                                                                       | A.String -> pointer_t (pointer_t i8_t)
                                                                                       | A.Bool -> pointer_t i1_t
                                                                                       | A.Void -> pointer_t void_t)
    in

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let global_var m (t, n) =
      let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty globals in

  (* Declare printf(), which the print built-in function will call *)
  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func = L.declare_function "printf" printf_t the_module in

  (* Define each function (arguments and return type) so we can call it *)
  let function_decls =
    let function_decl m fdecl =
      let name = fdecl.A.fname
      and formal_types =
	Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.A.formals)
      in let ftype = L.function_type (ltype_of_typ fdecl.A.datatype) formal_types in
      StringMap.add name (L.define_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty functions in

  (* Fill in the body of the given function *)
  let build_function_body fdecl =
    let (the_function, _) = StringMap.find fdecl.A.fname function_decls in
    let builder = L.builder_at_end context (L.entry_block the_function) in

    let int_format_str   = L.build_global_stringptr "%d\n" "fmt" builder
    and float_format_str = L.build_global_stringptr "%f\n" "fmt" builder in

    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let local_vars =
      let add_formal m (t, n) p = L.set_value_name n p;
	let local = L.build_alloca (ltype_of_typ t) n builder in
	ignore (L.build_store p local builder);
	StringMap.add n local m in

      let add_local m (t, n) =
	let local_var = L.build_alloca (ltype_of_typ t) n builder
	in StringMap.add n local_var m in

      let formals = List.fold_left2 add_formal StringMap.empty fdecl.A.formals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local formals fdecl.A.locals in

    (* Return the value for a variable or formal argument *)
    let lookup n = try StringMap.find n local_vars
                   with Not_found -> StringMap.find n global_vars
    in

    let check_function func =
      (* Type of each variable (global, formal, or local *)
        List.fold_left (fun m (t, n) -> StringMap.add n t m)
        StringMap.empty (globals @ func.A.formals @ func.A.locals)
      in

    let rec type_of_identifier s i =
      let symbols = check_function (List.nth functions i) in
      try StringMap.find s symbols
      with Not_found -> type_of_identifier s (succ i)
    in

    let get_tuple_type tuple =
      match (List.hd tuple) with
        A.IntLit _ -> ltype_of_typ (A.DataType(A.Int))
      | A.FloatLit _ -> ltype_of_typ (A.DataType(A.Float))
      | A.CharLit _ -> ltype_of_typ (A.DataType(A.Char))
      | A.StrLit _ -> ltype_of_typ (A.DataType(A.String))
      | A.BoolLit _ -> ltype_of_typ (A.DataType(A.Bool))
      | _ -> raise (UnsupportedTupleType) in

    let build_matrix_access s i1 i2 i3 builder isAssign =
      if isAssign
        then L.build_gep (lookup s) [| i1; i2; i3 |] s builder
      else
         L.build_load (L.build_gep (lookup s) [| i1; i2; i3 |] s builder) s builder
    in

    let build_tuple_access s i1 i2 builder isAssign =
      if isAssign
        then L.build_gep (lookup s) [| i1; i2 |] s builder
      else
         L.build_load (L.build_gep (lookup s) [| i1; i2 |] s builder) s builder
    in

    let build_tuple_argument s builder =
      L.build_in_bounds_gep (lookup s) [| L.const_int i32_t 0; L.const_int i32_t 0 |] s builder
    in

    let build_matrix_argument s builder =
      L.build_in_bounds_gep (lookup s) [| L.const_int i32_t 0; L.const_int i32_t 0; L.const_int i32_t 0 |] s builder
    in

    let build_matrix_tuple_argument s builder =
      L.build_in_bounds_gep (lookup s) [| L.const_int i32_t 0; L.const_int i32_t 0; L.const_int i32_t 0; L.const_int i32_t 0 |] s builder
    in

    let build_pointer_dereference s builder isAssign =
      if isAssign
        then L.build_load (lookup s) s builder
      else
        L.build_load (L.build_load (lookup s) s builder) s builder
    in

    let build_pointer_increment s builder isAssign =
      if isAssign
        then L.build_load (L.build_in_bounds_gep (lookup s) [| L.const_int i32_t 1 |] s builder) s builder
      else
        L.build_in_bounds_gep (L.build_load (L.build_in_bounds_gep (lookup s) [| L.const_int i32_t 0 |] s builder) s builder) [| L.const_int i32_t 1 |] s builder
    in

    (* Construct code for an expression; return its value *)
    let rec expr builder = function
	      A.IntLit i -> L.const_int i32_t i
      | A.FloatLit f -> L.const_float float_t f
      | A.CharLit c -> L.const_int i8_t (Char.code c)
      | A.StrLit s -> L.const_string context s
      | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
      | A.TupleLiteral t -> L.const_array (get_tuple_type t) (Array.of_list (List.map (expr builder) t))
      | A.TupleAccess(s, e) -> let i = expr builder e in build_tuple_access s (L.const_int i32_t 0) i builder false
      | A.MatrixLiteral m -> (match (List.hd (List.hd m)) with
                                A.FloatLit _ -> let realOrder=List.map List.rev m in let i32Lists = List.map (List.map (expr builder)) realOrder in let listOfArrays=List.map Array.of_list i32Lists in let i32ListOfArrays = List.map (L.const_array float_t) listOfArrays in let arrayOfArrays=Array.of_list i32ListOfArrays in L.const_array (array_t float_t (List.length (List.hd m))) arrayOfArrays
                              | A.IntLit _ -> let realOrder=List.map List.rev m in let i32Lists = List.map (List.map (expr builder)) realOrder in let listOfArrays=List.map Array.of_list i32Lists in let i32ListOfArrays = List.map (L.const_array i32_t) listOfArrays in let arrayOfArrays=Array.of_list i32ListOfArrays in L.const_array (array_t i32_t (List.length (List.hd m))) arrayOfArrays
                              | A.TupleLiteral t -> let realOrder=List.map List.rev m in let i32Lists = List.map (List.map (expr builder)) realOrder in let listOfArrays=List.map Array.of_list i32Lists in let i32ListOfArrays = List.map (L.const_array (array_t (get_tuple_type t) (List.length t))) listOfArrays in let arrayOfArrays=Array.of_list i32ListOfArrays in L.const_array (array_t (array_t (get_tuple_type t) (List.length t)) (List.length (List.hd m))) arrayOfArrays
                              )
      | A.MatrixAccess (s, e1, e2) -> let i1 = expr builder e1 and i2 = expr builder e2 in build_matrix_access s (L.const_int i32_t 0) i1 i2 builder false
      | A.PointerIncrement (s) ->  build_pointer_increment s builder false
      | A.Length (s) -> L.const_int i32_t (L.array_length (ltype_of_typ (type_of_identifier s 0)))
      | A.TupleReference (s) -> build_tuple_argument s builder
      | A.Dereference (s) -> build_pointer_dereference s builder false
      | A.MatrixReference (s) -> build_matrix_argument s builder
      | A.MatrixTupleReference (s) -> build_matrix_tuple_argument s builder
      | A.Noexpr -> L.const_int i32_t 0
      | A.Id s -> L.build_load (lookup s) s builder
      | A.Binop (e1, op, e2) ->
      let e1' = expr builder e1
      and e2' = expr builder e2 in

      let float_bops operator =
        match operator with
          A.Add     -> L.build_fadd e1' e2' "tmp" builder
        | A.Sub     -> L.build_fsub e1' e2' "tmp" builder
        | A.Mult    -> L.build_fmul e1' e2' "tmp" builder
        | A.Div     -> L.build_fdiv e1' e2' "tmp" builder
        | A.And     -> L.build_and e1' e2' "tmp" builder
        | A.Or      -> L.build_or e1' e2' "tmp" builder
        | A.Equal   -> L.build_fcmp L.Fcmp.Oeq e1' e2' "tmp" builder
        | A.Neq     -> L.build_fcmp L.Fcmp.One e1' e2' "tmp" builder
        | A.Less    -> L.build_fcmp L.Fcmp.Olt e1' e2' "tmp" builder
        | A.Leq     -> L.build_fcmp L.Fcmp.Ole e1' e2' "tmp" builder
        | A.Greater -> L.build_fcmp L.Fcmp.Ogt e1' e2' "tmp" builder
        | A.Geq     -> L.build_fcmp L.Fcmp.Oge e1' e2' "tmp" builder
      in

      let int_bops operator =
        match operator with
          A.Add     -> L.build_add e1' e2' "tmp" builder
        | A.Sub     -> L.build_sub e1' e2' "tmp" builder
        | A.Mult    -> L.build_mul e1' e2' "tmp" builder
        | A.Div     -> L.build_sdiv e1' e2' "tmp" builder
        | A.And     -> L.build_and e1' e2' "tmp" builder
        | A.Or      -> L.build_or e1' e2' "tmp" builder
        | A.Equal   -> L.build_icmp L.Icmp.Eq e1' e2' "tmp" builder
        | A.Neq     -> L.build_icmp L.Icmp.Ne e1' e2' "tmp" builder
        | A.Less    -> L.build_icmp L.Icmp.Slt e1' e2' "tmp" builder
        | A.Leq     -> L.build_icmp L.Icmp.Sle e1' e2' "tmp" builder
        | A.Greater -> L.build_icmp L.Icmp.Sgt e1' e2' "tmp" builder
        | A.Geq     -> L.build_icmp L.Icmp.Sge e1' e2' "tmp" builder
      in

      (*(let create_binops e1 e2 =
        match (e1, e2) with
          A.IntLit e1, A.IntLit e2 -> let e1' = L.const_int i32_t e1
                                      and e2' = L.const_int i32_t e2 in
                                      int_bops op e1' e2'
        | A.FloatLit e1, A.FloatLit e2 -> let e1' = L.const_float float_t e1
                                          and e2' = L.const_float float_t e2 in
                                          float_bops op e1' e2'
        | A.Id e1, A.Id e2 -> let e1' = L.build_load (lookup e1) e1 builder
                              and e2' = L.build_load (lookup e2) e2 builder in
                              (*let match_vars e1 e2 =
                                (match ((lookup e1), (lookup e2)) with
                                   i32_t, i32_t -> int_bops op e1' e1'
                                 | float_t, float_t -> float_bops op e1' e2') in
                              match_vars e1 e2*)
                              int_bops op e1' e2'
        | _ -> raise(UnsuppotedBinOp)
      in

      create_binops e1 e2 *)

      let string_of_e1'_llvalue = L.string_of_llvalue e1'
      and string_of_e2'_llvalue = L.string_of_llvalue e2' in

      let space = Str.regexp " " in

      let list_of_e1'_llvalue = Str.split space string_of_e1'_llvalue
      and list_of_e2'_llvalue = Str.split space string_of_e2'_llvalue in

      let i32_re = Str.regexp "i32\\|i32*\\|i8\\|i8*\\|i1\\|i1*"
      and float_re = Str.regexp "double\\|double*" in

      let rec match_string regexp str_list i =
         let length = List.length str_list in
         match (Str.string_match regexp (List.nth str_list i) 0) with
           true -> true
         | false -> if (i > length - 2) then false else match_string regexp str_list (succ i) in

      let get_type llvalue =
         match (match_string i32_re llvalue 0) with
           true  -> "int"
         | false -> (match (match_string float_re llvalue 0) with
                       true -> "float"
                     | false -> "") in

      let e1'_type = get_type list_of_e1'_llvalue
      and e2'_type = get_type list_of_e2'_llvalue in

      let build_ops_with_types typ1 typ2 =
        match (typ1, typ2) with
          "int", "int" -> int_bops op
        | "float" , "float" -> float_bops op
        | _, _ -> raise(UnsupportedBinaryOperationOnTypes (typ1, typ2))
      in

      build_ops_with_types e1'_type e2'_type
      | A.Unop(op, e) ->
	      let e' = expr builder e in

        let float_uops operator =
          match operator with
            A.Neg -> L.build_fneg e' "tmp" builder
          | A.Not -> raise(UnsupportedUnaryOperationOnFloat)  in

        let int_uops operator =
          match operator with
            A.Neg -> L.build_neg e' "tmp" builder
          | A.Not -> L.build_not e' "tmp" builder in

        let string_of_e'_llvalue = L.string_of_llvalue e' in

        let space = Str.regexp " " in

        let list_of_e'_llvalue = Str.split space string_of_e'_llvalue in

        let i32_re = Str.regexp "i32\\|i32*\\|i8\\|i8*\\|i1\\|i1*"
        and float_re = Str.regexp "double\\|double*" in

        let rec match_string regexp str_list i =
           let length = List.length str_list in
           match (Str.string_match regexp (List.nth str_list i) 0) with
             true -> true
           | false -> if (i > length - 2) then false else match_string regexp str_list (succ i) in

        let get_type llvalue =
           match (match_string i32_re llvalue 0) with
             true  -> "int"
           | false -> (match (match_string float_re llvalue 0) with
                         true -> "float"
                       | false -> "") in

        let e'_type = get_type list_of_e'_llvalue  in

        let build_ops_with_type typ =
          match typ with
            "int" -> int_uops op
          | "float" -> float_uops op
          | _ -> raise(UnsupportedUnaryOperationOnType typ)
        in

        build_ops_with_type e'_type
      | A.Assign (e1, e2) -> let e1' = (match e1 with
                                            Id s -> lookup s
                                          | A.TupleAccess(s, e) -> let i = (match e with A.IntLit i -> L.const_int i32_t i | A.Id s -> L.build_load (lookup s) s builder) in build_tuple_access s (L.const_int i32_t 0) i builder true
                                          | A.MatrixAccess (s, e1, e2) -> let i1 = expr builder e1 and i2 = expr builder e2 in build_matrix_access s (L.const_int i32_t 0) i1 i2 builder true
                                          | A.PointerIncrement(s) -> build_pointer_increment s builder true
                                          | A.Dereference(s) -> build_pointer_dereference s builder true
                                          | _ -> raise (IllegalAssignment))
                             and e2' = expr builder e2 in
	                   ignore (L.build_store e2' e1' builder); e2'
      | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
	  L.build_call printf_func [| int_format_str ; (expr builder e) |]
	    "printf" builder
      | A.Call ("prints", [e]) -> let get_string = function A.StrLit s -> s | _ -> "" in
      let s_ptr = L.build_global_stringptr ((get_string e) ^ "\n") ".str" builder in
    L.build_call printf_func [| s_ptr |]
      "printf" builder
      | A.Call ("printf", [e]) ->
    L.build_call printf_func [| float_format_str ; (expr builder e) |]
      "printf" builder
      | A.Call (f, act) ->
         let (fdef, fdecl) = StringMap.find f function_decls in
	 let actuals = List.rev (List.map (expr builder) (List.rev act)) in
	 let result = (match fdecl.A.datatype with A.DataType(A.Void) -> ""
                                            | _ -> f ^ "_result") in
         L.build_call fdef (Array.of_list actuals) result builder
    in

    (* Invoke "f builder" if the current block doesn't already
       have a terminal (e.g., a branch). *)
    let add_terminal builder f =
      match L.block_terminator (L.insertion_block builder) with
	Some _ -> ()
      | None -> ignore (f builder) in

    (* Build the code for the given statement; return the builder for
       the statement's successor *)
    let rec stmt builder = function
	A.Block sl -> List.fold_left stmt builder sl
      | A.Expr e -> ignore (expr builder e); builder
      | A.Return e -> ignore (match fdecl.A.datatype with
	  A.DataType(A.Void) -> L.build_ret_void builder
	| _ -> L.build_ret (expr builder e) builder); builder
      | A.If (predicate, then_stmt, else_stmt) ->
         let bool_val = expr builder predicate in
	 let merge_bb = L.append_block context "merge" the_function in

	 let then_bb = L.append_block context "then" the_function in
	 add_terminal (stmt (L.builder_at_end context then_bb) then_stmt)
	   (L.build_br merge_bb);

	 let else_bb = L.append_block context "else" the_function in
	 add_terminal (stmt (L.builder_at_end context else_bb) else_stmt)
	   (L.build_br merge_bb);

	 ignore (L.build_cond_br bool_val then_bb else_bb builder);
	 L.builder_at_end context merge_bb

      | A.While (predicate, body) ->
	  let pred_bb = L.append_block context "while" the_function in
	  ignore (L.build_br pred_bb builder);

	  let body_bb = L.append_block context "while_body" the_function in
	  add_terminal (stmt (L.builder_at_end context body_bb) body)
	    (L.build_br pred_bb);

	  let pred_builder = L.builder_at_end context pred_bb in
	  let bool_val = expr pred_builder predicate in

	  let merge_bb = L.append_block context "merge" the_function in
	  ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
	  L.builder_at_end context merge_bb

      | A.For (e1, e2, e3, body) -> stmt builder
	    ( A.Block [A.Expr e1 ; A.While (e2, A.Block [body ; A.Expr e3]) ] )
    in

    (* Build the code for each statement in the function *)
    let builder = stmt builder (A.Block fdecl.A.body) in

    (* Add a return if the last block falls off the end *)
    add_terminal builder (match fdecl.A.datatype with
        A.DataType(A.Int) -> L.build_ret (L.const_int i32_t 0)
      | A.DataType(A.Float) -> L.build_ret (L.const_float float_t 0.0)
      | A.DataType(A.Char) -> L.build_ret (L.const_int i8_t 0)
      | A.DataType(A.String) -> L.build_ret (L.const_string context "")
      | A.DataType(A.Bool) -> L.build_ret (L.const_int i1_t 0)
      | A.DataType(A.Void) -> L.build_ret_void
      | A.TupleType(t, _) -> (match t with
                                A.Int -> L.build_ret (L.const_array i32_t [| L.const_int i32_t 0 |])
                              | A.Float -> L.build_ret (L.const_array float_t [| L.const_float float_t 0.0 |])
                              | A.Char -> L.build_ret (L.const_array i8_t  [| L.const_int i8_t 0 |])
                              | A.String -> L.build_ret (L.const_array (pointer_t i8_t) [| L.const_string context "" |])
                              | A.Bool -> L.build_ret (L.const_array i1_t [| L.const_int i1_t 0 |])
                              | A.Void -> L.build_ret_void)
      | A.MatrixType(typ, size1, size2) -> L.build_ret ( match typ with
                                A.DataType(A.Float) -> let m= [[0.0;0.0];[0.0;0.0]] in let realOrder= List.map List.rev m in let i32Lists = List.map (List.map (L.const_float float_t)) realOrder in let listOfArrays=List.map Array.of_list i32Lists in let i32ListOfArrays = List.map (L.const_array float_t) listOfArrays in let arrayOfArrays=Array.of_list i32ListOfArrays in L.const_array (array_t float_t (2)) arrayOfArrays
                              | A.DataType(A.Int) -> let m= [[0;0];[0;0]] in let realOrder=List.map List.rev m in let i32Lists = List.map (List.map (L.const_int i32_t)) realOrder in let listOfArrays=List.map Array.of_list i32Lists in let i32ListOfArrays = List.map (L.const_array i32_t) listOfArrays in let arrayOfArrays=Array.of_list i32ListOfArrays in L.const_array (array_t i32_t (List.length (List.hd m))) arrayOfArrays
                            )
      (*| A.MatrixType(t, r, c) -> (match t with
                                    A.DataType(A.Int) -> L.build_ret (array_t (array_t i32_t r) c)
                                  | A.DataType(A.Float) -> L.build_ret (L.const_array (L.const_array float_t r) c)
                                  | A.DataType(A.Char) -> L.build_ret (L.const_array (L.const_array i8_t r) c)
                                  | A.DataType(A.String) -> L.build_ret (L.const_array (L.const_array (pointer_t i8_t) r) c)
                                  | A.DataType(A.Bool) -> L.build_ret (L.const_array (L.const_array i1_t r) c)
                                  | A.DataType(A.Void) -> L.build_ret_void
                                  | A.TupleType(t, l) -> (match t with
                                                            A.DataType(A.Int) -> L.build_ret (L.const_array (L.const_array (L.const_array i32_t l) r) c)
                                                          | A.DataType(A.Float) -> L.build_ret (L.const_array (L.const_array (L.const_array float_t l) r) c)
                                                          | A.DataType(A.Char) -> L.build_ret (L.const_array (L.const_array (L.const_array i8_t l) r) c)
                                                          | A.DataType(A.String) -> L.build_ret (L.const_array (L.const_array (L.const_array (pointer_t i8_t) l) r) c)
                                                          | A.DataType(A.Bool) -> L.build_ret (L.const_array (L.const_array (L.const_array i1_t l) r) c)
                                                          | A.DataType(A.Void) -> L.build_ret_void)) *)
      | A.TuplePointerType(t) | A.MatrixPointerType(t) | A.MatrixTuplePointerType(t) -> (match t with
                                                                                           A.Int -> L.build_ret (L.const_pointer_null (pointer_t i32_t))
                                                                                         | A.Float -> L.build_ret (L.const_pointer_null (pointer_t float_t))
                                                                                         | A.Char -> L.build_ret (L.const_pointer_null (pointer_t i8_t))
                                                                                         | A.String -> L.build_ret (L.const_pointer_null (pointer_t (pointer_t i8_t)))
                                                                                         | A.Bool -> L.build_ret (L.const_pointer_null (pointer_t i1_t))
                                                                                         | A.Void -> L.build_ret_void)

    )
  in

  List.iter build_function_body functions;
  the_module
