---
id: counter
title: Counter
---
Demonstrates calling an async "setState" in idiomatic ReasonReact
```reason
type action =
  | Tick;
type state = {
  count: int,
  timerId: ref (option Js.Global.intervalId)
};
let component = ReasonReact.reducerComponent "Counter";
let make _children => {
  ...component,
  initialState: fun () => {count: 0, timerId: ref None},
  reducer: fun action state =>
    switch action {
    | Tick => ReasonReact.Update {...state, count: state.count + 1}
    },
  didMount: fun self => {
    self.state.timerId := Some (Js.Global.setInterval (self.reduce (fun _ => Tick)) 1000);
    ReasonReact.NoUpdate
  },
  render: fun {state} => <div> (ReasonReact.stringToElement (string_of_int state.count)) </div>
};
```
