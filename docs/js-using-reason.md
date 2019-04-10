---
title: ReactJS using ReasonReact
---

`PageReason.re`:

```reason
/* ReasonReact used by ReactJS */
[@react.component]
let make = (~message, ~extraGreeting=?) => {
  let greeting =
    switch (extraGreeting) {
    | None => "How are you?"
    | Some(g) => g
    };
  <div> <MyBannerRe show=true message={message ++ " " ++ greeting} /> </div>;
};
```

Then use it on the JS side through

```javascript
var PageReason = require('path/to/PageReason.js').make;
```
