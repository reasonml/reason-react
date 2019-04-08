---
title: Counter
---

Demonstrates calling an async "setState" in ReasonReact.

```reason
type action =
  | Tick;

type state = {
  count: int,
};

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(
    (state, action) =>
      switch (action) {
      | Tick => {count: state.count + 1}
      },
    {count: 0}
  );

  React.useEffect0(() => {
    let timerId = Js.Global.setInterval(() => dispatch(Tick), 1000);
    Some(() => Js.Global.clearInterval(timerId))
  });
  
  <div>{ReasonReact.string(string_of_int(state.count))}</div>;
};
```