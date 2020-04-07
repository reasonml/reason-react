open ReactLib;

/**
 * Button component:
 */;

/**
 * Public `action` type. Exposed publicly through interface so that consumers
 * may explicitly invoke these actions safely.
 */
type action =
  | Click;

/**
 * Buutton's `state` is made abstract so you cannot rely on it. You can however
 * operate on it through public `Button.publicOperation` exposed "methods".
 */
type state;

/**
 * Button does not expose what it renders to.
 */
type renderedTree;

/**
 * The type of the
 */
type t = (state, React.noAction) => renderedTree;

let render: (~txt: string=?, ~size: int, 'x) => React.renderable(t);
