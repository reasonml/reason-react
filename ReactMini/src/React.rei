module GlobalState: {
  let debug: ref(bool);
  let reset: unit => unit;

  /***
   * Use physical equality to recognize that an element was added to the list of children.
   * Note: this currently does not check for pending updates on components in the list.
   */
  let useTailHack: ref(bool);
};

module Key: {type t; let create: unit => t;};

type sideEffects;

type update('state, 'action) =
  | NoUpdate
  | Update('state);

module Callback: {

  /***
   Type for callbacks

   This type can be left abstract to prevent calling the callback directly.
   For example, calling `update handler event` would force an immediate
   call of `handler` with the current state, and can be prevented by defining:

     type t 'payload;

    However, we do want to support immediate calling of a handler, as an escape hatch for the existing async
    setState reactJS pattern
    */
  type t('payload) = 'payload => unit;

  /*** Default no-op callback */
  let default: t('payload);

  /*** Chain two callbacks by executing the first before the second one */
  let chain: (t('payload), t('payload)) => t('payload);
};

type reduce('payload, 'action) = ('payload => 'action) => Callback.t('payload);

type self('state, 'action) = {
  state: 'state,
  reduce: 'payload .reduce('payload, 'action),
  act: 'action => unit
};


/*** Type of a react element before rendering  */
type reactElement;

type instance('state, 'action);

type oldNewSelf('state, 'action) = {
  oldSelf: self('state, 'action),
  newSelf: self('state, 'action)
};

type componentSpec('state, 'initialState, 'action) = {
  debugName: string,
  willReceiveProps: self('state, 'action) => 'state,
  didMount: self('state, 'action) => unit,
  didUpdate: oldNewSelf('state, 'action) => unit,
  willUnmount: self('state, 'action) => unit /* TODO: currently unused */,
  willUpdate: oldNewSelf('state, 'action) => unit,
  shouldUpdate: oldNewSelf('state, 'action) => bool,
  render: self('state, 'action) => reactElement,
  initialState: unit => 'initialState,
  reducer: ('action, 'state) => update('state, 'action),
  printState: 'state => string /* for internal debugging */,
  handedOffInstance: ref(option(instance('state, 'action))) /* Used to avoid Obj.magic in update */,
  key: Key.t
};

type component('state, 'action) = componentSpec('state, 'state, 'action);

type stateless = unit;

type actionless = unit;

let statelessComponent: (~useDynamicKey: bool=?, string) => component(stateless, actionless);

let statefulComponent:
  (~useDynamicKey: bool=?, string) => componentSpec('state, stateless, actionless);

let reducerComponent:
  (~useDynamicKey: bool=?, string) => componentSpec('state, stateless, 'action);

let element: (~key: Key.t=?, component('state, 'action)) => reactElement;

let arrayToElement: array(reactElement) => reactElement;

let listToElement: list(reactElement) => reactElement;

let stringToElement: string => reactElement;

let logString: string => unit;


/***
 * Log of operations performed to update an instance tree.
 */
module UpdateLog: {type t; let create: unit => t;};

module RenderedElement: {

  /*** Type of a react element after rendering  */
  type t;
  let listToRenderedElement: list(t) => t;

  /*** Render one element by creating new instances. */
  let render: reactElement => t;

  /*** Update a rendered element when a new react element is received. */
  let update: (t, reactElement) => (t, UpdateLog.t);

  /*** Flush pending state updates (and possibly add new ones). */
  let flushPendingUpdates: t => (t, UpdateLog.t);
};


/***
 * Imperative trees obtained from rendered elements.
 * Can be updated in-place by applying an update log.
 * Can return a new tree if toplevel rendering is required.
 */
module OutputTree: {
  type t;
  let fromRenderedElement: RenderedElement.t => t;
  let applyUpdateLog: (UpdateLog.t, t) => t;
  let print: t => string;
};

module ReactDOMRe: {
  type reactDOMProps;
  let createElement: (string, ~props: reactDOMProps=?, array(reactElement)) => reactElement;
};


/***
 * RemoteAction provides a way to send actions to a remote component.
 * The sender creates a fresh RemoteAction and passes it down.
 * The recepient component calls subscribe in the didMount method.
 * The caller can then send actions to the recipient components via act.
 */
module RemoteAction: {
  type t('action);

  /*** Create a new remote action, to which one component will subscribe. */
  let create: unit => t('action);

  /*** Subscribe to the remote action, via the component's `act` function. */
  let subscribe: (~act: 'action => unit, t('action)) => unit;

  /*** Perform an action on the subscribed component. */
  let act: (t('action), ~action: 'action) => unit;
};