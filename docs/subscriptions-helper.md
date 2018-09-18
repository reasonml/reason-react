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

let make = _children => {
  ...component,
  initialState: () => {timerId: ref(None)},
  didMount: self => {
    self.state.timerId := Some(Js.Global.setInterval(() => Js.log("hello!"), 1000));
  },
  willUnmount: self => {
    switch (self.state.timerId^) {
    | Some(id) => Js.Global.clearInterval(id);
    | None => ()
    }
  },
  render: /* ... */
};
```

Notice a few things:

- This is rather boilerplate-y.
- Did you use a `ref(option(foo))` type correctly instead of a mutable field, as indicated by the [Instance Variables section](instance-variables.md)?
- Did you remember to free your timer subscription in `willUnmount`?

For the last point, go search your codebase and see how many `setInterval` you have compared to the amount of `clearInterval`! We bet the ratio isn't 1 =). Likewise for `addEventListener` vs `removeEventListener`.

To solve the above problems and to codify a good practice, ReasonReact provides a helper field in `self`, called `onUnmount`. It asks for a callback of type `unit => unit` in which you free your subscriptions. It'll be called before the component unmounts.

Here's the previous example rewritten:

```reason
let component = ReasonReact.statelessComponent("Todo");

let make = _children => {
  ...component,
  didMount: self => {
    let intervalId = Js.Global.setInterval(() => Js.log("hello!"), 1000);
    self.onUnmount(() => Js.Global.clearInterval(intervalId));
  },
  render: /* ... */
};
```

Now you won't ever forget to clear your timer!

## Design Decisions

**Why not just put some logic in the willUnmount `lifecycle`**? Definitely do, whenever you could. But sometimes, folks forget to release their subscriptions inside callbacks:

```reason
let make = _children => {
  ...component,
  reducer: (action, state) => {
    switch (action) {
    | Click => ReasonReact.SideEffects(self => {
        fetchAsyncData(result => {
          self.send(Data(result))
        });
      })
    }
  },
  render: /* ... */
};
```

If the component unmounts and _then_ the `fetchAsyncData` calls the callback, it'll accidentally call `self.send`. Using `let cancel = fetchAsyncData(...); self.onUnmount(() => cancel())` is much easier.

**Note**: this is an **interop helper**. This isn't meant to be used as a shiny first-class feature for e.g. adding more flux stores into your app (for that purpose, please use our [local reducer](state-actions-reducer.md#actions-reducer)). Every time you use `self.onUnmount`, consider it as a simple, pragmatic and performant way to talk to the existing world.
