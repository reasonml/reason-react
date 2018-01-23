---
title: Subscriptions Helper
---

In a large, heterogeneous app, you might often have legacy or interop data sources that come from outside of the React/ReasonReact tree, or a timer, or some browser event handling. You'd listen and react to these changes by, say, updating the state.

For example, Here's what you're probably doing currently, for setting up a timer event:

```reason
type state = {
  timerId: ref(option(Js.Global.intervalId))
};

let component = ReasonReact.reducerComponent("Todo");

let make = (_children) => {
  ...component,
  initialState: () => {timerId: ref(None)},
  didMount: (self) => {
    self.state.timerId := Some(Js.Global.setInterval(() => Js.log("hello!"), 1000));
    ReasonReact.NoUpdate
  },
  willUnmount: (self) => {
    switch (self.state.timerId^) {
    | Some(id) => Js.Global.clearInterval(id);
    | None => ()
    }
  },
  render: ...
};
```

Notice a few things:

- This is rather boilerplate-y.
- Did you use a `ref(option(foo))` type correctly instead of a mutable field, as indicated by the [Instance Variables section](instance-variables.md)?
- Did you remember to free your timer subscription in `willUnmount`?

For the last point, go search your codebase and see how many `setInterval` you have compared to the amount of `clearInterval`! We bet the ratio isn't 1 =). Likewise for `addEventListener` vs `removeEventListener`.

To solve the above problems and to codify a good practice, ReasonReact provides a helper field in the component spec, called `subscriptions`. It asks for a callback of type `self => list(subscription)`.

`subscription` itself is the type `Sub(unit => 'token, 'token => unit)`. In plain words, it means that it:

- accepts a function that returns a subscription token (a timer id, event listener token, etc.)
- accepts a second function that, given the token, does some side-effect (probably clear the subscription).

Here's the previous example rewritten:

```reason
let component = ReasonReact.statelessComponent("Todo");

let make = (_children) => {
  ...component,
  subscriptions: (self) => [
    Sub(
      () => Js.Global.setInterval(() => Js.log("hello!"), 1000),
      Js.Global.clearInterval
    )
  ],
  render: ...
}
```

Now you won't ever forget to clear your timer!

**Note**: `subscriptions` is called **once**, after the component is mounted. It's not re-evaluated every time the component updates.

**Note**: this is an **interop helper**. This isn't meant to be used as a shiny first-class feature for e.g. adding more flux stores into your app (for that purpose, please use our [local reducer](state-actions-reducer.md#actions-reducer)). Every time you use `subscriptions`, consider it as a simple, pragmatic and performant way to talk to the existing world.
