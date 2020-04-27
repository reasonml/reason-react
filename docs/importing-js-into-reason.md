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
