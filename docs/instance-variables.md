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

**All your instance variables (subscriptions, refs, etc.) must be in state fields marked as a `ref`**. Don't directly use a `mutable` field on the state record, use an immutable field pointing to a Reason `ref`. Why such constraint? To prepare for concurrent React which needs to manage side-effects & mutations more formally. More details [here](https://reasonml.github.io/try/?reason=C4TwDgpgBAzlC8UDeBDAXFAlgO2AGlgHsBbCASWxmBWwGMIA1FAJw2YgDMtcBfAbgBQAegBUUbIQDuUEUIEAbCMFjVg0REgFQo6KAEY8WoqQpUa9JqyjsuAJgH9hYiMQCu8lGqgADM2u86tPQwcBzMJFC08oQwruwAdFAAKgAW0OwoACZQhFy+qhABxJgA5inKAEbQZopQFSBQwGmNmKRYwADkcBAAHhC0rmqZGLJOUByu2Mh+EDwIAHzjk1AAFACUC1AAShAoMITYOyi0wPEAqmCZntBI8XczBBUec6OKyjO2CMh38Q86GABmRyiOqDKBuVSYA45PIzALYCAQTJwYCEOrpTiKE5I7g+D4BKiYeTyACEMjkM1+JHIlGodEYLCgaEQABZBCCYClCO5slUoCzyQIAFIweLREpQEkfKkmWnmBnMdliJqYOCSbnyTLYDrKdXMADWWC4kmgmTRoEgOgQqAwOHw4MGKCe1WppjpFhYtt45KAA) if you're ever interested.

