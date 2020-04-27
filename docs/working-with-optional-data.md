---
title: Working with Optional Data
---

If you're coming from Javascript, optional data can be a real pain in the butt. ReasonML removes a *whole class* of `null` and `undefined` bugs which makes your code WAY safer and easier to write, but it takes some good examples to get you there :smile:

### Accessing Optional Nested Data

Say you have have an array of colors and you want to match one of those colors:

```reason
let selected = colors->Belt.Array.getBy(c => c##id === id);
```

```javascript
// Javascript
const selected = colors.find(c => c.id === id);
```

In both cases `selected` could be optional. The compiler may yell at you to handle that case, here's how you could handle it:

```reason
let label = selected->Belt.Option.mapWithDefault(
  "Select a Color",
  selected => selected##name
);
```

What this is doing: "if selected exists, go look into `selected##name` otherwise return `Select a Color`".

Read more about [`mapWithDefault`](https://reasonml.org/apis/javascript/latest/belt/option) here.

### Something or Nothing

We need to grab the name of the person, but we also know that `name` can come back as `undefined`. We still want that label to be a string.

```reason
/* create the type for the record, totally ok that it's the same name! */

type person = {
  name: option(string)
};

let person = {
  name: None
};

let label = switch(person.name) {
    | Some(name) => name
    | None => "Peter"
}
```

You can also use `Belt.Optional.getWithDefault` which is sugar for above:

```reason
let label = Belt.Option.getWithDefault(person.name, "Peter");
```

If you need to return null instead of a component:

```
<div>
  {
    switch (person.name) {
    | Some(name) => <Name name="Peter" />
    | None => React.null
    }
  }
</div>;
```

Read more about [`getWithDefault`](https://reasonml.org/apis/javascript/latest/belt/option) here.
