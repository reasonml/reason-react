type jsProps;
type reactElement;
type reactRef;
type reactClass;
[@bs.val] external null: reactElement = "null";
external string: string => reactElement = "%identity";
external array: array(reactElement) => reactElement = "%identity";
external refToJsObj: reactRef => Js.t({..}) = "%identity";

[@bs.val] [@bs.splice] [@bs.val] [@bs.module "react"]
external createElement:
  (reactClass, ~props: Js.t({..})=?, array(reactElement)) => reactElement =
  "createElement";

[@bs.splice] [@bs.module "react"]
external cloneElement:
  (reactElement, ~props: Js.t({..})=?, array(reactElement)) => reactElement =
  "cloneElement";
let createDomElement: ('a, ~props: 'b, Js.Array.t('c)) => 'd;
type subscription = unit => unit;
type didCatchInfo = {componentStack: string};
let didCatchInfoToJs: didCatchInfo => {. "componentStack": string};
let didCatchInfoFromJs: {.. "componentStack": string} => didCatchInfo;

type update('state, 'action) =
  | NoUpdate
  | Update('state)
  | SideEffects(reducerSelf('state, 'action) => unit)
  | UpdateWithSideEffects('state, reducerSelf('state, 'action) => unit)
and reducerSelf('state, 'action) = {
  handle:
    'payload.
    ('payload, reducerSelf('state, 'action) => unit, 'payload) => unit,

  state: 'state,
  send: 'action => unit,
  onUnmount: subscription => unit,
}
and oldNewSelf('state, 'action) = {
  oldSelf: reducerSelf('state, 'action),
  newSelf: reducerSelf('state, 'action),
}
and reducerComponent('state, 'action) = {
  reactClassInternal: reactClass,
  debugName: string,
  initialState: unit => 'state,
  reducer: ('action, 'state) => update('state, 'action),
  getDerivedStateFromProps: 'state => 'state,
  didMount: reducerSelf('state, 'action) => unit,
  didUpdate: oldNewSelf('state, 'action) => unit,
  didCatch: (reducerSelf('state, 'action), exn, didCatchInfo) => unit,
  willUnmount: reducerSelf('state, 'action) => unit,
  willUpdate: oldNewSelf('state, 'action) => unit,
  shouldUpdate: oldNewSelf('state, 'action) => bool,
  render: reducerSelf('state, 'action) => reactElement,
};

type statelessSelf = {
  handle: 'payload. (('payload, statelessSelf) => unit, 'payload) => unit,
  onUnmount: subscription => unit,
}
and statelessComponent = {
  reactClassInternal: reactClass,
  debugName: string,
  didMount: statelessSelf => unit,
  didUpdate: statelessSelf => unit,
  willUnmount: statelessSelf => unit,
  willUpdate: statelessSelf => unit,
  shouldUpdate: statelessSelf => bool,
  render: statelessSelf => reactElement,
};
type jsPropsToReason('component, 'props) = 'props => 'component;

let wrapReasonForJs:
  (~component: 'spec, jsPropsToReason('spec, 'props)) => reactClass;

let statelessComponent: string => statelessComponent;
let reducerComponent: string => reducerComponent('a, 'b);
let element:
  (~key: string=?, ~ref: Js.nullable(reactRef) => unit=?, 'a) => reactElement;
module WrapProps: {
  let wrapProps:
    (
      ~reactClass: 'a,
      ~props: 'b,
      'c,
      ~key: Js.nullable(string),
      ~ref: Js.nullable(Js.nullable(reactRef) => unit)
    ) =>
    'd;
  let dummyInteropComponent: statelessComponent;
  let wrapJsForReason: (~reactClass: 'a, ~props: 'b, 'c) => statelessComponent;
};
let wrapJsForReason: (~reactClass: 'a, ~props: 'b, 'c) => statelessComponent;
[@bs.module "react"] external fragment: 'a = "Fragment";
module Router: {
  /** update the url with the string path. Example: `push("/book/1")`, `push("/books#title")` */
  let push: string => unit;
  type watcherID;
  type url = {
    /* path takes window.location.path, like "/book/title/edit" and turns it into `["book", "title", "edit"]` */
    path: list(string),
    /* the url's hash, if any. The # symbol is stripped out for you */
    hash: string,
    /* the url's query params, if any. The ? symbol is stripped out for you */
    search: string,
  };
  /** start watching for URL changes. Returns a subscription token. Upon url change, calls the callback and passes it the url record */
  let watchUrl: (url => unit) => watcherID;
  /** stop watching for URL changes */
  let unwatchUrl: watcherID => unit;
  /** this is marked as "dangerous" because you technically shouldn't be accessing the URL outside of watchUrl's callback;
      you'd read a potentially stale url, instead of the fresh one inside watchUrl.

      But this helper is sometimes needed, if you'd like to initialize a page whose display/state depends on the URL,
      instead of reading from it in watchUrl's callback, which you'd probably have put inside didMount (aka too late,
      the page's already rendered).

      So, the correct (and idiomatic) usage of this helper is to only use it in a component that's also subscribed to
      watchUrl. Please see https://github.com/reasonml-community/reason-react-example/blob/master/src/todomvc/TodoItem.re
      for an example.
      */
  let dangerouslyGetInitialUrl: unit => url;
};
