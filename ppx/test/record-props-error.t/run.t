Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ ../ppx.sh --output ml input.re
  File "output.ml", line 5, characters 68-76:
  5 |                                                                     no_props
                                                                          ^^^^^^^^
  Error: [@react.component] only accepts 'props' as a field, given: no_props
  [1]
