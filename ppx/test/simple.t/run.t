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
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 6,
        "col": 11
      },
      "type": "string",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`onClick` prop

  $ ocamlmerlin single type-enclosing -position 6:17 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 8,
        "col": 14
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`onClick` callback argument (the event)

  $ ocamlmerlin single type-enclosing -position 6:23 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 6,
        "col": 20
      },
      "end": {
        "line": 6,
        "col": 55
      },
      "type": "ReactEvent.Mouse.t => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 20
      },
      "end": {
        "line": 6,
        "col": 55
      },
      "type": "option(ReactEvent.Mouse.t => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 8,
        "col": 14
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`setValue`

  $ ocamlmerlin single type-enclosing -position 6:29 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
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
    },
    {
      "start": {
        "line": 6,
        "col": 26
      },
      "end": {
        "line": 6,
        "col": 54
      },
      "type": "unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 20
      },
      "end": {
        "line": 6,
        "col": 55
      },
      "type": "ReactEvent.Mouse.t => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 20
      },
      "end": {
        "line": 6,
        "col": 55
      },
      "type": "option(ReactEvent.Mouse.t => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 8,
        "col": 14
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`setValue` callback param

  $ ocamlmerlin single type-enclosing -position 6:39 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
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
    },
    {
      "start": {
        "line": 6,
        "col": 35
      },
      "end": {
        "line": 6,
        "col": 53
      },
      "type": "int => int",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 26
      },
      "end": {
        "line": 6,
        "col": 54
      },
      "type": "unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 20
      },
      "end": {
        "line": 6,
        "col": 55
      },
      "type": "ReactEvent.Mouse.t => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 20
      },
      "end": {
        "line": 6,
        "col": 55
      },
      "type": "option(ReactEvent.Mouse.t => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 8,
        "col": 14
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`setValue` callback body

  $ ocamlmerlin single type-enclosing -position 6:47 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
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
    },
    {
      "start": {
        "line": 6,
        "col": 44
      },
      "end": {
        "line": 6,
        "col": 53
      },
      "type": "int",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 35
      },
      "end": {
        "line": 6,
        "col": 53
      },
      "type": "int => int",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 26
      },
      "end": {
        "line": 6,
        "col": 54
      },
      "type": "unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 20
      },
      "end": {
        "line": 6,
        "col": 55
      },
      "type": "ReactEvent.Mouse.t => unit",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 20
      },
      "end": {
        "line": 6,
        "col": 55
      },
      "type": "option(ReactEvent.Mouse.t => unit)",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 8,
        "col": 14
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

`value` in `value->React.int`

  $ ocamlmerlin single type-enclosing -position 7:9 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
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
    },
    {
      "start": {
        "line": 7,
        "col": 6
      },
      "end": {
        "line": 7,
        "col": 22
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 7,
        "col": 6
      },
      "end": {
        "line": 7,
        "col": 22
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 8,
        "col": 14
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
        "line": 7,
        "col": 6
      },
      "end": {
        "line": 7,
        "col": 22
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 7,
        "col": 6
      },
      "end": {
        "line": 7,
        "col": 22
      },
      "type": "option(React.element)",
      "tail": "no"
    },
    {
      "start": {
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 8,
        "col": 14
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]

Closing `</button>`

  $ ocamlmerlin single type-enclosing -position 8:10 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
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
    },
    {
      "start": {
        "line": 6,
        "col": 4
      },
      "end": {
        "line": 8,
        "col": 14
      },
      "type": "ReactDOM.domProps",
      "tail": "no"
    },
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
    },
    {
      "start": {
        "line": 3,
        "col": 38
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 31
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "unit => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 3,
        "col": 13
      },
      "end": {
        "line": 9,
        "col": 3
      },
      "type": "(~initialValue: int=?, unit) => React.element",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: (~initialValue: int=?, unit) => React.element;\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
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
      "type": "{\n  external makeProps:\n    (~initialValue: 'initialValue=?, ~key: string=?, unit) =>\n    {.. \"initialValue\": option('initialValue)} = \"\"\n    \"����\u0000\u0000\u0000!\u0000\u0000\u0000\u000b\u0000\u0000\u0000!\u0000\u0000\u0000\u001f���A�,initialValue@��A�#key@��@@@\";\n  let make: {.. \"initialValue\": option(int)} => React.element;\n}",
      "tail": "no"
    }
  ]
