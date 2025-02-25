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

`<button`
TODO: currently the tag returns a string, not a React.element or a function

  $ ocamlmerlin single type-enclosing -position 6:8 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 6,
      "col": 4
    },
    "end": {
      "line": 6,
      "col": 11
    },
    "type": "string",
    "tail": "no"
  }

`onClick` prop
TODO: currently the prop returns a React.element, not a labelled argument

  $ ocamlmerlin single type-enclosing -position 6:17 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 6,
      "col": 4
    },
    "end": {
      "line": 8,
      "col": 14
    },
    "type": "React.element",
    "tail": "no"
  }

`onClick` callback argument (the event)

  $ ocamlmerlin single type-enclosing -position 6:23 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 6,
      "col": 20
    },
    "end": {
      "line": 6,
      "col": 55
    },
    "type": "option(React.Event.Mouse.t => unit)",
    "tail": "no"
  }

`setValue`

  $ ocamlmerlin single type-enclosing -position 6:29 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 6,
      "col": 26
    },
    "end": {
      "line": 6,
      "col": 34
    },
    "type": "(int => int) => unit",
    "tail": "no"
  }

`setValue` callback param

  $ ocamlmerlin single type-enclosing -position 6:39 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 6,
      "col": 35
    },
    "end": {
      "line": 6,
      "col": 40
    },
    "type": "int",
    "tail": "no"
  }

`setValue` callback body

  $ ocamlmerlin single type-enclosing -position 6:47 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 6,
      "col": 44
    },
    "end": {
      "line": 6,
      "col": 49
    },
    "type": "int",
    "tail": "no"
  }

`value` in `value->React.int`

  $ ocamlmerlin single type-enclosing -position 7:9 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 7,
      "col": 6
    },
    "end": {
      "line": 7,
      "col": 11
    },
    "type": "int",
    "tail": "no"
  }

`int` in `value->React.int`

  $ ocamlmerlin single type-enclosing -position 7:22 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 7,
      "col": 13
    },
    "end": {
      "line": 7,
      "col": 22
    },
    "type": "int => React.element",
    "tail": "no"
  }

Closing `</button>`
TODO: currently the closing tag returns a unit, not a React.element or a function

  $ ocamlmerlin single type-enclosing -position 8:10 -verbosity 0 \
  > -filename component.re < component.re | jq '.value[0]'
  {
    "start": {
      "line": 8,
      "col": 4
    },
    "end": {
      "line": 8,
      "col": 13
    },
    "type": "unit",
    "tail": "no"
  }
