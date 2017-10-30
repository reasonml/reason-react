---
id: retained-props
title: Retained Props
---
Copy a few props into a special field to emulate ReactJS' lifecycle events' `prevProps`/`nextProps` functionality.
```reason
type retainedProps = {message: string};

let component = ReasonReact.statelessComponentWithRetainedProps("RetainedPropsExample");

let make = (~message, _children) => {
  ...component,
  retainedProps: {message: message},
  didUpdate: ({oldSelf, newSelf}) =>
    if (oldSelf.retainedProps.message !== newSelf.retainedProps.message) {
      /* do whatever sneaky imperative things here */
      Js.log("props `message` changed!")
    },
  render: (_self) => <div> (ReasonReact.stringToElement(message)) </div>
};
```
