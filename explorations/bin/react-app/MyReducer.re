[@refmt.staticExperiment];
open ReactLib;
open StaticReactDOM;

type state = int;

type action =
  | MyAction(string);

type renderedTree;

external makeTreeOpaque :
  StaticReact.elem('renderedTree) => StaticReact.elem(renderedTree) =
  "%identity";

let makeTreeOpaque = (() => makeTreeOpaque)();

type t = (int, action) => renderedTree;

let render = (children, ~state=0, self) =>
  StaticReact.Reducer(
    state,
    makeTreeOpaque(
      <div
        onClick=(e => print_string("divClicked!"))
        className=("&MyReducer&" )
      />,
    ),
    (_, MyAction(next)) => int_of_string(next),
  );
