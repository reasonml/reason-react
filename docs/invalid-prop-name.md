---
title: Invalid Prop Name
---

Prop names like `type` (as in `<input type="text" />`) aren't syntactically valid; `type` is a reserved keyword in Reason/OCaml. Use `<input type_="text" />` instead. This follows BuckleScript's [name mangling rules](https://bucklescript.github.io/docs/en/object.html#invalid-field-names).

For `aria-*` use camelCasing, e.g., `ariaLabel`. For DOM components, we'll translate it to `aria-label` under the hood.

For `data-*` this is a bit trickier; words with `-` in them aren't valid in Reason/OCaml. When you do want to write them, e.g., `<div data-name="click me" />`, use the following:

```reason
ReactDOMRe.createElementVariadic(
  "div",
  ~props=(ReactDOMRe.objToDOMProps({"data-name": "click me"})),
  [||]
)
```

For non-DOM components, you need to pick valid prop names.
