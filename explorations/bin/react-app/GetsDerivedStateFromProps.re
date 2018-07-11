open ReactLib;

let render = (~txt="deafult", ~size, children, ~state=(size, 0), self) => {
  let (curSize, curChangeCount) = state;
  let nextChangeCount = curSize !== size ? curChangeCount + 1 : curChangeCount;
  React.Reducer(
    (size, nextChangeCount),
    <>
      <Button txt="ButtonInContainerThatCountsSizeChanges" size=0>
        children
      </Button>
      <Div
        className=("size changed times:" ++ string_of_int(nextChangeCount))
      />
    </>,
    (_, _) => state,
  );
};
