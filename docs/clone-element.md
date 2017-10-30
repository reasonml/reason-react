---
id: clone-element
title: cloneElement
---
Signature: `let cloneElement: (reactElement, ~props: Js.t({..})=?, 'anyTypeHere) => reactElement`

Same as ReactJS' [cloneElement](https://facebook.github.io/react/docs/react-api.html#cloneelement). However, adding extra props to a ReasonReact component doesn't make sense; you'd either curry the props or use other patterns. Therefore, `ReasonReact.cloneElement` is only used for edge-case interop situations. For example, `data-*` and `aria-*` attributes aren't syntactically valid as a function label. The following doesn't parse:

```reason
<div data-payload=1 aria-label="click me" className="foo" />
```

You'd use `cloneElement` to circumvent it like so:

```reason
let myElement =
  ReasonReact.cloneElement(
    <div className="foo" />,
    ~props={"data-payload": 1, "aria-label": "click me"},
    [||]
  );
```

This will assign the extra `data-payload` and `aria-label` props (**both untyped**, be careful!) onto the `div`, through a clever, syntactically valid use of Reason's JS object sugar for [BuckleScript objects](http://bucklescript.github.io/bucklescript/Manual.html#_create_js_objects_using_bs_obj).

For non-DOM components, you need to use valid prop names.

You can also use `cloneElement` to simulate [prop spreading](props-spread.md), but this is discouraged in ReasonReact.
