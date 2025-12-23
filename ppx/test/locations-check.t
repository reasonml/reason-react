Test the preprocessed reason-react components have well-formed locations.
Uses https://github.com/ocaml-ppx/ppxlib/blob/44583fc14c3cc39ee6269ffd69f52146283f72c0/src/location_check.mli

With no annotations (ppx does nothing)

  $ cat >input.ml <<EOF
  > let make ~foo ~bar =
  >   (div
  >      ~children:[ React.string foo; bar |> string_of_int |> React.string ]
  >      ())
  > EOF

  $ reason-react-ppx -check -locations-check input.ml
  let make ~foo ~bar =
    div ~children:[React.string foo; (bar |> string_of_int) |> React.string] ()

With JSX annotation

  $ cat >input.ml <<EOF
  > let make ~foo ~bar =
  >   (div
  >      ~children:[ React.string foo; bar |> string_of_int |> React.string ]
  >      () [@JSX])
  > EOF

  $ reason-react-ppx -check -locations-check input.ml
  File "input.ml", line 2, characters 3-6:
  2 |   (div
         ^^^
  Error: invalid output from ppx, expression overlaps with expression at location:
  File "input.ml", line 2, characters 2-96:
  [1]

With @react.component annotation

  $ cat >input.ml <<EOF
  > let[@react.component] make ~foo ~bar =
  >   (div
  >      ~children:[ React.string foo; bar |> string_of_int |> React.string ]
  >      () [@JSX])
  > EOF

  $ reason-react-ppx -check -locations-check input.ml
  File "input.ml", line 1, characters 33-36:
  1 | let[@react.component] make ~foo ~bar =
                                       ^^^
  Error: invalid output from ppx, core type overlaps with core type at location:
  File "input.ml", line 1, characters 33-36:
  [1]

Everything

  $ cat >input.ml <<EOF
  > let[@react.component] make ~foo ~bar =
  >   (div
  >      ~children:[ React.string foo; bar |> string_of_int |> React.string ]
  >      () [@JSX])
  > EOF

  $ reason-react-ppx -check -locations-check input.ml
  File "input.ml", line 1, characters 33-36:
  1 | let[@react.component] make ~foo ~bar =
                                       ^^^
  Error: invalid output from ppx, core type overlaps with core type at location:
  File "input.ml", line 1, characters 33-36:
  [1]
