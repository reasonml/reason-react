---
id: lifecycles
title: Lifecycles
---

ReasonReact supports the familiar ReactJS lifecycle events.

```reason
didMount: self => update(state)

willReceiveProps: self => state

shouldUpdate: oldAndNewSelf => bool

willUpdate: oldAndNewSelf => unit

didUpdate: oldAndNewSelf => unit

willUnmount: self => unit
```

Note:

- We've dropped the `component` prefix from all these.
- `willReceiveProps` asks, for the return type, to be `state`, not `update state` (i.e. not `NoUpdate/Update/SideEffects/UpdateWithSideEffects`). We presume you'd always want to update the state in this lifecycle. If not, simply return the previous `state` exposed in the lifecycle argument.
- `didUpdate`, `willUnmount` and `willUpdate` don't allow you to return a new state to be updated, to prevent infinite loops.
- `willMount` is unsupported. Use `didMount` instead.
- `didUpdate`, `willUpdate` and `shouldUpdate` take in a **`oldAndNewSelf` record**, of type `{oldSelf: self, newSelf: self}`. These two fields are the equivalent of ReactJS' `componentDidUpdate`'s `prevProps/prevState/` in conjunction with `props/state`. Likewise for `willUpdate` and `shouldUpdate`.

**Note that you should return `ReasonReact.NoUpdate` whenever possible from the lifecycle events**. In preparation for ReactJS fiber, we'll remove the ability to return a new state from lifecycles. If you need to update state, simply send an action to `reducer` and handle it correspondingly: `self.reduce(() => DidMountUpdate, ())`.

**Some new lifecyle methods act differently**. Described below.

## Access next or previous props: `retainedProps`

One pattern that's sometimes used in ReactJS is accessing a lifecyle event's `prevProps` (`componentDidUpdate`), `nextProps` (`componentWillUpdate`), and so on. ReasonReact doesn't automatically keep copies of previous props for you. We provide the `retainedProps` API for this purpose:

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

We expose `ReasonReact.statelessComponentWithRetainedProps` and `ReasonReact.reducerComponentWithRetainedProps`. Both work like their ordinary non-retained-props counterpart, and require you to specify a new field, `retainedProps` (of whatever type you'd like) in your component's spec in `make`.

### `willReceiveProps`

Traditional ReactJS `componentWillReceiveProps` takes in a `nextProps`. We don't have `nextProps`, since those are simply the labeled arguments in `make`, available to you in the scope. To access the _current_ props, however, you'd use the above `retainedProps` API:

```reason
type state = {someToggle: bool};

let component = ReasonReact.reducerComponentWithRetainedProps("MyComponent");

let make = (~name, _children) => {
  ...component,
  initialState: () => {someToggle: false},
  /* just like state, the retainedProps field can return anything! Here it retained the `name` prop's value */
  retainedProps: name,
  willReceiveProps: (self) => {
    if (self.retainedProps === name) {
      ...
      /* previous ReactJS logic would be: if (props.name === nextProps.name) */
    };
    ...
  }
};
```

### `willUpdate`

ReactJS' `componentWillUpdate`'s `nextProps` is just the labeled arguments in `make`, and "current props" (aka `this.props`) is the props you've copied into `retainedProps`, accessible via `{oldSelf}`:

```reason
{
  ...component,
  willUpdate: {oldSelf, newSelf} => ...
}
```

### `didUpdate`

ReactJS' `prevProps` is what you've synced in `retainedProps`, under `oldSelf`.

### `shouldUpdate`

ReactJS' `shouldComponentUpdate` counterpart.
