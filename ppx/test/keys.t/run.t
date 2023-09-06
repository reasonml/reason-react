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

Let's test hovering over parts of the component

key={author.Author.name}
_^

  $ ocamlmerlin single type-enclosing -position 10:7 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  null

key={author.Author.name}
_______^

  $ ocamlmerlin single type-enclosing -position 10:14 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  null

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
  null

<img src={author.Author.imageUrl} />
__^

  $ ocamlmerlin single type-enclosing -position 10:41 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  null

<img src={author.Author.imageUrl} />
______^

  $ ocamlmerlin single type-enclosing -position 10:44 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  null

<img src={author.Author.imageUrl} />
_____________^

  $ ocamlmerlin single type-enclosing -position 10:51 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  null

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
  null
