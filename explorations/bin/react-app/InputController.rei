open ReactLib;

type state;

type renderedTree; /* Keep state and the state tree abstract */

type t = (state, React.noAction) => renderedTree; /* Keep state and the state tree abstract */

let render: (~shouldControlInput: bool, 'c) => React.renderable(t);
