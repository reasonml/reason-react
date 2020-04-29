---
title: A List of Simple Examples
---

### A Basic Greeting Component

**Some things to note**:

- Reason's `return` statements are implicit so you don't need to write `return`. It'll always be the last item in the block
- Reason has labelled parameters (arguments) that are prefixed by a tilde, eg: `~message`
- Since everything in ReasonReact is typed, we need to wrap our message in `React.string(message)`

```reason
/* Greeting.re */

[@react.component]
let make = (~message) => <h1> {React.string(message)} </h1>;
```

Usage in another file. Looks very similar to JSX in Javascript!

```reason
/* ... */

<div>
  <Greeting message="Hello World!">
</div>

/* ... */
```

### A Component with Optional Arguments and React.Fragment

```reason
[@react.component]
let make = (~title, ~description=?) =>
  <>
    /* React.Fragment works the same way as in React.js! */
    <h1> title </h1>
    /* Handling optional variables where you don't want to render anything */
    {
      switch (description) {
      | Some(description) => <span> {React.string(description)} </span>
      /* Since everything is typed, React.null is required */
      | None => React.null
      }
    }
  </>;
```

### A Form Component with React.js Differences

```reason
[@react.component]
let make = () => {
  /* unused variables are prefixed with an underscore */
  let onSubmit = _event => Js.log("Hello this is a log!");

  /* onSubmit=onSubmit turns to just onSubmit */
  <form onSubmit>

      <input
        /* class names work the same way */
        className="w-full"
        /* type_ is underscored b/c its a reserved word in Reason */
        type_="text"
        /* No brackets needed! */
        autoFocus=true
        placeholder="Game Code"
      />
      <button type_="submit"> {React.string("Button label")} </button>
    </form>;
};
```

### A Component that Renders a List of Items

This component uses [Belt](https://reasonml.org/apis/javascript/latest/belt), Reason's preferred Standard Library.

```reason
/* We define the type of the item (this is a record) */
type item = {
  id: string,
  text: string,
};

[@react.component]
let make = (~items) =>
  <ul>
    {
      items
      ->Belt.Array.map(item =>
          <li key={item.id}> {React.string(item.text)} </li>
        )
      /* Since everything is typed, the arrays need to be, too! */
      ->React.array
    }
  </ul>;
```
