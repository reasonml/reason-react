DOM JSX currently rejects arbitrary data attributes. These expected failures
document the limitation before adding support for them.

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

Check the failure status before showing the final diagnostic, since the full
list of accepted DOM props is long.

  $ cat > input.re <<EOF
  > let element = <div dataFoo="value" />;
  > EOF
  $ dune build @mel > error.log 2>&1
  [1]
  $ tail -n 1 error.log
  This argument cannot be applied with label ~dataFoo

Optional data attributes are also rejected.

  $ cat > input.re <<EOF
  > let element = (~dataFoo=?, ()) => <div ?dataFoo />;
  > EOF
  $ dune build @mel > error.log 2>&1
  [1]
  $ tail -n 1 error.log
  This argument cannot be applied with label ?dataFoo

SVG elements have the same limitation.

  $ cat > input.re <<EOF
  > let element = <svg dataFoo="value" />;
  > EOF
  $ dune build @mel > error.log 2>&1
  [1]
  $ tail -n 1 error.log
  This argument cannot be applied with label ~dataFoo
