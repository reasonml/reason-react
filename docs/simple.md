---
id: simple
title: Simple
---

See https://github.com/reasonml-community/reason-react-example for examples you can clone and run. This page copy pastes a few from there for ease of reading.

```reason
let component = ReasonReact.statelessComponent("Page");
let handleClick = (_event, _self) => Js.log("clicked!");
let make = (~message, _children) => {
  ...component,
  render: (self) =>
    <div onClick=(self.handle(handleClick))> (ReasonReact.stringToElement(message)) </div>
};
```

Usage in another file:

```reason
ReactDOMRe.renderToElementWithId(<Page message="Hello!" />, "index");
```

In the same file, you'd do:

```reason
ReactDOMRe.renderToElementWithId(make(~message="Hello!", [||]), "index");
```
