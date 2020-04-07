[@refmt.staticExperiment];
open ReactLib;
open ReactDOM;

open ReactLib.React.Types;

type state = string;

type renderedTree = (ReactDOM.t(Input.t), MyReducer.t);

type t = (state, React.noAction) => renderedTree;

let render = (~shouldControlInput, children, ~state="AppInstance", self) => {
  let input = <Input init="initTxt" />;
  let input =
    !shouldControlInput
      ? input
      : React.control(input, ~state="haha I am controlling your input");
  React.Reducer(
    state,
    <>
      <div className="divRenderedByAppContainsInput"> input </div>
      <MyReducer />
    </>,
    React.nonReducer,
  );
};
