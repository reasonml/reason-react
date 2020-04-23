---
title: Gentype & Typescript
---

[Gentype](https://github.com/cristianoc/genType) is a library that automatically generates idiomatic bindings between Reason and JavaScript: either vanilla or typed with TypeScript/FlowType.

Installing it includes running `yarn add --dev gentype` and creating a basic `gentypeconfig` in your `bsconfig.json` file:

```
"gentypeconfig": {
    "language": "typescript",
    "shims": {},
    "debug": {
      "all": false,
      "basic": false
    }
}
```

Read more [here](https://github.com/cristianoc/genType#installation)

### Basic Greeting Component

```reason
[@gentype "Greeting"]
[@react.component]
let make = (~message) => {
    <div>{React.string(message)}</div>
}
```

Here's how you import that component into your Typescript project. As you can see, there's a new file generated with a `.gen` extension. Then, everything works as is!

```ts
/* App.tsx */

import { Greeting } from './Greeting.gen';

// ..

export default function App() {
    return <Greeting message="Hello world!" />
}
```
