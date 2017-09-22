---
id: common-errors
title: Common Type Errors
---
#### I'm having the type error ________

Check your terminal to see if we've provided a dedicated error message for your use-case! We've encoded a few tips in the type errors.

#### Unbound record field reduce/Unbound record field handle

This means you've passed `self` to a helper function of your render, and it used it like so: `<div onClick=(self.reduce click)/>`. This is because the record can't be found in the scope of the file. Just annotate it: `<div onClick=(self.ReasonReact.reduce click)/>`.

#### Something about callbacks passed to `reduce` (or `handle`) having incompatible types between them

You've probably passed `self.reduce` to a helper function that uses this `reduce` reference twice. For complex reasons this doesn't type; you'd have to pass in the whole `self` to the helper.
