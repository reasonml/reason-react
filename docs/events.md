---
id: events
title: Events
---
ReasonReact events map cleanly to ReactJS [synthetic events](https://facebook.github.io/react/docs/events.html). More info in the [inline docs](https://github.com/reasonml/reason-react/blob/380358e5894d4223e7dd9c1fb2df72f0756231bc/src/reactEventRe.rei#L1).

If you're accessing fields on your event object, like `event.target.value`, you'd use a combination of a `ReactDOMRe` helper and [BuckleScript's `##` object access FFI](http://bucklescript.github.io/bucklescript/Manual.html#_binding_to_js_objects):

```reason
(ReactDOMRe.domElementToObj (ReactEventRe.Form.target event))##value
```

More info on the `ReactDOMRe` module below in the [Working with DOM](#reason-react-working-with-dom) section.

## Styles

Since CSS-in-JS is all the rage right now, we'll recommend our official pick soon. In the meantime, for inline styles, there's the `ReactDOMRe.Style.make` API:

```reason
<div style=(
  ReactDOMRe.Style.make
    color::"#444444"
    fontSize::"68px"
    ()
)/>
```

It's a labeled (typed!) function call that maps to the familiar style object `{color: '#444444', fontSize: '68px'}`. **Note** that `make` returns an opaque `ReactDOMRe.style` type that you can't read into. We also expose a `ReactDOMRe.Style.combine` that takes in two `style`s and combine them.

### Escape Hatch: `unsafeAddProp`

The above `Style.make` API will safely type check every style field! However, we might have missed some more esoteric fields. If that's the case, the type system will tell you that the field you're trying to add doesn't exist. To remediate this, we're exposing a `ReactDOMRe.Style.unsafeAddProp` to dangerously add a field to a style:

```reason
let myStyle = ReactDOMRe.Style.make color::"#444444" fontSize::"68px" ();
let newStyle = ReactDOMRe.Style.unsafeAddProp myStyle "width" "10px";
```
