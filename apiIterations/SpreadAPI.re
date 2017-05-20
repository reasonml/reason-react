/**
 * Example of using the proposed "Spread API" version of Reason React.
 * Basic premise is that a component class is merely a "prototype" which is
 * extended according to supplied properties.
 */

type state = {clickCount: int, value: string};

type size =
  | Medium
  | Large;

let buttonLabel state => text ^ " button-clicks:" ^ string_of_int state.clickCount;

let handleClick e curState self => ReasonReact.Update {...curState, clickCount: curState.clickCount + 1};

let component = ReasonReact.createComponent "StatefulButton";

let make ::size=Medium ::text="Button" children => {
  ...component,
  initialState: fun () => {clickCount: 0, value: "abc"},
  render: fun state {ReasonReact.update: update} => {
    let className =
      switch size {
      | Medium => "exampleButton medium"
      | Large => "exampleButton large"
      };
    <div className onClick=(update handleClick)> (ReasonReact.string (buttonLabel state)) </div>
  }
};
