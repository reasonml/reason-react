---
title: Intro Example
---

Here is a small overview of the ReasonReact API before we start. No worries if some of these are unfamiliar; the docs cover all of them.

## The component "Greeting"

```reason
/* file: Greeting.re */

[@react.component]
let make = (~name) =>
  <button> {ReasonReact.string("Hello " ++ name ++ "!")} </button>;
```

## Using Greeting in your App

If you're writing your entire React app in Reason, you'll probably have a `ReactDOM.render` in an index.js. This is what that looks like in Reason:

```reason
/* file: Index.re */
switch (ReactDOM.querySelector("#root")) {
| Some(root) => ReactDOM.render(<Greeting name="John" />, root)
| None => ()
}
```

This is how you used to write this in plain Javascript (index.js):

```js
/* file: index.js */
let root = document.getElementById("root");
if(root != null) {
  ReactDOM.render(<Greeting name="John" />, root);
};
```

or if you prefer to be surprised with runtime errors:

```js
ReactDOM.render(<Greeting name="John" />, document.getElementById("root"));
```

### Using Greeting in an existing Javascript/Typescript App

It's easy to import a Reason component into your existing app. All Reason extensions will have `bs` and export your component as `make`. You can rename it and call it as you usually do. [Gentype](https://github.com/cristianoc/genType) makes this easier (see the example).

```js
/* file: App.js */

import { make as Greeting } from "./Greeting.bs";

export default function App() {
  return (
    <div>
      <Greeting name="Peter" />
    </div>
  );
}
```

Make sure you check out [Examples](simple) for more!
