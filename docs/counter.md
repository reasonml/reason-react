---
title: Counter
---

Demonstrates calling an async "setState" in ReasonReact.

```reason
type action =
  | Tick;

type state = {
  count: int,
  timerId: ref(option(Js.Global.intervalId))
};

let component = ReasonReact.reducerComponent("Counter");

let make = _children => {
  ...component,
  initialState: () => {count: 0, timerId: ref(None)},
  reducer: (action, state) =>
    switch (action) {
    | Tick => ReasonReact.Update({...state, count: state.count + 1})
    },
  didMount: self => {
    self.state.timerId :=
      Some(Js.Global.setInterval(() => self.send(Tick), 1000));
    ReasonReact.NoUpdate;
  },
  willUnmount: self => {
    switch (self.state.timerId^) {
    | Some(id) => Js.Global.clearInterval(id)
    | None => ()
    }
  },
  render: ({state}) =>
    <div>{ReasonReact.stringToElement(string_of_int(state.count))}</div>
};
```

Or, using the [subscriptions helper](subscriptions-helper.md):

```reason
type action =
  | Tick;

type state = {count: int};

let component = ReasonReact.reducerComponent("Counter");

let make = _children => {
  ...component,
  initialState: () => {count: 0},
  reducer: (action, state) =>
    switch (action) {
    | Tick => ReasonReact.Update({count: state.count + 1})
    },
  subscriptions: self => [
    Sub(
      () => Js.Global.setInterval(() => self.send(Tick), 1000),
      Js.Global.clearInterval
    )
  ],
  render: ({state}) =>
    <div>{ReasonReact.stringToElement(string_of_int(state.count))}</div>
};
```
