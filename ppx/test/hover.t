Test some locations in reason-react components, reproduces #840

  $ cat >dune-project <<EOF
  > (lang dune 3.13)
  > (using melange 0.1)
  > EOF

  $ cat >dune <<EOF
  > (melange.emit
  >  (alias foo)
  >  (target foo)
  >  (libraries reason-react)
  >  (emit_stdlib false)
  >  (preprocess
  >   (pps melange.ppx reason-react-ppx)))
  > EOF

  $ cat >component.ml <<EOF
  > let[@react.component] make ~foo ~bar =
  >   (div
  >      ~children:[ React.string foo; bar |> string_of_int |> React.string ]
  >      () [@JSX])
  > EOF
  $ dune build @foo

Let's test hovering over parts of the component

`React.string`

  $ ocamlmerlin single type-enclosing -position 3:25 -verbosity 0 \
  > -filename component.ml < component.ml | jq '.value[0]'
  {
    "start": {
      "line": 3,
      "col": 17
    },
    "end": {
      "line": 3,
      "col": 29
    },
    "type": "string -> React.element",
    "tail": "no"
  }

The `foo` variable inside the component body

  $ ocamlmerlin single type-enclosing -position 3:31 -verbosity 0 \
  > -filename component.ml < component.ml | jq '.value[0]'
  {
    "start": {
      "line": 3,
      "col": 30
    },
    "end": {
      "line": 3,
      "col": 33
    },
    "type": "string",
    "tail": "no"
  }
