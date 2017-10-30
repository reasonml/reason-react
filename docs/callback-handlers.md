---
id: callback-handlers
title: Callback Handlers
---

This section describes how ReactJS' `<div onClick={this.handleClick} />` pattern translates into ReasonReact.

## Callback Without State Update

Two scenarios.

### Not Reading Into `self`

_Reminder: `self` is ReasonReact's `this`. It's a record that contains things like `state`, `retainedProps` and others._

If you're just forwarding a callback prop onto your child, you'd do exactly the same thing you'd have done in ReactJS:

```reason
let component = ...;

let make (~name, ~onClick, _children) => {
  ...component,
  render: (self) => <button onClick=onClick />
};
```

No surprise here. Since Reason's JSX has [punning syntax](https://reasonml.github.io/guide/language/jsx#punning), that `button` will format into `<button onClick />`.

Similarly, to pre-process a value before sending it back to the component's owner:

```reason
let component = ...;

let make (~name, ~onClick, _children) => {
  let click event => onClick name; /* pass the name string up to the owner */
  {
    ...component,
    render: (self) => <button onClick=click />
  }
};
```

### Reading Into `self`

To access `state`, `retainedProps` and the other items in `self` from a callback, you **need** to wrap the callback in an extra layer called `self.handle`:

```reason
let component = ...;
let make (~name, ~onClick, _children) =>
  let click = (event, self) => {
    onClick(event);
    Js.log(self.state);
  };
  {
    ...component,
    initialState: ...,
    render: (self) => <button onClick={self.handle(click)} />
  }
};
```

**Note** how your `click` callback now takes the extra argument `self`. Formally, `self.handle` expects a callback that

- accepts the **single** payload you'd normally directly pass to e.g. `handleClick`,
- plus the argument `self`,
- returns "nothing" (aka, `()`, aka, `unit`).

**Note 2**: sometimes you might be forwarding `handle` to some helper functions. Pass the whole `self` instead and **annotate it**. This avoids a complex `self` record type behavior. See [Record Field `reduce`/`handle` Not Found](record-field-reduce-handle-not-found.md).

#### Explanation

In reality, `self.handle` is just a regular function accepting two arguments, the first being the callback in question, and the second one being the payload that's intended to be passed to the callback.

Get it? Through Reason's natural language-level currying, we usually only ask you to pass the first argument. This returns a new function that takes in the second argument and executes the function body. The second argument being passed by the caller, aka the component you're rendering!

#### Callback Receiving Multiple Arguments

Sometimes, the component you're calling is from JavaScript (using the [ReasonReact<->ReactJS interop](interop.md)), and its callback prop asks you to pass a callback that receives more than one argument. In ReactJS, it'd look like:

```javascript
handleSubmit: function(username, password, event) {
  this.setState(...)
}
...
<MyForm onUserClickedSubmit={this.handleSubmit} />
```

You cannot write such `handleSubmit` in ReasonReact, as `handle` expects to wrap around a function that only takes **one** argument. Here's the workaround:

```
let handleSubmitEscapeHatch = (username, password, event) => 
        self.handle((tupleOfThreeItems) => doSomething(tupleOfThreeItems))(username, password, event));
...
<MyForm onUserClickedSubmit=(handleSubmitEscapeHatch) />
```

Basically, you write a normal callback that:

- takes those many arguments from the JS component callback prop,
- packs them into a tuple and call `self.handle`,
- pass to `handle` the usual function that expects a single argument,
- finish calling `self.handle` by passing the tuple directly yourself.

## Callback With State Update

You can't update state in `self.handle`; you need to use `self.reduce` instead. See the next section.
