[@refmt.staticExperiment];
open ReactLib;
open StaticReactDOM;

type state = string;

type action =
  | TextChanged(string);

type renderedTree = StaticReactDOM.t(StaticReact.empty);

type t = (state, action) => renderedTree;

let render = (~init="deafult", children, ~state=init, self) =>
  StaticReact.Reducer(
    state,
    <> <div className="divRenderedByInput" /> </>,
    (_, TextChanged(s)) => state,
  );
