open ReactLib;

open React;

type state = string;

type action =
  | Click;

type renderedTree = Div.t(React.empty);

type t = (state, React.noAction) => renderedTree;

let render = (~txt="default", ~size: int, children, ~state=txt, self) =>
  React.Reducer(
    state,
    <> <Div className="buttonClass" /> </>,
    React.nonReducer,
  );
