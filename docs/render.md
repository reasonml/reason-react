---
id: render
title: Render
---

`render` needs to return a `ReasonReact.reactElement`: `<div />`, `<MyComponent />`, etc. Render takes the argument `self`:

```reason
...
    render: (self) => <div />
...
```

What if you want to return `null` from a `render`? Or pass a string to a DOM component like `div` which only allows `ReasonReact.reactElement`s?

In ReactJS, you can easily do: `<div> hello </div>`, `<div> 1 </div>`, `<div> null </div>`, etc. In Reason, the type system restrict you from passing arbitrary data like so; you can only return `ReasonReact.reactElement` from `render`.

Fortunately, we special-case a few special elements of the type `ReasonReact.reactElement`:

- `ReasonReact.nullElement`: This is your `null` equivalent for `render`'s return value. Akin to `return null` in ReactJS render.

- `ReasonReact.stringToElement`: Takes a string and converts it to a `reactElement`. You'd use `<div> {ReasonReact.stringToElement(string_of_int(10))} </div>` to display an int.

- `ReasonReact.arrayToElement`: Takes an array and converts it to a `reactElement`.
