---
title: Importing JS into Reason
---

### Importing a Javascript file into Reason

```js
/* MyJavascriptFile.js */

export default function Greeting({ name }) {
    return <span> Hey {name}</span>
}
```

```reason
/* App.re */

module Greeting = {
  [@bs.module "./MyJavascriptFile.js"] [@react.component]
  external make: (~name: string) => React.element = "default";
};

let make = () => <div> <Greeting name="Peter" /> </div>;
```

### Default props and JavaScript components

Sometimes you need your JavaScript component to have a default prop. How you
handle this will depend on the details of the situation.

#### Scenario 1: The JavaScript component prop is already coded to have a default

```js
function Greeting({ name }) {
 return <span>Hey {name}</span>
};

Greeting.defaultProps = {
  name: "John"
};
```

Props (or any function argument) with a default is just an optional prop as far
as its signature is concerned. To bind to it, we just make the prop optional.

```reason
module Greeting = {
  [@bs.module "./Greeting.js"] [@react.component]
  external make: (~name: string=?) => React.element = "default";
};
```

(Note that function signatures are only concerned with types, not values. Code
like `external make: (~name="Peter") => React.element` is a syntax error.
`"Peter"` is a value, whereas `string` is a type.)

#### Scenario 2: The JavaScript component prop doesn't have a default, but we want to add one

In JavaScript, the logic for default arguments is handled at runtime inside the
function body. If our external does not already have a default, we'll need to
wrap it with our own component to add the logic.

```reason
module GreetingJs = {
  [@bs.module "./Greeting.js"] [@react.component]
  external make: (~name: string) => React.element = "default";
};

module Greeting = { 
  [@react.component]
  let make = (~name="Peter") => <GreetingJs name />;
};
```
