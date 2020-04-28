---
title: useState Hook
---

[React.js docs for useState](https://reactjs.org/docs/hooks-reference.html#usestate)

>The setState function is used to update the state. It accepts a new state value and enqueues a re-render of the component.

### A Simple Counter Example

```reason
type action =
  | Tick;

type state = {count: int};

[@react.component]
let make = (~initialCount) => {
  let (count, setCount) = React.useState(_ => initialCount);

  <>
    {React.string("Count: " ++ count)}
    <button onClick={_ => setCount(_ => initialCount)}>
      {React.string("Reset")}
    </button>
    <button onClick={_ => setCount(prevCount => prevCount - 1)}>
      {React.string("-")}
    </button>
    <button onClick={_ => setCount(prevCount => prevCount + 1)}>
      {React.string("+")}
    </button>
  </>;
};
```
