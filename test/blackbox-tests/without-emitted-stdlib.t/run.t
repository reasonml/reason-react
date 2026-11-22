Use the router, DOM test helpers, and Node bindings without emitting the standard
library. A consumer should only need ReasonReact and the Melange JavaScript runtime.

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (target output)
  >  (alias mel)
  >  (emit_stdlib false)
  >  (compile_flags :standard -nopervasives -nostdlib -alert -deprecated)
  >  (libraries reason-react reason-react.node)
  >  (preprocess (pps melange.ppx reason-react-ppx)))
  > EOF

  $ dune build --display quiet @mel
  File "_none_", line 1:
  Error: Stdlib__Array not found, it means either the module does not exist or it is a namespace
  [1]
