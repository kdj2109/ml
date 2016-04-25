let read_ppm ppmname = 
  let ppm_chan = open_in ppmname in
  try
    let first_line = input_line ppm_chan in
    let second_line = input_line ppm_chan in
    let third_line = input_line ppm_chan in
    print_endline first_line; print_endline second_line; print_endline
    third_line;
    while true; do
      let ppm_line = input_line ppm_chan in

      print_endline ppm_line;
  done;
with End_of_file ->
  close_in ppm_chan
in
let has_open l = 
  let r = Str.regexp "((a-z)+((a-z)|(A-Z)|(0-9))*(‘ ‘)*=(' ')*open\\((.)*\\))" in
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
    if (has_open line) then read_ppm "file/pic.ppm";
    lines := line :: !lines;
  done; []
with End_of_file ->
  close_in chan;
  List.rev !lines
in read_file filename
