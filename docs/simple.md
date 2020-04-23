---
title: Simple Examples
---

### A Simple Component

```reason
/* Greeting.re */

[@react.component]
let make = (~message) => <h1> {React.string(message)} </h1>;
```

Usage in another file:

```reason
ReactDOMRe.renderToElementWithId(
  <Greeting message="Hello World!" />,
  "index",
);
```

### A Component with Optional Arguments and React.Fragment

```reason
[@react.component]
let make = (~title, ~description=?) => {
    /* React.Fragment works the same way as in React.js! */
    <>
        <h1>{title}</h1>
        /* Handling optional variables where you don't want to render anything */
        {switch(description) {
            | Some(description) => <span>{React.string(description)</span>}
            /* Since everything is typed, React.null is required */
            | None => React.null
        }}
    </>
};
```

### A Form Component with React.js Differences

```reason
[@react.component]
let make = () => {
    /* unused variables are prefixed with an underscore */
    let onSubmit = _event => {
        Js.log("Hello this is a log!");
    };

    /* onSubmit=onSubmit turns to just onSubmit */
    <form onSubmit>
        /* class names work the same way */
        <input className="w-full"
            /* type_ is underscored b/c its a reserved word in Reason */
            type_="text"
            /* No brackets needed! */
            autoFocus=true
            placeholder="Game Code"
        />
        <button type_="submit">
            {React.string("Button label")}
        </button>
    </form>
};
```

### A Component that Renders a List of Items

```
type item = {
  id: string,
  text: string,
};

[@react.component]
let make = (~items) => {
  <ul>
    {items
     ->Belt.Array.map(item => {
         <li key={item.id}> {React.string(item.text)} </li>
       })
     ->React.array}
  </ul>;
};
```
