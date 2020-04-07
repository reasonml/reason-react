[@react.experiment.static];
open StaticReact;
open StaticReact.React.Types;
open ReactDOM;

type state = string;

type renderedTree = (ReactDOM.dom(Input.t), MyReducer.t);

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
