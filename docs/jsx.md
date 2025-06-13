---
title: JSX
---

Reason comes with [JSX](https://reasonml.github.io/docs/en/jsx.html) syntax. Enables representation of HTML-like expressions within the language.

reason-react enables [the ReactJS JSX transform](https://reactjs.org/docs/introducing-jsx.html) in Reason.

Since `reason-react.0.12.0`, the JSX transformation currently supports the [New JSX Transform](https://legacy.reactjs.org/blog/2020/09/22/introducing-the-new-jsx-transform.html). JSX functions are imported from `react/jsx-runtime`. Previous versions of reason-react used the legacy API `React.createElement`.

# Install

To use it, you would need to install [`reason-react-ppx`](https://opam.ocaml.org/packages/reason-react-ppx/) and add `(preprocess (pps reason-react-ppx))` in [`melange.emit or library`](https://dune.readthedocs.io/en/stable/melange.html) stanzas in your `dune` file.

# What the ppx does

Here's a list of transformations made by the [ppx](https://ocaml.org/docs/metaprogramming).

## Uncapitalized

```reason
<div foo={bar}> {child1} {child2} </div>
```

transforms into

```reason
ReactDOM.jsxs(
  "div",
  ReactDOM.domProps(
    ~children=React.array([|child1, child2|]),
    ~foo=bar,
    (),
  )
)
```

which compiles to the JavaScript code:

```js
React.jsx('div', {foo: bar, children: [ child1, child2 ] })
```

Prop-less `<div />` transforms into

```reason
ReactDOM.jsx("div", ReactDOM.domProps());
```

Which compiles to

```js
React.createElement('div', {})
```

## Capitalized

```reason
<MyReasonComponent ref={b} foo={bar} baz={qux}> {child1} {child2} </MyReasonComponent>
```

transforms into

```reason
React.jsxs(
  MyReasonComponent.make,
  MyReasonComponent.makeProps(
    ~ref=b,
    ~foo=bar,
    ~baz=qux,
    ~children=[|child1, child2|],
    ()
  ),
);
```

which compiles to

```js
React.jsxs(
  MyReasonComponent.make,
  {
    ref: b,
    foo: bar,
    baz: qux,
    children: [ child1, child2 ],
  },
);
```

Prop-less `<MyReasonComponent />` transforms into

```reason
React.jsx(
  MyReasonComponent.make,
  MyReasonComponent.makeProps(),
);
```

which compiles to

```js
React.jsx(MyReasonComponent.make, {});
```

The `make` above is exactly the same `make` function you've seen in the previous section.

`ref` and `key` are reserved in reason-react, just like in ReactJS. **Don't** use them as props in your component!

## Fragment

Fragment lets you group elements without a wrapper node, and return a single element without any effect on the DOM. More details about this in the [react documentation: Fragments](https://react.dev/reference/react/Fragment).

The empty JSX tag `<></>` is shorthand for `<React.Fragment></React.Fragment>`

```reason
<> child1 child2 </>;
```

transforms into

```reason
React.jsx(
  React.jsxFragment,
  ReactDOM.domProps(~children=React.array([|child1, child2|]), ()),
);
```

Which compiles to

```js
React.jsx(React.Fragment, { children: [child1, child2] });
```

## Children

reason-react children are **fully typed**, and you can pass any data structure to it (as long as the receiver component permits it). When you write:

```reason
<MyReasonComponent> <div /> <div /> </MyReasonComponent>
```

You're effectively passing the array `[| <div />, <div /> |]` to `MyReasonComponent`'s children. If you pass a single child like so:

```reason
<MyReasonComponent> <div /> </MyReasonComponent>
```

We unwrap this for you automatically to just `<div />` instead of an array of a single element.
