---
title: Working with DOM
---

## ReactDOM

ReasonReact's ReactDOM module is called `ReactDOM`. The module exposes helpers that work with familiar ReactJS idioms

- `ReactDOM.querySelector` : `string => option(Dom.element)`
- `ReactDOM.Client.createRoot` : `Dom.element => Client.root`
- `ReactDOM.Client.render` : `(Client.root, React.element) => unit`
- `ReactDOM.Client.hydrateRoot` : `(Dom.element, React.element) => Client.root`
- `ReactDOM.createPortal` : `(React.element, Dom.element) => React.element`
- `ReactDOM.unmountComponentAtNode` : `Dom.element => unit`

More info about `ReactDOM` can be found in the [official ReactDOM documentation](https://react.dev/reference/react-dom).

## ReactDOMServer

ReasonReact's equivalent of `ReactDOMServer` from `react-dom/server` exposes

- `renderToString` : `React.element => string`
- `renderToStaticMarkup` : `React.element => string`

More info about `ReactDOMServer` can be found in the [official React documentation](https://react.dev/reference/react-dom/server).
