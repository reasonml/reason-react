type update =
  | NoUpdate
  | Update
  | Silent;

type effect =
  | NoSideEffect
  | SideEffect;

type stateTransition = (update, effect);
