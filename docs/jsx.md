---
title: JSX (Version 3)
---

Reason comes with the [JSX](https://reasonml.github.io/docs/en/jsx.html) syntax! ReasonReact has two different transforms that you can use for your components. This doc covers Version 3 of the transform which is very similar to how [the ReactJS JSX transform](https://reactjs.org/docs/introducing-jsx.html) works. To use it, put `{"reason": {"react-jsx": 3}` in your [`bsconfig.json`](https://bucklescript.github.io/docs/en/build-configuration.html#reason-refmt) (schema [here](http://bucklescript.github.io/bucklescript/docson/#build-schema.json)).

[Version 2](jsx-2.md) is used to render Reducer style components which require special interop to handle the ways they differ from ReactJS components. If you are starting a new project you can stick to version 3 all the time.

For help to migrate from version 2 to version 3, check the section [below](https://reasonml.github.io/reason-react/docs/en/jsx.html#migrating-from-version-2-to-version-3).

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

## Migrating from version 2 to version 3

There are many ReasonReact applications, so it is hard to define "The One True" migration strategy for them all.

Depending on the size and nature of your application there are two options available to migrate from JSX version 2 to version 3.

### Application level

By adding `{"reason": {"react-jsx": 3}` in your [`bsconfig.json`](https://bucklescript.github.io/docs/en/build-configuration.html#reason-refmt).

This approach requires that all components in the application must be made compatible with version 3 of JSX at once, so it will be a better fit for smaller apps with a reduced number of components, where all of them can be migrated to version 3 in one fell swoop.

### File level

For larger applications, it might not be possible to migrate all components at once. In these cases, a per-file migration is also possible.

A file can be configured to use version 3 of the transform by adding `[@bs.config {jsx: 3}];` at the top of the file.

The per-file configuration allows to mix, in the same application, components compatible with either of both versions of the JSX transforms. However, the restriction is that all the components used in a file will have to be compatible with the JSX version specified for that file.

For example, if a file contains the following code:

```reason
/* User.re */
[@bs.config {jsx: 3}];

[@react.component]
let make = (~id) => {
  <Profile>
    <UserDetails id />
  </Profile>;
};
```

Then `Profile` and `UserDetails` components will have to be compatible with the version 3 of JSX. Or alternatively, if they are using version 2, they can be wrapped with the function `ReasonReactCompat.wrapReasonReactForReact`.

#### From primitives to more complex components

As all usages of any component in a file need to be migrated to the same version of JSX, one natural way to tackle large migrations at the file level is to start converting the most primitive components to version 3, as they generally render elements of a reduced number of components, or host elements like `<div />`. Once the most simple components are done, one can proceed with the most complex ones.

While this process is ongoing, both versions of JSX need to coexist. For example, a component `Banner` compatible with version 2 might need to use a component `Image` that is compatible with version 3. `Image` can be made compatible by leveraging `ReasonReactCompat.wrapReactForReasonReact`:

```reason
/* In Image.re */
[@bs.config {jsx: 3}];

[@react.component]
let make = (~src) => <img src />;

module Jsx2 = {
  let component = ReasonReact.statelessComponent("Image");
  /* `children` is not labelled, as it is a regular parameter in version 2 of JSX */
  let make = (~src, children) =>
    ReasonReactCompat.wrapReactForReasonReact(
      make,
      makeProps(~src, ()),
      children,
    );
};
```

Then, `Image` can be used from `Banner`:

```reason
/* In Banner.re */
let component = ReasonReact.statelessComponent("Banner");

let make = _children => {
  ...component,
  render: _self => <Image.Jsx2 src="./cat.gif" />,
};
```

Once all components are using version 3, there is no more need to keep the `[@bs.config {jsx: 3}];` annotations at the top of each file, and they can be replaced by bumping the JSX version in the `bsconfig.json` file to `{"reason": {"react-jsx": 3}`.

### Upgrade script

A migration script [is provided](https://github.com/chenglou/upgrade-reason-react#installation) to facilitate the task to convert components to version 3. It will wrap existing ReasonReact components as if they are Hooks components. This script will not attempt to re-write your logic as hooks because this is often a complicated process and it is not guaranteed to be correct. Please always inspect and test the work of the migration script to make sure it does what you are expecting.
