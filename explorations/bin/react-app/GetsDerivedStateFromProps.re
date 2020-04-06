[@refmt.staticExperiment];
open ReactLib;
open StaticReactDOM;

let render = (~txt="deafult", ~size, children, ~state=(size, 0), self) => {
  let (curSize, curChangeCount) = state;
  let nextChangeCount = curSize !== size ? curChangeCount + 1 : curChangeCount;
  StaticReact.Reducer(
    (size, nextChangeCount),
    <>
      <Button txt="ButtonInContainerThatCountsSizeChanges" size=0>
        children
      </Button>
      <div
        className={"size changed times:" ++ string_of_int(nextChangeCount)}
      />
    </>,
    (_, _) => state,
  );
};
