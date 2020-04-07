/**
 * This is a comment here.
 * and another one.
 */

let foo = "alskdfj";
[@refmt.staticExperiment];
open ReactLib;
open StaticReactDOM;
type state = string;

type action =
  | Click;

type renderedTree = StaticReactDOM.t(StaticReact.empty);

type t = (state, StaticReact.noAction) => renderedTree;

let render = (~txt="default", ~size: int, children, ~state=txt, self) =>
  StaticReact.Reducer(
    state,
    <> <div className="buttonClass" /> </>,
    StaticReact.nonReducer,
  );
