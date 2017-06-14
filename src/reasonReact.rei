/**
 * This API assumes that JSX will desugar <Foo key ref attr1=val1 attrn=valn /> into:
 *
 * ReasonReact.element (
 *   Foo.make ::key ::ref attr1::val1 attrn::valn [| |]
 * )
 */

/**
 * TODO: Features (Highest Priority First)
 * - The `.shouldUpdate` lifecycle hook needs to be called. It is not
 * currently. This should be a lifecycle hook that behaves like ReactJS today.
 *  - Later we can make a better one using the same single factory function.
 * - componentWillReceiveProps but allowing side effects (Alternatively,
 * justify why we believe this is not needed - perhaps didUpdate is
 * sufficient).
 * - componentDidMount functionality (or perhaps we won't implement it). At
 * least decide that we won't support it and justify our decision.
 * ------------Cutoff to replace the V1 bindings with V2 ----------------------
 * - A way to invoke pure functions with JSX which don't have controllers.
 * - A more fine grained shouldComponentUpdate. Returning portions of previous
 * subelements from last `create`.
 */

/**
 * TODO: Test Cases (Highest Priority First):
 * -------------------
 * 1. That a silent update will not block received props!
 * 2. That a silent update will not block another state update! (Two different
 * DOM nodes having event handlers - one triggering silent, the other
 * triggering loud). Then switch which one is invoked first.
 * 3. Add tests for "handle()". (non state updating callback)
 * ------------Cutoff to replace the V1 bindings with V2 ----------------------
 * 4. Multiple setStates on didMount.
 *   - A deep nested component and higher-in-tree component both updating states.
 *     - Does the state change of the higher one flush down to the lower one
 *       and therefore effect the lower one's props in its didMount?
 *       - Perhaps it shouldn't. Maybe we can't make that even happen.
 * 5. updating only a portion of components.
 */
/* TODOs below this point don't need to block the migration / switch to v2. They need to
 * be done before releasing widely and encouraging other devs to use v2. */

/**
 * TODO: Document:
 * --------------
 * Document the component and tooling abstractions that the core API eliminates
 * most of the time.
 *
 * - getInitialState.
 * - Polymorphic props.
 * - shouldComponentUpdate.
 * - willReceiveProps.
 * - getDefaultProps.
 * - propTypes.
 * - Instance variables.
 * - Some portion of unit tests.
 * - Reduces two forms of state setting to one.
 * - Kills constructor.
 * - Demonstrate that we can also implement this API via a simple `include
 *   ReactComponent.Create {}`
 *
 * Philosophy:
 * -----------
 * - Create a more formal description of the Reason React API.
 * - Document benefits of the ability to have plain integers/strings as state types.
 */
type reactClass;

type reactElement;

type reactRef;

external nullElement : reactElement = "null" [@@bs.val];

external stringToElement : string => reactElement = "%identity";

external arrayToElement : array reactElement => reactElement = "%identity";

external refToJsObj : reactRef => Js.t {..} = "%identity";

external createElement : reactClass => props::Js.t {..}? => array reactElement => reactElement =
  "createElement" [@@bs.splice] [@@bs.val] [@@bs.module "react"];

type update 'state =
  | NoUpdate
  | Update 'state
  | SilentUpdate 'state;

type renderNotImplemented =
  | RenderNotImplemented;

module Callback: {

  /**
   Type for callbacks

   This type can be left abstract to prevent calling the callback directly.
   For example, calling `update handler event` would force an immediate
   call of `handler` with the current state, and can be prevented by defining:
     type t 'payload;
    */
  type t 'payload = 'payload => unit;

  /** Default no-op callback */
  let default: t 'payload;

  /** Chain two callbacks by executing the first before the second one */
  let chain: t 'payload => t 'payload => t 'payload;
};

type self 'state = {
  enqueue: 'payload .('payload => 'state => self 'state => update 'state) => Callback.t 'payload,
  handle: 'payload .('payload => 'state => self 'state => unit) => Callback.t 'payload,
  update: 'payload .('payload => 'state => self 'state => update 'state) => Callback.t 'payload
};

type reactClassInternal;

type next 'state = state::'state? => self 'state => 'state;

type render 'state = state::'state => self 'state => reactElement;


/** A stateless component is a component with state of type unit */
type stateless = unit;


/** For internal use only */
type jsElementWrapped;

type componentSpec 'state 'initialState = {
  debugName: string,
  reactClassInternal,
  /* Keep here as a way to prove that the API may be implemented soundly */
  mutable handedOffState: ref (option 'state),
  willReceiveProps: 'state => self 'state => 'state,
  didMount: 'state => self 'state => update 'state,
  didUpdate: previousState::'state => currentState::'state => self 'state => unit,
  willUnmount: 'state => self 'state => unit,
  willUpdate: previousState::'state => nextState::'state => self 'state => unit,
  shouldUpdate: previousState::'state => nextState::'state => self 'state => bool,
  render: 'state => self 'state => reactElement,
  initialState: unit => 'initialState,
  jsElementWrapped
}
and component 'state = componentSpec 'state 'state;

let statefulComponent: string => componentSpec 'state stateless;


/** Create a stateless component: i.e. a component where state has type stateless. */
let statelessComponent: string => component stateless;

let element: key::string? => ref::(Js.null reactRef => unit)? => component 's => reactElement;

type jsPropsToReason 'jsProps 'state = Js.t 'jsProps => component 'state;


/**
 * We *under* constrain the kind of component spec this accepts because we actually extend the *originally*
 * defined component. It uses mutation on the original component, so that even if it is extended with
 * {...component}, all extensions will also see the underlying js class. I can sleep at night because js
 * interop is integrating with untyped, code and it is *possible* to create pure-ReasonReact apps without JS
 * interop entirely. */
let wrapReasonForJs:
  component::componentSpec 'state 'initialState => jsPropsToReason _ => reactClass;

let createDomElement: string => props::Js.t {..} => array reactElement => reactElement;


/**
 * Wrap props into a JS component
 * Use for interop when Reason components use JS components
 */
let wrapJsForReason:
  reactClass::reactClass => props::Js.t {..} => array reactElement => component stateless;
