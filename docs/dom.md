---
title: Working with DOM
---

## ReactDOM

ReasonReact's ReactDOM module is called `ReactDOMRe`. The module exposes helpers that work with familiar ReactJS idioms. For example, to access `event.target.value`, you can do `ReactDOMRe.domElementToObj(ReactEventRe.Form.target(event))##value`.

- `render` : `(ReasonReact.reactElement, ReactDOMRe.container) => unit`
- `unmountComponentAtNode` : `Dom.element => unit`
- `findDOMNode` : `ReasonReact.reactRef => Dom.element`
- `hydrate` : `(ReasonReact.reactElement, ReactDOMRe.container) => unit`
- `objToDOMProps` : `Js.t({..}) => reactDOMProps` (see use-case in [Invalid Prop Name](invalid-prop-name.md))
- `domElementToObj` : `Dom.element => Js.t({..})`: turns a DOM element into a Js object whose fields that you can dangerously access.

> ReactDOMRe.container can be either `Element(element)` or `Selector(string)`

## ReactDOMServer

ReasonReact's equivalent `ReactDOMServerRe` exposes:

- `renderToString` : `ReactRe.reactElement => string`

- `renderToStaticMarkup` : `ReactRe.reactElement => string`
