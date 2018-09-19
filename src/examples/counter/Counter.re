module Counter = {
  type action =
    | Increment
    | Decrement;
  type state = {counter: int};
  let component = ReasonReact.reducerComponent("Counter");
  let make = _ => {
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
        state.counter->string_of_int->ReasonReact.string
      </div>,
  };
};

ReactDOMRe.renderToElementWithId(<Counter />, "root");
