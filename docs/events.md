---
id: event
title: Event
---

ReasonReact events map cleanly to ReactJS [synthetic events](https://facebook.github.io/react/docs/events.html). More info in the [inline docs](https://github.com/reasonml/reason-react/blob/380358e5894d4223e7dd9c1fb2df72f0756231bc/src/reactEventRe.rei#L1).

If you're accessing fields on your event object, like `event.target.value`, you'd use a combination of a `ReactDOMRe` helper and [BuckleScript's `##` object access FFI](https://bucklescript.github.io/docs/en/object.html#accessors):

```reason
ReactDOMRe.domElementToObj(ReactEventRe.Form.target(event))##value;
```

More info on the `ReactDOMRe` module below in the [Working with DOM](dom.md) section.
