Demonstrate how to use the React JSX PPX

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (target output)
  >  (alias mel)
  >  (compile_flags :standard -w -20)
  >  (emit_stdlib false)
  >  (libraries reason-react melange.belt)
  >  (preprocess (pps melange.ppx reason-react-ppx)))
  > EOF

  $ cat > x.re <<EOF
  > module App = {
  >   [@react.component]
  >   let make = () =>
  >     ["Hello!", "This is React!"]
  >     ->Belt.List.map(greeting => <h1> greeting->React.string </h1>)
  >     ->Belt.List.toArray
  >     ->React.array;
  > };
  > let () =
  >   Js.log2("Here's two:", 2);
  >   ignore(<App />)
  > EOF

  $ dune build @mel
  File "x.re", line 5, characters 32-35:
  5 |     ->Belt.List.map(greeting => <h1> greeting->React.string </h1>)
                                      ^^^
  Error: Uninterpreted extension 'mel.obj'.
  [1]

  $ cat _build/default/output/x.js
  cat: _build/default/output/x.js: No such file or directory
  [1]
