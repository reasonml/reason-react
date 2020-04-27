---
title: Adding data-* attributes
---

Reason doesn't currently supporting using props with dashes, ie: `data-id` or `data-whatever`. There's a great way you can overcome this by creating a `Spread` component:

```reason
/* Spread.re */
[@react.component]
let make = (~props, ~children) => ReasonReact.cloneElement(children, ~props, [||]);
```

Using Spread:

```reason
[@react.component]
let make = () =>
  <Spread props={"data-cy": name}>
    /* This div will now have the `data-cy` attribute in the DOM! */
    <div />
  </Spread>;
```
