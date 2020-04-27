---
title: JSX (Version 3)
---

Reason comes with the [JSX](https://reasonml.github.io/docs/en/jsx.html) syntax! ReasonReact has two different transforms that you can use for your components. This doc covers Version 3 of the transform which is very similar to how [the ReactJS JSX transform](https://reactjs.org/docs/introducing-jsx.html) works. To use it, put `{"reason": {"react-jsx": 3}` in your [`bsconfig.json`](https://bucklescript.github.io/docs/en/build-configuration.html#reason-refmt) (schema [here](http://bucklescript.github.io/bucklescript/docson/#build-schema.json)).

[Version 2](jsx-2.md) is used to render Reducer style components which require special interop to handle the ways they differ from ReactJS components. If you are starting a new project you can stick to version 3 all the time.

For help to migrate from version 2 to version 3, check the `ReasonReactCompat` [section](https://reasonml.github.io/reason-react/docs/en/reasonreactcompat.html#migrating-an-application-to-v070-and-jsx-v3).

## Uncapitalized

```reason
<div foo={bar}> {child1} {child2} </div>
```

transforms into

```reason
ReactDOMRe.createDOMElementVariadic(
  "div",
  ~props=ReactDOMRe.domProps(~foo=bar, ()),
  [|child1, child2|]
);
```

which compiles to the JS code:

```js
React.createElement('div', {foo: bar}, child1, child2)
```

Prop-less `<div />` transforms into

```reason
ReactDOMRe.createDOMElementVariadic(
  "div",
  ~props=ReactDOMRe.domProps(),
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
