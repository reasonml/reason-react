---
title: Working with DOM
---

### ReactDOM

ReasonReact's ReactDOM module is called `ReactDOMRe`. The module exposes helpers that work with familiar ReactJS idioms. For example, to access `event.target.value`, you can do `ReactDOMRe.domElementToObj(ReactEventRe.Form.target(event))##value`.

- `render` : `(ReasonReact.reactElement, Dom.element) => unit`
- `unmountComponentAtNode` : `Dom.element => unit`
- `findDOMNode` : `ReasonReact.reactRef => Dom.element`
- `hydrate` : `(ReasonReact.reactElement, Dom.element) => unit`
- `objToDOMProps` : `Js.t({..}) => reactDOMProps` (see use-case in [Invalid Prop Name](invalid-prop-name.md))
- `domElementToObj` : `Dom.element => Js.t({..})`: turns a DOM element into a Js object whose fields that you can dangerously access.

And 4 convenience utilities:

- `renderToElementWithClassName` : `(ReasonReact.reactElement, string) => unit`: finds the (first) element of the provided class name and `render` to it.
- `renderToElementWithId` : `(ReasonReact.reactElement, string) => unit`: finds the element of the provided id and `render` to it.
- `hydrateToElementWithClassName`, `hydrateToElementWithId`: same.

### ReactDOMServer

ReasonReact's equivalent `ReactDOMServerRe` exposes:

- `renderToString` : `ReactRe.reactElement => string`

- `renderToStaticMarkup` : `ReactRe.reactElement => string`
