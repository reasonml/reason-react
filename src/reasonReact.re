type reactClass;

type jsProps;

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

external createElementVerbatim : 'a = "createElement" [@@bs.val] [@@bs.module "react"];

let createDomElement s ::props children => {
  let vararg = [|Obj.magic s, Obj.magic props|] |> Js.Array.concat children;
  /* Use varargs to avoid warnings on duplicate keys in children */
  (Obj.magic createElementVerbatim)##apply Js.null vararg
};

let magicNull = Obj.magic Js.null;

type update 's =
  | NoUpdate
  | Update 's
  | SilentUpdate 's;

type reactClassInternal = reactClass;

type renderNotImplemented =
  | RenderNotImplemented;

type stateless = unit;

type noRetainedProps = unit;

module Callback = {
  type t 'payload = 'payload => unit;
  let default _event => ();
  let chain handlerOne handlerTwo payload => {
    handlerOne payload;
    handlerTwo payload
  };
};


/**
 * Elements are what JSX blocks become. They represent the *potential* for a
 * component instance and state to be created / updated. They are not yet
 * instances.
 */
type element =
  | Element (component 'state 'retainedProps) :element
and jsPropsToReason 'jsProps 'state 'retainedProps =
  Js.t 'jsProps => component 'state 'retainedProps
and render 'state 'retainedProps = state::'state => self 'state 'retainedProps => reactElement
/**
 * Type of hidden field for Reason components that use JS components
 */
and jsElementWrapped =
  option (key::Js.undefined string => ref::Js.undefined (Js.null reactRef => unit) => reactElement)
/**
 * Granularly types state, and initial state as being independent, so that we
 * may include a template that all instances extend from.
 */
and componentSpec 'state 'initialState 'retainedProps 'initialRetainedProps = {
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
and component 'state 'retainedProps = componentSpec 'state 'state 'retainedProps 'retainedProps
/**
 * A reduced form of the `componentBag`. Better suited for a minimalist React
 * API.
 */
and self 'state 'retainedProps = {
  enqueue:
    'payload .
    ('payload => self 'state 'retainedProps => update 'state) => Callback.t 'payload,

  handle: 'payload .('payload => self 'state 'retainedProps => unit) => Callback.t 'payload,
  update:
    'payload .
    ('payload => self 'state 'retainedProps => update 'state) => Callback.t 'payload,

  state: 'state,
  retainedProps: 'retainedProps
}
and oldNewSelf 'state 'retainedProps = {
  oldSelf: self 'state 'retainedProps,
  newSelf: self 'state 'retainedProps
};

type jsComponentThis 'state 'props 'retainedProps =
  Js.t {
    .
    state : totalState 'state 'retainedProps,
    props : Js.t {. reasonProps : 'props},
    setState :
      ((totalState 'state 'retainedProps => 'props => totalState 'state 'retainedProps) => unit)
      [@bs.meth],
    jsPropsToReason : option (jsPropsToReason 'props 'state 'retainedProps)
  }
/**
 * `totalState` tracks all of the internal reason API bookkeeping, as well as
 * version numbers for state updates. Version numbers allows us to work
 * around limitations of legacy React APIs which don't let us prevent an
 * update from happening in callbacks. We build that capability into the
 * wrapping Reason API, and use React's `shouldComponentUpdate` hook to
 * analyze the version numbers, creating the effect of blocking an update in
 * the handlers.
 *
 * Since we will mutate `totalState` in `shouldComponentUpdate`, and since
 * there's no guarantee that returning true from `shouldComponentUpdate`
 * guarantees that a component's update *actually* takes place (it could get
 * rolled back by Fiber etc), then we should put all properties that we
 * mutate directly on the totalState, so that when Fiber makes backup shallow
 * backup copies of `totalState`, our changes can be rolled back correctly
 * even when we mutate them.
 */
and totalState 'state 'retainedProps =
  Js.t {
    .
    reasonState : 'state,
    /*
     * Be careful - integers may roll over. Taking up three integers is very
     * wasteful. We should only consume one integer, and pack three counters
     * within. They typically only need to count to (approx 10?).
     */
    /* Version of the reactState - as a result of updates or other. */
    reasonStateVersion : int,
    /* Version of state that the subelements were computed from.
     * `reasonStateVersion` can increase and
     * `reasonStateVersionUsedToComputeSubelements` can lag behind if there has
     * not yet been a chance to rerun the named arg factory function.  */
    reasonStateVersionUsedToComputeSubelements : int
  };

let lifecycleNoUpdate _ => NoUpdate;

let lifecyclePreviousNextUnit _ => ();

let lifecyclePreviousCurrentReturnUnit _ => ();

let lifecycleReturnUnit _ => ();

let lifecycleReturnTrue _ => true;

let didMountDefault = lifecycleNoUpdate;

let didUpdateDefault = lifecyclePreviousCurrentReturnUnit;

let shouldUpdateDefault = lifecycleReturnTrue;

let willUnmountDefault = lifecycleReturnUnit;

let willUpdateDefault = lifecyclePreviousNextUnit;

let willReceivePropsDefault {state} => state;

let renderDefault _bag => stringToElement "RenderNotImplemented";

let initialStateDefault () => ();

let retainedPropsDefault = ();

let convertPropsIfTheyreFromJs props jsPropsToReason debugName => {
  let props = Obj.magic props;
  switch (Js.Undefined.to_opt props##reasonProps, jsPropsToReason) {
  | (Some props, _) => props
  /* TODO: annotate with BS to avoid curry overhead */
  | (None, Some toReasonProps) => Element (toReasonProps props)
  | (None, None) =>
    raise (
      Invalid_argument (
        "A JS component called the Reason component " ^
        debugName ^ " which didn't implement the JS->Reason React props conversion."
      )
    )
  }
};

let createClass (type reasonState) (type retainedProps) debugName :reactClass =>
  CreateClassInternalHack.createClass (
    {
      val displayName = debugName;
      /**
       * TODO: Avoid allocating this every time we need it. Should be doable.
       */
      pub self state retainedProps => {
        enqueue: Obj.magic this##enqueueMethod,
        handle: Obj.magic this##handleMethod,
        update: Obj.magic this##updateMethod,
        state,
        retainedProps
      };
      /**
       * TODO: Null out fields that aren't overridden beyond defaults in
       * `component`. React optimizes components that don't implement
       * lifecycles!
       */
      /* For "Silent" updates, it's important that updates never change the
       * component's "out of date"-ness. For silent updates, if the component
       * was previously out of date, it needs to remain out of date. If not out
       * of date, it should remain not out of date. The objective is to not
       * trigger any *more* updates than would have already occured. The trick
       * we use is to bump *both* versions simultaneously (reasonStateVersion,
       * reasonStateVersionUsedToComputeSubelements).
       */
      pub transitionNextTotalState curTotalState reasonStateUpdate =>
        switch reasonStateUpdate {
        | NoUpdate => curTotalState
        | Update nextReasonState => {
            "reasonState": nextReasonState,
            "reasonStateVersion": curTotalState##reasonStateVersion + 1,
            "reasonStateVersionUsedToComputeSubelements": curTotalState##reasonStateVersionUsedToComputeSubelements
          }
        | SilentUpdate nextReasonState => {
            "reasonState": nextReasonState,
            "reasonStateVersion": curTotalState##reasonStateVersion + 1,
            "reasonStateVersionUsedToComputeSubelements":
              curTotalState##reasonStateVersionUsedToComputeSubelements + 1
          }
        };
      pub getInitialState () :totalState 'state 'retainedProps => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        let convertedReasonProps =
          convertPropsIfTheyreFromJs thisJs##props thisJs##jsPropsToReason debugName;
        let Element component = convertedReasonProps;
        let initialReasonState = component.initialState ();
        {
          "reasonState": Obj.magic initialReasonState,
          /**
           * Initial version starts with state and subelement computation in
           * sync, waiting to render the first time.
           */
          "reasonStateVersion": 1,
          "reasonStateVersionUsedToComputeSubelements": 1
        }
      };
      pub componentDidMount () => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        let convertedReasonProps =
          convertPropsIfTheyreFromJs thisJs##props thisJs##jsPropsToReason debugName;
        let Element component = convertedReasonProps;
        if (component.didMount !== didMountDefault) {
          /**
           * TODO: Not need to use the callback from of setState here.
           * Keep things consistent with which version of state React sees in
           * its state.
           */
          thisJs##setState (
            fun curTotalState _ => {
              let curReasonState = curTotalState##reasonState;
              let self = this##self curReasonState (Obj.magic component.retainedProps);
              let self = Obj.magic self;
              let reasonStateUpdate = component.didMount self;
              let reasonStateUpdate = Obj.magic reasonStateUpdate;
              this##transitionNextTotalState curTotalState reasonStateUpdate
            }
          )
        }
      };
      pub componentDidUpdate prevProps prevState => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        let newJsProps = thisJs##props;
        let newConvertedReasonProps =
          convertPropsIfTheyreFromJs newJsProps thisJs##jsPropsToReason debugName;
        let Element newComponent = newConvertedReasonProps;
        if (newComponent.didUpdate !== lifecyclePreviousCurrentReturnUnit) {
          let oldConvertedReasonProps =
            prevProps === newJsProps ?
              newConvertedReasonProps :
              convertPropsIfTheyreFromJs prevProps thisJs##jsPropsToReason debugName;
          let Element oldComponent = oldConvertedReasonProps;
          let curState = thisJs##state;
          let prevReasonState = prevState##reasonState;
          let prevReasonState = Obj.magic prevReasonState;
          let curReasonState = curState##reasonState;
          let newSelf = this##self curReasonState (Obj.magic newComponent.retainedProps);
          let newSelf = Obj.magic newSelf;
          /* bypass this##self call for small perf boost */
          let oldSelf =
            Obj.magic {
              ...newSelf,
              state: prevReasonState,
              retainedProps: oldComponent.retainedProps
            };
          newComponent.didUpdate {oldSelf, newSelf}
        }
      };
      /* pub componentWillMount .. TODO (or not?) */
      pub componentWillUnmount () => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        let convertedReasonProps =
          convertPropsIfTheyreFromJs thisJs##props thisJs##jsPropsToReason debugName;
        let Element component = convertedReasonProps;
        if (component.willUnmount !== lifecycleReturnUnit) {
          let curState = thisJs##state;
          let curReasonState = curState##reasonState;
          let self = this##self curReasonState (Obj.magic component.retainedProps);
          let self = Obj.magic self;
          component.willUnmount self
        }
      };
      /**
       * If we are even getting this far, we've already done all the logic for
       * detecting unnecessary updates in shouldComponentUpdate. We know at
       * this point that we need to rerender, and we've even *precomputed* the
       * render result (subelements)!
       */
      pub componentWillUpdate nextProps (nextState: totalState _) => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        let newConvertedReasonProps =
          convertPropsIfTheyreFromJs nextProps thisJs##jsPropsToReason debugName;
        let Element newComponent = newConvertedReasonProps;
        if (newComponent.willUpdate !== willUpdateDefault) {
          let oldJsProps = thisJs##props;
          /* Avoid converting again the props that are just the same as curProps. */
          let oldConvertedReasonProps =
            nextProps === oldJsProps ?
              newConvertedReasonProps :
              convertPropsIfTheyreFromJs oldJsProps thisJs##jsPropsToReason debugName;
          let Element oldComponent = oldConvertedReasonProps;
          let curState = thisJs##state;
          let curReasonState = curState##reasonState;
          let curReasonState = Obj.magic curReasonState;
          let nextReasonState = nextState##reasonState;
          let newSelf = this##self nextReasonState (Obj.magic newComponent.retainedProps);
          let newSelf = Obj.magic newSelf;
          /* bypass this##self call for small perf boost */
          let oldSelf =
            Obj.magic {
              ...newSelf,
              state: curReasonState,
              retainedProps: oldComponent.retainedProps
            };
          newComponent.willUpdate {oldSelf, newSelf}
        }
      };
      /**
       * One interesting part of the new Reason React API. There isn't a need
       * for a separate `willReceiveProps` function. The primary `create` API
       * is *always* receiving props.
       */
      pub componentWillReceiveProps nextProps => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        let newConvertedReasonProps =
          convertPropsIfTheyreFromJs nextProps thisJs##jsPropsToReason debugName;
        let Element newComponent = Obj.magic newConvertedReasonProps;
        if (newComponent.willReceiveProps !== willReceivePropsDefault) {
          let oldJsProps = thisJs##props;
          /* Avoid converting again the props that are just the same as curProps. */
          let oldConvertedReasonProps =
            nextProps === oldJsProps ?
              newConvertedReasonProps :
              convertPropsIfTheyreFromJs oldJsProps thisJs##jsPropsToReason debugName;
          let Element oldComponent = oldConvertedReasonProps;
          thisJs##setState (
            fun curTotalState _ => {
              let curReasonState = Obj.magic curTotalState##reasonState;
              let curReasonStateVersion = curTotalState##reasonStateVersion;
              let oldSelf =
                Obj.magic (this##self curReasonState (Obj.magic oldComponent.retainedProps));
              let nextReasonState = Obj.magic (newComponent.willReceiveProps oldSelf);
              let nextReasonStateVersion =
                nextReasonState !== curReasonState ?
                  curReasonStateVersion + 1 : curReasonStateVersion;
              if (nextReasonStateVersion !== curReasonStateVersion) {
                let nextTotalState: totalState 'a 'retainedProps = {
                  "reasonState": nextReasonState,
                  "reasonStateVersion": nextReasonStateVersion,
                  "reasonStateVersionUsedToComputeSubelements": curTotalState##reasonStateVersionUsedToComputeSubelements
                };
                let nextTotalState = Obj.magic nextTotalState;
                nextTotalState
              } else {
                curTotalState
              }
            }
          )
        }
      };
      /**
       * shouldComponentUpdate is invoked any time props change, or new state
       * updates occur.
       *
       * The easiest way to think about this method, is:
       * - "Should component have its componentWillUpdate method called,
       * followed by its render() method?",
       *
       * TODO: This should also call the component.shouldUpdate hook, but only
       * after we've done the appropriate filtering with version numbers.
       * Version numbers filter out the state updates that should definitely
       * not have triggered re-renders in the first place. (Due to returning
       * things like NoUpdate from callbacks, or returning the previous
       * state/subdescriptors from named argument factory functions.)
       *
       * Therefore the component.shouldUpdate becomes a hook solely to perform
       * performance optimizations through.
       */
      pub shouldComponentUpdate nextJsProps nextState _ => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        let curJsProps = thisJs##props;
        let propsWarrantRerender = nextJsProps !== curJsProps;

        /**
         * Now, we inspect the next state that we are supposed to render, and ensure that
         * - We have enough information to answer "should update?"
         * - We have enough information to render() in the event that the answer is "true".
         *
         * Typically the answer is "true", except we can detect some "next
         * states" that were simply updates that we performed to work around
         * legacy versions of React.
         *
         * If we can detect that props have changed or a non-silent update has occured,
         * we ask the component's shouldUpdate if it would like to update - defaulting to true.
         */
        let oldConvertedReasonProps =
          convertPropsIfTheyreFromJs thisJs##props thisJs##jsPropsToReason debugName;
        /* Avoid converting again the props that are just the same as curProps. */
        let newConvertedReasonProps =
          nextJsProps === curJsProps ?
            oldConvertedReasonProps :
            convertPropsIfTheyreFromJs nextJsProps thisJs##jsPropsToReason debugName;
        let Element oldComponent = oldConvertedReasonProps;
        let Element newComponent = newConvertedReasonProps;
        let nextReasonStateVersion = nextState##reasonStateVersion;
        let nextReasonStateVersionUsedToComputeSubelements = nextState##reasonStateVersionUsedToComputeSubelements;
        let stateChangeWarrantsComputingSubelements =
          nextReasonStateVersionUsedToComputeSubelements !== nextReasonStateVersion;
        let warrantsUpdate = propsWarrantRerender || stateChangeWarrantsComputingSubelements;
        let ret =
          if (warrantsUpdate && newComponent.shouldUpdate !== shouldUpdateDefault) {
            let curState = thisJs##state;
            let curReasonState = curState##reasonState;
            let curReasonState = Obj.magic curReasonState;
            let nextReasonState = nextState##reasonState;
            let newSelf = this##self nextReasonState (Obj.magic newComponent.retainedProps);
            let newSelf = Obj.magic newSelf;
            /* bypass this##self call for small perf boost */
            let oldSelf =
              Obj.magic {
                ...newSelf,
                state: curReasonState,
                retainedProps: oldComponent.retainedProps
              };
            newComponent.shouldUpdate {oldSelf, newSelf}
          } else {
            warrantsUpdate
          };
        /* Mark ourselves as all caught up! */
        nextState##reasonStateVersionUsedToComputeSubelements#=nextReasonStateVersion;
        ret
      };
      pub enqueueMethod callback => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        fun event => {
          let remainingCallback = callback event;
          thisJs##setState (
            fun curTotalState _ => {
              let curReasonState = curTotalState##reasonState;
              let convertedReasonProps =
                convertPropsIfTheyreFromJs thisJs##props thisJs##jsPropsToReason debugName;
              let Element component = convertedReasonProps;
              let reasonStateUpdate =
                remainingCallback (
                  Obj.magic (this##self curReasonState (Obj.magic component.retainedProps))
                );
              if (reasonStateUpdate === NoUpdate) {
                magicNull
              } else {
                let nextTotalState =
                  this##transitionNextTotalState curTotalState reasonStateUpdate;
                if (nextTotalState##reasonStateVersion !== curTotalState##reasonStateVersion) {
                  nextTotalState
                } else {
                  magicNull
                }
              }
            }
          )
        }
      };
      pub handleMethod callback => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        fun callbackPayload => {
          let curState = thisJs##state;
          let curReasonState = curState##reasonState;
          let convertedReasonProps =
            convertPropsIfTheyreFromJs thisJs##props thisJs##jsPropsToReason debugName;
          let Element component = convertedReasonProps;
          callback
            callbackPayload
            (Obj.magic (this##self curReasonState (Obj.magic component.retainedProps)))
        }
      };
      pub updateMethod callback => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        fun event => {
          let curTotalState = thisJs##state;
          let curReasonState = curTotalState##reasonState;
          let convertedReasonProps =
            convertPropsIfTheyreFromJs thisJs##props thisJs##jsPropsToReason debugName;
          let Element component = convertedReasonProps;
          let reasonStateUpdate =
            callback
              event (Obj.magic (this##self curReasonState (Obj.magic component.retainedProps)));
          if (reasonStateUpdate === NoUpdate) {
            magicNull
          } else {
            let nextTotalState = this##transitionNextTotalState curTotalState reasonStateUpdate;
            if (nextTotalState##reasonStateVersion !== curTotalState##reasonStateVersion) {
              /* Need to Obj.magic because setState accepts a callback
               * everywhere else */
              let nextTotalState = Obj.magic nextTotalState;
              thisJs##setState nextTotalState
            }
          }
        }
      };
      /**
       * In order to ensure we always operate on freshest props / state, and to
       * support the API that "reduces" the next state along with the next
       * rendering, with full acccess to named argument props in the closure,
       * we always *pre* compute the render result.
       */
      pub render () => {
        let thisJs: jsComponentThis reasonState element retainedProps = [%bs.raw "this"];
        let convertedReasonProps =
          convertPropsIfTheyreFromJs thisJs##props thisJs##jsPropsToReason debugName;
        let Element created = Obj.magic convertedReasonProps;
        let component = created;
        let curState = thisJs##state;
        let curReasonState = Obj.magic curState##reasonState;
        let self = Obj.magic (this##self curReasonState (Obj.magic component.retainedProps));
        component.render self
      }
    }
    [@bs]
  )[@bs];

let basicComponent debugName => {
  let componentTemplate = {
    reactClassInternal: createClass debugName,
    debugName,
    /* Keep here as a way to prove that the API may be implemented soundly */
    handedOffState: {contents: None},
    didMount: didMountDefault,
    willReceiveProps: willReceivePropsDefault,
    didUpdate: didUpdateDefault,
    willUnmount: willUnmountDefault,
    willUpdate: willUpdateDefault,
    /**
     * Called when component will certainly mount at some point - and may be
     * called on the sever for server side React rendering.
     */
    shouldUpdate: shouldUpdateDefault,
    render: renderDefault,
    initialState: initialStateDefault,
    jsElementWrapped: None,
    retainedProps: retainedPropsDefault
  };
  componentTemplate
};

let statelessComponent debugName :component stateless noRetainedProps => basicComponent debugName;

let statefulComponent debugName :componentSpec 'state stateless noRetainedProps noRetainedProps =>
  basicComponent debugName;

let statefulComponentWithRetainedProps
    debugName
    :componentSpec 'state stateless 'retainedProps noRetainedProps =>
  basicComponent debugName;

let statelessComponentWithRetainedProps
    debugName
    :componentSpec stateless stateless 'retainedProps noRetainedProps =>
  basicComponent debugName;


/**
 * Convenience for creating React elements before we have a better JSX transform.  Hopefully this makes it
 * usable to build some components while waiting to migrate the JSX transform to the next API.
 *
 * Constrain the component here instead of relying on the Element constructor which would lead to confusing
 * error messages.
 */
let element
    key::(key: string)=(Obj.magic Js.undefined)
    ref::(ref: Js.null reactRef => unit)=(Obj.magic Js.undefined)
    (component: component 'state 'retainedProps) => {
  let element = Element component;
  switch component.jsElementWrapped {
  | Some jsElementWrapped =>
    jsElementWrapped key::(Js.Undefined.return key) ref::(Js.Undefined.return ref)
  | None =>
    createElement
      component.reactClassInternal props::{"key": key, "ref": ref, "reasonProps": element} [||]
  }
};

let wrapReasonForJs ::component (jsPropsToReason: jsPropsToReason 'jsProps 'state 'retainedProps) => {
  let jsPropsToReason: jsPropsToReason jsProps 'state 'retainedProps = Obj.magic jsPropsToReason /* cast 'jsProps to jsProps */;
  (Obj.magic component.reactClassInternal)##prototype##jsPropsToReason#=(Some jsPropsToReason);
  component.reactClassInternal
};

module WrapProps = {
  /* We wrap the props for reason->reason components, as a marker that "these props were passed from another
     reason component" */
  let wrapProps
      ::reactClass
      ::props
      children
      key::(key: Js.undefined string)
      ref::(ref: Js.undefined (Js.null reactRef => unit)) => {
    let props = Js.Obj.assign (Js.Obj.assign (Js.Obj.empty ()) props) {"ref": ref, "key": key};
    let varargs = [|Obj.magic reactClass, Obj.magic props|] |> Js.Array.concat children;
    /* Use varargs under the hood */
    (Obj.magic createElementVerbatim)##apply Js.null varargs
  };
  let dummyInteropComponent = statefulComponent "interop";
  let wrapJsForReason ::reactClass ::props children :component stateless noRetainedProps => {
    let jsElementWrapped = Some (wrapProps ::reactClass ::props children);
    {...dummyInteropComponent, jsElementWrapped}
  };
};

let wrapJsForReason = WrapProps.wrapJsForReason;