let filename = "tests/io.mxl" in
let read_file filename = 
let lines = ref [] in
let chan = open_in filename in
try
  while true; do
    lines := input_line chan :: !lines
  done; !lines
with End_of_file ->
  close_in chan;
  List.rev !lines 
;;  
  
(*let rec print_list = function *)
(*[] -> ()*)
(*| e::1 print_string e; print_string " "; print_list lines*)  
