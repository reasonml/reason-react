---
title: Intro Example
---

Here is a small overview of the ReasonReact API before we start. No worries if some of these are unfamiliar; the docs cover all of them.

## The component "Greeting"

```reason
/* file: Greeting.re */

[@react.component]
let make = (~name) =>
  <button> {ReasonReact.string("Hello " ++ name ++ "!")} </button>;
```

## A usage of the component

(assuming there's a `div` on the page with id `greeting`)

```reason
/* file: Index.re */

ReactDOMRe.renderToElementWithId(<Greeting name="John" />, "greeting");
```
