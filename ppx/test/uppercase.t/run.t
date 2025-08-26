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
  File "component.re", line 4, characters 4-8:
  4 |     <div>
          ^^^^
  Error: Uninterpreted extension 'mel.obj'.
  [1]

Let's test hovering over parts of the component

`children` inside `<Box>` element

  $ ocamlmerlin single type-enclosing -position 14:12 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 14,
      "col": 7
    },
    "end": {
      "line": 14,
      "col": 15
    },
    "type": "'a",
    "tail": "no"
  }
