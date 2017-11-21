---
id: react-ref
title: React Ref
---

_Not to be confused with Reason `ref`, the language feature that enables mutation_.

A ReasonReact `ref` would be just another instance variable. You'd type it as `ReasonReact.reactRef` if it's attached to a custom component, and `Dom.element` if it's attached to a React DOM element.

```reason
type state = {
  isOpen: bool,
  mySectionRef: ref(option(ReasonReact.reactRef))
};

let setSectionRef = (theRef, {ReasonReact.state}) => {
  state.mySectionRef := Js.Nullable.to_opt(theRef);
  /* wondering about Js.Nullable.to_opt? See the note below */
};

let component = ReasonReact.reducerComponent("MyPanel");

let make = (~className="", _children) => {
  ...component,
  initialState: () => {isOpen: false, mySectionRef: ref(None)},
  reducer: ...,
  render: (self) => <Section1 ref={self.handle(setSectionRef)} />
};
```

Attaching to a React DOM element looks the same: `state.mySectionRef = {myDivRef: Js.Nullable.to_opt(theRef)}`.

**Note** how [ReactJS refs can be null](https://github.com/facebook/react/issues/9328#issuecomment-298438237). Which is why `theRef` and `myDivRef` are converted from a [JS nullable](http://bucklescript.github.io/bucklescript/Manual.html#_null_and_undefined) to an OCaml `option` (Some/None). When you use the ref, you'll be forced to handle the null case through a `switch`, which prevents subtle errors!

**You must follow the instanceVars convention in the previous section for ref**.

ReasonReact ref only accept callbacks. The string `ref` from ReactJS is deprecated.

We also expose an escape hatch `ReasonReact.refToJsObj` of type `ReasonReact.reactRef => Js.t {..}`, which turns your ref into a JS object you can freely use; **this is only used to access ReactJS component class methods**.

```reason
let handleClick = (event, self) =>
  switch self.state.mySectionRef^ {
  | None => ()
  | Some(r) => ReasonReact.refToJsObj(r)##someMethod(1, 2, 3) /* I solemnly swear that I am up to no good */
  };
```
