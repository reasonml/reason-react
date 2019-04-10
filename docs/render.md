---
title: Render
---

<aside class="warning">
The Record API is in feature-freeze. For the newest features and better support going forward, please consider migrating to the new <a href="https://reasonml.github.io/reason-react/docs/en/components">function components</a>.
</aside>

`render` needs to return a `ReasonReact.reactElement`: `<div />`, `<MyComponent />`, etc. Render takes the argument `self`:

```reason
/* ... */
    render: (self) => <div />
/* ... */
```

What if you want to return `null` from a `render`? Or pass a string to a DOM component like `div` which only allows `ReasonReact.reactElement`s?

In ReactJS, you can easily do: `<div> hello </div>`, `<div> {1} </div>`, `<div> {null} </div>`, etc. In Reason, the type system restricts you from passing arbitrary data like so; you can only return `ReasonReact.reactElement` from `render`.

Fortunately, we special-case a few special elements of the type `ReasonReact.reactElement`:

- `ReasonReact.null`: This is your `null` equivalent for `render`'s return value. Akin to `return null` in ReactJS render.

- `ReasonReact.string`: Takes a string and converts it to a `reactElement`. You'd use `<div> {ReasonReact.string(string_of_int(10))} </div>` to display an int.

- `ReasonReact.array`: Takes an array and converts it to a `reactElement`.
