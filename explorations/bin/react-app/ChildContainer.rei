open ReactLib;

type state;

/*
 * ChildContainer happens to admit that it wraps the supplied children
 * parameter in one layer of Div.
 */
type t('c) = (state, StaticReact.noAction) => StaticReactDOM.t('c);

let render:
  (~txt: string=?, StaticReact.elem('childrenTree)) =>
  StaticReact.renderable(t('childrenTree));
