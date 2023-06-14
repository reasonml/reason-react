---
title: Intro Example
---

Here is a small overview of the ReasonReact API before we start. No worries if some of these are unfamiliar; the docs cover all of them.

## The component "Greeting"

```reason
/* file: Greeting.re */

[@react.component]
let make = (~name) => <button> {React.string("Hello " ++ name ++ "!")} </button>;
```

## Using Greeting in your App

If you're writing your entire React app in Reason, you'll probably have a `ReactDOM.render` in an index file. This is what that looks like in Reason:

```reason
/* file: Index.re */
switch (ReactDOM.querySelector("#root")) {
| Some(root) => ReactDOM.render(<Greeting name="John" />, root)
| None => ()
}
```

This is how you used to write this in plain JavaScript (index.js):

```js
/* file: index.js */
let root = document.getElementById("root");
if (root != null) {
  ReactDOM.render(<Greeting name="John" />, root);
};
```

### Using Greeting in an existing JavaScript/Typescript application

It's easy to import a ReasonReact component into your existing app. After being transpiled to JS, all Reason components will have `.js` as extension by default and export a function component called `make`. You can change it with [module_systems](https://melange.re/v1.0.0/build-system/#commonjs-or-es6-modules) field inside a [`melange.emit` stanza](https://dune.readthedocs.io/en/stable/melange.html#melange-emit).

```js
/* file: App.js */

import { make as Greeting } from "./Greeting.js";

export default function App() {
  return (
    <div>
      <Greeting name="Peter" />
    </div>
  );
}
```

Make sure you check out [Examples](simple) for more!
