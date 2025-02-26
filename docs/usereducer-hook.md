---
title: useReducer
---

[React.js docs for useReducer](https://reactjs.org/docs/hooks-reference.html#usereducer)

> useReducer is usually preferable to useState when you have complex state logic that involves multiple sub-values or when the next state depends on the previous one. useReducer also lets you optimize performance for components that trigger deep updates because you can pass dispatch down instead of callbacks.

```reason
/* we can create anything as the type for action, here we use a variant with 2 cases. */
type action =
  | Increment
  | Decrement;

/* `state` could also be anything. In this case, we want an int */
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
