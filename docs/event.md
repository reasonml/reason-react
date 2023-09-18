---
title: Event
---

ReasonReact events map cleanly to ReactJS [synthetic events](https://reactjs.org/docs/events.html). ReasonReact exposes a module called [`ReactEvent`](https://github.com/reasonml/reason-react/blob/main/src/ReactEvent.rei#L1) to help you work with events.

ReactEvent module contains all event types as submodules, e.g. `ReactEvent.Form`, `ReactEvent.Mouse`, etc.

You can access their properties using the `ReactEvent.{{EventName}}.{{property}}` method. For example, to access the `target` property of a `ReactEvent.Form.t` event, you would use `ReactEvent.Form.target`.

Since `target` is a JavaScript Object, those are typed as [`Js.t`](https://melange.re/v2.0.0/communicate-with-javascript/#using-jst-objects). If you're accessing fields on an object, like `event.target.value`, you'd use [Melange's `##` object access FFI](https://melange.re/v2.0.0/communicate-with-javascript/#using-jst-objects):

```reason
ReactEvent.Form.target(event)##value;
```

Or, equivalently, using the pipe first operator:

```reason
event->ReactEvent.Form.target##value;
```

More info in the [inline docs](https://github.com/reasonml/reason-react/blob/main/src/ReactEvent.rei#L1).
