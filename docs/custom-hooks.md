---
title: Custom Hooks
---

```reason
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
