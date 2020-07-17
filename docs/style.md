---
title: Style
---

Since CSS-in-JS is all the rage right now, we'll recommend our official pick soon. In the meantime, for inline styles, there's the `ReactDOM.Style.make` API:

```reason
<div style=(
  ReactDOM.Style.make(~color="#444444", ~fontSize="68px", ())
)/>
```

It's a labeled (typed!) function call that maps to the familiar style object `{color: '#444444', fontSize: '68px'}`. **Note** that `make` returns an opaque `ReactDOM.style` type that you can't read into. We also expose a `ReactDOM.Style.combine` that takes in two `style`s and combine them.

## Escape Hatch: `unsafeAddProp`

The above `Style.make` API will safely type check every style field! However, we might have missed some more esoteric fields. If that's the case, the type system will tell you that the field you're trying to add doesn't exist. To remediate this, we're exposing a `ReactDOM.Style.unsafeAddProp` to dangerously add a field to a style:

```reason
let myStyle = ReactDOM.Style.make(~color="#444444", ~fontSize="68px", ());
let newStyle = ReactDOM.Style.unsafeAddProp(myStyle, "width", "10px");
```
