/* THIS MODULE IS DEPRECATED. It's kept for backward compatibility. Please see the new one at ReasonReact.re. Migration guide at https://github.com/reasonml/reason-react/blob/master/HISTORY.md#014 */




/* ============================================ some types */
type reactClass = ReasonReact.reactClass;

type reactElement = ReasonReact.reactElement;

type reactRef = ReasonReact.reactRef;

type reactJsChildren;

external createElement : reactClass => props::Js.t {..}? => array reactElement => reactElement =
  "createElement" [@@bs.splice] [@@bs.val] [@@bs.module "react"];

external nullElement : reactElement = "null" [@@bs.val];

external stringToElement : string => reactElement = "%identity";

external arrayToElement : array reactElement => reactElement = "%identity";

let listToElement list => arrayToElement (Array.of_list list);

external refToJsObj : reactRef => Js.t {..} = "%identity";

/* We wrap the props for reason->reason components, as a marker that "these props were passed from another
   reason component" */
external createCompositeElementInternalHack :
  reactClass => Js.t {.. reasonProps : 'props} => array reactElement => reactElement =
  "createElement" [@@bs.val] [@@bs.module "react"] [@@bs.splice];

let wrapPropsInternal
    comp
    props
    wrapPropsHow
    ::children
    ref::(ref: option (reactRef => unit))=?
    key::(key: option string)=?
    () => {
  let ref =
    switch ref {
    | None => Js.Undefined.empty
    | Some ref => Js.Undefined.return ref
    };
  let key =
    switch key {
    | None => Js.Undefined.empty
    | Some key => Js.Undefined.return key
    };
  let props = wrapPropsHow ::props ::ref ::key;
  /* "ok chenglou explain this crap, what are you doing?"

     React's runtime key warning (https://facebook.github.io/react/docs/lists-and-keys.html#keys) is
     important. We'll convert them to static warnings one day, but right now we want to piggyback on it.
     Unfortunately, the way React detects missing keys and warn, is by detecting that children's an array, and
     that the array items are missing `key`. It rightfully skips the warning when people do `<div>{foo}
     {bar}</div>` because that compiles to `React.createElement('div', null, foo, bar)`. See how children are
     not an array, but passed to `createElement` variadic-ally.

     From our side, if our bindings always pass an array as children, we'd always get the children key warning
     for something like `<div>foo bar baz</div>` (Reason JSX syntax) that hypothetically would naively desugar
     to `ReactRe.createElement "div" [|foo, bar, baz|]`. So, to skip the key warning from our side, we need to
     compile to variadic children too. BS supports variadic js call if we use the `bs.splice` external and if
     we pass the last argument as an array literal. Literal! Aka we can't just pass an array reference. So we
     pattern match on all the possibilities of an array up til a dozen (this compiles to efficient code too).

     */
  switch children {
  | [] => createCompositeElementInternalHack comp props [||]
  | [a] => createCompositeElementInternalHack comp props [|a|]
  | [a, b] => createCompositeElementInternalHack comp props [|a, b|]
  | [a, b, c] => createCompositeElementInternalHack comp props [|a, b, c|]
  | [a, b, c, d] => createCompositeElementInternalHack comp props [|a, b, c, d|]
  | [a, b, c, d, e] => createCompositeElementInternalHack comp props [|a, b, c, d, e|]
  | [a, b, c, d, e, f] => createCompositeElementInternalHack comp props [|a, b, c, d, e, f|]
  | [a, b, c, d, e, f, g] => createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g|]
  | [a, b, c, d, e, f, g, h] =>
    createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g, h|]
  | [a, b, c, d, e, f, g, h, i] =>
    createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g, h, i|]
  | [a, b, c, d, e, f, g, h, i, j] =>
    createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g, h, i, j|]
  | [a, b, c, d, e, f, g, h, i, j, k] =>
    createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g, h, i, j, k|]
  | [a, b, c, d, e, f, g, h, i, j, k, l] =>
    createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g, h, i, j, k, l|]
  | [a, b, c, d, e, f, g, h, i, j, k, l, m] =>
    createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g, h, i, j, k, l, m|]
  | [a, b, c, d, e, f, g, h, i, j, k, l, m, n] =>
    createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g, h, i, j, k, l, m, n|]
  | [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o] =>
    createCompositeElementInternalHack comp props [|a, b, c, d, e, f, g, h, i, j, k, l, m, n, o|]
  | [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p] =>
    createCompositeElementInternalHack
      comp props [|a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p|]
  | [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q] =>
    createCompositeElementInternalHack
      comp props [|a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q|]
  | _ =>
    /* 16 is a good number because it fills the cache line. Just kidding, submit an issue if you want more */
    let msg =
      "Reason allows up to 17 static children (but dynamic children in an array can be unlimited in size); You have " ^
      string_of_int (List.length children) ^ ", please put them in an array and assign key to the elements. Sorry for the inconvenience!";
    raise (Invalid_argument msg)
  }
};

let jsChildrenToReason (children: Js.null_undefined reactJsChildren) :list reactElement =>
  switch (Js.Null_undefined.to_opt children) {
  | None => []
  | Some children =>
    if (Js.Array.isArray children) {
      Array.to_list (Obj.magic children)
    } else {
      [Obj.magic children]
    }
  };

type jsState 'state = Js.t {. mlState : 'state};

module CommonLifecycle = {
  let componentDidMount _ => None;
  let componentWillUpdate _ nextProps::_ nextState::_ => None;
  let componentDidUpdate prevProps::_ prevState::_ _ => None;
  let componentWillReceiveProps _ nextProps::_ => None;
  let componentWillUnmount _ => ();
};

module ComponentBase = {
  type componentBag 'state 'props 'instanceVars = {
    state: 'state,
    props: 'props,
    updater:
      'dataPassedToHandler .
      (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state) =>
      'dataPassedToHandler =>
      unit,

    handler: 'dataPassedToHandler .
      (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) =>
      'dataPassedToHandler =>
      unit,
    instanceVars: 'instanceVars,
    /**
     * Work in progress / prototype API for setState. This isn't sufficient for
     * every use case and there is some overlap with updater. In a world
     * without `this`, it is even more important that `setState` accept a
     * callback. With `ReactJS`, absence of the callback form often relies on
     * trapping `this` in scope, and relies on the fact that
     * `this.state`/`this.props` will be mutated to have the new
     * `state`/`props` on `this`. Still, this `setState` API doesn't do
     * everything we wish so it will likely change.
     */
    setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
  };
  type jsComponentThis 'state 'props 'instanceVars =
    Js.t {
      .
      state : jsState 'state,
      props : Obj.t,
      setState : ((jsState 'state => 'props => jsState 'state) => unit) [@bs.meth]
    };
  include CommonLifecycle;
};

module type CompleteComponentSpec = {
  let name: string;
  type props;
  type state;
  type instanceVars;
  type jsProps;
  let getInstanceVars: unit => instanceVars;
  let getInitialState: props => state;

  /**
   * TODO: Preallocate a "returnNone", and then at runtime check for reference
   * equality to this function and avoid even invoking it.
   */
  let componentDidMount: ComponentBase.componentBag state props instanceVars => option state;
  let componentWillReceiveProps:
    ComponentBase.componentBag state props instanceVars => nextProps::props => option state;
  let componentWillUpdate:
    ComponentBase.componentBag state props instanceVars =>
    nextProps::props =>
    nextState::state =>
    option state;
  let componentDidUpdate:
    prevProps::props =>
    prevState::state =>
    ComponentBase.componentBag state props instanceVars =>
    option state;
  let componentWillUnmount: ComponentBase.componentBag state props instanceVars => unit;
  let jsPropsToReasonProps: option (jsProps => props);
  let render: ComponentBase.componentBag state props instanceVars => reactElement;
};

module type ReactComponent = {
  type props_;
  let comp: reactClass;
  let wrapProps:
    props_ =>
    children::list reactElement =>
    ref::(reactRef => unit)? =>
    key::string? =>
    unit =>
    reactElement;
};

/* writing this in full-stack bare-metal JS. OCaml for-loop doesn't have early return, and throwing exceptions &
   catching isn't great perf */
let findFirstCallback
    (type a)
    (type b)
    (callbacks: array (Js.null (a, b)))
    (callback: a)
    :Js.null b =>
  [%bs.raw
    {|
  function(callbacks, callback) {
    for (var i = 0; i < callbacks.length; i++) {
      // we fill the slots from left to right. If there's a null then we can early stop.
      if (callbacks[i] == null) {
        return null;
      };
      if (callbacks[i][0] === callback) {
        return callbacks[i][1];
      }
    }
    return null;
  }
|}
  ]
  callbacks
  callback
  [@bs];

module CreateComponent
       (CompleteComponentSpec: CompleteComponentSpec)
       :(ReactComponent with type props_ = CompleteComponentSpec.props) => {
  type props_ = CompleteComponentSpec.props;
  /* This part is the secret sauce that bridges to Reactjs. It's a bit verbose (but consistent) right now; We'll
     find a way to make it shorter in the future. */
  let convertPropsIfTheyreFromJs props => {
    let props = Obj.magic props;
    switch (Js.Undefined.to_opt props##reasonProps, CompleteComponentSpec.jsPropsToReasonProps) {
    | (Some props, _) => props
    /* TODO: annotate with BS to avoid curry overhead */
    | (None, Some toReasonProps) => toReasonProps props
    | (None, None) =>
      raise (
        Invalid_argument (
          "A JS component called the Reason component " ^
          CompleteComponentSpec.name ^
          " which didn't implement the JS->Reason React props conversion. Did you forget to add `JsProps` to " ^
          CompleteComponentSpec.name ^ "'s `include ReactRe.Component.*`?"
        )
      )
    }
  };
  type jsComponentThis_ =
    ComponentBase.jsComponentThis
      CompleteComponentSpec.state CompleteComponentSpec.props CompleteComponentSpec.instanceVars;
  external createClassInternalHack : Js.t 'classSpec => reactClass =
    "createClass" [@@bs.val] [@@bs.module "react"];
  let maxMemoizedCount = 30;
  let comp =
    createClassInternalHack (
      {
        val displayName = CompleteComponentSpec.name;
        /* we dangerously initialize these as nulls but don't tell the system so; They're guaranteed not to be
           null when being passed around, as long as we initialize them in getInitialState. We also can't
           initialize them here because the values are only shallowly copied, so they'd be shared across
           instances. */
        val mutable instanceVars = [%bs.raw "null"];
        val mutable memoizedUpdaterCallbacks = [%bs.raw "null"];
        val mutable memoizedUpdaterCount = 0;
        val mutable memoizedRefCallbacks = [%bs.raw "null"];
        val mutable memoizedRefCount = 0;
        pub getInitialState () :jsState CompleteComponentSpec.state => {
          this##instanceVars#=(CompleteComponentSpec.getInstanceVars ());
          this##memoizedUpdaterCallbacks#=(Array.make maxMemoizedCount Js.null);
          this##memoizedRefCallbacks#=(Array.make maxMemoizedCount Js.null);
          let that: jsComponentThis_ = [%bs.raw "this"];
          let props = convertPropsIfTheyreFromJs that##props;
          let state = CompleteComponentSpec.getInitialState props;
          {"mlState": state}
        };
        pub componentDidMount () => {
          let that: jsComponentThis_ = [%bs.raw "this"];
          let currState = that##state##mlState;
          let newState =
            CompleteComponentSpec.componentDidMount {
              props: convertPropsIfTheyreFromJs that##props,
              state: currState,
              instanceVars: this##instanceVars,
              updater: Obj.magic this##updaterMethod,
              handler: Obj.magic this##handlerMethod,
              setState: Obj.magic this##setStateMethod
            };
          switch newState {
          | None => ()
          | Some state => that##setState (fun _ _ => {"mlState": state})
          }
        };
        pub componentWillUpdate nextProps nextState => {
          let that: jsComponentThis_ = [%bs.raw "this"];
          let currState = that##state##mlState;
          let newState =
            CompleteComponentSpec.componentWillUpdate
              {
                props: convertPropsIfTheyreFromJs that##props,
                state: currState,
                instanceVars: this##instanceVars,
                updater: Obj.magic this##updaterMethod,
                handler: Obj.magic this##handlerMethod,
                setState: Obj.magic this##setStateMethod
              }
              nextProps::(convertPropsIfTheyreFromJs nextProps)
              nextState::nextState##mlState;
          switch newState {
          | None => ()
          | Some state => that##setState (fun _ _ => {"mlState": state})
          }
        };
        pub componentDidUpdate prevProps prevState => {
          let that: jsComponentThis_ = [%bs.raw "this"];
          let currState = that##state##mlState;
          let newState =
            CompleteComponentSpec.componentDidUpdate
              prevProps::(convertPropsIfTheyreFromJs prevProps)
              prevState::prevState##mlState
              {
                props: convertPropsIfTheyreFromJs that##props,
                state: currState,
                instanceVars: this##instanceVars,
                updater: Obj.magic this##updaterMethod,
                handler: Obj.magic this##handlerMethod,
                setState: Obj.magic this##setStateMethod
              };
          switch newState {
          | None => ()
          | Some state => that##setState (fun _ _ => {"mlState": state})
          }
        };
        pub componentWillReceiveProps nextProps => {
          let that: jsComponentThis_ = [%bs.raw "this"];
          let currState = that##state##mlState;
          let newState =
            CompleteComponentSpec.componentWillReceiveProps
              {
                props: convertPropsIfTheyreFromJs that##props,
                state: currState,
                instanceVars: this##instanceVars,
                updater: Obj.magic this##updaterMethod,
                handler: Obj.magic this##handlerMethod,
                setState: Obj.magic this##setStateMethod
              }
              nextProps::(convertPropsIfTheyreFromJs nextProps);
          switch newState {
          | None => ()
          | Some state => that##setState (fun _ _ => {"mlState": state})
          }
        };
        pub componentWillUnmount () => {
          let that: jsComponentThis_ = [%bs.raw "this"];
          let currState = that##state##mlState;
          CompleteComponentSpec.componentWillUnmount {
            props: convertPropsIfTheyreFromJs that##props,
            state: currState,
            instanceVars: this##instanceVars,
            updater: Obj.magic this##updaterMethod,
            handler: Obj.magic this##handlerMethod,
            setState: Obj.magic this##setStateMethod
          }
        };
        pub handlerMethod callback =>
          switch (
            this##memoizedRefCount,
            Js.Null.to_opt (findFirstCallback this##memoizedRefCallbacks callback)
          ) {
          | (_, Some memoized) => memoized
          | (count, None) =>
            let that: jsComponentThis_ = [%bs.raw "this"];
            let maybeMemoizedCallback callbackPayload => {
              let currState = that##state##mlState;
              callback
                {
                  ComponentBase.props: convertPropsIfTheyreFromJs that##props,
                  state: currState,
                  instanceVars: this##instanceVars,
                  updater: Obj.magic this##updaterMethod,
                  handler: Obj.magic this##handlerMethod,
                  setState: Obj.magic this##setStateMethod
                }
                callbackPayload
            };
            if (count < maxMemoizedCount) {
              let memoizedRefCallbacks = this##memoizedRefCallbacks;
              memoizedRefCallbacks.(count) = Js.Null.return (callback, maybeMemoizedCallback);
              this##memoizedRefCount#=(this##memoizedRefCount + 1)
            };
            maybeMemoizedCallback
          };
        pub setStateMethod cb => {
          let that: jsComponentThis_ = [%bs.raw "this"];

          /**
           * Makes sense to adapt the API to the Reason API where you are often
           * passed the entire bag for every lifecycle/callback.
           */
          that##setState (
            fun prevState props => {
              let bag = {
                ComponentBase.props: convertPropsIfTheyreFromJs props,
                state: prevState##mlState,
                instanceVars: this##instanceVars,
                updater: Obj.magic this##updaterMethod,
                handler: Obj.magic this##handlerMethod,
                setState: Obj.magic this##setStateMethod
              };
              {"mlState": cb bag}
            }
          )
        };
        pub updaterMethod callback =>
          switch (
            this##memoizedUpdaterCount,
            Js.Null.to_opt (findFirstCallback this##memoizedUpdaterCallbacks callback)
          ) {
          | (_, Some memoized) => memoized
          | (count, None) =>
            let that: jsComponentThis_ = [%bs.raw "this"];
            let maybeMemoizedCallback callbackPayload => {
              let currState = that##state##mlState;
              let newState =
                callback
                  {
                    ComponentBase.props: convertPropsIfTheyreFromJs that##props,
                    state: currState,
                    instanceVars: this##instanceVars,
                    updater: Obj.magic this##updaterMethod,
                    handler: Obj.magic this##handlerMethod,
                    setState: Obj.magic this##setStateMethod
                  }
                  callbackPayload;
              switch newState {
              | None => ()
              | Some state => that##setState (fun _ _ => {"mlState": state})
              }
            };
            if (count < maxMemoizedCount) {
              let memoizedUpdaterCallbacks = this##memoizedUpdaterCallbacks;
              memoizedUpdaterCallbacks.(count) = Js.Null.return (callback, maybeMemoizedCallback);
              this##memoizedUpdaterCount#=(this##memoizedUpdaterCount + 1)
            };
            maybeMemoizedCallback
          };
        pub render () => {
          let that: jsComponentThis_ = [%bs.raw "this"];
          CompleteComponentSpec.render {
            props: convertPropsIfTheyreFromJs that##props,
            state: that##state##mlState,
            instanceVars: this##instanceVars,
            updater: Obj.magic this##updaterMethod,
            handler: Obj.magic this##handlerMethod,
            setState: Obj.magic this##setStateMethod
          }
        }
      }
      [@bs]
    );
  let wrapPropsAndPutIndicatorThatItComesFromReason ::props ::ref ::key => {
    "reasonProps": props,
    "ref": ref,
    "key": key
  };
  /* fully apply this to avoid currying overhead */
  let wrapProps (props: props_) ::children ::ref=? ::key=? () =>
    wrapPropsInternal
      comp props wrapPropsAndPutIndicatorThatItComesFromReason ::children ::?key ::?ref ();
};

let wrapPropsAndPutRefAndKey ::props ::ref ::key =>
  Js.Obj.assign (Js.Obj.assign (Js.Obj.empty ()) props) {"ref": ref, "key": key};

/* fully apply this to avoid currying overhead */
let wrapPropsShamelessly comp props ::children ::ref=? ::key=? () =>
  wrapPropsInternal comp props wrapPropsAndPutRefAndKey ::children ::?key ::?ref ();

module Component = {
  include ComponentBase;
  type jsProps = unit;
  type instanceVars = unit;
  type state = unit;
  let getInstanceVars () => ();
  let jsPropsToReasonProps = None;
  let getInitialState _ => ();
  module Stateful = {
    include ComponentBase;
    type jsProps = unit;
    type instanceVars = unit;
    let getInstanceVars () => ();
    let jsPropsToReasonProps = None;
    module JsProps = {
      include ComponentBase;
      type instanceVars = unit;
      let getInstanceVars () => ();
      let jsPropsToReasonProps = None;
    };
    module InstanceVars = {
      include ComponentBase;
      type jsProps = unit;
      let jsPropsToReasonProps = None;
      module JsProps = {
        include ComponentBase;
      };
    };
  };
  module JsProps = {
    include ComponentBase;
    type instanceVars = unit;
    type state = unit;
    let getInstanceVars () => ();
    let getInitialState _ => ();
  };
  module InstanceVars = {
    include ComponentBase;
    type jsProps = unit;
    type state = unit;
    let getInitialState _ => ();
    let jsPropsToReasonProps = None;
    module JsProps = {
      include ComponentBase;
      type state = unit;
      let getInitialState _ => ();
    };
  };
};
