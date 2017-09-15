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
  "cloneElement" [@@bs.splice] [@@bs.module "react"];

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


/** An actionless component is a component with actions of type unit */
type actionless = unit;

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

type reduce 'payload 'action = ('payload => 'action) => Callback.t 'payload;

/* Control how a state update is performed.
   The state can be updated of left unchanged.
   Side effects can be specified and are scheduled for later execution.
   Note: when a side effect is scheduled, it's added to a queue of existing pending side effects.
   All the side effects are performed in batch after all the state updates have been performed,
   in the same order in which they were scheduled, just before shouldUpdate is called. */
type update 'state 'retainedProps 'action =
  /* Don't update the state. */
  | NoUpdate
  /* Update the state with the given one. */
  | Update 'state
  /* Update the state with the given one, but don't trigger a re-render.
     Do not prevent a re-render either, if one was scheduled to happen. */
  | SilentUpdate 'state
  /* Perform side effects without updating state, and don't trigger a re-render.
     Do not prevent a re-render either, if one was scheduled to happen.
     The side effects function is invoked when all the updates have completed. */
  | SideEffects (self 'state 'retainedProps 'action => unit)
  /* Update the state and perform side effects.
     The side effects function is invoked when all the updates have completed. */
  | UpdateWithSideEffects 'state (self 'state 'retainedProps 'action => unit)
  /* Like UpdateWithSideEffects, but don't trigger a re-render.
     Do not prevent a re-render either, if one was scheduled to happen. */
  | SilentUpdateWithSideEffects 'state (self 'state 'retainedProps 'action => unit)
and self 'state 'retainedProps 'action = {
  /**
   * Call a handler function.
   *
   * The callback is passed the payload and current state immediately.
   * Note: the callback typically performs side effects, since it returns nothing.
   */
  handle:
    'payload .
    ('payload => self 'state 'retainedProps 'action => unit) => Callback.t 'payload,

  /**
   * Execute a callback to perform state update.
   *
   * The callback is passed the payload and current state immediately.
   * Note: there can be pending state updates, so the state seen by the callback could be stale.
   * Note: the returned state is determined immediately, but the update will be performed
   * only after all the pending ones. At that point, the then-current state will simply be
   * ignored and overwritten.
   * Note: this callback can perform side effects as well as specify additional side effects
   * in the returned update. The side effects of the callback are executed immediately when
   * it is called. Those specified in the returned update are scheduled and executed when
   * all the updates are complete.
   */
  update:
    'payload .
    (('payload => self 'state 'retainedProps 'action => update 'state 'retainedProps 'action) =>
    Callback.t 'payload)
    [@ocaml.deprecated "Please use self.reduce instead. See the migration guide at https://github.com/reasonml/reason-react/blob/master/HISTORY.md#024"],

  /**
   * Schedule a callback that performs state update,
   * by adding it at the end of the queue of pending updates.
   * The function passed as first argument has two phases:
   * Phase 1 when the payload is provided
   * Phase 2 when the state is provided.
   *
   * Phase 1 is executed immediately.
   *
   * Phase 2 is a state update enqueued after the existing state updates pending.
   * The state received will be the resulting one after the pending updates have been executed.
   * Note: phase 2 must not perform side effects.
   * If side effects are required, they should be contained in a
   * side-effectful function specified in the returned update.
   */
  enqueue:
    'payload .
    (('payload => self 'state 'retainedProps 'action => update 'state 'retainedProps 'action) => Callback.t 'payload)
    [@ocaml.deprecated "Please use self.reduce instead. See the migration guide at https://github.com/reasonml/reason-react/blob/master/HISTORY.md#024"],
  /**
   * Run the reducer function with the action returned by the fuction passed as first argument.
   *
   * The reducer lifecycle has two phases:
   * Phase 1 is the fuction passed as first argument, which is called immediately with the payload.
   * Phase 2 is the reducer function, which is called next with the returned action.
   * Note: the fuction passed as first argument can perform immediate side effects.
   * Note: The reducer function must not perform side effects, but a state update is scheduled,
   * which can optionally specify delayed side effects.
   *
   * Note: enqueue is a simplified form of reducer api where no actions are defined,
   * and both phases of the lifecycle happen on the single fuction passed as first argument.
   */
  reduce: 'payload .reduce 'payload 'action /* ('payload => 'action) => Callback.t 'payload */,
  state: 'state,
  retainedProps: 'retainedProps
};

type reactClassInternal;


/** For internal use only */
type jsElementWrapped;

type oldNewSelf 'state 'retainedProps 'action = {
  oldSelf: self 'state 'retainedProps 'action,
  newSelf: self 'state 'retainedProps 'action
};

type componentSpec 'state 'initialState 'retainedProps 'initialRetainedProps 'action = {
  debugName: string,
  reactClassInternal,
  /* Keep here as a way to prove that the API may be implemented soundly */
  mutable handedOffState: ref (option 'state),
  /** Callback invoked when the component receives new props or state.
   * Note: this callback must not perform side effects.
   */
  willReceiveProps: self 'state 'retainedProps 'action => 'state,
  didMount: self 'state 'retainedProps 'action => update 'state 'retainedProps 'action,
  didUpdate: oldNewSelf 'state 'retainedProps 'action => unit,
  willUnmount: self 'state 'retainedProps 'action => unit,
  willUpdate: oldNewSelf 'state 'retainedProps 'action => unit,
  shouldUpdate: oldNewSelf 'state 'retainedProps 'action => bool,
  render: self 'state 'retainedProps 'action => reactElement,
  initialState: unit => 'initialState,
  retainedProps: 'initialRetainedProps,
  /** Reducer callback.
   *
   * The callback is invoked by the reduce function contained in self.
   * A state update is scheduled based on the action passed, and added to the queue of pending updates.
   * The state received will be the resulting one after the pending updates have been executed.
   *
   * Note: this callback must not perform side effects.
   * If side effects are required, they should be contained in a
   * side-effectful function specified in the returned update.
   */
  reducer: 'action => 'state => update 'state 'retainedProps 'action,
  jsElementWrapped
}
and component 'state 'retainedProps 'action =
  componentSpec 'state 'state 'retainedProps 'retainedProps 'action;


/** Create a stateless component: i.e. a component where state has type stateless. */
let statelessComponent:
  string => componentSpec stateless stateless noRetainedProps noRetainedProps actionless;

let statelessComponentWithRetainedProps:
  string => componentSpec stateless stateless 'retainedProps noRetainedProps actionless;

let reducerComponent:
  string => componentSpec 'state stateless noRetainedProps noRetainedProps 'action;

let reducerComponentWithRetainedProps:
  string => componentSpec 'state stateless 'retainedProps noRetainedProps 'action;

let statefulComponent:
  string => componentSpec 'state stateless noRetainedProps noRetainedProps actionless
    [@@ocaml.deprecated
      "Please use the new reducerComponent instead. See the migration guide at https://github.com/reasonml/reason-react/blob/master/HISTORY.md#024"
    ];

let statefulComponentWithRetainedProps:
  string => componentSpec 'state stateless 'retainedProps noRetainedProps actionless
    [@@ocaml.deprecated
      "Please use the new reducerComponentWithRetainedProps instead. See the migration guide at https://github.com/reasonml/reason-react/blob/master/HISTORY.md#024"
    ];

let element:
  key::string? =>
  ref::(Js.null reactRef => unit)? =>
  component 'state 'retainedProps 'action =>
  reactElement;

type jsPropsToReason 'jsProps 'state 'retainedProps 'action =
  Js.t 'jsProps => component 'state 'retainedProps 'action;


/**
 * We *under* constrain the kind of component spec this accepts because we actually extend the *originally*
 * defined component. It uses mutation on the original component, so that even if it is extended with
 * {...component}, all extensions will also see the underlying js class. I can sleep at night because js
 * interop is integrating with untyped, code and it is *possible* to create pure-ReasonReact apps without JS
 * interop entirely. */
let wrapReasonForJs:
  component::componentSpec 'state 'initialState 'retainedProps 'initialRetainedProps 'action =>
  jsPropsToReason _ =>
  reactClass;

let createDomElement: string => props::Js.t {..} => array reactElement => reactElement;


/**
 * Wrap props into a JS component
 * Use for interop when Reason components use JS components
 */
let wrapJsForReason:
  reactClass::reactClass =>
  props::Js.t {..} =>
  array reactElement =>
  component stateless noRetainedProps actionless;
