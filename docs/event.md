---
title: Event
---

ReasonReact events map cleanly to ReactJS [synthetic events](https://reactjs.org/docs/events.html). More info in the [inline docs](https://github.com/reasonml/reason-react/blob/main/src/ReactEvent.rei#L1).

If you're accessing fields on your event object, like `event.target.value`, you'd use [BuckleScript's `##` object access FFI](https://bucklescript.github.io/docs/en/object.html#accessors):

```reason
ReactEvent.Form.target(event)##value;
```

Or, equivalently, using the pipe first operator:

```reason
event->ReactEvent.Form.target##value;
```
