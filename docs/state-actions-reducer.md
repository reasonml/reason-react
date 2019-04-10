---
title: State, Actions & Reducer
---

<aside class="warning">
The Record API is in feature-freeze. For the newest features and better support going forward, please consider migrating to the new <a href="https://reasonml.github.io/reason-react/docs/en/components">function components</a>.
</aside>

Finally, we're getting onto stateful components!

ReasonReact stateful components are like ReactJS stateful components, except with the concept of "reducer" (like [Redux](http://redux.js.org)) built in. If that word doesn't mean anything to you, just think of it as a state machine. If _that_ word does mean something to you, just think: "Woah this is great".

To declare a stateful ReasonReact component, instead of `ReasonReact.statelessComponent("MyComponentName")`, use `ReasonReact.reducerComponent("MyComponentName")`.

Here's a complete, working, stateful ReasonReact component. We'll refer to it later on.

```reason
/* State declaration */
type state = {
  count: int,
  show: bool,
};

/* Action declaration */
type action =
  | Click
  | Toggle;

/* Component template declaration.
   Needs to be **after** state and action declarations! */
let component = ReasonReact.reducerComponent("Example");

/* greeting and children are props. `children` isn't used, therefore ignored.
   We ignore it by prepending it with an underscore */
let make = (~greeting, _children) => {
  /* spread the other default fields of component here and override a few */
  ...component,

  initialState: () => {count: 0, show: true},

  /* State transitions */
  reducer: (action, state) =>
    switch (action) {
    | Click => ReasonReact.Update({...state, count: state.count + 1})
    | Toggle => ReasonReact.Update({...state, show: !state.show})
    },

  render: self => {
    let message =
      "You've clicked this " ++ string_of_int(self.state.count) ++ " times(s)";
    <div>
      <button onClick=(_event => self.send(Click))>
        (ReasonReact.string(message))
      </button>
      <button onClick=(_event => self.send(Toggle))>
        (ReasonReact.string("Toggle greeting"))
      </button>
      (
        self.state.show
          ? ReasonReact.string(greeting)
          : ReasonReact.null
      )
    </div>;
  },
};
```

## `initialState`

ReactJS' `getInitialState` is called `initialState` in ReasonReact. It takes `unit` and returns the state type. The state type could be anything! An int, a string, a ref or the common record type, which you should declare **right before the `reducerComponent` call**:

```reason
type state = {count: int, show: bool};

let component = ReasonReact.reducerComponent("Example");

let make = (~onClick, _children) => {
  ...component,
  initialState: () => {count: 0, show: true},
  /* ... other fields */
};

```

Since the props are just the arguments on `make`, feel free to read into them to initialize your state based on them.

## Actions & Reducer

In ReactJS, you'd update the state inside a callback handler, e.g.

```javascript
{
  /* ... other fields */
  handleClick: function() {
    this.setState({count: this.state.count + 1});
  },
  handleSubmit: function() {
    this.setState(...);
  },
  render: function() {
    return (
      <MyForm
        onClick={this.handleClick}
        onSubmit={this.handleSubmit} />
    );
  }
}
```

In ReasonReact, you'd gather all these state-setting handlers into a single place, the component's `reducer`! **Please refer to the first snippet of code on this page**.

**Note**: if you ever see mentions of `self.reduce`, this is the old API. The new API is called `self.send`. The old API's docs are [here](https://github.com/reasonml/reason-react/blob/e17fcb5d27a2b7fb2cfdc09d46f0b4cf765e50e4/docs/state-actions-reducer.md).

A few things:

- There's a user-defined type called **`action`**, named so by convention. It's a variant of all the possible state transitions in your component. _In state machine terminology, this'd be a "token"_.
- A user-defined `state` type, and an `initialState`. Nothing special.
- The current `state` value is accessible through `self.state`, whenever `self` is passed to you as an argument of some function.
- A "**reducer**"! This [pattern-matches](https://reasonml.github.io/docs/en/pattern-matching.html) on the possible actions and specifies what state update each action corresponds to. _In state machine terminology, this'd be a "state transition"_.
- In `render`, instead of `self.handle` (which doesn't allow state updates), you'd use `self.send`. `send` takes an action.

So, when a click on the dialog is triggered, we "send" the `Click` action to the reducer, which handles the `Click` case by returning the new state that increments a counter. ReasonReact takes the state and updates the component.

**Note**: just like for `self.handle`, sometimes you might be forwarding `send` to some helper functions. Pass the whole `self` instead and **annotate it**. This avoids a complex `self` record type behavior. See [Record Field `send`/`handle` Not Found](record-field-send-handle-not-found.md).

## State Update Through Reducer

Notice the return value of `reducer`? The `ReasonReact.Update` part. Instead of returning a bare new state, we ask you to return the state wrapped in this "update" variant. Here are its possible values:

- `ReasonReact.NoUpdate`: don't do a state update.
- `ReasonReact.Update(state)`: update the state.
- `ReasonReact.SideEffects(self => unit)`: no state update, but trigger a side-effect, e.g. `ReasonReact.SideEffects(_self => Js.log("hello!"))`.
- `ReasonReact.UpdateWithSideEffects(state, self => unit)`: update the state, **then** trigger a side-effect.

### Important Notes

**Please read through all these points**, if you want to fully take advantage of `reducer` and avoid future ReactJS Fiber race condition problems.

- The `action` type's variants can carry a payload: `onClick=(data => self.send(Click(data.foo)))`.
- Don't pass the whole event into the action variant's payload. ReactJS events are pooled; by the time you intercept the action in the `reducer`, the event's already recycled.
- `reducer` **must** be pure! Aka don't do side-effects in them directly. You'll thank us when we enable the upcoming concurrent React (Fiber). Use `SideEffects` or `UpdateWithSideEffects` to enqueue a side-effect. The side-effect (the callback) will be executed after the state setting, but before the next render.
- If you need to do e.g. `ReactEvent.BlablaEvent.preventDefault(event)`, do it in `self.send`, before returning the action type. Again, `reducer` must be pure.
- Feel free to trigger another action in `SideEffects` and `UpdateWithSideEffects`, e.g. `UpdateWithSideEffects(newState, (self) => self.send(Click))`.
- If your state only holds instance variables, it also means (by the convention in the instance variables section) that your component only contains `self.handle`, no `self.send`. You still need to specify a `reducer` like so: `reducer: ((), _state) => ReasonReact.NoUpdate`. Otherwise you'll get a `variable cannot be generalized` type error.

### Tip

Cram as much as possible into `reducer`. Keep your actual callback handlers (the `self.send(Foo)` part) dumb and small. This makes all your state updates & side-effects (which itself should mostly only be inside `ReasonReact.SideEffects` and `ReasonReact.UpdateWithSideEffects`) much easier to scan through. Also more ReactJS fiber async-mode resilient.

## Async State Setting

In ReactJS, you could use `setState` inside a callback, like so:

```
setInterval(() => this.setState(...), 1000);
```

In ReasonReact, you'd do something similar:

```reason
Js.Global.setInterval(() => self.send(Tick), 1000)
```
