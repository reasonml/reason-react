---
title: Context
---

In order to use React's context, you need to create two things:

1. The context itself
2. A context provider component

```reason
/** as a separate file: ContextProvider.re */

// 1. The context itself
let themeContext = React.createContext("light");

// 2. The provider
include React.Context; // Adds the makeProps external
let make = React.Context.provider(themeContext);
```

```reason
/** or inside any other module */

// 1. The context itself
let themeContext = React.createContext("light");

// 2. The provider component
module ContextProvider = {
  include React.Context; // Adds the makeProps external
  let make = React.Context.provider(themeContext);
};
```

That will give you a `ContextProvider` component you can use in your application later on, by wrapping any component with `ContextProvider`, to have access to the context value inside the component tree. To know more about Context, check the [createContext page of the React.js documentation](https://react.dev/reference/react/createContext) and [when to use it](https://react.dev/learn/passing-data-deeply-with-context).

```reason
/** App.re */
[@react.component]
let make = () =>
  <div>
    <ContextProvider value="light">
      <ComponentToConsumeTheContext />
    </ContextProvider>
  </div>
```

Then you can consume the context by using the `React.useContext` hook

```reason
/** ComponentToConsumeTheContext.re */
[@react.component]
let make = () => {
  let theme = React.useContext(ContextProvider.themeContext);

  <h1>theme->React.string</h1>
}
```

## Binding to an external Context

Binding to a Context defined in a JavaScript file holds no surprises.

```js
/** ComponentThatDefinesTheContext.js */
export const ThemeContext = React.createContext("light");
```

```reason
/** ComponentToConsumeTheContext.re */
[@bs.module "ComponentThatDefinesTheContext"]
external themeContext: React.Context.t(string) = "ThemeContext";

[@react.component]
let make = () => {
  let theme = React.useContext(themeContext);

  <h1>theme->React.string</h1>
}
```
