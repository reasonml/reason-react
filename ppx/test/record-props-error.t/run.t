Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ ../ppx.sh --output ml input.re
  File "output.ml", line 4, characters 27-35:
  4 |       [@@react.component { no_props = string }]
                                 ^^^^^^^^
  Error: [@react.component] only accepts 'props' as a field, given: no_props
  [1]
