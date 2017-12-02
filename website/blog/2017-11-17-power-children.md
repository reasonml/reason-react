---
title: RR 0.3.0 - Power Children
---

0.3.0 is here! We've bumped the minor version because it's a breaking change (just a small one, see [HISTORY.md](https://github.com/reasonml/reason-react/blob/master/HISTORY.md#030). We've been _really_ careful with breaking changes). Stay tuned for more exciting features coming in the next few weeks (non-breaking). In the meantime, here's the big improvement of this release: **you're now allowed to pass any data type to JSX children**, not just `array(reactElement)`. And yes, they all type check, naturally!

Head over to the improved [JSX](https://reasonml.github.io/reason-react/docs/en/jsx.html#children) docs and then [Children](https://reasonml.github.io/reason-react/docs/en/children.html) docs to know the details. Here's a summary.

Previously, `<Comp> child1 child2 </Comp>` desugars to passing an array of `[|child1, child2|]` to `Comp` as `children`. This is likewise the case for `<Comp> child1 </Comp>` where, due to syntax constraints, we're _still_ passing an array of `[|child1|]` to `Comp`. Since Reason 3, we've introduced the [children spread syntax](https://reasonml.github.io/guide/language/jsx#children-spread) which simply makes `<Comp> ...child1 </Comp>` _not_ pass the array wrapper, but directly `child1`, to `children`.

What does this unlock? Crazy tricks like these:

- A form component that mandates a tuple of 2 react element and shows them side-by-side:

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

The type system will ensure that the data you're passing matches its usage inside these component. No need to explicitly annotate them unless you want to.

In reality, this change was around 2 or 3 lines of code (albeit with lots of thinking time). It's a nice indicator of us leveraging the language itself rather than reinventing such concept within the framework. Notice also that the new spread syntax addition is _still_ ReasonReact-agnostic (under the hood, the `children` label simply isn't passed a wrapper list/array in the presence of `...`). This kind of simple, gradual and vertically-integrated-yet-agnostic improvement is a large part of what we're hoping to do more in the future.
