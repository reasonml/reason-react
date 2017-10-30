---
id: children
title: Children
---

JSX children are typed as `array`. This is problematic, because `<Foo> children </Foo>` where `children` comes from props (aka your `make` function) is really now a wrapped array (`Foo.make([|children|])`) and wouldn't type.

Some people circumvent this with `<Foo> {ReasonReact.arrayToElement(children)} </Foo>`, but this is wrong; it'll trigger ReactJS' [key warning](https://facebook.github.io/react/docs/lists-and-keys.html#basic-list-component). Instead, you should use the desugared form, `Foo.make(children)`, which doesn't automatically wrap the children in an array wrapper like JSX does. Learn about desugaring JSX [here](jsx.md#capitalized).

For passing to DOM element, e.g. `<div foo=bar> children </div>` use the following:

```reason
ReasonReact.createDomElement("div", ~props={"foo": bar}, children);
```

The reason why passing nested children array in ReactJS doesn't warn is because ReactJS uses some hacks under the hood.

This isn't ideal; we'll make this better in the future!
