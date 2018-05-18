---
title: cloneElement
---

Signature: `let cloneElement: (reactElement, ~props: Js.t({..})=?, 'anyChildrenType) => reactElement`

Same as ReactJS' [cloneElement](https://reactjs.org/docs/react-api.html#cloneelement). However, adding extra props to a ReasonReact component doesn't make sense; you'd use a [**render prop**](https://reactjs.org/docs/render-props.html). Therefore, `ReasonReact.cloneElement` is only used for edge-case interop situations. For example, `data-*` attributes aren't syntactically valid as a function label. The following doesn't parse:

```reason
<div data-payload=1 className="foo" />
```

You'd use `cloneElement` to circumvent it like so:

```reason
let myElement =
  ReasonReact.cloneElement(
    <div className="foo" />,
    ~props={"data-payload": 1},
    [||]
  );
```

This will assign the extra `data-payload` props (**untyped**, be careful!) onto the `div`, through a clever, syntactically valid use of Reason's JS object sugar for [BuckleScript objects](https://bucklescript.github.io/docs/en/object.html#object-as-record).

For non-DOM components, you need to use valid prop names.

You can also use `cloneElement` to simulate [prop spreading](props-spread.md), but this is discouraged in ReasonReact.
