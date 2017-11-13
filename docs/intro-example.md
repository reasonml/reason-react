---
id: intro-example
title: Intro Example
---

Here is a small overview of the ReasonReact API before we start. No worries if some of these are unfamiliar; the docs cover all of them.

```reason
let component = ReasonReact.statelessComponent("Greeting");

/* underscores before names indicate unused variables. We name them for clarity */
let make = (~name, _children) => {
  ...component,
  render: (_self) => <button> {ReasonReact.stringToElement("Hello!")} </button>
};
```
