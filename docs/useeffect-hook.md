---
title: useEffect Hook
---

[React.js docs for useEffect](https://reactjs.org/docs/hooks-reference.html#useeffect)

Here's a simple example of how to use React's `useState` with `useEffects`.

### Cleaning up an effect

```reason
[@react.component]
let make = () => {
    React.useEffect0(() => {
        let id = subscription.subscribe();
        /* clean up the subscription */
        Some(() => subscription.unsubscribe(id));
    });
}
```

### Conditionally firing an effect

With this, the subscription will only be recreated when `~source` changes

```reason
[@react.component]
let make = (~source) => {
    React.useEffect1(() => {
        let id = subscription.subscribe();
        /* clean up the subscription */
        Some(() => subscription.unsubscribe(id));
    }, [|source|]);
}
```
