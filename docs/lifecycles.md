---
title: Lifecycles
---

ReasonReact supports a considered subset of ReactJS lifecycle events to make it easier to follow changes in future ReactJS releases.

```reason
didMount: self => unit

willReceiveProps: self => state

shouldUpdate: oldAndNewSelf => bool

willUpdate: oldAndNewSelf => unit

didUpdate: oldAndNewSelf => unit

willUnmount: self => unit
```

Notes:

- We've dropped the `component` prefix from all events.
- `willReceiveProps` requires the return type to be `state` and not `update(state)` (i.e. not `NoUpdate/Update/SideEffects/UpdateWithSideEffects`). We presume you'd want to update the state in this lifecycle. If not, simply return the previous `state` exposed in the lifecycle argument.
- `didUpdate`, `willUnmount` and `willUpdate` don't allow you to return a new state to be updated, to prevent infinite loops.
- `willMount` is unsupported. Use `didMount` instead.
- `didUpdate`, `willUpdate` and `shouldUpdate` take in a **`oldAndNewSelf` record**, of type `{oldSelf: self, newSelf: self}`. These two fields are the equivalent of ReactJS' `componentDidUpdate`'s `prevProps/prevState/` in conjunction with `props/state`. Likewise for `willUpdate` and `shouldUpdate`.

If you need to update state in a lifecycle event other than `willReceiveProps`, simply `send` an action to the `reducer` and handle it accordingly, e.g. `self.send(DidMountUpdate)`.

**Some new lifecyle methods act differently**. Described below.

## Access next or previous props: `retainedProps`

In a ReactJS lifecyle event, you may need to access the component's `prevProps` (`componentDidUpdate`), `nextProps` (`componentWillUpdate`), and so on. ReasonReact doesn't automatically keep copies of previous props for you. For stateless components, we provide the `retainedProps` API for this purpose:

```reason
type retainedProps = {message: string};

let component = ReasonReact.statelessComponentWithRetainedProps("RetainedPropsExample");

let make = (~message, _children) => {
  ...component,
  retainedProps: {message: message},
  didUpdate: ({oldSelf, newSelf}) =>
    if (oldSelf.retainedProps.message !== newSelf.retainedProps.message) {
      /* do whatever sneaky imperative things here */
      Js.log("props `message` changed!")
    },
  render: (_self) => ...
};
```

We expose `ReasonReact.statelessComponentWithRetainedProps` which works like its ordinary counterpart without retained props, but requires you to specify a new field, `retainedProps` in your component's spec in `make`. `retainedProps` can be of whatever type you require.

`ReasonReact.reducerComponentWithRetainedProps` has been deprecated. Instead, you may make use of `willReceiveProps` for a `reducerComponent`.

## `willReceiveProps`

In the traditional ReactJS lifecycle event `componentWillReceiveProps`, you have access to `nextProps` and `props`. In `reason-react`, `nextProps` are the labeled arguments of the `make` statement and are available to you in this scope. _Current_ props (`props`) however are not available unless you have already persisted them in the component's state in a previous lifecycle method.

```reason
type state = {someToggle: bool, somePropRetained: int};

let component = ReasonReact.reducerComponent("MyComponent");

let make = (~someProp, _children) => {
  ...component,
  initialState: () => {someToggle: false, someProp: someProp},
  willReceiveProps: ({state}) => {
    if (state.someProp !== someProp) {
      /* ReactJS analogue would be: if (props.someProp === nextProps.someProp) */
      /* perform your logic here */
      ...
      /* persist the new value of the prop when returning the state */
      {...state, someProp: someProp}
    } else {
      /* perform your logic here */
      /* if you would not update the state, simply return it here */
      state
    };
    ...
  }
};
```

## `willUpdate`

The traditional ReactJS lifecycle event `componentWillUpdate` receives `nextProps` and `nextState`. In `reason-react`, `nextProps` are the labeled arguments of the `make` statement and are available to you in this scope. If you would refer to the previous value of some prop persisted in state, you could refer to `oldSelf.state`. Similarly, the counterpart to `nextState` is `newSelf.state`.

```reason
{
  ...component,
  willUpdate: {oldSelf, newSelf} => ...
}
```

## `didUpdate`

The counterpart to `prevProps` of traditional ReactJs lifecycle events, is to refer to `oldSelf.state` for props persisted in state.
```reason
{
  ...component,
  didUpdate: {oldSelf, newSelf} => ...
}
```

## `shouldUpdate`

Counterpart to ReactJS lifecycle event `shouldComponentUpdate`.