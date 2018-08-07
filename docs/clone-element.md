---
title: cloneElement
---

Signature: `let cloneElement: (reactElement, ~props: Js.t({..})=?, 'anyChildrenType) => reactElement`

Same as ReactJS' [cloneElement](https://reactjs.org/docs/react-api.html#cloneelement). However, adding extra props to a ReasonReact component doesn't make sense; you'd use a [**render prop**](https://reactjs.org/docs/render-props.html). Therefore, `ReasonReact.cloneElement` is only used in edge-cases to convert over existing code.

```reason
let clonedElement =
  ReasonReact.cloneElement(
    <div className="foo" />,
    ~props={"payload": 1},
    [||]
  );
```

The `props` value is unsafe, be careful!

You can also use `cloneElement` to simulate [prop spreading](props-spread.md), but this is discouraged in ReasonReact.
