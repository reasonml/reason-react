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
  File "component.re", line 2, characters 21-51:
  2 | let make = (~key) => <div> key->React.string </div>;
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: ~key cannot be accessed from the component props. Please set the key where the component is being used.
  [1]
