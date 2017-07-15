type sideEffects;

type update 'state 'event;

type self 'state = {
  state: 'state,
  update: 'event .update 'state 'event
};

type instanceTree;

type reactElement;

type component 'state = {
  debugName: string,
  didMount: self 'state => list sideEffects,
  didUnmount: self 'state => list sideEffects,
  handedOffState: ref (option 'state),
  hitTest: self 'state => bool,
  initialState: unit => 'state,
  printState: 'state => string,
  willReceiveProps: self 'state => 'state,
  render: self 'state => reactElement
};

let div: array reactElement => reactElement;

let createComponent: string => component 'state;

type stateless = unit;

let createStatelessComponent: string => component stateless;

let element: component 'state => reactElement;

let logString: string => unit;

let render: reactElement => list instanceTree;

let update: list instanceTree => reactElement => list instanceTree;

module Print: {
  let tree: instanceTree => string;
  let trees: list instanceTree => string;
};