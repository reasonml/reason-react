open ReactLib;

type state = int;

type action =
  | MyAction(string);

type renderedTree;

external makeTreeOpaque :
  React.elem('renderedTree) => React.elem(renderedTree) =
  "%identity";

let makeTreeOpaque = (() => makeTreeOpaque)();

type t = (int, action) => renderedTree;

let render = (children, ~state=0, self) =>
  React.Reducer(
    state,
    makeTreeOpaque(
      <Div
        onClick=(e => print_string("divClicked!"))
        className=("MyReducer:" ++ string_of_int(state))
      />,
    ),
    (_, MyAction(next)) => int_of_string(next),
  );
