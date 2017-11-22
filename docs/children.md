---
id: children
title: Children
---

ReasonReact children are like ReactJS children, except we provide more bells and whistles that leverages the language itself.

For example, in ReactJS, you'd often want to constrain the `children` being passed to you as a single child. So inside your own render, you'd do:

```js
render: () => {
  return React.Children.only(this.children);
}
```

Or, maybe you accept two (and exactly two) children:

```js
render: () => {
  return (
    <div>
      {this.props.children[0]}
      <Separator />
      {this.props.children[1]}
    </div>
  );
}
```

Or maybe you're actually rendering a children callback:

```js
render: () => {
  return React.Children.only(this.props.children('hello'));
}
```

And for more complicated cases, you'd start using some elaborate `React.Children.*` utils. None of these are type-safe (naturally, since JS is dynamic):

```js
<MyForm> <div /> <div /> </MyForm>
// oops, this blows up because `MyForm` expects a single child
```

We can do better in ReasonReact through simply using the language!

```reason
<MyForm> ...(<div />, <div />) </MyForm>
```

Two things:

- `MyForm`'s children is expected to be a tuple of 2 react elements.

- The presence of `...` is called [children spread](https://reasonml.github.io/guide/language/jsx#children-spread). Passing `<MyForm> (<div />, <div />) </MyForm>` would wrap the tuple in an array (see the [JSX](jsx.md#children) section).

Here are some use-cases for children + children spread + Reason built-in data structures:

- A layout component that mandates a tuple of 2 react element and shows them side-by-side:

  ```reason
  <MyForm> ...(<div />, <div />) </MyForm>
  ```

- A component that mandates a callback, no need for ReactJS' `React.Children.only` runtime check:

  ```reason
  <Motion> ...((name) => <div className=name />) </Motion>
  ```

- A layout helper that accepts a variant of `TwoRows | ThreeRows | FourColumns`

  ```reason
  <Layout> ...(ThreeRows(<div />, child2, child3)) </Layout>
  ```

How do we know that `MyForm`, `Motion` and `Layout` accept such children? Well, that'll simply be inferred by internal usage of `children` in these components' respective `render`. Just another day in the magical land of type inference.

Go wild!

### Pitfall

Following the above section's reasoning, this code should work:

```reason
let children = [| <div /> |];
<div> ...children </div>; /* <--- this line */
```

It _does_ work for custom components (upper-case), But it doesn't for DOM components (lower-cased). This is due to some bindings-related constraints; we'll make this better in the future! In the meantime, for passing to DOM element, e.g. `<div className=bar> ...children </div>` use the following:

```reason
ReasonReact.createDomElement("div", ~props={"className": bar}, children);
```
