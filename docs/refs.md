---
title: Refs in React
---

_Not to be confused with Reason `ref`, the language feature that enables mutation_.

Refs in React come in two forms. One works a lot like Reason `ref` - it is an object with a single field `current` that gets mutated. The other is a function which gets called whenever the ref value changes. ReasonReact works with both. `React.Ref.t` is the ref with a value that mutates. You create this kind of ref with the  `useRef` hook or with `createRef` in the Record API.

There are many cases where you might want to use refs to track things that don't necessarily need to trigger a re-render but are useful for logging or some other side effect. In this case you can use `useRef` with any value you'd like to track!

```reason
[@react.component]
let make = () => {
  let clicks = React.useRef(0);

  <div onClick={_ => React.Ref.(clicks->setCurrent(clicks->current + 1))} />;
};
```

DOM elements allow you to pass refs to track specific elements that have been rendered for side-effects outside of React's control. To do this you can use the `ReactDOMRe.Ref` module.

```reason
[@react.component]
let make = () => {
  let divRef = React.useRef(Js.Nullable.null);

  React.useEffect(() => {
    doSomething(divRef);
  });

  <div ref={ReactDOMRe.Ref.domRef(divRef)} />;
};
```

For some cases it's easier to work with callback refs which get called when the DOM node changes. We support this use-case as well using `ReactDOMRe.Ref.callbackDomRef`.

```reason
[@react.component]
let make = () => {
  <div ref={ReactDOMRe.Ref.callbackDomRef(ref =>
    doEffectWhenRefChanges(ref)
  )} />;
};
```
