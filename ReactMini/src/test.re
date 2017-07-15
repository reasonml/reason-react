open! React;

let log = logString;


/**
 * The simplest component. Composes nothing!
 */
module Box = {
  let component = React.createComponent "Box";
  let make onClick::_=? children => {
    ...component,
    initialState: fun () => "ImABox",
    printState: fun s => s,
    render: fun _self => div children
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
  let component = React.createComponent "ChangeCounter";
  let make ::label _children => {
    ...component,
    initialState: fun () => {mostRecentLabel: label, numChanges: 10},
    printState: fun {numChanges, mostRecentLabel} =>
      Printf.sprintf "[%d, \"%s\"]" numChanges mostRecentLabel,
    willReceiveProps: fun {state} =>
      label != state.mostRecentLabel ?
        {mostRecentLabel: label, numChanges: state.numChanges + 1} : state,
    render: fun _self => div [|React.element (Box.make [||])|]
  };
};

module StatelessButton = {
  let component = React.createStatelessComponent "StatelessButton";
  let make initialClickCount::_="noclicks" test::_="default" children => {
    ...component,
    render: fun _self => div [|React.element (Box.make children)|]
  };
};

module ButtonWrapper = {
  type state = {buttonWrapperState: int};
  let component = React.createComponent "ButtonWrapper";
  let make ::wrappedText="default" children => {
    ...component,
    initialState: fun () => {buttonWrapperState: 0},
    printState: fun {buttonWrapperState} => Printf.sprintf "%d" buttonWrapperState,
    render: fun _self =>
      div [|
        React.element (
          StatelessButton.make initialClickCount::("wrapped:" ^ wrappedText ^ ":wrapped") children
        ),
        React.element (
          StatelessButton.make initialClickCount::("wrapped:" ^ wrappedText ^ ":wrapped") children
        )
      |]
  };
};

let buttonWrapperJsx = React.element (ButtonWrapper.make wrappedText::"TestButtonUpdated!!!" [||]);

module ButtonWrapperWrapper = {
  let component = React.createComponent "ButtonWrapperWrapper";
  let make wrappedText::_="default" children => {
    ...component,
    initialState: fun () => "buttonWrapperWrapperState",
    printState: fun state => Printf.sprintf "\"%s\"" state,
    render: fun _self => div (Array.append children [|buttonWrapperJsx|])
  };
};

log "\nInitial Tree\n-------------------";

let trees0 = render (React.element (ChangeCounter.make label::"defaultText" [||]));

log (Print.trees trees0);

log "\nUpdating Tree With Same Label (ButtonWrapperWrapper)\n-------------------";

let trees1 = update trees0 (React.element (ChangeCounter.make label::"defaultText" [||]));

log (Print.trees trees1);

log "\nUpdating Tree With New Label (ButtonWrapperWrapper)\n-------------------";

let trees2 = update trees1 (React.element (ChangeCounter.make label::"updatedText" [||]));

log (Print.trees trees2);

log "\nUpdating Tree With New Root Type (ButtonWrapperWrapper)\n-------------------";

let trees3 =
  update trees2 (React.element (ButtonWrapperWrapper.make wrappedText::"updatedText" [||]));

log (Print.trees trees3);

log "\nUpdating Tree With Same Root Type as Previous (ButtonWrapperWrapper)\n-------------------";

let trees4 =
  update trees3 (React.element (ButtonWrapperWrapper.make wrappedText::"updatedTextm" [||]));


/**
 * You can see the sequence of instance trees obtained by update.
 */
print_string (Print.trees (trees0 @ trees1 @ trees2 @ trees3 @ trees4));
