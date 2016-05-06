let process filename =
    let rec read_file filename =
      let file_regex = Str.regexp "<.+\.mxl"  in
      let open_regex = Str.regexp "#include[ ]+<.+>;" in
      let has_file l =
        let has_inc l = 
          try ignore (Str.search_forward open_regex l 0); true
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
        lines:= (if (has_file l) then (Str.replace_first open_regex (read_file
        (Str.string_after (Str.matched_string l) 1)) l ) else l)  :: !lines;
      done;
      String.concat "" (List.map (fun i -> i ^ String.make 1 '\n') (List.rev !lines)) 
    with End_of_file -> ignore(close_in ic); 
    String.concat "" (List.map (fun i -> i ^ String.make 1 '\n') (List.rev !lines))
  in
  let process_string l =
    let read_ppm ppmname =
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
      let w = ref "" in
      let h = ref "" in 
      let ppm_lines = ref [] in
      try
        let ptype = input_line ppm_chan in
        let d = Str.split (Str.regexp " ") (input_line ppm_chan) in
        w := List.nth d 0;
        h := List.nth d 1;
        let max = input_line ppm_chan in
        print_endline ppmname;
        while true; do
          ppm_lines := (clean_string (input_line ppm_chan)) :: !ppm_lines;
        done;
        "(|" ^ (String.concat ","
        (List.map (fun i -> i) (List.rev !ppm_lines))) ^ "|" ^ !w ^ "," ^ !h ^ ");"
      with End_of_file -> ignore(close_in ppm_chan); "(|" ^ (String.concat ","
        (List.map (fun i -> i) (List.rev !ppm_lines))) ^ "|" ^ !w ^ "," ^ !h ^ ");"
    in
  let file_regex = Str.regexp "\".+\.ppm" in
  let open_regex = Str.regexp "open\\(.+*\\)" in 
    let has_open l = try ignore (Str.search_forward open_regex l 0); true
      with Not_found -> false
    in 
    let has_file l =
      if has_open l then 
        try ignore(Str.search_forward file_regex l 0); true
        with Not_found -> false
      else false
    in if (has_file l) then Str.replace_first open_regex (read_ppm (Str.string_after
    (Str.matched_string l) 1)) l else l
in process_string (read_file filename)
