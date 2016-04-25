
let filename = "tests/io.mxl" in
(* let find_open l = "hello" in *)
let lines = ref [] in
let chan = open_in filename in
try
  while true; do
    let line = input_line chan in

    print_endline line;
    lines := line :: !lines;
  done; []
with End_of_file ->
  close_in chan;
  List.rev !lines
