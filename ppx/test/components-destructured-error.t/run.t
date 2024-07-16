Test some locations in reason-react components

  $ cat >dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat >dune <<EOF
  > (melange.emit
  >  (alias foo)
  >  (target foo)
  >  (libraries reason-react)
  >  (preprocess
  >   (pps melange.ppx reason-react-ppx)))
  > EOF

  $ dune build
  File "component.re", lines 1-2, characters 0-54:
  1 | [@react.component]
  2 | let (pageState, setPageState) = React.useState(_ => 0).
  Error: react.component calls cannot be destructured.
  [1]
