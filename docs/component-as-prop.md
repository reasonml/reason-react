---
id: component-as-prop
title: Component as Prop
---

In ReactJS, `<Menu banner=MyBanner />` is easy; in ReasonReact, we can't trivially pass the whole component module ([explanations](https://reasonml.github.io/guide/language/module)). Solution:

```reason
let bannerCallback = (prop1, prop2) => <MyBanner message=prop1 count=prop2 />;

<Menu bannerFunc=bannerCallback />;
```
