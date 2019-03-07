[@@@bs.config { jsx = 3 }]

let div ~children  () = children

module Test = struct

let make ~a  ~b  _ =
  print_endline (a ^ b);
  print_endline "This function should be named `Test`";
  ((div ~children:[] ())[@JSX ])[@@react.component ]

end
