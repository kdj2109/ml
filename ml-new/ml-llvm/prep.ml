let process filename =
    let rec read_file filename =
      let file_regex = Str.regexp "<.+\\.mxl"  in
      let inc_regex = Str.regexp "#include[ ]+<.+>;" in
      let has_file l =
        let has_inc l = 
          try ignore (Str.search_forward inc_regex l 0); true
          with Not_found -> false
        in
        if has_inc l then
          try ignore(Str.search_forward file_regex l 0); true
          with Not_found -> false
        else false
      in
    let lines = ref [] in
    let ic = open_in filename in
    try
      while true; do
        let l = input_line ic in
        let l = (if (has_file l) then ( Str.replace_first inc_regex
        (read_file (Str.string_after (Str.matched_string l) 1) )l ) else l) in
        lines:=  l :: !lines;
      done;
      String.concat "" (List.map (fun i -> i ^ String.make 1 '\n') (List.rev !lines)) 
    with End_of_file -> ignore(close_in ic); 
    String.concat "" (List.map (fun i -> i ^ String.make 1 '\n') (List.rev !lines))
  in 
  let process_string l =
    let read_ppm ppmname id=
      let is_decimal e = 
        try ignore(Str.search_forward (Str.regexp "[0-9]+") e 0); true
        with Not_found -> false
      in
      let clean_string l =
        let only_digits = List.find_all is_decimal (Str.split (Str.regexp " ") l ) in
        (String.concat "," (List.mapi (fun i x -> if (i + 1) mod 3 = 0 then (x ^ ")")
                                              else if i mod 3 = 0 then ("(" ^ x) else x) only_digits)) 
      in
      let ppm_chan = open_in ppmname in 
      print_endline ppmname;
      let w = ref "" in
      let h = ref "" in
      let matrix_decl = ref "" in 
      let ppm_lines = ref [] in
      try
        let ptype = input_line ppm_chan in
        let d = Str.split (Str.regexp " ") (input_line ppm_chan) in
        w := List.nth d 0;
        h := List.nth d 1;
        matrix_decl := "[3][" ^ !w ^ ":" ^ !h  ^ "]";
        let max = input_line ppm_chan in
        while true; do
          ppm_lines := (clean_string (input_line ppm_chan)) :: !ppm_lines;
        done;
        "int" ^ !matrix_decl ^ " " ^ id ^ (String.make 1 '\n') ^ ";" ^id ^ "= [|" ^ (String.concat "|"
        (List.map (fun i -> i) (List.rev !ppm_lines))) ^ "|];"
      with End_of_file -> ignore(close_in ppm_chan); "int" ^ !matrix_decl ^ " " ^ id
      ^ ";" ^ (String.make 1 '\n') ^ id ^ "=[|" ^ (String.concat "|"
      (List.map (fun i -> i) (List.rev !ppm_lines))) ^ "|];"
    in
    let file_regex = Str.regexp "\".+\\.ppm" in
    let decl_regex = Str.regexp "[0-9A-Za-z_]+[ ]*=[ ]*open\\(.+*\\);" in
    let id_regex = Str.regexp "[0-9A-Za-z_]+[ ]*=" in
    let has_decl l = try ignore(Str.search_forward decl_regex l 0); true
        with Not_found -> false
    in
    let get_id l = try ignore(Str.search_forward id_regex l 0); 
        Str.global_replace (Str.regexp "=") "" (Str.matched_string l)
        with Not_found -> l
    in
    let get_file l = try ignore(Str.search_forward file_regex l 0);
    (Str.string_after (Str.matched_string l) 1)
        with Not_found -> l
    in
    let matrix_string l =
      let decl_line = Str.matched_string l in
      let ppm_file = get_file decl_line in
      let id = get_id l in 
      Str.replace_first decl_regex (read_ppm ppm_file id) l
    in
    let line= (if (has_decl l) then (matrix_string l) else l) in line
in process_string (read_file filename)
