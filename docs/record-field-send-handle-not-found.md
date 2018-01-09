---
title: Record Field send/handle Not Found
---

Do you see a type error related to this? This might mean that you've passed `self` to a helper function of your render, and it used it like so: `<div onClick={_e => self.send(Click)} />`. This is because the record can't be found in the scope of the file. Just annotate it: `<div onClick={_e => self.ReasonReact.send(Click)} />`.

More info [here](https://reasonml.github.io/docs/en/record.html#record-needs-an-explicit-definition).
