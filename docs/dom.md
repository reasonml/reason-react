---
id: dom
title: Working with DOM
---

For example, you can dangerously access `event.target.value` as `ReactDOMRe.domElementToObj(ReactEventRe.Form.target(event))##value`.

### ReactDOM

ReasonReact's ReactDOM module is called `ReactDOMRe`. The module exposes helpers that work with familiar ReactJS idioms. For example, to access `event.target.value`, you can do `ReactDOMRe.domElementToObj(ReactEventRe.Form.target(event))##value`.

- `render` : `(ReasonReact.reactElement, Dom.element) => unit`

- `unmountComponentAtNode` : `Dom.element => unit`

- `findDOMNode` : `ReasonReact.reactRef => Dom.element`

- `objToDOMProps` : `Js.t({..}) => reactDOMProps` (see use-case in [Invalid Prop Name](invalid-prop-name.md))

- `domElementToObj` : `Dom.element => Js.t({..})`: turns a DOM element into a Js object whose fields that you can dangerously access.

And two extra convenience utilities:

- `renderToElementWithClassName` : `(ReasonReact.reactElement, string) => unit`: finds the (first) element of the provided class name and `render` to it.

- `renderToElementWithId` : `(ReasonReact.reactElement, string) => unit`: finds the element of the provided id and `render` to it.

### ReactDOMServer

ReasonReact's equivalent `ReactDOMServerRe` exposes:

- `renderToString` : `ReactRe.reactElement => string`

- `renderToStaticMarkup` : `ReactRe.reactElement => string`
