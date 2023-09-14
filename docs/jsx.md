---
title: JSX
---

Reason comes with the [JSX](https://reasonml.github.io/docs/en/jsx.html) syntax! ReasonReact works very similar to how [the ReactJS JSX transform](https://reactjs.org/docs/introducing-jsx.html) does.

To use it, you would need to install [`reason-react-ppx`](https://opam.ocaml.org/packages/reason-react-ppx/) and add `(preprocess (pps reason-react-ppx))` in [`melange.emit or library`](https://dune.readthedocs.io/en/stable/melange.html) stanzas in your `dune` file.

Here's a list of transformations made by the [ppx](https://ocaml.org/docs/metaprogramming):

## Uncapitalized

```reason
<div foo={bar}> {child1} {child2} </div>
```

transforms into

```reason
ReactDOM.createDOMElementVariadic(
  "div",
  ~props=ReactDOM.domProps(~foo=bar, ()),
  [|child1, child2|]
);
```

which compiles to the JavaScript code:

```js
React.createElement('div', {foo: bar}, child1, child2)
```

Prop-less `<div />` transforms into

```reason
ReactDOM.createDOMElementVariadic(
  "div",
  ~props=ReactDOM.domProps(),
  [||]
);
```

Which compiles to

```js
React.createElement('div', {})
```

## Capitalized

```reason
<MyReasonComponent key={a} ref={b} foo={bar} baz={qux}> {child1} {child2} </MyReasonComponent>
```

transforms into

```reason
React.createElementVariadic(
  MyReasonComponent.make,
  MyReasonComponent.makeProps(
    ~key=a,
    ~ref=b,
    ~foo=bar,
    ~baz=qux,
    ~children=React.null,
    ()
  ),
  [|child1, child2|]
);
```

which compiles to

```js
React.createElement(
  MyReasonComponent.make,
  {
    key: a,
    ref: b,
    foo: bar,
    baz: qux,
    children: null,
  },
  child1,
  child2,
);
```

Prop-less `<MyReasonComponent />` transforms into

```reason
React.createElement(MyReasonComponent.make, MyReasonComponent.makeProps());
```

which compiles to

```js
React.createElement(MyReasonComponent.make, {});
```

The `make` above is exactly the same `make` function you've seen in the previous section.

`ref` and `key` are reserved in ReasonReact, just like in ReactJS. **Don't** use them as props in your component!

## Fragment

```reason
<> child1 child2 </>;
```

transforms into

```reason
ReactDOMRe.createElement(ReasonReact.fragment, [|child1, child2|]);
```

Which compiles to

```js
React.createElement(React.Fragment, undefined, child1, child2);
```

## Children

ReasonReact children are **fully typed**, and you can pass any data structure to it (as long as the receiver component permits it). When you write:

```reason
<MyReasonComponent> <div /> <div /> </MyReasonComponent>
```

You're effectively passing the array `[| <div />, <div /> |]` to `MyReasonComponent`'s children. If you pass a single child like so:

```reason
<MyReasonComponent> <div /> </MyReasonComponent>
```

We unwrap this for you automatically to just `<div />` instead of an array of a single element.
