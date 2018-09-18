---
title: Element Type is Invalid Runtime Error
---

If you run your app and see in the console the error:

> "element type is invalid... You likely forgot to export your component from the file it's defined in, or you might have mixed up default and named imports"

This likely means that:

- You're wrapping a JS component for ReasonReact using with [`ReasonReact.wrapJsForReason`](interop.md#reasonreact-using-reactjs).
- The JS component uses ES6 default export (`export default MyComponent`) (or, you forgot to export the component altogether!).
- You're using Babel/Webpack to compile those ES6 modules.

This is a common mistake. Please see BuckleScript's [Import an ES6 Default Value](https://bucklescript.github.io/docs/en/import-export.html#import-an-es6-default-value). Aka, instead of:

```reason
[@bs.module] external myJSReactClass: ReasonReact.reactClass = "./myJSReactClass";
```

Use:

```reason
[@bs.module "./myJSReactClass"] external myJSReactClass: ReasonReact.reactClass = "default";
```

Remember that Reason doesn't have runtime type errors! So it _must_ have meant that your binding was written wrongly.
