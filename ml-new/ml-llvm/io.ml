let filename = "file/io.mxl" in
let has_open l = 
  let r = Str.regexp "open" in
  try ignore (Str.search_forward r l 0); true
  with Not_found -> false
in
let lines = ref [] in
let chan = open_in filename in
try
  while true; do
    let line = input_line chan in
    if (has_open line) then print_string "found"; 
    lines := line :: !lines;
  done; []
with End_of_file ->
  close_in chan;
  List.rev !lines
