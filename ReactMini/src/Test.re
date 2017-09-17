open! ReasonReact;

let log = logString;


/**
 * The simplest component. Composes nothing!
 */
module Box = {
  let component = ReasonReact.createComponent "Box";
  let make onClick::_=? _children => {
    ...component,
    initialState: fun () => "ImABox",
    printState: fun s => s,
    render: fun _self => <div />
  };
};


/**
 * This component demonstrates several things:
 *
 * 1. Demonstration of making internal state hidden / abstract. Components
 * should encapsulate their state representation and should be free to change
 * it.
 *
 * 2. Demonstrates an equivalent of `componentWillReceiveProps`.
 * `componentWillReceiveProps` is like an "edge trigger" on props, and the
 * first item of the tuple shows how we implement that with this API.
 */
module type ChangeCounterIntf = {
  type state;
  let make:
    /* The label for the change counter */
    label::string =>
    /* Children forwarded to nothing. */
    array reactElement =>
    /* The resulting component state */
    component state;
};

module ChangeCounter: ChangeCounterIntf = {
  type state = {
    numChanges: int,
    mostRecentLabel: string
  };
  let component = ReasonReact.createComponent "ChangeCounter";
  let make ::label _children => {
    ...component,
    initialState: fun () => {mostRecentLabel: label, numChanges: 10},
    printState: fun {numChanges, mostRecentLabel} =>
      Printf.sprintf "[%d, \"%s\"]" numChanges mostRecentLabel,
    willReceiveProps: fun {state} =>
      label != state.mostRecentLabel ?
        {mostRecentLabel: label, numChanges: state.numChanges + 1} : state,
    render: fun _self => <div> <Box /> </div>
  };
};

module StatelessButton = {
  let component = ReasonReact.createStatelessComponent "StatelessButton";
  let make initialClickCount::_="noclicks" test::_="default" _children => {
    ...component,
    render: fun _self => <div> <Box /> </div>
  };
};

module ButtonWrapper = {
  type state = {buttonWrapperState: int};
  let component = ReasonReact.createComponent "ButtonWrapper";
  let make ::wrappedText="default" _children => {
    ...component,
    initialState: fun () => {buttonWrapperState: 0},
    printState: fun {buttonWrapperState} => Printf.sprintf "%d" buttonWrapperState,
    render: fun _self =>
      <div>
        <StatelessButton initialClickCount=("wrapped:" ^ wrappedText ^ ":wrapped") />
        <StatelessButton initialClickCount=("wrapped:" ^ wrappedText ^ ":wrapped") />
      </div>
  };
};

let buttonWrapperJsx = <ButtonWrapper wrappedText="TestButtonUpdated!!!" />;

module ButtonWrapperWrapper = {
  let component = ReasonReact.createComponent "ButtonWrapperWrapper";
  let make wrappedText::_="default" _children => {
    ...component,
    initialState: fun () => "buttonWrapperWrapperState",
    printState: fun state => Printf.sprintf "\"%s\"" state,
    render: fun _self => <div> buttonWrapperJsx </div>
  };
};

log "\nInitial Tree\n-------------------";

let trees0 = render (ReasonReact.element (ChangeCounter.make label::"defaultText" [||]));

log (Print.trees trees0);

log "\nUpdating Tree With Same Label (ButtonWrapperWrapper)\n-------------------";

let trees1 = update trees0 (ReasonReact.element (ChangeCounter.make label::"defaultText" [||]));

log (Print.trees trees1);

log "\nUpdating Tree With New Label (ButtonWrapperWrapper)\n-------------------";

let trees2 = update trees1 (ReasonReact.element (ChangeCounter.make label::"updatedText" [||]));

log (Print.trees trees2);

log "\nUpdating Tree With New Root Type (ButtonWrapperWrapper)\n-------------------";

let trees3 =
  update trees2 (ReasonReact.element (ButtonWrapperWrapper.make wrappedText::"updatedText" [||]));

log (Print.trees trees3);

log "\nUpdating Tree With Same Root Type as Previous (ButtonWrapperWrapper)\n-------------------";

let trees4 =
  update trees3 (ReasonReact.element (ButtonWrapperWrapper.make wrappedText::"updatedTextm" [||]));


/**
 * You can see the sequence of instance trees obtained by update.
 */
print_string (Print.trees (trees0 @ trees1 @ trees2 @ trees3 @ trees4));