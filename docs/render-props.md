---
title: Render Props
---

### Basic Render Props

```reason
[@react.component]
let make = () => {
  <Loader render={() => <div />} />
};
```

```reason
/* Loader.re */

[@react.component]
let make = (~render) => {
 <div> {render()} </div>
};
```

### Children as Render Props

```reason
[@react.component]
let make = (~children) => {
  <Loader>
    {person => <div> {React.string(person.name)} </div>}
  </Loader>;
};
```

```reason
/* Loader.re */

[@react.component]
let make = (~children) => {
  let person = {name: "Peter"};
  <div> {children(person)} </div>;
};
```
