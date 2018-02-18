---
title: Talk to Existing ReactJS Code
---

### Project Setup

You can reuse the _same_ bsb setup (that you might have seen [here](installation.md#bsb))! Aka, put a `bsconfig.json` at the root of your ReactJS project:

```json
{
  "name": "my-project-name",
  "reason": {"react-jsx" : 2},
  "sources": [
    "my_source_folder"
  ],
  "package-specs": [{
    "module": "commonjs",
    "in-source": true
  }],
  "suffix": ".bs.js",
  "namespace": true,
  "bs-dependencies": [
    "reason-react"
  ],
  "refmt": 3
}
```

This will build Reason files in `my_source_folder` (e.g. `reasonComponent.re`) and output the JS files (e.g. `reasonComponent.bs.js`) alongside them.

Then add `bs-platform` to your package.json (`npm install --save-dev bs-platform` or `yarn add --dev bs-platform`):

```json
"scripts": {
  "start": "bsb -make-world -w"
},
"devDependencies": {
  "bs-platform": "^2.1.0"
},
"dependencies": {
  "react": "^15.4.2",
  "react-dom": "^15.4.2",
  "reason-react": "^0.3.1"
}
...
```

Running `npm start` (or alias it to your favorite command) starts the `bsb` build watcher. **You don't have to touch your existing JavaScript build configuration**!

### ReasonReact using ReactJS

Easy! Since other Reason components only need you to expose a `make` function, fake one up:

```reason
[@bs.module] external myJSReactClass : ReasonReact.reactClass = "./myJSReactClass";

let make = (~name: string, ~age: option(int)=?, children) =>
  ReasonReact.wrapJsForReason(
    ~reactClass=myJSReactClass,
    ~props={"name": name, "age": Js.Nullable.from_opt(age)},
    children
  );
```

`ReasonReact.wrapJsForReason` is the helper we expose for this purpose. It takes in the `reactClass` you want to wrap, the `props` js object (of type `Js.t {. foo: bar}`) you'd pass to it (with values converted from Reason data structures to JS), and the mandatory children you'd forward to the JS side.

**We recommend** to type the `make` parameters, since they're passed to `props` into the JS side, which is untyped.

**Note**: if your app successfully compiles, and you see the error "element type is invalid..." in your console, you might be hitting [this mistake](element-type-is-invalid.md).

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
var MyReasonComponent = require('./myReasonComponent.bs');
// make sure you're passing the correct data types!
<MyReasonComponent name="John" />
```

**Note**: `default` exports like the one above are supported for `BuckleScript >=1.8.2`. If that doesn't work, try a non-default export, like:

```reason
let jsComponent = ReasonReact.wrapReasonForJs(...)
```

and then import it on the JS side with:

```
var MyReasonComponent = require('./myReasonComponent.bs').jsComponent
```
