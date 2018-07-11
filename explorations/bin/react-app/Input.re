open ReactLib;

type state = string;

type action =
  | TextChanged(string);

type renderedTree = Div.t(React.empty);

type t = (state, action) => renderedTree;

let render = (~init="deafult", children, ~state=init, self) =>
  React.Reducer(
    state,
    <> <Div className="divRenderedByInput" /> </>,
    (_, TextChanged(s)) => state,
  );
