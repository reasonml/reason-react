---
title: ReactDOM
---

reason-react's ReactDOM module is called `ReactDOM`. The module exposes helpers that work with familiar ReactJS idioms:

- `ReactDOM.querySelector` : `string => option(Dom.element)`
- `ReactDOM.Client.createRoot` : `Dom.element => Client.root`
- `ReactDOM.Client.render` : `(Client.root, React.element) => unit`
- `ReactDOM.Client.hydrateRoot` : `(Dom.element, React.element) => Client.root`
- `ReactDOM.createPortal` : `(React.element, Dom.element) => React.element`
- `ReactDOM.unmountComponentAtNode` : `Dom.element => unit`

More info about `ReactDOM` module can be found in the interface file: [ReactDOM.rei](https://github.com/reasonml/reason-react/blob/main/src/ReactDOM.rei) or in the [official react-dom documentation](https://react.dev/reference/react-dom).

### Usage

In React 18, the `ReactDOM.render` function is replaced by `ReactDOM.Client.render`.

```reason
let element = ReactDOM.querySelector("#root");
switch (element) {
| None => Js.log("#root element not found");
| Some(element) => {
  let root = ReactDOM.Client.createRoot(element);
  ReactDOM.Client.render(<Greeting name="John" />, root);
}
}
```

### Hydration

Hydration is the process of converting a static HTML page into a dynamic React app.

```reason
let element = ReactDOM.querySelector("#root");
switch (element) {
| None => Js.log("#root element not found");
| Some(element) => {
  /* root is a ReactDOM.Client.root and used to render on top of the existing HTML
     with ReactDOM.Client.render or unmount, via ReactDOM.Client.unmount. */
  let _root = ReactDOM.Client.hydrateRoot(<Greeting name="John" />, element);
  ();
}
}
```

## ReactDOMServer

reason-react's equivalent of `ReactDOMServer` from `react-dom/server` exposes

- `renderToString` : `React.element => string`
- `renderToStaticMarkup` : `React.element => string`

More info about `ReactDOMServer` can be found in the [official React documentation](https://react.dev/reference/react-dom/server).
