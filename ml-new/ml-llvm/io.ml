let rec print_list = function
  [] -> ()
| e::l -> print_string e ; print_string "," ; print_list l
in
let is_decimal e = 
  try ignore(Str.search_forward (Str.regexp "[0-9]+") e 0); true
  with Not_found -> false
in
let clean_string l =
  let only_digits = List.find_all is_decimal (Str.split (Str.regexp " ") l ) in
  (String.concat ","
    (List.map (fun i ->  i) only_digits))
in
let read_ppm ppmname =
  let filename = ppmname in
  let ppm_chan = open_in filename in
  let ppm_lines = ref [] in
  try
    let first_line = input_line ppm_chan in
    let dimensions = Str.split (Str.regexp " ") (input_line ppm_chan) in
    let max = input_line ppm_chan in
    print_endline first_line; print_endline max; print_list dimensions;
    print_string "\n";
    while true; do
      let ppm_line = input_line ppm_chan in
      let clean_line = clean_string ppm_line in 
      ppm_lines := clean_line :: !ppm_lines;
      (*print_string clean_line;*)
    done;
  with End_of_file ->
    close_in ppm_chan;
    let all_digits = (String.concat "," (List.map (fun i -> i) !ppm_lines)) in
    print_endline all_digits;
in
let has_open l = 
  let r = Str.regexp "open\\(.+*\\)" in
  try ignore (Str.search_forward r l 0); true
  with Not_found -> false
in
let filename = "file/io.mxl" in
let read_file fname = 
let lines = ref [] in
let chan = open_in filename in
try
  while true; do
    let line = input_line chan in
    lines := line :: !lines;
    if (has_open line) then read_ppm "file/pic.ppm";
  done; []
with End_of_file ->
  close_in chan;
  List.rev !lines
in read_file filename