---
title: Render
---

`render` needs to return a `React.reactElement`: `<div />`, `<MyComponent />`, etc. Render takes the argument `self`:

```reason
...
    render: (self) => <div />
...
```

What if you want to return `null` from a `render`? Or pass a string to a DOM component like `div` which only allows `React.reactElement`s?

In ReactJS, you can easily do: `<div> hello </div>`, `<div> {1} </div>`, `<div> {null} </div>`, etc. In Reason, the type system restricts you from passing arbitrary data like so; you can only return `React.reactElement` from `render`.

Fortunately, we special-case a few special elements of the type `React.reactElement`:

- `React.null`: This is your `null` equivalent for `render`'s return value. Akin to `return null` in ReactJS render.

- `React.string`: Takes a string and converts it to a `reactElement`. You'd use `<div> {React.string(string_of_int(10))} </div>` to display an int.

- `React.array`: Takes an array and converts it to a `reactElement`.
