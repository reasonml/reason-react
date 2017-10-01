---
id: react-element
title: React Element
---

What if you want to return `null` from a `render`? Or pass an array as children? Or a string?

In ReactJS, you can easily do: `<div> hello </div>`, `<div> 1 </div>`, `<div> null </div>`, etc. In Reason, the type system restrict you from passing arbitrary data like so; you can only return `ReasonReact.reactElement` from `render`.

Fortunately, we special-case a few special elements of the type `ReasonReact.reactElement`:

- `ReasonReact.nullElement`: this is your `null` equivalent.
- `ReasonReact.stringToElement foo`: takes a string and converts it into a `reactElement`. You'd use `<div> (ReasonReact.stringToElement (string_of_int 10)) </div>` to display an int.
- `ReasonReact.arrayToElement foo`: takes an array and converts it to `reactElement`.
