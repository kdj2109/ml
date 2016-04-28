let rec print_list = function
  [] -> ()
| e::l -> print_string e ; print_string " " ; print_list l
in
let is_decimal e = 
  try ignore(Str.search_forward (Str.regexp "[0-9]+") e 0); true
  with Not_found -> false
in
let clean_string l =
  let only_digits = List.find_all is_decimal (Str.split (Str.regexp " ") l ) in
  (String.concat "," (List.mapi (fun i x -> if (i + 1) mod 3 = 0 then (x ^ ")")
                                            else if i mod 3 = 0 then ("(" ^ x) else x) only_digits)) 
in
let read_ppm ppmname =
  let ppm_chan = open_in ppmname in
  let w = ref "" in
  let h = ref "" in 
  let ppm_lines = ref [] in
  try
    let first_line = input_line ppm_chan in
    let d = Str.split (Str.regexp " ") (input_line ppm_chan) in
    w := List.nth d 0;
    h := List.nth d 1;
    let max = input_line ppm_chan in
    print_endline first_line; print_endline max; print_list d;
    print_string "\n";
    while true; do
      ppm_lines := (clean_string (input_line ppm_chan)) :: !ppm_lines;
    done;
    "|" ^ (String.concat "," (List.map (fun i -> i) !ppm_lines)) ^ "|" ^ !w ^ "," ^ !h;
  with End_of_file -> ignore(close_in ppm_chan); "|" ^ (String.concat "," (List.map (fun i -> i) !ppm_lines)) ^ "|" ^ !w ^ "," ^ !h;
in
let open_regex = Str.regexp "open\\(.+*\\)" in 
let has_open l = 
  try ignore (Str.search_forward (open_regex) l 0); true
  with Not_found -> false
in
let filename = "file/io.mxl" in
let read_file fname = 
let lines = ref [] in
let chan = open_in filename in
try
  while true; do
    let line = input_line chan in
    lines := (if has_open line then Str.replace_first open_regex (read_ppm "file/pic.ppm") line else line) :: !lines;
  done; []
with End_of_file ->
  close_in chan;
  List.rev !lines;
in read_file filename