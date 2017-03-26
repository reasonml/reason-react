React on Reason
===

Scope
---
- Create bindings to React that are more native to Reason
- Implementing a reconciler that demonstrates that these bindings to React are sound. 
- Pure logic 
- Not UI related
- A reactive tree that changes over time

Example of bindings
---
```reason
/**
 * Dreaming!
 */
let button ::txt="default" ::width=500 ::height=50 children ::state=initialState updater => {
  let handleChild e => {
    ..state,
    clickCount: state.clickCount + 1
  };
  <box onClick=(updater handleClick)> (string_of_int state.clickCount) </box>
};
```

License
---
MIT
