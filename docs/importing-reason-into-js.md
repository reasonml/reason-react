---
title: Importing Reason into JS
---

### Importing a Basic Reason file into Javascript

```reason
/* Greeting.re */

[@react.component]
let make = (~name) => <span> {React.string("Hey " ++ name)} </span>;
```

```js
/* App.js */

import { make as Greeting } from './Greeting.bs'

export default function App() {
    return <Greeting name="Peter" />
}
```

### Importing a Component as Default

```reason
/* Greeting.re */

[@react.component]
let make = (~name) => <span> {React.string("Hey " ++ name)} </span>;

/* this sets the named export to default */
let default = make;
```

```js
/* App.js */

import Greeting from './Greeting.bs'

export default function App() {
    return <Greeting name="Peter" />
}
```
