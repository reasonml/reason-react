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
  File "component.re", line 9, characters 11-17:
  9 | let make = author =>
                 ^^^^^^
  Error: react-jsx-ppx: props need to be labelled arguments.
    If you are working with refs be sure to wrap with React.forwardRef.
    If your component doesn't have any props, use () (unit) or _ (wildcard) instead of a name.
  [1]

Let's test hovering over parts of the component

key={author.Author.name}
_^

  $ ocamlmerlin single type-enclosing -position 10:8 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 2
    },
    "end": {
      "line": 10,
      "col": 85
    },
    "type": "'a",
    "tail": "no"
  }

key={author.Author.name}
_______^

  $ ocamlmerlin single type-enclosing -position 10:14 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 11
    },
    "end": {
      "line": 10,
      "col": 17
    },
    "type": "Author.t",
    "tail": "no"
  }

key={author.Author.name}
______________^

  $ ocamlmerlin single type-enclosing -position 10:22 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 18
    },
    "end": {
      "line": 10,
      "col": 24
    },
    "type": "{ type t = { name: string, imageUrl: string, }; }",
    "tail": "no"
  }

key={author.Author.name}
____________________^

  $ ocamlmerlin single type-enclosing -position 10:28 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 18
    },
    "end": {
      "line": 10,
      "col": 29
    },
    "type": "string",
    "tail": "no"
  }

<img src={author.Author.imageUrl} />
__^

  $ ocamlmerlin single type-enclosing -position 10:41 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 37
    },
    "end": {
      "line": 10,
      "col": 41
    },
    "type": "(~src: string, ~children: list('_weak1), unit) => '_weak2",
    "tail": "no"
  }

<img src={author.Author.imageUrl} />
______^

  $ ocamlmerlin single type-enclosing -position 10:44 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 37
    },
    "end": {
      "line": 10,
      "col": 73
    },
    "type": "unit",
    "tail": "no"
  }

<img src={author.Author.imageUrl} />
_____________^

  $ ocamlmerlin single type-enclosing -position 10:51 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 47
    },
    "end": {
      "line": 10,
      "col": 53
    },
    "type": "Author.t",
    "tail": "no"
  }

<img src={author.Author.imageUrl} />
____________________^

  $ ocamlmerlin single type-enclosing -position 10:58 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 54
    },
    "end": {
      "line": 10,
      "col": 60
    },
    "type": "{ type t = { name: string, imageUrl: string, }; }",
    "tail": "no"
  }

<img src={author.Author.imageUrl} />
___________________________^

  $ ocamlmerlin single type-enclosing -position 10:66 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 10,
      "col": 54
    },
    "end": {
      "line": 10,
      "col": 69
    },
    "type": "string",
    "tail": "no"
  }
