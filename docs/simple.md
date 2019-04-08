---
title: Simple
---

See https://github.com/reasonml-community/reason-react-example for examples you can clone and run. This page copy pastes a few from there for ease of reading.

```reason
let handleClick = (_event) => Js.log("clicked!");

let make = (~message) =>
  <div onClick={handleClick}>{React.string(message)}</div>;
```

Usage in another file:

```reason
ReactDOMRe.renderToElementWithId(<Page message="Hello!" />, "index");
```

In the same file, you'd do:

```reason
ReactDOMRe.renderToElementWithId(React.createElement(Page.make, Page.makeProps(~message="Hello!", ())), "index");
```
