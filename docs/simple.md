---
title: Simple
---
See https://reasonml.github.io/docs/en/jsx.html for the usage of JSX in Reason.

A simple stateless component is defined as:
```reason
let component = ReasonReact.statelessComponent("Page");

let handleClick = (_event, _self) => Js.log("clicked!");

let make = (~message, _children) => {
  ...component,
  render: self =>
    <div onClick={self.handle(handleClick)}>{ReasonReact.string(message)}</div>
};
```

Usage in another file:

```reason
ReactDOMRe.renderToElementWithId(<Page message="Hello!" />, "index");
```

In the same file, you'd do:

```reason
ReactDOMRe.renderToElementWithId(ReasonReact.element(make(~message="Hello!", [||])), "index");
```
### Option(al) argument
When an argument is an option it can passed with a "?" without unwrapping it. 
```reason
let component = ReasonReact.statelessComponent("WelcomeMessage");

let make = (~message, ~myClass=None, _children) => {
  ...component,
  render: (_) =>
    <div className=?myClass> (ReasonReact.string(message)) </div>,
};
```

Usage:
```reason
ReactDOMRe.renderToElementWithId(<WelcomeMessage message="Welcome!" />, "index");
/* Or */
ReactDOMRe.renderToElementWithId(<WelcomeMessage message="Have fun with Reason!" myClass="subtle" />, "index");
```
### Examples
See https://github.com/reasonml-community/reason-react-example for examples you can clone and run.
