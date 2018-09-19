module Value = {
  type state = {
    last: option(int),
    value: int,
  };
  let component = ReasonReact.reducerComponent("Counter");
  let make = (~value, _) =>
    ReasonReact.Reducer({
      ...component,
      initialState: () => {last: None, value},
      reducer: ((), _) => NoUpdate,
      getDerivedStateFromProps: state => {
        last: state.value !== value ? Some(state.value) : state.last,
        value,
      },
      render: ({state}) =>
        <div>
          (
            "last : "
            ++ state.last
               ->Belt.Option.map(string_of_int)
               ->Belt.Option.getWithDefault("Nothing")
          )
          ->ReasonReact.string
          <br />
          ("current : " ++ state.value->string_of_int)->ReasonReact.string
        </div>,
    });
};

module Counter = {
  type action =
    | Increment
    | Decrement;
  type state = {counter: int};
  let component = ReasonReact.reducerComponent("Counter");
  let make = _ =>
    ReasonReact.Reducer({
      ...component,
      initialState: () => {counter: 0},
      reducer: (action, state) =>
        switch (action) {
        | Increment => Update({counter: state.counter + 1})
        | Decrement => Update({counter: state.counter - 1})
        },
      render: ({state, send}) =>
        <div>
          <button onClick={_ => send(Increment)}>
            "+"->ReasonReact.string
          </button>
          <button onClick={_ => send(Decrement)}>
            "-"->ReasonReact.string
          </button>
          <Value value={state.counter} />
        </div>,
    });
};

ReactDOMRe.renderToElementWithId(<Counter />, "root");
