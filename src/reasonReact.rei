/**
 * This API assumes that JSX will desugar <Foo key ref attr1=val1 attrn=valn /> into:
 *
 * ReasonReact.element (
 *   Foo.make ::key ::ref attr1::val1 attrn::valn [| |]
 * )
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
type reactClass;

type reactElement;

type reactRef;

external nullElement : reactElement = "null" [@@bs.val];

external stringToElement : string => reactElement = "%identity";

external arrayToElement : array reactElement => reactElement = "%identity";

external refToJsObj : reactRef => Js.t {..} = "%identity";

external createElement : reactClass => props::Js.t {..}? => array reactElement => reactElement =
  "createElement" [@@bs.splice] [@@bs.val] [@@bs.module "react"];

external cloneElement : reactElement => props::Js.t {..}? => array reactElement => reactElement =
  "cloneElement" [@@bs.splice] [@@bs.module "React"];

type update 'state =
  | NoUpdate
  | Update 'state
  | SilentUpdate 'state;

type renderNotImplemented =
  | RenderNotImplemented;


/** 
 * A stateless component is a component with state of type unit. This cannot be
 * abstract for now, because a stateless component's willReceiveProps needs to
 * return the state, aka unit. We can provide a helper
 * ReasonReact.statelessReturn that's of type `stateless`, but that's verbose
 */
type stateless = unit;

type noRetainedProps;

module Callback: {

  /**
   Type for callbacks

   This type can be left abstract to prevent calling the callback directly.
   For example, calling `update handler event` would force an immediate
   call of `handler` with the current state, and can be prevented by defining:

     type t 'payload;

    However, we do want to support immediate calling of a handler, as an escape hatch for the existing async
    setState reactJS pattern
    */
  type t 'payload = 'payload => unit;

  /** Default no-op callback */
  let default: t 'payload;

  /** Chain two callbacks by executing the first before the second one */
  let chain: t 'payload => t 'payload => t 'payload;
};

type self 'state 'retainedProps = {
  enqueue:
    'payload .
    ('payload => self 'state 'retainedProps => update 'state) => Callback.t 'payload,

  handle: 'payload .('payload => self 'state 'retainedProps => unit) => Callback.t 'payload,
  update:
    'payload .
    ('payload => self 'state 'retainedProps => update 'state) => Callback.t 'payload,

  state: 'state,
  retainedProps: 'retainedProps
};

type reactClassInternal;

type render 'state 'retainedProps = state::'state => self 'state 'retainedProps => reactElement;


/** For internal use only */
type jsElementWrapped;

type oldNewSelf 'state 'retainedProps = {
  oldSelf: self 'state 'retainedProps,
  newSelf: self 'state 'retainedProps
};

type componentSpec 'state 'initialState 'retainedProps 'initialRetainedProps = {
  debugName: string,
  reactClassInternal,
  /* Keep here as a way to prove that the API may be implemented soundly */
  mutable handedOffState: ref (option 'state),
  willReceiveProps: self 'state 'retainedProps => 'state,
  didMount: self 'state 'retainedProps => update 'state,
  didUpdate: oldNewSelf 'state 'retainedProps => unit,
  willUnmount: self 'state 'retainedProps => unit,
  willUpdate: oldNewSelf 'state 'retainedProps => unit,
  shouldUpdate: oldNewSelf 'state 'retainedProps => bool,
  render: self 'state 'retainedProps => reactElement,
  initialState: unit => 'initialState,
  jsElementWrapped,
  retainedProps: 'initialRetainedProps
}
and component 'state 'retainedProps = componentSpec 'state 'state 'retainedProps 'retainedProps;


/** Create a stateless component: i.e. a component where state has type stateless. */
let statelessComponent:
  string => componentSpec stateless stateless noRetainedProps noRetainedProps;

let statefulComponent: string => componentSpec 'state stateless noRetainedProps noRetainedProps;

let statefulComponentWithRetainedProps:
  string => componentSpec 'state stateless 'retainedProps noRetainedProps;

let statelessComponentWithRetainedProps:
  string => componentSpec stateless stateless 'retainedProps noRetainedProps;

let element:
  key::string? =>
  ref::(Js.null reactRef => unit)? =>
  component 'state 'retainedProps =>
  reactElement;

type jsPropsToReason 'jsProps 'state 'retainedProps =
  Js.t 'jsProps => component 'state 'retainedProps;


/**
 * We *under* constrain the kind of component spec this accepts because we actually extend the *originally*
 * defined component. It uses mutation on the original component, so that even if it is extended with
 * {...component}, all extensions will also see the underlying js class. I can sleep at night because js
 * interop is integrating with untyped, code and it is *possible* to create pure-ReasonReact apps without JS
 * interop entirely. */
let wrapReasonForJs:
  component::componentSpec 'state 'initialState 'retainedProps 'initialRetainedProps =>
  jsPropsToReason _ =>
  reactClass;

let createDomElement: string => props::Js.t {..} => array reactElement => reactElement;


/**
 * Wrap props into a JS component
 * Use for interop when Reason components use JS components
 */
let wrapJsForReason:
  reactClass::reactClass => props::Js.t {..} => array reactElement => component stateless noRetainedProps;
