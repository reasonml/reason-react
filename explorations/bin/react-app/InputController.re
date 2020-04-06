[@refmt.staticExperiment];
open ReactLib;
open StaticReactDOM;

open ReactLib.StaticReact.Types;

type state = string;

type renderedTree = (StaticReactDOM.t(Input.t), MyReducer.t);

type t = (state, StaticReact.noAction) => renderedTree;

let render = (~shouldControlInput, children, ~state="AppInstance", self) => {
  let input = <Input init="initTxt" />;
  let input =
    !shouldControlInput
      ? input
      : StaticReact.control(input, ~state="haha I am controlling your input");
  StaticReact.Reducer(
    state,
    <>
      <div className="divRenderedByAppContainsInput"> input </div>
      <MyReducer />
    </>,
    StaticReact.nonReducer,
  );
};
