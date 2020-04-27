---
title: A Custom useDebounce Hook
---

```reason
/* this is a hook that takes 2 arguments */
let useDebounce = (value, delay) => {
  let (debouncedValue, setDebouncedValue) = React.useState(_ => value);

  React.useEffect1(
    () => {
      let handler =
        Js.Global.setTimeout(() => setDebouncedValue(_ => value), delay);

      Some(() => Js.Global.clearTimeout(handler));
    },
    [|value|],
  );

  debouncedValue;
};
```
