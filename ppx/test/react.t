Demonstrate how to use the React JSX PPX

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF
  $ cat > dune <<EOF
  > (melange.emit
  >  (target output)
  >  (alias mel)
  >  (compile_flags :standard -w -20)
  >  (emit_stdlib false)
  >  (libraries reason-react)
  >  (preprocess (pps melange.ppx reason-react-ppx)))
  > EOF
  $ cat > x.re <<EOF
  > module App = {
  >   [@react.component]
  >   let make = () =>
  >     ["Hello!", "This is React!"]
  >     ->Belt.List.map(greeting => <h1> greeting->React.string </h1>)
  >     ->Belt.List.toArray
  >     ->React.array;
  > };
  > let () =
  >   Js.log2("Here's two:", 2);
  >   ignore(<App />)
  > EOF

  $ dune build @mel --display=short
        ocamlc .ppx/9aa86304e1964cfc127b38093f18cb83/dune__exe___ppx.{cmi,cmo}
      ocamlopt .ppx/9aa86304e1964cfc127b38093f18cb83/build_info__Build_info_data.{cmx,o}
          melc output/node_modules/reason-react/React.js
          melc output/node_modules/reason-react/ReactDOM.js
          melc output/node_modules/reason-react/ReactDOMServer.js
          melc output/node_modules/reason-react/ReactDOMStyle.js
          melc output/node_modules/reason-react/ReactEvent.js
          melc output/node_modules/reason-react/ReactTestUtils.js
          melc output/node_modules/reason-react/ReasonReactErrorBoundary.js
          melc output/node_modules/reason-react/ReasonReactRouter.js
          melc output/node_modules/reason-react/legacy/ReactDOMRe.js
          melc output/node_modules/reason-react/legacy/ReasonReact.js
         refmt x.re.ml
      ocamlopt .ppx/9aa86304e1964cfc127b38093f18cb83/dune__exe___ppx.{cmx,o}
      ocamlopt .ppx/9aa86304e1964cfc127b38093f18cb83/ppx.exe
           ppx x.re.pp.ml
          melc .output.mobjs/melange/melange__X.{cmi,cmj,cmt}
          melc output/x.js
