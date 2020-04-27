---
title: ReasonReact 0.7.0: Support for React Hooks
---

Version 0.7.0 of ReasonReact adds support for the [React Hooks API](https://reactjs.org/docs/hooks-intro.html). This allows for writing function components with state and complex interactions.

You can now write components like

```reason
[@react.component]
let make = (~className, ~text) => <div className> {text} </div>;
```

which will compile to a 0-cost React component that looks like

```js
let make = ({className, text}) => <div className={className}> {text} </div>;
```

In these new components you can make use of the full Hooks api:

```reason
type action =
  | Tick;

type state = {
  count: int,
};

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(
    (state, action) =>
      switch (action) {
      | Tick => {count: state.count + 1}
      },
    {count: 0}
  );

  React.useEffect0(() => {
    let timerId = Js.Global.setInterval(() => dispatch(Tick), 1000);
    Some(() => Js.Global.clearInterval(timerId))
  });
  
  <div>{ReasonReact.string(string_of_int(state.count))}</div>;
};
```

Please read the [new documentation](https://reasonml.github.io/reason-react/docs/en/components) for an in-depth explanation of how to write these components and how they compile to existing ReactJS code.

These components make use of a [new jsx](https://reasonml.github.io/reason-react/docs/en/jsx) implementation that desugars exactly to `React.createElement` calls. In order to use these new components with JSX you will need to use `[@bs.config {jsx: 3}]` at the top of your file and use `^5.0.4` or `^6.0.1` BuckleScript which supports this new version. If you are in a greenfield project or you have fully converted, you can also [change the JSX version](https://bucklescript.github.io/docs/en/build-configuration.html#reason-refmt) in your `bsconfig.json` file to `3` and drop the in-file annotations.

This release also makes use of a new `React` namespace for APIs for all of the code related to this new way of writing components. Some functions have been copied over (like `React.string`, `React.array`) and many are new (like hooks)!

The only breaking change for this API is the introduction of new namespaces, which should be a fairly straightforward fix that most people won't need to do. However, since lots of the new code won't work without a more recent version of BuckleScript, we do recommend doing an upgrade on this version first and treating this as a breaking change even if you have no `React` namespace conflict. If you're interested in migrating some components the upgrade script is [provided](https://github.com/chenglou/upgrade-reason-react#installation). It will wrap existing ReasonReact components as if they are Hooks components. This script will _not_ attempt to re-write your logic as hooks because this is often a complicated process and it is not guaranteed to be correct. Please always inspect and test the work of the migration script to make sure it does what you're expecting!
