---
title: cloneElement
---

Signature: `let cloneElement: (React.element, ~props: Js.t({..})=?, 'anyChildrenType) => React.element`

Same as ReactJS' [cloneElement](https://reactjs.org/docs/react-api.html#cloneelement). However, adding extra props to a reason-react component doesn't make sense; you'd use a [**render prop**](https://reactjs.org/docs/render-props.html). Therefore, `React.cloneElement` is only used in edge-cases.

```reason
let clonedElement =
  React.cloneElement(
    <div className="foo" />,
    ~props={"payload": 1},
    [||]
  );
```

The `props` value is unsafe, be careful!

You can also use `cloneElement` to simulate [prop spreading](props-spread.md), but this is discouraged in reason-react.
