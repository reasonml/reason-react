---
title: useReducer
---

[React.js docs for useReducer](https://reactjs.org/docs/hooks-reference.html#usereducer)

> useReducer is usually preferable to useState when you have complex state logic that involves multiple sub-values or when the next state depends on the previous one. useReducer also lets you optimize performance for components that trigger deep updates because you can pass dispatch down instead of callbacks.

```reason
/* we create a type for the action, but action can be anything */
type action =
  | Increment
  | Decrement;

/* similarly on 'state', it can be anything. In this case, it's an int */
let reducer = (state, action) =>
  switch (action) {
  | Increment => state + 1
  | Decrement => state - 1
  };

[@react.component]
  let make = (~initialValue=0) => {
    let (state, dispatch) = React.useReducer(reducer, initialValue);

    <section>
      <div className="value"> state->React.int </div>
      <button onClick={_ => dispatch(Increment)}>
        "Increment"->React.string
      </button>
      <button onClick={_ => dispatch(Decrement)}>
        "Decrement"->React.string
      </button>
    </section>;
  };
```
