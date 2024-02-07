type element;
type componentLike('props, 'return) = 'props => 'return;
type component('props) = componentLike('props, element);

external null: element = "null";
external float: float => element = "%identity";
external int: int => element = "%identity";
external string: string => element = "%identity";
external array: array(element) => element = "%identity";

/* this function exists to prepare for making `component` abstract */
external component: componentLike('props, element) => component('props) =
  "%identity";

[@mel.module "react"]
external createElement: (component('props), 'props) => element =
  "createElement";

[@mel.module "react"]
external cloneElement: (element, 'props) => element = "cloneElement";

[@mel.variadic] [@mel.module "react"]
external createElementVariadic:
  (component('props), 'props, array(element)) => element =
  "createElement";

[@mel.module "react/jsx-runtime"]
external jsxKeyed:
  (component('props), 'props, ~key: string=?, unit) => element =
  "jsx";

[@mel.module "react/jsx-runtime"]
external jsx: (component('props), 'props) => element = "jsx";

[@mel.module "react/jsx-runtime"]
external jsxs: (component('props), 'props) => element = "jsxs";

[@mel.module "react/jsx-runtime"]
external jsxsKeyed:
  (component('props), 'props, ~key: string=?, unit) => element =
  "jsxs";

[@mel.module "react/jsx-runtime"] external jsxFragment: 'element = "Fragment";

type ref('value) = {mutable current: 'value};

module Ref: {
  [@deprecated "Please use the type React.ref instead"]
  type t('value) = ref('value);

  [@deprecated "Please directly read from ref.current instead"] [@mel.get]
  external current: ref('value) => 'value = "current";

  [@deprecated "Please directly assign to ref.current instead"] [@mel.set]
  external setCurrent: (ref('value), 'value) => unit = "current";
};

[@mel.module "react"]
external createRef: unit => ref(Js.nullable('a)) = "createRef";

module Children: {
  [@mel.module "react"] [@mel.scope "Children"]
  external map: (element, element => element) => element = "map";
  [@mel.module "react"] [@mel.scope "Children"]
  external mapWithIndex:
    (element, [@mel.uncurry] ((element, int) => element)) => element =
    "map";
  [@mel.module "react"] [@mel.scope "Children"]
  external forEach: (element, element => unit) => unit = "forEach";
  [@mel.module "react"] [@mel.scope "Children"]
  external forEachWithIndex:
    (element, [@mel.uncurry] ((element, int) => unit)) => unit =
    "forEach";
  [@mel.module "react"] [@mel.scope "Children"]
  external count: element => int = "count";
  [@mel.module "react"] [@mel.scope "Children"]
  external only: element => element = "only";
  [@mel.module "react"] [@mel.scope "Children"]
  external toArray: element => array(element) = "toArray";
};

module Context: {
  type t('props);

  [@mel.obj]
  external makeProps:
    (~value: 'props, ~children: element, unit) =>
    {
      .
      "value": 'props,
      "children": element,
    };

  [@mel.get]
  external provider:
    t('props) =>
    component({
      .
      "value": 'props,
      "children": element,
    }) =
    "Provider";
};

[@mel.module "react"]
external createContext: 'a => Context.t('a) = "createContext";

[@mel.module "react"]
external forwardRef:
  ([@mel.uncurry] (('props, Js.Nullable.t(ref('a))) => element)) =>
  component('props) =
  "forwardRef";

[@mel.module "react"]
external memo: component('props) => component('props) = "memo";

[@mel.module "react"]
external memoCustomCompareProps:
  (component('props), [@mel.uncurry] (('props, 'props) => bool)) =>
  component('props) =
  "memo";

module Fragment: {
  [@mel.obj]
  external makeProps: (~children: element, unit) => {. "children": element};

  [@mel.module "react"]
  external make: component({. "children": element}) = "Fragment";
};

module StrictMode: {
  [@mel.obj]
  external makeProps: (~children: element, unit) => {. "children": element};
  [@mel.module "react"]
  external make: component({. "children": element}) = "StrictMode";
};

module Suspense: {
  [@mel.obj]
  external makeProps:
    (~children: element=?, ~fallback: element=?, unit) =>
    {
      .
      "children": option(element),
      "fallback": option(element),
    };
  [@mel.module "react"]
  external make:
    component({
      .
      "children": option(element),
      "fallback": option(element),
    }) =
    "Suspense";
};

/* HOOKS */

/*
 * Yeah, we know this api isn't great. tl;dr: useReducer instead.
 * It's because useState can take functions or non-function values and treats
 * them differently. Lazy initializer + callback which returns state is the
 * only way to safely have any type of state and be able to update it correctly.
 */
[@mel.module "react"]
external useState:
  ([@mel.uncurry] (unit => 'state)) => ('state, ('state => 'state) => unit) =
  "useState";

[@mel.module "react"]
external useReducer:
  ([@mel.uncurry] (('state, 'action) => 'state), 'state) =>
  ('state, 'action => unit) =
  "useReducer";

[@mel.module "react"]
external useReducerWithMapState:
  (
    [@mel.uncurry] (('state, 'action) => 'state),
    'initialState,
    [@mel.uncurry] ('initialState => 'state)
  ) =>
  ('state, 'action => unit) =
  "useReducer";

[@mel.module "react"]
external useSyncExternalStore:
  (
    ~subscribe: ([@mel.uncurry] (unit => unit)) => [@mel.uncurry] (unit => unit),
    ~getSnapshot: unit => 'snapshot
  ) =>
  'snapshot =
  "useSyncExternalStore";

[@mel.module "react"]
external useSyncExternalStoreWithServer:
  (
    ~subscribe: ([@mel.uncurry] (unit => unit)) => [@mel.uncurry] (unit => unit),
    ~getSnapshot: unit => 'snapshot,
    ~getServerSnapshot: [@mel.uncurry] (unit => 'snapshot)
  ) =>
  'snapshot =
  "useSyncExternalStore";

[@mel.module "react"]
external useEffect: ([@mel.uncurry] (unit => option(unit => unit))) => unit =
  "useEffect";
[@mel.module "react"]
external useEffect0:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    [@mel.as {json|[]|json}] _
  ) =>
  unit =
  "useEffect";
[@mel.module "react"]
external useEffect1:
  ([@mel.uncurry] (unit => option(unit => unit)), array('a)) => unit =
  "useEffect";
[@mel.module "react"]
external useEffect2:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b)) => unit =
  "useEffect";
[@mel.module "react"]
external useEffect3:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c)) => unit =
  "useEffect";
[@mel.module "react"]
external useEffect4:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd)) => unit =
  "useEffect";
[@mel.module "react"]
external useEffect5:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd, 'e)) =>
  unit =
  "useEffect";
[@mel.module "react"]
external useEffect6:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    ('a, 'b, 'c, 'd, 'e, 'f)
  ) =>
  unit =
  "useEffect";
[@mel.module "react"]
external useEffect7:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    ('a, 'b, 'c, 'd, 'e, 'f, 'g)
  ) =>
  unit =
  "useEffect";

[@mel.module "react"]
external useInsertionEffect:
  ([@mel.uncurry] (unit => option(unit => unit))) => unit =
  "useInsertionEffect";
[@mel.module "react"]
external useInsertionEffect0:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    [@mel.as {json|[]|json}] _
  ) =>
  unit =
  "useInsertionEffect";
[@mel.module "react"]
external useInsertionEffect1:
  ([@mel.uncurry] (unit => option(unit => unit)), array('a)) => unit =
  "useInsertionEffect";
[@mel.module "react"]
external useInsertionEffect2:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b)) => unit =
  "useInsertionEffect";
[@mel.module "react"]
external useInsertionEffect3:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c)) => unit =
  "useInsertionEffect";
[@mel.module "react"]
external useInsertionEffect4:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd)) => unit =
  "useInsertionEffect";
[@mel.module "react"]
external useInsertionEffect5:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd, 'e)) =>
  unit =
  "useInsertionEffect";
[@mel.module "react"]
external useInsertionEffect6:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    ('a, 'b, 'c, 'd, 'e, 'f)
  ) =>
  unit =
  "useInsertionEffect";
[@mel.module "react"]
external useInsertionEffect7:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    ('a, 'b, 'c, 'd, 'e, 'f, 'g)
  ) =>
  unit =
  "useInsertionEffect";

[@mel.module "react"]
external useLayoutEffect:
  ([@mel.uncurry] (unit => option(unit => unit))) => unit =
  "useLayoutEffect";
[@mel.module "react"]
external useLayoutEffect0:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    [@mel.as {json|[]|json}] _
  ) =>
  unit =
  "useLayoutEffect";
[@mel.module "react"]
external useLayoutEffect1:
  ([@mel.uncurry] (unit => option(unit => unit)), array('a)) => unit =
  "useLayoutEffect";
[@mel.module "react"]
external useLayoutEffect2:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b)) => unit =
  "useLayoutEffect";
[@mel.module "react"]
external useLayoutEffect3:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c)) => unit =
  "useLayoutEffect";
[@mel.module "react"]
external useLayoutEffect4:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd)) => unit =
  "useLayoutEffect";
[@mel.module "react"]
external useLayoutEffect5:
  ([@mel.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd, 'e)) =>
  unit =
  "useLayoutEffect";
[@mel.module "react"]
external useLayoutEffect6:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    ('a, 'b, 'c, 'd, 'e, 'f)
  ) =>
  unit =
  "useLayoutEffect";
[@mel.module "react"]
external useLayoutEffect7:
  (
    [@mel.uncurry] (unit => option(unit => unit)),
    ('a, 'b, 'c, 'd, 'e, 'f, 'g)
  ) =>
  unit =
  "useLayoutEffect";

[@mel.module "react"]
external useMemo: ([@mel.uncurry] (unit => 'any)) => 'any = "useMemo";
[@mel.module "react"]
external useMemo0:
  ([@mel.uncurry] (unit => 'any), [@mel.as {json|[]|json}] _) => 'any =
  "useMemo";
[@mel.module "react"]
external useMemo1: ([@mel.uncurry] (unit => 'any), array('a)) => 'any =
  "useMemo";
[@mel.module "react"]
external useMemo2: ([@mel.uncurry] (unit => 'any), ('a, 'b)) => 'any =
  "useMemo";
[@mel.module "react"]
external useMemo3: ([@mel.uncurry] (unit => 'any), ('a, 'b, 'c)) => 'any =
  "useMemo";
[@mel.module "react"]
external useMemo4: ([@mel.uncurry] (unit => 'any), ('a, 'b, 'c, 'd)) => 'any =
  "useMemo";
[@mel.module "react"]
external useMemo5:
  ([@mel.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e)) => 'any =
  "useMemo";
[@mel.module "react"]
external useMemo6:
  ([@mel.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f)) => 'any =
  "useMemo";
[@mel.module "react"]
external useMemo7:
  ([@mel.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'any =
  "useMemo";

/* This is used as return values  */
type callback('input, 'output) = 'input => 'output;

[@mel.module "react"] external useCallback: 'fn => 'fn = "useCallback";
[@mel.module "react"]
external useCallback0: ('fn, [@mel.as {json|[]|json}] _) => 'fn =
  "useCallback";
[@mel.module "react"]
external useCallback1: ('fn, array('a)) => 'fn = "useCallback";
[@mel.module "react"]
external useCallback2: ('fn, ('a, 'b)) => 'fn = "useCallback";
[@mel.module "react"]
external useCallback3: ('fn, ('a, 'b, 'c)) => 'fn = "useCallback";
[@mel.module "react"]
external useCallback4: ('fn, ('a, 'b, 'c, 'd)) => 'fn = "useCallback";
[@mel.module "react"]
external useCallback5: ('fn, ('a, 'b, 'c, 'd, 'e)) => 'fn = "useCallback";
[@mel.module "react"]
external useCallback6: ('fn, ('a, 'b, 'c, 'd, 'e, 'f)) => 'fn = "useCallback";
[@mel.module "react"]
external useCallback7: ('fn, ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'fn =
  "useCallback";

[@mel.module "react"]
external useContext: Context.t('any) => 'any = "useContext";

[@mel.module "react"] external useRef: 'value => ref('value) = "useRef";
[@mel.module "react"] external useId: unit => string = "useId";

[@mel.module "react"] external useDeferredValue: 'a => 'a = "useDeferredValue";

[@mel.module "react"]
external useImperativeHandle0:
  (
    Js.Nullable.t(ref('value)),
    [@mel.uncurry] (unit => 'value),
    [@mel.as {json|[]|json}] _
  ) =>
  unit =
  "useImperativeHandle";

[@mel.module "react"]
external useImperativeHandle1:
  (
    Js.Nullable.t(ref('value)),
    [@mel.uncurry] (unit => 'value),
    array('a)
  ) =>
  unit =
  "useImperativeHandle";

[@mel.module "react"]
external useImperativeHandle2:
  (Js.Nullable.t(ref('value)), [@mel.uncurry] (unit => 'value), ('a, 'b)) =>
  unit =
  "useImperativeHandle";

[@mel.module "react"]
external useImperativeHandle3:
  (
    Js.Nullable.t(ref('value)),
    [@mel.uncurry] (unit => 'value),
    ('a, 'b, 'c)
  ) =>
  unit =
  "useImperativeHandle";

[@mel.module "react"]
external useImperativeHandle4:
  (
    Js.Nullable.t(ref('value)),
    [@mel.uncurry] (unit => 'value),
    ('a, 'b, 'c, 'd)
  ) =>
  unit =
  "useImperativeHandle";

[@mel.module "react"]
external useImperativeHandle5:
  (
    Js.Nullable.t(ref('value)),
    [@mel.uncurry] (unit => 'value),
    ('a, 'b, 'c, 'd, 'e)
  ) =>
  unit =
  "useImperativeHandle";

[@mel.module "react"]
external useImperativeHandle6:
  (
    Js.Nullable.t(ref('value)),
    [@mel.uncurry] (unit => 'value),
    ('a, 'b, 'c, 'd, 'e, 'f)
  ) =>
  unit =
  "useImperativeHandle";

[@mel.module "react"]
external useImperativeHandle7:
  (
    Js.Nullable.t(ref('value)),
    [@mel.uncurry] (unit => 'value),
    ('a, 'b, 'c, 'd, 'e, 'f, 'g)
  ) =>
  unit =
  "useImperativeHandle";

module Uncurried: {
  [@mel.module "react"]
  external useState:
    ([@mel.uncurry] (unit => 'state)) =>
    ('state, (. ('state => 'state)) => unit) =
    "useState";

  [@mel.module "react"]
  external useReducer:
    ([@mel.uncurry] (('state, 'action) => 'state), 'state) =>
    ('state, (. 'action) => unit) =
    "useReducer";

  [@mel.module "react"]
  external useReducerWithMapState:
    (
      [@mel.uncurry] (('state, 'action) => 'state),
      'initialState,
      [@mel.uncurry] ('initialState => 'state)
    ) =>
    ('state, (. 'action) => unit) =
    "useReducer";

  /* This is used as return values */
  type callback('input, 'output) = (. 'input) => 'output;

  [@mel.module "react"]
  external useCallback:
    ([@mel.uncurry] ('input => 'output)) => callback('input, 'output) =
    "useCallback";
  [@mel.module "react"]
  external useCallback0:
    ([@mel.uncurry] ('input => 'output), [@mel.as {json|[]|json}] _) =>
    callback('input, 'output) =
    "useCallback";
  [@mel.module "react"]
  external useCallback1:
    ([@mel.uncurry] ('input => 'output), array('a)) =>
    callback('input, 'output) =
    "useCallback";
  [@mel.module "react"]
  external useCallback2:
    ([@mel.uncurry] ('input => 'output), ('a, 'b)) =>
    callback('input, 'output) =
    "useCallback";
  [@mel.module "react"]
  external useCallback3:
    ([@mel.uncurry] ('input => 'output), ('a, 'b, 'c)) =>
    callback('input, 'output) =
    "useCallback";
  [@mel.module "react"]
  external useCallback4:
    ([@mel.uncurry] ('input => 'output), ('a, 'b, 'c, 'd)) =>
    callback('input, 'output) =
    "useCallback";
  [@mel.module "react"]
  external useCallback5:
    ([@mel.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e)) =>
    callback('input, 'output) =
    "useCallback";
  [@mel.module "react"]
  external useCallback6:
    ([@mel.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f)) =>
    callback('input, 'output) =
    "useCallback";
  [@mel.module "react"]
  external useCallback7:
    ([@mel.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) =>
    callback('input, 'output) =
    "useCallback";
};

[@mel.module "react"]
external useTransition: unit => (bool, callback(callback(unit, unit), unit)) =
  "useTransition";

module Experimental: {
  /* This module is used to bind to APIs for future versions of React. There is no guarantee of backwards compatibility or stability. */
  [@mel.module "react"] external use: Js.Promise.t('a) => 'a = "use";
};

[@mel.set]
external setDisplayName: (component('props), string) => unit = "displayName";

[@mel.get] [@mel.return nullable]
external displayName: component('props) => option(string) = "displayName";

[@mel.module "react"]
external useDebugValue: ('value, ~format: 'value => string=?, unit) => unit =
  "useDebugValue";

module Event: {
  /* This is the whole synthetic event system of ReactJS/ReasonReact. The first module `Synthetic` represents
     the generic synthetic event. The rest are the specific ones.

     In each module, the type `t` commonly means "the type of that module" (OCaml convention). In our case, e.g.
     `ReactEvent.Mouse.t` represents a ReactJS synthetic mouse event. You'd use it to type your props:

     ```
     type props = {
       onClick: ReactEvent.Mouse.t => unit
     };
     ```

     All the methods and properties of a type of event are in the module, as seen below.

     Each module also has a `tag` type. You can ignore it; they're only needed by their `t` type. This way, we
     get to allow a base `Synthetic` event module with generic methods. So e.g. even a mouse event (`Mouse.t`)
     get to be passed to a generic handler:

     ```
     let handleClick = ({state, props}, event) => {
       ReactEvent.Mouse.preventDefault(event);
       ...
     };
     let handleSubmit = ({state, props}, event) => {
       /* this handler can be triggered by either a Keyboard or a Mouse event; conveniently use the generic
          preventDefault */
       ReactEvent.Synthetic.preventDefault(event);
       ...
     };

     let render = (_) => <Foo onSubmit=handleSubmit onEnter=handleSubmit .../>;
     ```

     How to translate idioms from ReactJS:

     1. myMouseEvent.preventDefault() -> ReactEvent.Mouse.preventDefault(myMouseEvent)
     2. myKeyboardEvent.which -> ReactEvent.Keyboard.which(myKeyboardEvent)
     */
  type synthetic('a);

  module Synthetic: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: synthetic('a) => bool = "bubbles";
    [@mel.get] external cancelable: synthetic('a) => bool = "cancelable";
    [@mel.get]
    external currentTarget: synthetic('a) => Js.t({..}) = "currentTarget";
    [@mel.get]
    external defaultPrevented: synthetic('a) => bool = "defaultPrevented";
    [@mel.get] external eventPhase: synthetic('a) => int = "eventPhase";
    [@mel.get] external isTrusted: synthetic('a) => bool = "isTrusted";
    [@mel.get]
    external nativeEvent: synthetic('a) => Js.t({..}) = "nativeEvent";
    [@mel.send]
    external preventDefault: synthetic('a) => unit = "preventDefault";
    [@mel.send]
    external isDefaultPrevented: synthetic('a) => bool = "isDefaultPrevented";
    [@mel.send]
    external stopPropagation: synthetic('a) => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: synthetic('a) => bool =
      "isPropagationStopped";
    [@mel.get] external target: synthetic('a) => Js.t({..}) = "target";
    [@mel.get] external timeStamp: synthetic('a) => float = "timeStamp";
    [@mel.get] external type_: synthetic('a) => string = "type";
    [@mel.send] external persist: synthetic('a) => unit = "persist";
  };

  /* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
  external toSyntheticEvent: synthetic('a) => Synthetic.t = "%identity";

  module Clipboard: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external clipboardData: t => Js.t({..}) = "clipboardData"; /* Should return Dom.dataTransfer */
  };

  module Composition: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external data: t => string = "data";
  };

  module Drag: {
    type tag;
    type t = synthetic(tag);

    // SyntheticEvent
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";

    // MouseEvent
    [@mel.get] external altKey: t => bool = "altKey";
    [@mel.get] external button: t => int = "button";
    [@mel.get] external buttons: t => int = "buttons";
    [@mel.get] external clientX: t => int = "clientX";
    [@mel.get] external clientY: t => int = "clientY";
    [@mel.get] external ctrlKey: t => bool = "ctrlKey";
    [@mel.send]
    external getModifierState: (t, string) => bool = "getModifierState";
    [@mel.get] external metaKey: t => bool = "metaKey";
    [@mel.get] external movementX: t => int = "movementX";
    [@mel.get] external movementY: t => int = "movementY";
    [@mel.get] external pageX: t => int = "pageX";
    [@mel.get] external pageY: t => int = "pageY";
    [@mel.get] [@mel.return nullable]
    external relatedTarget: t => option(Js.t({..})) = "relatedTarget"; /* Should return Dom.eventTarget */
    [@mel.get] external screenX: t => int = "screenX";
    [@mel.get] external screenY: t => int = "screenY";
    [@mel.get] external shiftKey: t => bool = "shiftKey";

    [@mel.get] external dataTransfer: t => Js.t({..}) = "dataTransfer"; /* Should return Dom.dataTransfer */
  };

  module Keyboard: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external altKey: t => bool = "altKey";
    [@mel.get] external charCode: t => int = "charCode";
    [@mel.get] external ctrlKey: t => bool = "ctrlKey";
    [@mel.send]
    external getModifierState: (t, string) => bool = "getModifierState";
    [@mel.get] external key: t => string = "key";
    [@mel.get] external keyCode: t => int = "keyCode";
    [@mel.get] external locale: t => string = "locale";
    [@mel.get] external location: t => int = "location";
    [@mel.get] external metaKey: t => bool = "metaKey";
    [@mel.get] external repeat: t => bool = "repeat";
    [@mel.get] external shiftKey: t => bool = "shiftKey";
    [@mel.get] external which: t => int = "which";
  };

  module Focus: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] [@mel.return nullable]
    external relatedTarget: t => option(Js.t({..})) = "relatedTarget"; /* Should return Dom.eventTarget */
  };

  module Form: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
  };

  module Mouse: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external altKey: t => bool = "altKey";
    [@mel.get] external button: t => int = "button";
    [@mel.get] external buttons: t => int = "buttons";
    [@mel.get] external clientX: t => int = "clientX";
    [@mel.get] external clientY: t => int = "clientY";
    [@mel.get] external ctrlKey: t => bool = "ctrlKey";
    [@mel.send]
    external getModifierState: (t, string) => bool = "getModifierState";
    [@mel.get] external metaKey: t => bool = "metaKey";
    [@mel.get] external movementX: t => int = "movementX";
    [@mel.get] external movementY: t => int = "movementY";
    [@mel.get] external pageX: t => int = "pageX";
    [@mel.get] external pageY: t => int = "pageY";
    [@mel.get] [@mel.return nullable]
    external relatedTarget: t => option(Js.t({..})) = "relatedTarget"; /* Should return Dom.eventTarget */
    [@mel.get] external screenX: t => int = "screenX";
    [@mel.get] external screenY: t => int = "screenY";
    [@mel.get] external shiftKey: t => bool = "shiftKey";
  };

  module Pointer: {
    type tag;
    type t = synthetic(tag);

    // Event
    [@mel.get] external type_: t => string = "type";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";

    [@mel.get] external eventPhase: t => int = "eventPhase";

    [@mel.send] external stopPropagation: t => unit = "stopPropagation"; // aka cancelBubble
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";

    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external timeStamp: t => float = "timeStamp";

    // SyntheticEvent
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.send] external persist: t => unit = "persist";

    // UIEvent
    [@mel.get] external detail: t => int = "detail";
    [@mel.get] external view: t => Dom.window = "view"; /* Should return DOMAbstractView/WindowProxy */

    // MouseEvent
    [@mel.get] external screenX: t => int = "screenX";
    [@mel.get] external screenY: t => int = "screenY";
    [@mel.get] external clientX: t => int = "clientX";
    [@mel.get] external clientY: t => int = "clientY";
    [@mel.get] external pageX: t => int = "pageX";
    [@mel.get] external pageY: t => int = "pageY";
    [@mel.get] external movementX: t => int = "movementX";
    [@mel.get] external movementY: t => int = "movementY";

    [@mel.get] external ctrlKey: t => bool = "ctrlKey";
    [@mel.get] external shiftKey: t => bool = "shiftKey";
    [@mel.get] external altKey: t => bool = "altKey";
    [@mel.get] external metaKey: t => bool = "metaKey";
    [@mel.send]
    external getModifierState: (t, string) => bool = "getModifierState";

    [@mel.get] external button: t => int = "button";
    [@mel.get] external buttons: t => int = "buttons";

    [@mel.get] [@mel.return nullable]
    external relatedTarget: t => option(Js.t({..})) = "relatedTarget"; /* Should return Dom.eventTarget */

    // PointerEvent
    [@mel.get] external pointerId: t => Dom.eventPointerId = "pointerId";
    [@mel.get] external width: t => float = "width";
    [@mel.get] external height: t => float = "height";
    [@mel.get] external pressure: t => float = "pressure";
    [@mel.get] external tangentialPressure: t => float = "tangentialPressure";
    [@mel.get] external tiltX: t => int = "tiltX";
    [@mel.get] external tiltY: t => int = "tiltY";
    [@mel.get] external twist: t => int = "twist";
    [@mel.get] external pointerType: t => string = "pointerType";
    [@mel.get] external isPrimary: t => bool = "isPrimary";
  };

  module Selection: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
  };

  module Touch: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external altKey: t => bool = "altKey";
    [@mel.get] external changedTouches: t => Js.t({..}) = "changedTouches"; /* Should return Dom.touchList */
    [@mel.get] external ctrlKey: t => bool = "ctrlKey";
    [@mel.send]
    external getModifierState: (t, string) => bool = "getModifierState";
    [@mel.get] external metaKey: t => bool = "metaKey";
    [@mel.get] external shiftKey: t => bool = "shiftKey";
    [@mel.get] external targetTouches: t => Js.t({..}) = "targetTouches"; /* Should return Dom.touchList */
    [@mel.get] external touches: t => Js.t({..}) = "touches"; /* Should return Dom.touchList */
  };

  module UI: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external detail: t => int = "detail";
    [@mel.get] external view: t => Dom.window = "view"; /* Should return DOMAbstractView/WindowProxy */
  };

  module Wheel: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external deltaMode: t => int = "deltaMode";
    [@mel.get] external deltaX: t => float = "deltaX";
    [@mel.get] external deltaY: t => float = "deltaY";
    [@mel.get] external deltaZ: t => float = "deltaZ";
  };

  module Media: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
  };

  module Image: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
  };

  module Animation: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external animationName: t => string = "animationName";
    [@mel.get] external pseudoElement: t => string = "pseudoElement";
    [@mel.get] external elapsedTime: t => float = "elapsedTime";
  };

  module Transition: {
    type tag;
    type t = synthetic(tag);
    [@mel.get] external bubbles: t => bool = "bubbles";
    [@mel.get] external cancelable: t => bool = "cancelable";
    [@mel.get] external currentTarget: t => Js.t({..}) = "currentTarget";
    [@mel.get] external defaultPrevented: t => bool = "defaultPrevented";
    [@mel.get] external eventPhase: t => int = "eventPhase";
    [@mel.get] external isTrusted: t => bool = "isTrusted";
    [@mel.get] external nativeEvent: t => Js.t({..}) = "nativeEvent";
    [@mel.send] external preventDefault: t => unit = "preventDefault";
    [@mel.send] external isDefaultPrevented: t => bool = "isDefaultPrevented";
    [@mel.send] external stopPropagation: t => unit = "stopPropagation";
    [@mel.send]
    external isPropagationStopped: t => bool = "isPropagationStopped";
    [@mel.get] external target: t => Js.t({..}) = "target";
    [@mel.get] external timeStamp: t => float = "timeStamp";
    [@mel.get] external type_: t => string = "type";
    [@mel.send] external persist: t => unit = "persist";
    [@mel.get] external propertyName: t => string = "propertyName";
    [@mel.get] external pseudoElement: t => string = "pseudoElement";
    [@mel.get] external elapsedTime: t => float = "elapsedTime";
  };
};
