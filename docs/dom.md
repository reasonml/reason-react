---
title: Working with DOM
---

## ReactDOM

ReasonReact's ReactDOM module is called `ReactDOM`. The module exposes helpers that work with familiar ReactJS idioms.

- `render` : `(React.element, Dom.element) => unit`
- `unmountComponentAtNode` : `Dom.element => unit`
- `hydrate` : `(React.element, Dom.element) => unit`
- `createPortal` : `(React.component('props), 'props) => React.element`

## ReactDOMServer

ReasonReact's equivalent `ReactDOMServer` exposes:

- `renderToString` : `React.element => string`
- `renderToStaticMarkup` : `React.element => string`
