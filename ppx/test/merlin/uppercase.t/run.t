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

`children` inside `<Box>` element

  $ ocamlmerlin single type-enclosing -position 14:12 -verbosity 0 \
  > -filename component.re < component.re | jq '.value'
  [
    {
      "start": {
        "line": 14,
        "col": 7
      },
      "end": {
        "line": 14,
        "col": 15
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 14,
        "col": 6
      },
      "end": {
        "line": 14,
        "col": 16
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 12,
        "col": 28
      },
      "end": {
        "line": 16,
        "col": 3
      },
      "type": "Js.t({.. \"children\": React.element})",
      "tail": "no"
    },
    {
      "start": {
        "line": 12,
        "col": 28
      },
      "end": {
        "line": 16,
        "col": 3
      },
      "type": "React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 12,
        "col": 13
      },
      "end": {
        "line": 16,
        "col": 3
      },
      "type": "(~children: React.element) => React.element",
      "tail": "no"
    },
    {
      "start": {
        "line": 10,
        "col": 19
      },
      "end": {
        "line": 17,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~children: 'children, ~key: string=?, unit) =>\n    {.. \"children\": 'children} = \"\"\n    \"����\u0000\u0000\u0000\u001c\u0000\u0000\u0000\u000b\u0000\u0000\u0000\u001f\u0000\u0000\u0000\u001e���A�(children��A�#key@��@@@\";\n  let make: (~children: React.element) => React.element;\n  let make: {.. \"children\": React.element} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 10,
        "col": 19
      },
      "end": {
        "line": 17,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~children: 'children, ~key: string=?, unit) =>\n    {.. \"children\": 'children} = \"\"\n    \"����\u0000\u0000\u0000\u001c\u0000\u0000\u0000\u000b\u0000\u0000\u0000\u001f\u0000\u0000\u0000\u001e���A�(children��A�#key@��@@@\";\n  let make: {.. \"children\": React.element} => React.element;\n}",
      "tail": "no"
    },
    {
      "start": {
        "line": 10,
        "col": 0
      },
      "end": {
        "line": 17,
        "col": 1
      },
      "type": "{\n  external makeProps:\n    (~children: 'children, ~key: string=?, unit) =>\n    {.. \"children\": 'children} = \"\"\n    \"����\u0000\u0000\u0000\u001c\u0000\u0000\u0000\u000b\u0000\u0000\u0000\u001f\u0000\u0000\u0000\u001e���A�(children��A�#key@��@@@\";\n  let make: {.. \"children\": React.element} => React.element;\n}",
      "tail": "no"
    }
  ]
