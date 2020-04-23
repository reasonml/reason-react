---
title: useReducer Hook
---

[React.js docs for useReducer](https://reactjs.org/docs/hooks-reference.html#usereducer)

>useReducer is usually preferable to useState when you have complex state logic that involves multiple sub-values or when the next state depends on the previous one. useReducer also lets you optimize performance for components that trigger deep updates because you can pass dispatch down instead of callbacks.

```reason
/* we create a type for the action */
type action =
  | Tick;

/* and do the same for state */
type state = {count: int};

[@react.component]
let make = () => {
  let (state, dispatch) =
    React.useReducer(
      (state, action) =>
        switch (action) {
        | Tick => {count: state.count + 1}
        },
      {count: 0},
    );

  /* useEffect hook takes 0 arguments hence, useEffect0 */
  React.useEffect0(() => {
    let timerId = Js.Global.setInterval(() => dispatch(Tick), 1000);
    Some(() => Js.Global.clearInterval(timerId));
  });

  /* ints need to be converted to strings, that are then consumed by React.string */
  <div> {React.string(string_of_int(state.count))} </div>;
};
```
