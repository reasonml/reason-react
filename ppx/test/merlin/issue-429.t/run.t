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

`greeting` prop

  $ ocamlmerlin single type-enclosing -position 15:19 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

`state` in `let (state, dispatch)`

  $ ocamlmerlin single type-enclosing -position 16:11 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

`dispatch` in `let (state, dispatch)`

  $ ocamlmerlin single type-enclosing -position 16:19 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

`message` in `let message`

  $ ocamlmerlin single type-enclosing -position 26:11 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

Wrapping `div`

  $ ocamlmerlin single type-enclosing -position 29:5 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

First child `button`

  $ ocamlmerlin single type-enclosing -position 30:9 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

First child `onClick` prop

  $ ocamlmerlin single type-enclosing -position 30:17 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

First child `onClick` callback argument (event)

  $ ocamlmerlin single type-enclosing -position 30:23 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

First child `onClick` prop `dispatch`

  $ ocamlmerlin single type-enclosing -position 30:30 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

First child `onClick` prop `Click`

  $ ocamlmerlin single type-enclosing -position 30:39 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 31,
        "col": 35
      },
      "end": {
        "line": 31,
        "col": 40
      },
      "type": "((int)) => action",
      "tail": "no"
    }
  ]

First child `string`

  $ ocamlmerlin single type-enclosing -position 30:53 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 31,
        "col": 49
      },
      "end": {
        "line": 31,
        "col": 55
      },
      "type": "string => element",
      "tail": "no"
    }
  ]

First child `message`

  $ ocamlmerlin single type-enclosing -position 30:62 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

Third child `state`

  $ ocamlmerlin single type-enclosing -position 34:9 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

Third child `show` in `state.show`

  $ ocamlmerlin single type-enclosing -position 34:15 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

Third child `string`

  $ ocamlmerlin single type-enclosing -position 34:22 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 35,
        "col": 18
      },
      "end": {
        "line": 35,
        "col": 24
      },
      "type": "string => element",
      "tail": "no"
    }
  ]

Third child `greeting`

  $ ocamlmerlin single type-enclosing -position 34:30 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  []

Third child `null`

  $ ocamlmerlin single type-enclosing -position 34:40 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 35,
        "col": 37
      },
      "end": {
        "line": 35,
        "col": 41
      },
      "type": "element",
      "tail": "no"
    }
  ]
