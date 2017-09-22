---
id: component-creation
title: Component Creation
---
A component template is created through `ReasonReact.statelessComponent "TheComponentName"`. The string being passed is for debugging purposes (the equivalent of ReactJS' [`displayName`](https://facebook.github.io/react/docs/react-component.html#displayname)).

As an example, here's a `greeting.re` file's content:

```reason
let component = ReasonReact.statelessComponent "Greeting";
```

Now we'll define the function that's called when other files invoke `<Greeting name="John" />` (without JSX: `ReasonReact.element (Greeting.make name::"John" [||])`): the `make` function. It must return the component spec template we just defined, with functions such as `render` overridden:

```reason
let component = ReasonReact.statelessComponent "Greeting";
let make ::name _children => {
  ...component, /* spread the template's other defaults into here  */
  render: fun _self => <div> (ReasonReact.stringToElement name) </div>
};
```

**Note**: do **not** inline `let component` into the `make` function body like the following!

```reason
let make _children => {...(ReasonReact.statelessComponent "Greeting"), render: fun blabla}
```

Since `make` is called at every JSX invocation, you'd be creating a fresh new component every time.

### Props

Props are just the labeled arguments of the `make` function, seen above. They can also be optional and/or have defaults, e.g. `let make ::name ::age=? ::className="box" _children => ...`.

The last prop **must** be `children`. If you don't use it, simply ignore it by naming it `_` or `_children`. Names starting with underscore don't trigger compiler warnings if they're unused.

**The prop name cannot be `ref` nor `key`**. Those are reserved, just like in ReactJS.

Following that example, you'd call that component in another file through `<Foo name="Reason" />`. `className`, if omitted, defaults to "box". `age` defaults to `None`. If you'd like to explicitly pass `age`, simply do so: `<Foo name="Reason" age=20 />`.

#### Neat Trick with Props Forwarding

Sometimes in ReactJS, you're being given a prop from the owner that you'd like to forward directly to the child:

```
<Foo name="Reason" age={this.props.age} />
```

This is a source of bugs, because `this.props.age` might be accidentally changed to a nullable number while `Foo` doesn't expect it to be so, or vice-versa; it might be nullable before, and now it's not and `Foo` is left with a useless null check somewhere in the render.

In Reason, if you want to explicitly pass an optional `ageFromProps` (whose type is `option int`, aka `None | Some int`), the following wouldn't work:

```reason
<Foo name="Reason" age=ageFromProps />
```

Because `age` expects a normal `int` when you do call `Foo` with it, not an `option int`! Naively, you'd be forced to solve this like so:

```reason
switch ageFromProps {
| None => <Foo name="Reason" />
| Some nonNullableAge => <Foo name="Reason" age=nonNullableAge />
}
```

Cumbersome. Fortunately, here's a better way to explicitly pass an optional value:

```reason
<Foo name="Reason" age=?ageFromProps />
```

It says "I understand that `age` is optional and that when I use the label I should pass an int. But I'd like to forward an `option` value explicitly". This isn't a JSX trick we've made up; it's just part of the language feature! See the section on "Explicitly Passed Optional" in the [Reason docs](https://reasonml.github.io/guide/language/function/#explicitly-passed-optional).

### Render

`render` needs to return a `ReasonReact.reactElement`: `<div />`, `<MyComponent />`, `ReasonReact.nullElement` (the `null` you'd usually return, but this time of the `reactElement` type), `ReasonReact.stringToElement "foo"`, etc. Render takes the argument `self`:

```reason
...
    render: fun self => <div />
...
```

### `self`

`self` is a record that contains `state`, `retainedProps`, `handle` and `reduce`.

We'll be referring to `state`, `retainedProps` and such immediately; they'll be explained later on.

### Callback Handlers

#### Callback Without State Update

In ReactJS, to set a new state and/or to trigger a prop callback, you'd do `<div onClick={this.handleClick} />`.

In ReasonReact, **if you don't read into `state`/`retainedProps`** or whatever (e.g. you're only calling a prop callback like `onClick`, and/or accessing the props arguments), you can do basically the same:

```reason
let component = ...;
let make ::name ::onClick _children => {
  let click event => onClick name; /* pass the name string up to the owner */
  {
    ...component,
    render: fun self => <button onClick=click />
  }
};
```

If you do want to access `state`, `retainedProps` and the rest, you **need** to wrap the callback in an extra layer called `self.handle`:

```reason
let component = ...;
let make ::name ::onClick _children => {
  let click event self => {
    onClick event;
    Js.log self.state;
  };
  {
    ...component,
    initialState: ...,
    render: fun self => <button onClick=(self.handle click) />
  }
};
```

**Note** how your `click` callback now takes an extra argument, `self`. This is the same `self` which contains the latest `state`, `retainedProps` and others, described just above.

Formally, `self.handle` expects a callback that

- accepts the payload you'd normally directly pass to e.g. `handleClick`,
- plus the argument `self`,
- returns "nothing" (aka, `()`, aka, `unit`).

**Note**: sometimes you might be forwarding `handle` to some helper functions. Pass the whole `self` instead and **annotate it**. This avoids a complex `self` record type behavior. See [Common Type Errors](#reason-react-common-type-errors). Example:

#### Callback With State Update

You can't update state in `self.handle`; you need to use `self.reduce` instead. See below.

### State, Actions & Reducer

Finally, we're getting onto stateful components!

ReasonReact stateful components are like ReactJS stateful components, except with the concept of "reducer" (like [Redux](http://redux.js.org)) built in. If that word doesn't mean anything to you, just think of it as a state machine. If _that_ word doesn't mean anything to you, just think: "Woah this is great".

To declare a stateful ReasonReact component, instead of `ReasonReact.statelessComponent "MyComponentName"`, use `ReasonReact.reducerComponent "MyComponentName"`:

```reason
let component = ReasonReact.reducerComponent "Greeting";

let make ::name _children => {
  ...component,
  initialState: fun () => 0, /* here, state is an `int` */
  render: fun self => {
    let greeting = "Hello " ^ name ^ ". You've clicked the button " ^ (string_of_int self.state) ^ " time(s)!";
    <div> (ReasonReact.stringToElement greeting) </div>
  }
};
```

#### `initialState`

ReactJS' `getInitialState` is called `initialState` in ReasonReact. It takes `unit` and returns the state type. The state type could be anything! An int, a string, a ref or the common record type, which you should declare **right** before the `reducerComponent` call:

```
type state = {counter: int, showPopUp: bool};

let component = ReasonReact.reducerComponent "Dialog";

let make ::onClick _children => {
  ...component,
  initialState: fun () => {counter: 0, showPopUp: false},
  render: ...
};
```

Since the props are just the arguments on `make`, feel free to read into them to initialize your state based on them.

#### Actions & Reducer

In ReactJS, you'd update the state inside a callback handler, e.g.

```
{
  ...
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

In ReasonReact, you'd gather all these state-setting handlers into a single place, the component's `reducer`! Here's a full example, which we'll explain in detail:

```reason
type action =
  | Click
  | Toggle;

type state = {count: int, show: bool};

let component = ReasonReact.reducerComponent "MyForm";

let make _children => {
  ...component,
  initialState: fun () => {count: 0, show: false},
  reducer: fun action state =>
    switch action {
    | Click => ReasonReact.Update {...state, count: state.count + 1}
    | Toggle => ReasonReact.Update {...state, show: not state.show}
    },
  render: fun self => {
    let message = "Clicked " ^ string_of_int self.state.count ^ " times(s)";
    <div>
      <MyDialog
        onClick=(self.reduce (fun _event => Click))
        onSubmit=(self.reduce (fun _event => Toggle)) />
      (ReasonReact.stringToElement message)
    </div>
  }
};
```

A few things:

- There's a user-defined type called **`actions`**, named so by convention. It's a variant of all the possible state transitions in your component. _In state machine terminology, this'd be a "token"_.
- A user-defined `state` type, and an `initialState`. Nothing special.
- The current `state` value is accessible through `self.state`, whenever `self` is passed to you as an argument of some function.
- A "**reducer**"! This [pattern-matches](https://reasonml.github.io/guide/language/pattern-matching) on the possible actions and specify what state update each action corresponds to. _In state machine terminology, this'd be a "state transition"_.
- In `render`, instead of `self.handle` (which doesn't allow state updates), you'd use `self.reduce`. `reduce` takes a callback, passing it the event (or whatever callback payload `onSubmit`/`onClick`/`onFoo` gives you from `MyDialog`) and asking for an action as the return value.

So, when a click on the dialog is triggered, we send the `Click` action to the reducer, which handles the `Click` case by returning the new state that increment a counter. ReasonReact takes the state and updates the component.

**Note**: just like for `self.handle`, sometimes you might be forwarding `reduce` to some helper functions. Pass the whole `self` instead and **annotate it**. This avoids a complex `self` record type behavior. See [Common Type Errors](#reason-react-common-type-errors). Example:

#### State Update Through Reducer

Notice the return value of `reducer`? The `ReasonReact.Update` part. Instead of returning a bare new state, we ask you to return the state wrapped in this "update" variant. Here are its possible values:

- `ReasonReact.NoUpdate`: don't do a state update.
- `ReasonReact.Update state`: update the state.
- `ReasonReact.SideEffects (self => unit)`: no state update, but trigger a side-effect, e.g. `ReasonReact.SideEffects (fun _self => Js.log "hello!")`.
- `ReasonReact.UpdateWithSideEffects state (self => unit)`: update the state, **then** trigger a side-effect.

_If you're a power user, there's also `SilentUpdate` and `SilentUpdateWithSideEffects`. See reasonReact.rei to see what they do. Don't use them if you're trying to update a ref/timer/subscription/any other instance variable_.

##### Important Notes

**Please read through all these points**, if you want to fully take advantage of `reducer` and avoid future ReactJS Fiber race condition problems.

- The `action` type's variants can carry a payload: `onClick=(self.reduce (fun data => Click data.foo))`.
- Don't pass the whole event into the action variant's payload. ReactJS events are pooled; by the time you intercept the action in the `reducer`, the event's already recycled.
- `reducer` must be pure (not to be confused with `self.reduce`, which can be impure)! Don't do side-effects in them directly. You'll thank us when we enable the upcoming concurrent React (Fiber). Use `SideEffects` or `UpdateWithSideEffects` to enqueue a side-effect. The side-effect (the callback) will be executed after the state setting, but before the next render.
- If you need to do e.g. `ReactEventRe.BlablaEvent.preventDefault event`, do it in `self.reduce`, before returning the action type. Again, `reducer` must be pure.
- If your state only holds instance variables, it also means (by the convention in the instance variables section) that your component only contains `self.handle`, no `self.reduce`. You still needs to specify a `reducer` like so: `reducer: fun () _state => ReasonReact.NoUpdate`. Otherwise you'll get a `variable cannot be generalized` type error.

#### Async State Setting

In ReactJS, you could use `setState` inside a callback, like so:

```
setInterval(() => this.setState(...), 1000);
```

In ReasonReact, since the new state, if any, is returned from the `reducer`, the above wouldn't work; naturally, returning a new state from a `setInterval` doesn't make sense!

Instead, you'd do:

```reason
type action =
  | Tick;

type state = {
  count: int,
  timerId: ref (option Js.Global.intervalId)
};

let component = ReasonReact.reducerComponent "Counter";

let make _children => {
  ...component,
  initialState: fun () => {count: 0, timerId: ref None},
  reducer: fun action state =>
    switch action {
    | Tick => ReasonReact.Update {...state, count: state.count + 1}
    },
  didMount: fun self => {
    self.state.timerId := Some (Js.Global.setInterval (self.reduce (fun _ => Tick)) 1000);
    ReasonReact.NoUpdate
  },
  render: fun {state} => <div> (ReasonReact.stringToElement (string_of_int state.count)) </div>
};
```

Aka, creating a `reducer` handler as you would normally, and let that setInterval (or whatver async state setting you use) asynchronously call the callback returned by your `self.reduce`.

### Lifecycle Events

**Note that as of ReasonReact v0.2.4**, you should return `ReasonReact.NoUpdate` whenever possible from the lifecycle events. In preparation for ReactJS fiber, we'll remove the ability to return a new state from lifecycles. If you need to update state, simply send an action to `reducer` and handle it correspondingly: `self.reduce (fun () => DidMountUpdate) ()`.

ReasonReact supports the usuals:

```reason
didMount: self => update state

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

**Some new lifecyle methods act differently**. Described below.

### Access next or previous props: `retainedProps`

One pattern that's sometimes used in ReactJS is accessing a lifecyle event's `prevProps` (`componentDidUpdate`), `nextProps` (`componentWillUpdate`), and so on. ReasonReact doesn't automatically keep copies of previous props for you. We provide the `retainedProps` API for this purpose:

```reason
type retainedProps = {message: string};

let component = ReasonReact.statelessComponentWithRetainedProps "RetainedPropsExample";

let make ::message _children => {
  ...component,
  retainedProps: {message: message},
  didUpdate: fun {oldSelf, newSelf} =>
    if (oldSelf.retainedProps.message !== newSelf.retainedProps.message) {
      /* do whatever sneaky imperative things here */
      Js.log "props `message` changed!"
    },
  render: fun _self => ...
};
```

We expose `ReasonReact.statelessComponentWithRetainedProps` and `ReasonReact.reducerComponentWithRetainedProps`. Both work like their ordinary non-retained-props counterpart, and require you to specify a new field, `retainedProps` (of whatever type you'd like) in your component's spec in `make`.

#### `willReceiveProps`

Traditional ReactJS `componentWillReceiveProps` takes in a `nextProps`. We don't have `nextProps`, since those are simply the labeled arguments in `make`, available to you in the scope. To access the _current_ props, however, you'd use the above `retainedProps` API:

```reason
type state = {someToggle: bool};

let component = ReasonReact.reducerComponentWithRetainedProps "MyComponent";

let make ::name _children => {
  ...component,
  initialState: fun () => {someToggle: false},
  /* just like state, the retainedProps field can return anything! Here it retained the `name` prop's value */
  retainedProps: name,
  willReceiveProps: fun self => {
    if (self.retainedProps === name) {
      /* previous ReactJS logic would be: if (props.name === nextProps.name)
      ...
    }
    ...
  }
}
```

#### `willUpdate`

ReactJS' `componentWillUpdate`'s `nextProps` is just the labeled arguments in `make`, and "current props" (aka `this.props`) is the props you've copied into `retainedProps`, accessible via `{oldSelf}`:

```reason
{
  ...component,
  willUpdate: fun {oldSelf, newSelf} => ...
}
```

#### `didUpdate`

ReactJS' `prevProps` is what you've synced in `retainedProps`, under `oldSelf`.

#### `shouldUpdate`

ReactJS' `shouldComponentUpdate` counterpart.

### Instance Variables

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
  someRandomState: option string,
  intervalId: ref (option int)
};

let component = ...; /* remember, `component` needs to be close to `make`, and after `state` type declaration! */
let make _children => {
  ...component,
  initialState: fun () => {
    someRandomState: Some "hello",
    intervalId: ref None
  },
  didMount: fun {state} => {
    /* mutate the value here */
    state.intervalId := Some (Js.Global.setInterval ...);
    /* no extra state update needed */
    ReasonReact.NoUpdate
  },
  render: ...
};
```

**All your instance variables (subscriptions, refs, etc.) must be in state fields marked as a `ref`**. Don't directly use a `mutable` field on the state record, use an immutable field pointing to a Reason `ref`. Why such constraint? To prepare for concurrent React which needs to manage side-effects & mutations more formally. More details [here](https://reasonml.github.io/try/?reason=C4TwDgpgBAzlC8UDeBDAXFAlgO2AGlgHsBbCASWxmBWwGMIA1FAJw2YgDMtcBfAbgBQAegBUUbIQDuUEUIEAbCMFjVg0REgFQo6KAEY8WoqQpUa9JqyjsuAJgH9hYiMQCu8lGqgADM2u86tPQwcBzMJFC08oQwruwAdFAAKgAW0OwoACZQhFy+qhABxJgA5inKAEbQZopQFSBQwGmNmKRYwADkcBAAHhC0rmqZGLJOUByu2Mh+EDwIAHzjk1AAFACUC1AAShAoMITYOyi0wPEAqmCZntBI8XczBBUec6OKyjO2CMh38Q86GABmRyiOqDKBuVSYA45PIzALYCAQTJwYCEOrpTiKE5I7g+D4BKiYeTyACEMjkM1+JHIlGodEYLCgaEQABZBCCYClCO5slUoCzyQIAFIweLREpQEkfKkmWnmBnMdliJqYOCSbnyTLYDrKdXMADWWC4kmgmTRoEgOgQqAwOHw4MGKCe1WppjpFhYtt45KAA) if you're ever interested.

### React Ref

_Not to be confused with Reason `ref`, the language feature that enables mutation_.

A ReasonReact `ref` would be just another instance variable. You'd type it as `ReasonReact.reactRef` if it's attached to a custom component, and `Dom.element` if it's attached to a React DOM element.

```reason
type state = {
  isOpen: bool,
  mySectionRef: ref (option ReasonReact.reactRef)
};

let setSectionRef theRef {ReasonReact.state} => {
  state.mySectionRef := Js.Null.to_opt theRef;
  /* wondering about Js.Null.to_opt? See the note below */
};

let component = ReasonReact.reducerComponent "MyPanel";

let make ::className="" _children => {
  ...component,
  initialState: fun () => {
    isOpen: false,
    mySectionRef: ref None
  },
  reducer: ...,
  render: fun self => <Section1 ref=(self.handle setSectionRef) />
};
```

Attaching to a React DOM element looks the same: `state.mySectionRef = {myDivRef: Js.Null.to_opt theRef}`.

**Note** how [ReactJS refs can be null](https://github.com/facebook/react/issues/9328#issuecomment-298438237). Which is why `theRef` and `myDivRef` are converted from a [JS nullable](http://bucklescript.github.io/bucklescript/Manual.html#_null_and_undefined) to an OCaml `option` (Some/None). When you use the ref, you'll be forced to handle the null case through a `switch`, which prevents subtle errors!

**You must follow the instanceVars convention in the previous section for ref**.

ReasonReact ref only accept callbacks. The string `ref` from ReactJS is deprecated.

We also expose an escape hatch `ReasonReact.refToJsObj` of type `ReasonReact.reactRef => Js.t {..}`, which turns your ref into a JS object you can freely use; **this is only used to access ReactJS component class methods**.

```reason
let handleClick event self =>
  switch !self.state.mySectionRef {
  | None => ()
  | Some r => (ReasonReact.refToJsObj r)##someMethod 1 2 3 /* I solemnly swear that I am up to no good */
  };
```
