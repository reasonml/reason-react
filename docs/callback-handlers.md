---
id: callback-handlers
title: Callback Handlers
---

## Callback Without State Update

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
let make ::name ::onClick _children =>
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

**Note**: sometimes you might be forwarding `handle` to some helper functions. Pass the whole `self` instead and **annotate it**. This avoids a complex `self` record type behavior. See [Common Type Errors](common-errors.md). Example:

## Callback With State Update

You can't update state in `self.handle`; you need to use `self.reduce` instead. See the next section.
