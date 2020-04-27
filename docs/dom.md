---
title: Working with DOM
---

## ReactDOM

ReasonReact's ReactDOM module is called `ReactDOMRe`. The module exposes helpers that work with familiar ReactJS idioms. For example, to access `event.target.value`, you can do `ReactEvent.Form.target(event)##value`.

- `render` : `(ReasonReact.reactElement, Dom.element) => unit`
- `unmountComponentAtNode` : `Dom.element => unit`
- `findDOMNode` : `ReasonReact.reactRef => Dom.element`
- `hydrate` : `(ReasonReact.reactElement, Dom.element) => unit`
- `objToDOMProps` : `Js.t({..}) => ReactDOMRe.props` (see use-case in [Invalid Prop Name](invalid-prop-name.md))
- `createElement` : `(string, ~props: ReactDOMRe.props=?, array(ReasonReact.reactElement)) => ReasonReact.reactElement`: the call that lower-case JSX turns into.
- `createElementVariadic`: same as above, but a less performant version, used when there's a children spread and not a static array at the call site: `<div>...myChildren</div>`.
- `domElementToObj` : `Dom.element => Js.t({..})`: turns a DOM element into a Js object whose fields you can dangerously access. Usually not needed.

And 4 convenience utilities:

- `renderToElementWithClassName` : `(ReasonReact.reactElement, string) => unit`: finds the (first) element with the provided class name and `render` to it.
- `renderToElementWithId` : `(ReasonReact.reactElement, string) => unit`: finds the element with the provided id and `render` to it.
- `hydrateToElementWithClassName`, `hydrateToElementWithId`: same.

## ReactDOMServer

ReasonReact's equivalent `ReactDOMServerRe` exposes:

- `renderToString` : `ReactRe.reactElement => string`

- `renderToStaticMarkup` : `ReactRe.reactElement => string`
