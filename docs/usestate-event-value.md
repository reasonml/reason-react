---
title: Using Event Values With useState
---

In ReactJS, it's common to update a component's state based on an event's
value. Because ReasonReact's `useState` is slightly different than ReactJS,
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
    onChange={event => setName(_ => ReactEvent.Form.target(event)##value)
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
is that ReasonReact enforces that we always use callbacks.

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
        let value = ReactEvent.Form.target(event)##value;
        setName(_ => value)
      }
    }
  />;
};
```

The key is to extract the `value` from the `event` *before* we send it to
`setName`. Even if React cleans up the event, we don't lose access to the
value we need.
