---
id: invalid-prop-name
title: Invalid Prop Name
---

Prop names like `type` (as in `<input type="text" />`) aren't syntactically valid; `type` is a reserved keyword in Reason/OCaml. Use `<input _type="text" />` instead. This follows BuckleScript's [name mangling rules](https://bucklescript.github.io/docs/en/object.html#invalid-field-names).

For `data-*` and `aria-*`, this is a bit trickier; words with `-` in them aren't valid in Reason/OCaml. When you do want to write them, e.g. `<div aria-label="click me" />`, use [`cloneElement`](clone-element.md) as a workaround.

For non-DOM components, you need to pick valid prop names.
