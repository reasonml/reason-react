---
title: Click Counter
---

Demonstrates working with state and reducer in ReasonReact.

```reason
type action =
  | Modify(int)
  | Reset;

type state = {
  count: int
};

let component = ReasonReact.reducerComponent("Counter");

let s = ReasonReact.string; /* Convenience helper */

let make = _children => {
  ...component,
  initialState: () => {count: 0},
  reducer: (action, state) =>
    switch (action) {
    | Modify(amount) => ReasonReact.Update({ count: state.count + amount })
    | Reset => ReasonReact.Update({ count: 0 })
    },
  render: ({state, send}) =>
    <div>
      <h3>{s("Clicked: " ++ string_of_int(state.count))}</h3>
      <button onClick={_event => send(Modify(1))}>{s("Increment")}</button>
      <button onClick={_event => send(Modify(-1))}>{s("Decrement")}</button>
      <button onClick={_event => send(Reset)}>{s("Reset")}</button>
    </div>
};
```
