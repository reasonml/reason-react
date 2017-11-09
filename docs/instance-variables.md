---
id: instance-variables
title: Instance Variables
---

A common pattern in ReactJS is to attach extra variables onto a component's spec:

```
const Greeting = React.createClass({
  intervalId: null,
  componentDidMount: () => this.intervalId = setInterval(...),
  render: ...
});
```

In reality, this is nothing but a thinly veiled way to mutate a component's "state", without triggering a re-render. ReasonReact asks you to correctly put these instance variables into your component's `state`, into Reason [`ref`s](https://reasonml.github.io/guide/language/mutation).

```reason
type state = {
  someRandomState: option(string),
  intervalId: ref(option(int))
};

let component = ...; /* remember, `component` needs to be close to `make`, and after `state` type declaration! */

let make = (_children) => {
  ...component,
  initialState: () => {someRandomState: Some("hello"), intervalId: ref(None)},
  didMount: ({state}) => {
    /* mutate the value here */
    state.intervalId := Some(Js.Global.setInterval(...));
    /* no extra state update needed */
    ReasonReact.NoUpdate
  },
  render: ...
};
```

**All your instance variables (subscriptions, refs, etc.) must be in state fields marked as a `ref`**. Don't directly use a `mutable` field on the state record, use an immutable field pointing to a Reason `ref`. Why such constraint? To prepare for concurrent React which needs to manage side-effects & mutations more formally. More details [here](https://reasonml.github.io/try/?reason=C4TwDgpgBAzlC8UDeBDAXFAlgO2AGlgHsBbCASWxmBWwGMIA1FAJw2YgDMAKHYASgC+AbgBQAegBUUbIQDuUCWJEAbCMFjVg0REhFQo6KAEY8eoqQpUa9JqyjtuAJj4jh4qRGIBXZSi1QAAystAINaehg4DmYSKFplQhgvdgA6KAAVAAtodhQAEyhCDkDgiFDiTABzTPUAI2grVShakChgbLbMUixgAHI4CAAPCFovLTyMRXcoDi9sZFKBBAA+GbmoLj4VqAAlCBQYQmw9lFpgFIBVMDy-aCQUh9KCWt8lqdV1UscEZAeUp4MGAAzG5JM0xlBvJpMEdCsUgpoytIIBA8nBgIRmjlOKozqisPMEbdHKEqJhlMoAIQKJSlf4kciUah0RgsKBoRAAFlEYJgmUIPgK9SgnJpIgAUjAUglKlwvvSLEzrKzmAA9Pg8qTtTBwWQC5R5bC9dR65gAaywxVk0DymNAkAMCFQGF4BChKBeDQZlmZNhYLtwbzEQA) if you're ever interested.

