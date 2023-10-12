### Welcome to the source of ReasonReact

We want to expose as minimum modules to the toplevel as possible, and at the same time want to map closely to the npm packages. So each module maps to a npm package, and each sub-module maps to a sub-module. For example: `react-dom` -> `ReactDOM` and `react-dom/server` -> `ReactDOM.Server`.

Files overview:

## Bindings

- `React`: bindings to React
  - `React.Event`: bindings to React's custom events system
  - `React.Context`: bindings to React's Context
- `ReactDOM`: bindings to ReactDOM
  - `ReactDOM.Server`: bindings to ReactDOMServer
  - `ReactDOM.Style`: bindings to create `style` objects
  - `ReactDOM.TestUtils`: helpers for testing your components

## Extra (not part of react)
- `ErrorBoundary`: component to catch errors within your component tree
- `ReasonReactRouter`: a simple, yet fully featured router with minimal memory allocations

Eventually `React.ErrorBoundary` and `ReasonReactRouter` could live into their own packages, but for now they are part of ReasonReact (and we will keep them here for backwards compatibility).
