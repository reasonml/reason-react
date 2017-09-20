Welcome to the source of ReasonReact!

Files overview:

- `ReactDOMRe`: bindings to ReactDOM.
- `ReactDOMServerRe`: bindings to ReactDOMServer.
- `ReactEventRe`: bindings to React's custom events system.
- `ReasonReact`: core React bindings.
- `ReasonReactOptimizedCreateClass`: our reasonReact component initialization uses React's createClass under the hood. This file's a tweaked version of it, with all the dependencies, warnings and invariants commented out (we don't need any of them anymore! Our types obsoleted them =D).
