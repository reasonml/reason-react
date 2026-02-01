Show the error message when an optionally labelled argument has the wrong type

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (target output)
  >  (alias mel)
  >  (emit_stdlib false)
  >  (libraries reason-react)
  >  (preprocess (pps melange.ppx reason-react-ppx)))
  > EOF

  $ cat > x.re <<EOF
  > module App = {
  >   [@react.component]
  >   let make = (~myProp: bool=?) => React.null;
  > };
  > EOF

  $ dune build @mel
  File "x.re", line 3, characters 15-27:
  3 |   let make = (~myProp: bool=?) => React.null;
                     ^^^^^^^^^^^^
  Error: This pattern matches values of type bool
         but a pattern was expected which matches values of type 'a option
  [1]
