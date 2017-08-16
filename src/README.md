Welcome to the source of ReasonReact!

Files overview:

- `reactDOMRe`: bindings to ReactDOM.
- `reactDOMServerRe`: bindings to ReactDOMServer.
- `reactEventRe`: bindings to React's custom events system.
- `reasonReact`: core React bindings.
- `reasonReactOptimizedCreateClass`: our reasonReact component initialization uses React's createClass under the hood. This file's a tweaked version of it, with all the dependencies, warnings and invariants commented out (we don't need any of them anymore! Our types obsoleted them =D).
