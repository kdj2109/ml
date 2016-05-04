let read_inc incname =
  let inc_chan = open_in incname in
  let inc_lines = ref [] in
  try
    while true; do
      inc_lines := input_line inc_chan :: !inc_lines;
    done;
    String.concat "" (List.map (fun i -> i ^ String.make 1 '\n') (List.rev !inc_lines)) 
  with End_of_file -> ignore(close_in inc_chan); String.concat "" (List.map (fun i -> i ^ String.make 1 '\n') (List.rev !inc_lines))
in
let file_regex = Str.regexp "<.+\.mxl"  in
let open_regex = Str.regexp "#include[ ]+<.+>;" in
let process_string l =
  let has_inc l = try ignore (Str.search_forward open_regex l 0); true
    with Not_found -> false
  in
  let has_file l =
    if has_inc l then
      try ignore(Str.search_forward file_regex l 0); true
      with Not_found -> false
    else false
  in
  if (has_file l) then Str.replace_first open_regex (read_inc (Str.string_after
  (Str.matched_string l) 1)) l else l
in
let filename = "file/io.mxl" in
let read_file fname =
  let lines = ref [] in
  let ic = open_in filename in
  let oc = open_out "file/temp2.mxl" in
  try
    while true; do
      let out_line = process_string (input_line ic) in
      Printf.fprintf oc "%s\n" out_line;
      print_endline out_line;
      lines := out_line :: !lines;
    done; []
  with End_of_file ->
    close_out oc;
    close_in ic;
    List.rev !lines;
in read_file filename
