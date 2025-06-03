---
title: Event
---

reason-react events map cleanly to ReactJS [synthetic events](https://reactjs.org/docs/events.html). reason-react exposes a module called [`React.Event`](https://github.com/reasonml/reason-react/blob/main/src/React.rei#L1) to help you work with events.

`React.Event` module contains all event types as submodules, e.g. `React.Event.Form`, `React.Event.Mouse`, etc.

You can access their properties using the `React.Event.{{EventName}}.{{property}}` method. For example, to access the `target` property of a `React.Event.Form.t` event, you would use `React.Event.Form.target`.

Since `target` is a JavaScript Object, those are typed as [`Js.t`][using-jst-objects]. If you're accessing fields on an object, like `event.target.value`, you'd use [Melange's `##` object access FFI][using-jst-objects]:

```reason
React.Event.Form.target(event)##value;
```

Or, equivalently, using the pipe first operator:

```reason
event->React.Event.Form.target##value;
```

More info in the [inline docs](https://github.com/reasonml/reason-react/blob/main/src/React.rei#L1) on the interface file.

[using-jst-objects]: https://melange.re/v4.0.0/communicate-with-javascript/#using-jst-objects
