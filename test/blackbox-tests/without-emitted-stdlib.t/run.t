Use the router and Node bindings without emitting the standard
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
  >  (compile_flags :standard -nopervasives -nostdlib)
  >  (libraries reason-react reason-react.node)
  >  (preprocess (pps melange.ppx reason-react-ppx)))
  > EOF

  $ dune build --display quiet @mel

Stdlib must not be pulled in through a transitive library dependency either.

  $ test ! -d _build/default/output/node_modules/melange
