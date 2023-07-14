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

  $ ocamlmerlin single type-enclosing -position 6:8 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`onClick` prop

  $ ocamlmerlin single type-enclosing -position 6:17 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`onClick` callback argument (the event)

  $ ocamlmerlin single type-enclosing -position 6:23 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`setValue`

  $ ocamlmerlin single type-enclosing -position 6:29 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`setValue` callback param

  $ ocamlmerlin single type-enclosing -position 6:39 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`setValue` callback body

  $ ocamlmerlin single type-enclosing -position 6:47 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`value` in `value->React.int`

  $ ocamlmerlin single type-enclosing -position 7:9 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`int` in `value->React.int`

  $ ocamlmerlin single type-enclosing -position 7:22 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
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
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

Closing `</button>`

  $ ocamlmerlin single type-enclosing -position 8:10 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 32
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 1,
        "col": 0
      },
      "end": {
        "line": 10,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {. initialValue: option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {. initialValue: option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]
