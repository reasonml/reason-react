---
title: ReasonReactCompat: migrating to 0.7.0 and JSX v3
---

In version 0.7.0, two large changes were introduced:

- Support for React hooks
- A new JSX version (v3)

You can read more in the release [blog post](https://reasonml.github.io/reason-react/blog/2019/04/10/react-hooks).

To enable the progressive migrations of existing ReasonReact applications to the new API and JSX version, a new module called `ReasonReactCompat` was added to ReasonReact.

## React and ReasonReact modules

`ReasonReactCompat` is a bridge between two modules:

- `ReasonReact`: contains the now frozen API that was used to implement components in v0.6.0 and earlier using JSX v2.
- `React`: the module that contains the hooks-compatible API, that is available since v0.7.0 and uses JSX v3.

JSX versions 2 and 3 are coupled with the corresponding modules `ReasonReact` and `React`. In other words: a component created using `ReasonReact` module will require JSX v2, and a component built using `React` module will require JSX v3.

For clarity and brevity, in the rest of the section we will refer to each group as follows:
- `ReasonReact` components (< 0.7.0) that use JSX v2, as **v2 components**
- `React` components (>= 0.7.0) that use JSX v3, as **v3 components**.

## `wrapReactForReasonReact`: Wrapping a v3 component to be used from a v2 component

In most cases, we will want to migrate our application to use v3 components (see the section about migration strategies [below](https://reasonml.github.io/reason-react/docs/en/reasonreactcompat.html#migrating-an-application-to-v070-and-jsx-v3)).

For example, a v2 component `Banner` might need to use a v3 component `Image`. `Image` can be made compatible by leveraging `ReasonReactCompat.wrapReactForReasonReact`:

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

### Component with `children`

Some components pass down `children` transparently, like:

```reason
/* In SomeButton.re */
[@react.component]
let make = (~children) => <button> children </button>;
```

If this kind of components need to expose a `Jsx2` module for backwards compatibility, like seen above, you might run into errors like:

```
This expression has type array('a)
but an expression was expected of type
ReasonReact.reactElement = React.element
```

In these cases, it is helpful to wrap `children` with `React.array` inside the `Jsx2` compatibility module, like:

```reason
/* In SomeButton.re */
module Jsx2 = {
  let component = ReasonReact.statelessComponent("SomeButton");
  let make = children => {
    let children = React.array(children);
    ReasonReactCompat.wrapReactForReasonReact(
      make,
      makeProps(~children, ()),
      children,
    );
  };
};
```

The reason behind those errors is that version 3 of JSX doesn't automatically wrap the `children` passed to an element in an array, like version 2 used to do. Using `React.array` in the `Jsx2` module is a way to provide a consistent behavior for usages of the component in both versions of the JSX transform.

## `wrapReasonReactForReact`: Wrapping a v2 component to be used from a v3 component

Sometimes we might need to make the translation the other way around: wrap a v2 component to be used from a v3 component. For example, if we are using some ReasonReact library that has not been updated yet to be compatible with the latest version.

In these cases, we can use `ReasonReact.wrapReasonReactForReact`.

Let's say we have a v2 component `Text` that needs to be used from a v3 component `Heading`:

```reason
/* In Text.re */
let component = ReasonReact.statelessComponent("Text");

let make = (~text, _children) => {
  ...component,
  render: _self => <span> {ReasonReact.string(text)} </span>,
};
```

We can follow the same approach as above and add a `Jsx3` module to the same file:

```reason
/* Still in Text.re */
module Jsx3 = {
  [@bs.obj] external makeProps: (~text: string, unit) => _ = "";
  let make =
    ReasonReactCompat.wrapReasonReactForReact(
      ~component, (reactProps: {. "text": string}) =>
      make(~text=reactProps##text, [||])
    );
};
```

### Component with `children`

If the v2 component we want to migrate uses `children` we have to take some extra steps to convert it.

For example, let's say we have a `List` v2 component:

```reason
/* List.re */
let component = ReasonReact.statelessComponent("List");

let make = (~visible, children) => {
  ...component,
  render: _self => visible ? <div> ...children </div> : ReasonReact.null,
};
```

The `Jsx3` compat module will look like:

```reason
/* Still in List.re */
module Jsx3 = {
  [@bs.obj]
  external makeProps: (~visible: bool, ~children: 'children=?, unit) => _ = "";
  let make =
    ReasonReactCompat.wrapReasonReactForReact(
      ~component,
      (
        reactProps: {
          .
          "visible": bool,
          "children": 'children,
        },
      ) =>
      make(
        ~visible=reactProps##visible,
        reactProps##children
        ->Js.Undefined.toOption
        ->Belt.Option.mapWithDefault([||], c => [|c|]),
      )
    );
};
```

Because v3 components using `List.Jsx3` can decide whether to pass `children` or not, we have to account for those cases by setting `children` as optional labelled argument in `makeProps`. After that, we also have convert `children` to an array inside `make` before passing control over to the v2 implementation.

## Migrating an application to v0.7.0 and JSX v3

There are many ReasonReact applications, so it is hard to define "The One True" migration strategy for them all.

Depending on the size and nature of your application there are two options available to migrate your application from 0.6.0 to 0.7.0.

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

Then `Profile` and `UserDetails` components will have to be compatible with the version 3 of JSX. Or alternatively, if they are using version 2, they can be wrapped with the function `ReasonReactCompat.wrapReasonReactForReact`, as seen in [the section above](https://reasonml.github.io/reason-react/docs/en/reasonreactcompat.html#wrapreasonreactforreact-wrapping-a-v2-component-to-be-used-from-a-v3-component).

#### From primitives to more complex components

As all usages of any component in a file need to be migrated to the same version of JSX, one natural way to tackle large migrations at the file level is to start converting the most primitive components to version 3, as they generally render elements of a reduced number of components, or host elements like `<div />`. Once the most simple components are done, one can proceed with the most complex ones.

Once all components are using version 3, there is no more need to keep the `[@bs.config {jsx: 3}];` annotations at the top of each file, and they can be replaced by bumping the JSX version in the `bsconfig.json` file to `{"reason": {"react-jsx": 3}` for the whole application.

### Upgrade script

A migration script [is provided](https://github.com/chenglou/upgrade-reason-react#installation) to facilitate the task to convert components to version 3. It will wrap existing ReasonReact components as if they are Hooks components. This script will not attempt to re-write your logic as hooks because this is often a complicated process and it is not guaranteed to be correct. Please always inspect and test the work of the migration script to make sure it does what you are expecting.
