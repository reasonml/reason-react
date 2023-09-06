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
  [
    {
      "start": {
        "line": 15,
        "col": 13
      },
      "end": {
        "line": 15,
        "col": 21
      },
      "type": "string",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

`state` in `let (state, dispatch)`

  $ ocamlmerlin single type-enclosing -position 16:11 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 16,
        "col": 7
      },
      "end": {
        "line": 16,
        "col": 12
      },
      "type": "state",
      "tail": "no"
    },
    {
      "start": {
        "line": 16,
        "col": 6
      },
      "end": {
        "line": 16,
        "col": 23
      },
      "type": "(state, action => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

`dispatch` in `let (state, dispatch)`

  $ ocamlmerlin single type-enclosing -position 16:19 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 16,
        "col": 14
      },
      "end": {
        "line": 16,
        "col": 22
      },
      "type": "action => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 16,
        "col": 6
      },
      "end": {
        "line": 16,
        "col": 23
      },
      "type": "(state, action => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

`message` in `let message`

  $ ocamlmerlin single type-enclosing -position 26:11 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 26,
        "col": 6
      },
      "end": {
        "line": 26,
        "col": 13
      },
      "type": "string",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

Wrapping `div`

  $ ocamlmerlin single type-enclosing -position 29:5 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 29,
        "col": 6
      },
      "type": "string",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

First child `button`

  $ ocamlmerlin single type-enclosing -position 30:9 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 11
      },
      "type": "string",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

First child `onClick` prop

  $ ocamlmerlin single type-enclosing -position 30:17 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

First child `onClick` callback argument (event)

  $ ocamlmerlin single type-enclosing -position 30:23 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 30,
        "col": 20
      },
      "end": {
        "line": 30,
        "col": 46
      },
      "type": "ReactEvent.Mouse.t => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 20
      },
      "end": {
        "line": 30,
        "col": 46
      },
      "type": "option(ReactEvent.Mouse.t => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

First child `onClick` prop `dispatch`

  $ ocamlmerlin single type-enclosing -position 30:30 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 30,
        "col": 26
      },
      "end": {
        "line": 30,
        "col": 34
      },
      "type": "action => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 26
      },
      "end": {
        "line": 30,
        "col": 45
      },
      "type": "unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 20
      },
      "end": {
        "line": 30,
        "col": 46
      },
      "type": "ReactEvent.Mouse.t => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 20
      },
      "end": {
        "line": 30,
        "col": 46
      },
      "type": "option(ReactEvent.Mouse.t => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

First child `onClick` prop `Click`

  $ ocamlmerlin single type-enclosing -position 30:39 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 30,
        "col": 35
      },
      "end": {
        "line": 30,
        "col": 40
      },
      "type": "((int)) => action",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 35
      },
      "end": {
        "line": 30,
        "col": 44
      },
      "type": "action",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 26
      },
      "end": {
        "line": 30,
        "col": 45
      },
      "type": "unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 20
      },
      "end": {
        "line": 30,
        "col": 46
      },
      "type": "ReactEvent.Mouse.t => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 20
      },
      "end": {
        "line": 30,
        "col": 46
      },
      "type": "option(ReactEvent.Mouse.t => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

First child `string`

  $ ocamlmerlin single type-enclosing -position 30:53 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 30,
        "col": 49
      },
      "end": {
        "line": 30,
        "col": 55
      },
      "type": "string => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 48
      },
      "end": {
        "line": 30,
        "col": 65
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 48
      },
      "end": {
        "line": 30,
        "col": 65
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

First child `message`

  $ ocamlmerlin single type-enclosing -position 30:62 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 30,
        "col": 56
      },
      "end": {
        "line": 30,
        "col": 63
      },
      "type": "string",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 48
      },
      "end": {
        "line": 30,
        "col": 65
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 48
      },
      "end": {
        "line": 30,
        "col": 65
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 30,
        "col": 4
      },
      "end": {
        "line": 30,
        "col": 75
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

Third child `state`

  $ ocamlmerlin single type-enclosing -position 34:9 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 34,
        "col": 5
      },
      "end": {
        "line": 34,
        "col": 10
      },
      "type": "state",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 5
      },
      "end": {
        "line": 34,
        "col": 15
      },
      "type": "bool",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 4
      },
      "end": {
        "line": 34,
        "col": 42
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

Third child `show` in `state.show`

  $ ocamlmerlin single type-enclosing -position 34:15 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 34,
        "col": 11
      },
      "end": {
        "line": 34,
        "col": 15
      },
      "type": "bool",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 5
      },
      "end": {
        "line": 34,
        "col": 15
      },
      "type": "bool",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 4
      },
      "end": {
        "line": 34,
        "col": 42
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

Third child `string`

  $ ocamlmerlin single type-enclosing -position 34:22 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 34,
        "col": 18
      },
      "end": {
        "line": 34,
        "col": 24
      },
      "type": "string => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 18
      },
      "end": {
        "line": 34,
        "col": 34
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 4
      },
      "end": {
        "line": 34,
        "col": 42
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

Third child `greeting`

  $ ocamlmerlin single type-enclosing -position 34:30 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 34,
        "col": 25
      },
      "end": {
        "line": 34,
        "col": 33
      },
      "type": "string",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 18
      },
      "end": {
        "line": 34,
        "col": 34
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 4
      },
      "end": {
        "line": 34,
        "col": 42
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]

Third child `null`

  $ ocamlmerlin single type-enclosing -position 34:40 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 34,
        "col": 37
      },
      "end": {
        "line": 34,
        "col": 41
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 34,
        "col": 4
      },
      "end": {
        "line": 34,
        "col": 42
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "array(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
    {
      "start": {
        "line": 29,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 26,
        "col": 2
      },
      "end": {
        "line": 35,
        "col": 9
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 26
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 15,
        "col": 11
      },
      "end": {
        "line": 36,
        "col": 1
      },
      "type": "(~greeting: string) => React.element",
      "tail": "no"
    }
  ]
