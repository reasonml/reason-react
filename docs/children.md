---
id: children
title: Children
---

ReasonReact children are like ReactJS children, except we provide more bells and whistles that leverages the language itself.

Let's say people are using your component like so: `<Animation><div /></Animation>`. In the `Animation` component, you'd want to constrain the `children` being passed to you (the `div` here) as a single child. Aka, you'd like to error on this: `<Animation><div /><div /></Animation>`.

ReactJS provides such helper:

```js
// inside Animation.js
render: () => {
  return React.Children.only(this.children);
}
```

Or, maybe you made a Layout component and accepts exactly two children (e.g. `<Layout><MyColumn /><MyColumn /></Layout>`):

```js
// Layout.js
render: () => {
  if (React.Children.count(this.props.children) !== 2) {
    // ... error
  }
  return (
    <div>
      {this.props.children[0]}
      <Separator />
      {this.props.children[1]}
    </div>
  );
}
```

Or maybe you mandate a children callback:

```js

render: () => {
  return React.Children.only(this.props.children('hello'));
}
```

As an author of these JS components, you can only hope that the user provided the right children type to you, and throw an error for them if not. In ReasonReact, `children` prop is typed and prevents bad usage from the consumer. This seems pretty natural, once you realize that `children` props **is basically like any other prop**! Yes, you can pass tuple, variant, record and others to children! This also mean we don't have to provide the equivalent `React.Children.*` utils in ReasonReact at all!

However, due to syntactical and interoperability reasons, we do have some small restrictions on `children`:

- DOM elements such as `div`, `span` and others mandate the `children` you pass to be `array(reactElement)`. For example, `<div> [1, 2, 3] </div>` or `<span> Some(10) </span>` don't work, since the `list` and the `option` are forwarded to the underlying ReactJS `div`/`span` and such data types don't make sense in JS.
- User-defined elements, by default, also accept an array (of anything). This is due to a rather silly constraint of the JSX syntax, described below.

## Syntax Constraint

_Technically_, if you've written a component that accepts a tuple as `children`:

```reason
/* MyForm.re */
type tuple2Children = (ReasonReact.reactElement, ReasonReact.reactElement);

let make = (children: tuple2Children) => {
  ...component,
  render: _self => {
    <div>
      {fst(children)}
      <Separator />
      {snd(children)}
    </div>
  }
};
```

Then you can expect the user you pass you a tuple:

```reason
<MyForm> (<div />, <div />) </MyForm>
```

This, however, will give you a type error:

```
This has type:
  array('a)
But somewhere wanted:
  tuple2Children (defined as (ReasonReact.reactElement, ReasonReact.reactElement))
```

It means that `MyForm` is expecting the tuple, but you're giving `array` instead! What's happening? Well, look at what JSX is transformed into:

```reason
<MyLayout> a b </MyLayout>
<MyLayout> a </MyLayout>
```

These actually become:

```reason
ReasonReact.element(
  MyLayout.make([|a, b|])
);
ReasonReact.element(
  MyLayout.make([|a|])
);
```

See how the second `MyLayout`'s children is also wrapped in an array? We can't special-case `<MyLayout> a </MyLayout>` to pass `a` without the array wrapping (it'd give even more confusing errors). Since children is usually an array, we've decided to always wrap it with an array, no matter how many items we visually see in the JSX. But what if you really want to pass unwrapped data?

### Children Spread

Just use `<MyLayout> ...a </MyLayout>`. This will simply transform into `ReasonReact.element(MyLayout.make(a))`, aka without the array wrapping.

#### Tips & Tricks

Here are some use-cases for children spread + Reason built-in data structures:

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
