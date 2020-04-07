[@react.experiment.static];
open StaticReact;
open ReactDOM;

type state = string;

type action =
  | TextChanged(string);

type renderedTree = ReactDOM.dom(React.empty);

type t = (state, action) => renderedTree;

let render = (~init="deafult", children, ~state=init, self) =>
  React.Reducer(
    state,
    <> <div className="divRenderedByInput" /> </>,
    (_, TextChanged(s)) => state,
  );
