open ReactLib;

let noReducer = (_, _) => (0, 0);

let render = (~size, children, ~state=(size, 0), self) =>
  React.Reducer(
    state,
    <>
      <Button txt="ButtonInContainerThatCountsSizeChanges" size=0 />
      children
    </>,
    noReducer,
  );

let render2 = (~size, children, ~state=(size, 0), self) =>
  React.Reducer(state, <> children </>, noReducer);

let render3 = (~size, children, ~state=(size, 0), self) =>
  React.Reducer(state, children, noReducer);
