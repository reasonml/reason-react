open React;

type state = {
  count: int,
  show: bool,
};

type action =
  | Click(int)
  | Toggle;

let initialState = {count: 0, show: true};

[@react.component]
let make = (~greeting) => {
  let (state, dispatch) =
    useReducer(
      (state, action) =>
        switch (action) {
        | Click(points) => {...state, count: state.count + points}
        | Toggle => {...state, show: !state.show}
        },
      initialState,
    );

  let message =
    "You've clicked this " ++ string_of_int(state.count) ++ " times(s)";

  <div>
    <button onClick={_ => dispatch(Click(10))}> {string(message)} </button>
    <button onClick={_ => dispatch(Toggle)}>
      {string("Toggle greeting")}
    </button>
    {state.show ? string(greeting) : null}
  </div>;
};
