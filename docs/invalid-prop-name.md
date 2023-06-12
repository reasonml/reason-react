---
title: Invalid Prop Name
---

Prop names like `type` (as in `<input type="text" />`) aren't syntactically valid; `type` is a reserved keyword in Reason/OCaml. Use `<input type_="text" />` instead.

### Invalid prop names on DOM elements
- `type` please use `type_` instead
- `as` please use `as_` instead
- `open` please use `open_` instead
- `begin` please use `begin_` instead
- `end` please use `end_` instead
- `in` please use `in_` instead
- `to` please use `to_` instead

For `aria-*` use camelCasing, e.g., `ariaLabel`. For DOM components, we'll translate it to `aria-label` under the hood.

For `data-*` this is a bit trickier; words with `-` in them aren't valid in Reason/OCaml. When you do want to write them, e.g., `<div data-name="click me" />`, use the following:

```reason
React.cloneElement(
  <div />,
  {"data-name": "click me"}
);
```

For non-DOM components, you need to pick valid prop names.
