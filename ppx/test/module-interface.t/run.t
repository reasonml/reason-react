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

module Component = { ... }
________^

  $ ocamlmerlin single type-enclosing -position 1:9 -verbosity 1 \
  > -filename component.re < component.re | jq '.value[0].type' -r | echo $(</dev/stdin) | tr ';' '\n'
  { external makeProps: (~author: 'author, ~key: string=?, unit) => {.. "author": 'author} = "" "�������A�&author��A�#key@��@@@"
   let make: {.. "author": string} => React.element
   }

module Component = { ... }
___________________^

  $ ocamlmerlin single type-enclosing -position 1:20 -verbosity 1 \
  > -filename component.re < component.re | jq '.value[0].type' -r | echo $(</dev/stdin) | tr ';' '\n'
  { external makeProps: (~author: 'author, ~key: string=?, unit) => {.. "author": 'author} = "" "�������A�&author��A�#key@��@@@"
   let make: (~author: string) => React.element
   let make: {.. "author": string} => React.element
   }
