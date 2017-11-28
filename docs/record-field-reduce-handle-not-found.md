---
id: record-field-reduce-handle-not-found
title: Record Field reduce/handle Not Found
---

Do you see a type error related to this? This might mean that you've passed `self` to a helper function of your render, and it used it like so: `<div onClick={self.reduce(click)}/>`. This is because the record can't be found in the scope of the file. Just annotate it: `<div onClick={self.ReasonReact.reduce(click)}/>`.

More info [here](https://reasonml.github.io/guide/language/record#record-needs-an-explicit-definition).
