---
id: component-as-prop
title: Component as Prop
---

In ReactJS, `<Menu banner=MyBanner />` is easy; in ReasonReact, we can't trivially pass the whole component module (it wouldn't even be syntactically valid. A module resides in another layer of language. [Explanations](https://reasonml.github.io/guide/language/module)). Solution:

```reason
let bannerCallback = (prop1, prop2) => <MyBanner message=prop1 count=prop2 />;

<Menu bannerFunc=bannerCallback />;
```

This also has some added advantages:

- The _owner_ is the one controlling how the component renders, not some opaque logic inside `MyBanner`.
- Circumvents the tendency of needing a [props spread](props-spread.md) in `MyBanner`'s render, since passing a component to a child and the child using prop spread on said component usually go together.

--- 

In practise, if you want a component that would accept children, you can do the following:

```reason
<RandomComponent wrapperFunc=((~children) => <div className="something-special"> ...children </div>) />
```

The associated definition of the `RandomComponent` could be something like:

```reason
let component = ReasonReact.statelessComponent("RandomComponent");

let make =
    (
      /* note the default value that just wrap with a simple node */
      ~wrapperFunc=(~children) => <div> ...children </div>,
      _children
    ) => {
  ...component,
  render: (_self) =>
    <div>
      (wrapperFunc(
        ~children=[|
          <span>Something</span>
        |]
      ))
       
    </div>
}
```
