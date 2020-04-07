open ReactLib;

type state;

type renderedTree; /* Keep state and the state tree abstract */

type t = (state, StaticReact.noAction) => renderedTree; /* Keep state and the state tree abstract */

let render: (~shouldControlInput: bool, 'c) => StaticReact.renderable(t);
