open ReactLib;

type state = int;

type stateTree('childTree) = state => list('childTree);

let render = (~count=0, child, ~state=0, self) =>
  React.Reducer(
    state,
    React.nonReducer,
    React.Sequence(Array.to_list(Array.make(count, child))),
  );
