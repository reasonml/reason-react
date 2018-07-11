/*
 * Renders the One() JSX child into multiple slots.
 */
open ReactLib;

type state;

/*
 * Components that forward children are parameterized!
 */
type stateTree('childTree) = state => list('childTree);

let render:
  (~count: int=?, React.element('childTree)) =>
  React.renderState(stateTree('childTree));
