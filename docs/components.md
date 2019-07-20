---
title: Components
---

ReasonReact uses functions and [React Hooks](https://reactjs.org/docs/hooks-intro.html) to compose the component of your application. Let's look at how a component is written and then break down some of the things happening.

```reason
[@react.component]
let make = (~name) => {
  let (count, setCount) = React.useState(() => 0);

  <div>
    <p> {React.string(name ++ " clicked " ++ string_of_int(count) ++ " times")} </p>
    <button onClick={_ => setCount(_ => count + 1)}>
      {React.string("Click me")}
    </button>
  </div>
};
```

## [@react.component]

This snippet is doing quite a bit! The first thing you might notice is the decorator attribute above the definition. `[@react.component]` tells ReasonReact that you're writing a component with named args syntax (`~name`), but that you would like to compile it into a function that takes a JS object as props which is how React works. Concretely, this attribute will generate code for you that looks like this:

```reason
[@bs.obj]
external makeProps: (~name: 'name, ~key: string=?, unit) => {. "name": 'name} = "";

let make = (Props) => {
  let name = Props##name;
  let (count, setCount) = React.useState(() => 0);

  <div>
    <p> {React.string(name ++ " clicked " ++ string_of_int(count) ++ " times")} </p>
    <button onClick={_evt => setCount(count => count + 1)}>
      {React.string("Click me")}
    </button>
  </div>
};
```

It has added a new function with `Props` as a suffix which uses [`[@bs.obj]`](https://bucklescript.github.io/docs/en/object-2#function) to create your props object. This function gets compiled away by BuckleScript and will be replaced by object literals when used.

### A note on `children`

Like React, `children` is just another prop that is passed to the component. Therefore, using the children in a component is no different than using any other prop! For example:

```reason
module ComponentTakesChildren = {
  [@react.component]
  let make = (~name, ~children) => {
    <div>
      <p> {React.string("Hello, " ++ name)} </p>
      children
    </div>
  };
};
```

The component above could be called like this:

```reason
<ComponentTakesChildren name="Imani">
  <div> {React.string("Effectively the child.")} </div>
</ComponentTakesChildren>
```

## Hooks

The next thing you might notice looking at this example is the use of hooks (`useState`). ReasonReact binds to [all of the hooks that React provides](https://reactjs.org/docs/hooks-intro.html) with only minor API differences. Please refer to their excellent documentation for more information on how hooks work and for best practices.

The differences that you'll notice are mostly around listing dependencies. In React they are passed as an array, however, as Reason does not allow elements of different types in an array, a tuple of varying length is needed as final argument to the hook. For a tuple of length `N` you would need to call `useEffectN`, as otherwise the argument would not type match given the function's type signature which would in turn require a tuple of length `N`.

Accordingly, for example, the two javascript calls:

```js
useEffect(effect, [dep1, dep2]) 
useEffect(effect, []) 
```

would be expressed as the following two reason calls:

```reason
useEffect2(effect, (dep1, dep2))
     /* ^^^ -- Note the number matching the dependencies' length */
useEffect0(effect)
     /* ^^^ --- Compiles to javascript as `useEffect(effect, [])` */
```

A notable exception is that when there is only one dependency, the relevant `useEffect1` call takes an array as the final argument to the hook. While tuples are compiled into JS arrays, the singleton would not be. Therefore, it is necessary to explicitly pass the dependency wrapped in an array.

```reason
useEffect1(effect, [|dep|])
```

However, as the length of the array is not specified, you could pass an array of arbitrary length, including the empty array, `[||]`.

Reason also always opts for the safest form of a given hook as well. So `React.useState` in JS can take an initial value or a function that returns an initial value. The former cannot be used safely in all situations, so ReasonReact only supports the second form which takes a function and uses the return.

## Hand-writing components

You don't need to use the `[@react.component]` declaration to write components. Instead you can write a pair of `foo` and `fooProps` functions such that `type fooProps: 'a => props and foo: props => React.element` and these will always work as React components! This works with your own version of [`[@bs.obj]`](https://bucklescript.github.io/docs/en/object-2#function), [`[bs.deriving abstract]`](https://bucklescript.github.io/docs/en/object#record-mode), or any other function that takes named args and returns a single props structure.

## Interop

### Export to JS

The make function above is a normal React component, you can use it today with code like:

```js
const MyComponent = require('./path/to/Component.bs.js').make;

<MyComponent name="Regina" />
```

### Import from JS

It also works seamlessly with [`[@genType]`](https://github.com/cristianoc/genType) annotations and can be integrated with safety into TypeScript and Flow applications.

Using a component written in JS requires a single external to annotate the types it takes.

```reason
[@bs.module "./path/to/Component.js"][@react.component]
external make: (~name: string) => React.element = "default";
```

This `[@react.component]` annotation will, again, generate both `make` and `makeProps` functions for you with the correct types. Here's an example of what this desugars to without `[@react.component]`:

```reason
[@bs.obj]
external makeProps: (~name: 'name, ~key: string=?, unit) => {. "name": 'name} = "";

[@bs.module "./path/to/Component.js"]
external make: ({. "name": string}) => React.element = "default";
```

**Note on `default`:** to understand what `default` means, see [the BuckleScript docs](https://bucklescript.github.io/docs/en/import-export#import-an-es6-default-value).

## Component Naming

Because components are actually a pair of functions, they have to belong to a module to be used in [JSX](jsx.md). It makes sense to use these modules for identification purposes as well. `[@react.component]` automatically adds the name for you based on the module you are in.

```reason
/* File.re */

/* will be named `File` in dev tools */
[@react.component]
let make = ...

/* will be named `File$component` in dev tools */
[@react.component]
let component = ...

module Nested = {
  /* will be named `File$Nested` in dev tools */
  [@react.component]
  let make = ...
};
```

If you need a dynamic name for higher-order components or you would like to set your own name you can use `React.setDisplayName(make, "NameThatShouldBeInDevTools");`.
