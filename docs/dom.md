---
title: Working with DOM
---

## ReactDOM

ReasonReact's ReactDOM module is called `ReactDOMRe`. The module exposes helpers that work with familiar ReactJS idioms. For example, to access `event.target.value`, you can do `ReactDOMRe.domElementToObj(ReactEventRe.Form.target(event))##value`.

- `render` : `(React.reactElement, Dom.element) => unit`
- `unmountComponentAtNode` : `Dom.element => unit`
- `findDOMNode` : `React.reactRef => Dom.element`
- `hydrate` : `(React.reactElement, Dom.element) => unit`
- `objToDOMProps` : `Js.t({..}) => reactDOMProps` (see use-case in [Invalid Prop Name](invalid-prop-name.md))
- `domElementToObj` : `Dom.element => Js.t({..})`: turns a DOM element into a Js object whose fields that you can dangerously access.

And 4 convenience utilities:

- `renderToElementWithClassName` : `(React.reactElement, string) => unit`: finds the (first) element of the provided class name and `render` to it.
- `renderToElementWithId` : `(React.reactElement, string) => unit`: finds the element of the provided id and `render` to it.
- `hydrateToElementWithClassName`, `hydrateToElementWithId`: same.

## ReactDOMServer

ReasonReact's equivalent `ReactDOMServerRe` exposes:

- `renderToString` : `React.reactElement => string`

- `renderToStaticMarkup` : `React.reactElement => string`
