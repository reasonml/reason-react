---
id: interop
title: Interop With Existing ReactJS Components
---

### ReasonReact using ReactJS

Easy! Since other Reason components only need you to expose a `make` function, fake one up:

```reason
[@bs.module] external myJSReactClass : ReasonReact.reactClass = "myJSReactClass";

let make = (~name: string, ~age: option(int)=?, children) =>
  ReasonReact.wrapJsForReason(
    ~reactClass=myJSReactClass,
    ~props={"name": name, "age": Js.Nullable.from_opt(age)},
    children
  );
```

`ReasonReact.wrapJsForReason` is the helper we expose for this purpose. It takes in the `reactClass` you want to wrap, the `props` js object (of type `Js.t {. foo: bar}`) you'd pass to it (with values converted from Reason data structures to JS), and the mandatory children you'd forward to the JS side.

**We recommend** to type the `make` parameters, since they're passed to `props` into the JS side, which is untyped.

### ReactJS Using ReasonReact

Eeeeasy. We expose a helper for the other direction, `ReasonReact.wrapReasonForJs`:

```reason
let component = ...;
let make ...;

let default =
  ReasonReact.wrapReasonForJs(
    ~component,
    (jsProps) => make(~name=jsProps##name, ~age=?Js.Nullable.to_opt(jsProps##age), [||])
  );
```

The function takes in the labeled reason `component` you've created, and a function that, given the JS props, asks you to call `make` while passing in the correctly converted parameters. You'd assign the whole thing to the name `default`. The JS side can then import it:

```
var MyReasonComponent = require('myReasonComponent');
// make sure you're passing the correct data types!
<MyReasonComponent name="John" />
```

**Note**: `default` exports like the one above are supported for `BuckleScript >=1.8.2`. If that doesn't work, try a non-default export, like:

```reason
let jsComponent = ReasonReact.wrapReasonForJs(...)
```

and then import it on the JS side with:

```
var MyReasonComponent = require('myReasonComponent').jsComponent
```
