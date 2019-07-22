---
title: Simple
---

```reason
/* Greeting.re */

[@react.component]
let make = (~message) => <h1> {React.string(message)} </h1>;
```

Usage in another file:

```reason
ReactDOMRe.renderToElementWithId(
  <Greeting message="Hello World!" />,
  "index",
);
```
