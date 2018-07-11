open ReactLib;

/*
 * State is polymorphic, and determined based on the type of prop passed.
 * Previously in Reason React, this required creating a createMake() function,
 * that would create new classes of the component for each possible
 * instantiation of state. With dynamic trees, you need separate
 * `component`/`make`s for separate `state` types because you need to ensure
 * that the same `component`/`make` is not used to construct conflicting
 * states.
 *
 * With static trees, this isn't an issue because no two types could ever end
 * up in the same slot at render time, and therefore we don't need any
 * `createMake` helpers to use polymorphic state.
 */
type state('x) = ('x, 'x);

type sub = Div.t(React.empty);

type t('x) = state('x) => sub;

let render =
    (~anyProp, ~size: string, children, ~state=(anyProp, anyProp), self) =>
  React.Reducer(state, <Div className=size />, (_, action) => state);
