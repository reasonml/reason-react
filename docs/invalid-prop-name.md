---
title: Invalid Prop Name
---

Prop names like `type` (as in `<input type="text" />`) aren't syntactically valid; `type` is a reserved keyword in Reason/OCaml. Use `<input type_="text" />` instead. This follows BuckleScript's [name mangling rules](https://bucklescript.github.io/docs/en/object.html#invalid-field-names).

In the case of binding to React libraries written in JavaScript whose prop names conflict with Reason's keywords (e.g. `to`), you can get around the problem by prefixing the offending prop name with an underscore (`_`) and Reason will autmoatically strip the underscore in the prop name when it compiles to JavaScript.
For example, to bind to this JSX output:
```jsx
import {NavLink} from "react-router-dom"
let output = (
  <NavLink to="/some-where">This is a link</NavLink>
);
```
where `to` is a required prop and `activeClassName` is an optional prop, you can write the binding as follows:
```reason
/* In ReactRouter.re */
module NavLink {
  [@bs.module "react-router-dom"] [@react.component]
  external make: (
    ~_to: string,
    ~activeClassName: string=?,
    ~children: React.element=?
  ) => React.element = "NavLink";
};
```
and use this binding as follows:
```reason
<ReactRouter.NavLink
  _to="/some-where/"
  activeClassName="someClass">
  {React.string("This is a link")}
</ReactRouter.NavLink>
```

Alternative, you can write the binding more explicitly as a pair of functions `make` and `makeProps`:
```reason
/* In ReactRouter.re */
module NavLink {
  [@bs.deriving abstract]
  type props = {
    [@bs.optional] activeClassName: string,
    [@bs.as "to"] to_: string
  };

  [@bs.module "react-router-dom"]
  external make: props => React.element = "NavLink";
  let makeProps = props;
};

```
The choice of what field name to give as the alias for `to` is arbitrary as long as it doesn't conflict with any keyword. Use the binding as follows:
```reason
<ReactRouter.NavLink
  to_="/some-where/"
  activeClassName="someClass">
  {React.string("This is a link")}
</ReactRouter.NavLink>
```


For `aria-*`: use the camelCased `ariaFoo`. E.g. `ariaLabel`. For DOM components, we'll translate it to `aria-label` under the hood.

For `data-*`, this is a bit trickier; words with `-` in them aren't valid in Reason/OCaml. When you do want to write them, e.g. `<div data-name="click me" />`, use the following:

```reason
ReactDOMRe.createElementVariadic(
  "div",
  ~props=(ReactDOMRe.objToDOMProps({"data-name": "click me"})),
  [||]
)
```

For non-DOM components, you need to pick valid prop names.
