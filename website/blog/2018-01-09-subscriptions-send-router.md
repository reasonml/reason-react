---
title: Router and Subscriptions!
---

Happy new year! We've got a new, non-breaking release for you =). As always, **[here](https://github.com/chenglou/upgrade-reason-react-to-031)'s the migration script** and [here](https://github.com/reasonml/reason-react/blob/master/HISTORY.md#031)'s the list of changes.

V0.3.1 brings two important features, both super lightweight and performant, yet strike, we hope, a sweet spot in terms of usability:

- [**Router**](https://reasonml.github.io/reason-react/docs/en/router.html)! It's tiny and has almost no learning overhead.
- [Subscriptions helper](https://reasonml.github.io/reason-react/docs/en/subscriptions-helper.html). Helps you cut down on some boilerplate.

These two features follow our spirit of keeping the learning and performance overhead low, while providing facilities that codifies your existing knowledge of ReactJS. In particular, note how:

- The subscriptions helper prevents you from forgetting to free your event listeners and timers.
- The router just uses pattern-matching to kill a majority of otherwise needed API surface.

There are no FAQs for these two features. Check out the linked docs; you can use your existing understanding of Reason to answer your questions: is this performant? Will this work in my existing setup? How does nesting work? Etc. Special thanks to Ryan Florence and Michael Jackson for some small conversations.

Additionally, we've **deprecated** `self.reduce` in favor of `self.send` (the migration script takes care of that):

- Before: `onClick={self.reduce(_event => Click)}`
- After: `onClick={_event => self.send(Click)}`

- Before: `didMount: self => {self.reduce(() => Click, ()); NoUpdate}`
- After: `didMount: self => {self.send(Click); NoUpdate}`

This change should drastically reduce the confusion of an immediately called `self.reduce` (the form with two arguments). It also rolls on the tongue better: you "send" an action to the reducer.

Happy coding!
