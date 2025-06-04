---
title: useState
---

The setState function is used to update the state. It accepts a new state value and enqueues a re-render of the component.

[React.js docs for useState](https://reactjs.org/docs/hooks-reference.html#usestate)

### Usage

The `useState` hook takes a function that returns the initial state value and returns a tuple with the current state value and a function to update the state.

reason-react exposes the `useState` hook with the initialiser function, not with the inmediate value.

```reason
let useState: (unit => 'state) => ('state, 'state => unit);
```

### A Simple Counter Example

```reason
[@react.component]
let make = (~initialCount) => {
  let (count, setCount) = React.useState(_ => initialCount);

  <section>
    {React.string("Count: " ++ Int.to_string(count))}
    <button onClick={_ => setCount(_ => initialCount)}>
      {React.string("Reset")}
    </button>
    <button onClick={_ => setCount(prevCount => prevCount - 1)}>
      {React.string("-")}
    </button>
    <button onClick={_ => setCount(prevCount => prevCount + 1)}>
      {React.string("+")}
    </button>
  </section>;
};
```

## Using Event values with useState

In ReactJS, it's common to update a component's state based on an event's
value. Because reason-react's `useState` is slightly different than ReactJS,
directly translating JavaScript components to Reason can lead to a common bug.

```js
/* App.js */
function App() {
  const [name, setName] = React.useState("John");
  return (
    <input
      type="text"
      value={name}
      onChange={(event) => setName(event.target.value)}
    />
  );
}
```

If we convert this component to reason, we may attempt to write this:

```reason
/* App.re */
/* WRONG! Don't do this! */
[@react.component]
let make = () => {
  let (name, setName) = React.useState(() => "John");
  <input
    type_="text"
    value={name}
    onChange={event => setName(_ => React.Event.Form.target(event)##value)
  />;
};
```

Can you spot the bug?

In the Reason version, the `onChange` callback won't correctly update the state.
This happens because the callback passed to `setName` is run *after* the `event`
variable is cleaned up by React, so the `value` field won't exist when it's
needed.

This isn't actually any different than how events and `useState` hooks work in
ReactJS when you choose to use a callback with `setName`. The only difference
is that reason-react enforces that we always use callbacks.

## Solution

Fortunately, fixing this bug is simple:

```reason
/* App.re */
/* CORRECT! This code is bug-free. 👍 */
[@react.component]
let make = () => {
  let (name, setName) = React.useState(() => "John");
  <input
    type_="text"
    value={name}
    onChange={
      event => {
        let value = React.Event.Form.target(event)##value;
        setName(_ => value)
      }
    }
  />;
};
```

The key is to extract the `value` from the `event` *before* we send it to
`setName`. Even if React cleans up the event, we don't lose access to the
value we need.

[melange-url-docs]: https://melange.re/v4.0.0
