---
id: intro-example
title: Intro Example
---
```reason
let component = ReasonReact.statelessComponent "Greeting";

/* underscore before names indicate unused variables. We name them for clarity */
let make ::name _children => {
  ...component,
  render: fun self => <button> (ReasonReact.stringToElement "Hello!") </button>
};
```
