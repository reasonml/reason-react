---
title: I want to create a DOM element without JSX
---

In certain cases, you might want to choose the DOM element given props, and JSX prevents that.

In JS, you'd do:

```js
React.createElement(multiline ? "textarea" : "input" /* ... */);
```

ReactJS has a special behavior that considers strings as special components. In a typed language, that's a bit trickier. To that end we provide `ReactDOM.stringToComponent` that makes the compiler understand that a given string is to be considered a component.

In Reason:

```reason
React.createElement(ReactDOM.stringToComponent(multiline ? "textarea" : "input"), /* ... */)
```

You can also pass a variable:

```reason
let tag = ReactDOM.stringToComponent(multiline ? "textarea" : "input");
React.createElement(tag, /* ... */)
```
