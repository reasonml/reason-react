---
id: js-using-reason
title: ReactJS using ReasonReact
---
PageReason.re:
```reason
let component = ReasonReact.statelessComponent("PageReason");

let make = (~message, ~extraGreeting=?, _children) => {
  ...component,
  render: (_self) => {
    let greeting =
      switch extraGreeting {
      | None => "How are you?"
      | Some((g)) => g
      };
    <div> <MyBannerRe show=true message=(message ++ (" " ++ greeting)) /> </div>
  }
};

let jsComponent =
  ReasonReact.wrapReasonForJs(
    ~component=component,
    (jsProps) =>
      make(
        ~message=jsProps##message,
        ~extraGreeting=?Js.Nullable.to_opt(jsProps##extraGreeting),
        [||]
      )
  );

```
Then use it on the JS side through
```javascript
var PageReason = require('path/to/PageReason.js').jsComponent;
```
