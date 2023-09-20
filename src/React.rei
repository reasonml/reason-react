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

[@mel.splice] [@mel.module "react"]
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

/* Experimental React.SuspenseList */
module SuspenseList: {
  type revealOrder;
  type tail;
  [@mel.obj]
  external makeProps:
    (
      ~children: element=?,
      ~revealOrder: [ | `forwards | `backwards | `together]=?,
      ~tail: [ | `collapsed | `hidden]=?,
      unit
    ) =>
    {
      .
      "children": option(element),
      "revealOrder": option(revealOrder),
      "tail": option(tail),
    };

  [@mel.module "react"]
  external make:
    component({
      .
      "children": option(element),
      "revealOrder": option(revealOrder),
      "tail": option(tail),
    }) =
    "SuspenseList";
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

type transitionConfig = {timeoutMs: int};

[@mel.module "react"]
external useTransition:
  (~config: transitionConfig=?, unit) =>
  (callback(callback(unit, unit), unit), bool) =
  "useTransition";

[@mel.set]
external setDisplayName: (component('props), string) => unit = "displayName";

[@mel.get] [@mel.return nullable]
external displayName: component('props) => option(string) = "displayName";

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

module DOM: {
  module Style: {
    type t;

    [@mel.obj]
    external make:
      (
        ~azimuth: string=?,
        ~background: string=?,
        ~backgroundAttachment: string=?,
        ~backgroundColor: string=?,
        ~backgroundImage: string=?,
        ~backgroundPosition: string=?,
        ~backgroundRepeat: string=?,
        ~border: string=?,
        ~borderCollapse: string=?,
        ~borderColor: string=?,
        ~borderSpacing: string=?,
        ~borderStyle: string=?,
        ~borderTop: string=?,
        ~borderRight: string=?,
        ~borderBottom: string=?,
        ~borderLeft: string=?,
        ~borderTopColor: string=?,
        ~borderRightColor: string=?,
        ~borderBottomColor: string=?,
        ~borderLeftColor: string=?,
        ~borderTopStyle: string=?,
        ~borderRightStyle: string=?,
        ~borderBottomStyle: string=?,
        ~borderLeftStyle: string=?,
        ~borderTopWidth: string=?,
        ~borderRightWidth: string=?,
        ~borderBottomWidth: string=?,
        ~borderLeftWidth: string=?,
        ~borderWidth: string=?,
        ~bottom: string=?,
        ~captionSide: string=?,
        ~clear: string=?,
        ~clip: string=?,
        ~color: string=?,
        ~content: string=?,
        ~counterIncrement: string=?,
        ~counterReset: string=?,
        ~cue: string=?,
        ~cueAfter: string=?,
        ~cueBefore: string=?,
        ~cursor: string=?,
        ~direction: string=?,
        ~display: string=?,
        ~elevation: string=?,
        ~emptyCells: string=?,
        ~float: string=?,
        ~font: string=?,
        ~fontFamily: string=?,
        ~fontSize: string=?,
        ~fontSizeAdjust: string=?,
        ~fontStretch: string=?,
        ~fontStyle: string=?,
        ~fontVariant: string=?,
        ~fontWeight: string=?,
        ~height: string=?,
        ~left: string=?,
        ~letterSpacing: string=?,
        ~lineHeight: string=?,
        ~listStyle: string=?,
        ~listStyleImage: string=?,
        ~listStylePosition: string=?,
        ~listStyleType: string=?,
        ~margin: string=?,
        ~marginTop: string=?,
        ~marginRight: string=?,
        ~marginBottom: string=?,
        ~marginLeft: string=?,
        ~markerOffset: string=?,
        ~marks: string=?,
        ~maxHeight: string=?,
        ~maxWidth: string=?,
        ~minHeight: string=?,
        ~minWidth: string=?,
        ~orphans: string=?,
        ~outline: string=?,
        ~outlineColor: string=?,
        ~outlineStyle: string=?,
        ~outlineWidth: string=?,
        ~overflow: string=?,
        ~overflowX: string=?,
        ~overflowY: string=?,
        ~padding: string=?,
        ~paddingTop: string=?,
        ~paddingRight: string=?,
        ~paddingBottom: string=?,
        ~paddingLeft: string=?,
        ~page: string=?,
        ~pageBreakAfter: string=?,
        ~pageBreakBefore: string=?,
        ~pageBreakInside: string=?,
        ~pause: string=?,
        ~pauseAfter: string=?,
        ~pauseBefore: string=?,
        ~pitch: string=?,
        ~pitchRange: string=?,
        ~playDuring: string=?,
        ~position: string=?,
        ~quotes: string=?,
        ~richness: string=?,
        ~right: string=?,
        ~size: string=?,
        ~speak: string=?,
        ~speakHeader: string=?,
        ~speakNumeral: string=?,
        ~speakPunctuation: string=?,
        ~speechRate: string=?,
        ~stress: string=?,
        ~tableLayout: string=?,
        ~textAlign: string=?,
        ~textDecoration: string=?,
        ~textIndent: string=?,
        ~textShadow: string=?,
        ~textTransform: string=?,
        ~top: string=?,
        ~unicodeBidi: string=?,
        ~verticalAlign: string=?,
        ~visibility: string=?,
        ~voiceFamily: string=?,
        ~volume: string=?,
        ~whiteSpace: string=?,
        ~widows: string=?,
        ~width: string=?,
        ~wordSpacing: string=?,
        ~zIndex: string=?,
        /* Below properties based on https://www.w3.org/Style/CSS/all-properties */
        /* Color Level 3 - REC */
        ~opacity: string=?,
        /* Backgrounds and Borders Level 3 - CR */
        /* backgroundRepeat - already defined by CSS2Properties */
        /* backgroundAttachment - already defined by CSS2Properties */
        ~backgroundOrigin: string=?,
        ~backgroundSize: string=?,
        ~backgroundClip: string=?,
        ~borderRadius: string=?,
        ~borderTopLeftRadius: string=?,
        ~borderTopRightRadius: string=?,
        ~borderBottomLeftRadius: string=?,
        ~borderBottomRightRadius: string=?,
        ~borderImage: string=?,
        ~borderImageSource: string=?,
        ~borderImageSlice: string=?,
        ~borderImageWidth: string=?,
        ~borderImageOutset: string=?,
        ~borderImageRepeat: string=?,
        ~boxShadow: string=?,
        /* Multi-column Layout - CR */
        ~columns: string=?,
        ~columnCount: string=?,
        ~columnFill: string=?,
        ~columnGap: string=?,
        ~columnRule: string=?,
        ~columnRuleColor: string=?,
        ~columnRuleStyle: string=?,
        ~columnRuleWidth: string=?,
        ~columnSpan: string=?,
        ~columnWidth: string=?,
        ~breakAfter: string=?,
        ~breakBefore: string=?,
        ~breakInside: string=?,
        /* Speech - CR */
        ~rest: string=?,
        ~restAfter: string=?,
        ~restBefore: string=?,
        ~speakAs: string=?,
        ~voiceBalance: string=?,
        ~voiceDuration: string=?,
        ~voicePitch: string=?,
        ~voiceRange: string=?,
        ~voiceRate: string=?,
        ~voiceStress: string=?,
        ~voiceVolume: string=?,
        /* Image Values and Replaced Content Level 3 - CR */
        ~objectFit: string=?,
        ~objectPosition: string=?,
        ~imageResolution: string=?,
        ~imageOrientation: string=?,
        /* Flexible Box Layout - CR */
        ~alignContent: string=?,
        ~alignItems: string=?,
        ~alignSelf: string=?,
        ~flex: string=?,
        ~flexBasis: string=?,
        ~flexDirection: string=?,
        ~flexFlow: string=?,
        ~flexGrow: string=?,
        ~flexShrink: string=?,
        ~flexWrap: string=?,
        ~justifyContent: string=?,
        ~order: string=?,
        /* Text Decoration Level 3 - CR */
        /* textDecoration - already defined by CSS2Properties */
        ~textDecorationColor: string=?,
        ~textDecorationLine: string=?,
        ~textDecorationSkip: string=?,
        ~textDecorationStyle: string=?,
        ~textEmphasis: string=?,
        ~textEmphasisColor: string=?,
        ~textEmphasisPosition: string=?,
        ~textEmphasisStyle: string=?,
        /* textShadow - already defined by CSS2Properties */
        ~textUnderlinePosition: string=?,
        /* Fonts Level 3 - CR */
        ~fontFeatureSettings: string=?,
        ~fontKerning: string=?,
        ~fontLanguageOverride: string=?,
        /* fontSizeAdjust - already defined by CSS2Properties */
        /* fontStretch - already defined by CSS2Properties */
        ~fontSynthesis: string=?,
        ~forntVariantAlternates: string=?,
        ~fontVariantCaps: string=?,
        ~fontVariantEastAsian: string=?,
        ~fontVariantLigatures: string=?,
        ~fontVariantNumeric: string=?,
        ~fontVariantPosition: string=?,
        /* Cascading and Inheritance Level 3 - CR */
        ~all: string=?,
        /* Writing Modes Level 3 - CR */
        ~glyphOrientationVertical: string=?,
        ~textCombineUpright: string=?,
        ~textOrientation: string=?,
        ~writingMode: string=?,
        /* Shapes Level 1 - CR */
        ~shapeImageThreshold: string=?,
        ~shapeMargin: string=?,
        ~shapeOutside: string=?,
        /* Masking Level 1 - CR */
        ~clipPath: string=?,
        ~clipRule: string=?,
        ~mask: string=?,
        ~maskBorder: string=?,
        ~maskBorderMode: string=?,
        ~maskBorderOutset: string=?,
        ~maskBorderRepeat: string=?,
        ~maskBorderSlice: string=?,
        ~maskBorderSource: string=?,
        ~maskBorderWidth: string=?,
        ~maskClip: string=?,
        ~maskComposite: string=?,
        ~maskImage: string=?,
        ~maskMode: string=?,
        ~maskOrigin: string=?,
        ~maskPosition: string=?,
        ~maskRepeat: string=?,
        ~maskSize: string=?,
        ~maskType: string=?,
        /* Compositing and Blending Level 1 - CR */
        ~backgroundBlendMode: string=?,
        ~isolation: string=?,
        ~mixBlendMode: string=?,
        /* Fragmentation Level 3 - CR */
        ~boxDecorationBreak: string=?,
        /* breakAfter - already defined by Multi-column Layout */
        /* breakBefore - already defined by Multi-column Layout */
        /* breakInside - already defined by Multi-column Layout */
        /* Basic User Interface Level 3 - CR */
        ~boxSizing: string=?,
        ~caretColor: string=?,
        ~navDown: string=?,
        ~navLeft: string=?,
        ~navRight: string=?,
        ~navUp: string=?,
        ~outlineOffset: string=?,
        ~resize: string=?,
        ~textOverflow: string=?,
        /* Grid Layout Level 1 - CR */
        ~grid: string=?,
        ~gridArea: string=?,
        ~gridAutoColumns: string=?,
        ~gridAutoFlow: string=?,
        ~gridAutoRows: string=?,
        ~gridColumn: string=?,
        ~gridColumnEnd: string=?,
        ~gridColumnGap: string=?,
        ~gridColumnStart: string=?,
        ~gridGap: string=?,
        ~gridRow: string=?,
        ~gridRowEnd: string=?,
        ~gridRowGap: string=?,
        ~gridRowStart: string=?,
        ~gridTemplate: string=?,
        ~gridTemplateAreas: string=?,
        ~gridTemplateColumns: string=?,
        ~gridTemplateRows: string=?,
        /* Will Change Level 1 - CR */
        ~willChange: string=?,
        /* Text Level 3 - LC */
        ~hangingPunctuation: string=?,
        ~hyphens: string=?,
        /* letterSpacing - already defined by CSS2Properties */
        ~lineBreak: string=?,
        ~overflowWrap: string=?,
        ~tabSize: string=?,
        /* textAlign - already defined by CSS2Properties */
        ~textAlignLast: string=?,
        ~textJustify: string=?,
        ~wordBreak: string=?,
        ~wordWrap: string=?,
        /* Animations - WD */
        ~animation: string=?,
        ~animationDelay: string=?,
        ~animationDirection: string=?,
        ~animationDuration: string=?,
        ~animationFillMode: string=?,
        ~animationIterationCount: string=?,
        ~animationName: string=?,
        ~animationPlayState: string=?,
        ~animationTimingFunction: string=?,
        /* Transitions - WD */
        ~transition: string=?,
        ~transitionDelay: string=?,
        ~transitionDuration: string=?,
        ~transitionProperty: string=?,
        ~transitionTimingFunction: string=?,
        /* Transforms Level 1 - WD */
        ~backfaceVisibility: string=?,
        ~perspective: string=?,
        ~perspectiveOrigin: string=?,
        ~transform: string=?,
        ~transformOrigin: string=?,
        ~transformStyle: string=?,
        /* Box Alignment Level 3 - WD */
        /* alignContent - already defined by Flexible Box Layout */
        /* alignItems - already defined by Flexible Box Layout */
        ~justifyItems: string=?,
        ~justifySelf: string=?,
        ~placeContent: string=?,
        ~placeItems: string=?,
        ~placeSelf: string=?,
        /* Basic User Interface Level 4 - FPWD */
        ~appearance: string=?,
        ~caret: string=?,
        ~caretAnimation: string=?,
        ~caretShape: string=?,
        ~userSelect: string=?,
        /* Overflow Level 3 - WD */
        ~maxLines: string=?,
        /* Basix Box Model - WD */
        ~marqueeDirection: string=?,
        ~marqueeLoop: string=?,
        ~marqueeSpeed: string=?,
        ~marqueeStyle: string=?,
        ~overflowStyle: string=?,
        ~rotation: string=?,
        ~rotationPoint: string=?,
        /* SVG 1.1 - REC */
        ~alignmentBaseline: string=?,
        ~baselineShift: string=?,
        ~clip: string=?,
        ~clipPath: string=?,
        ~clipRule: string=?,
        ~colorInterpolation: string=?,
        ~colorInterpolationFilters: string=?,
        ~colorProfile: string=?,
        ~colorRendering: string=?,
        ~cursor: string=?,
        ~dominantBaseline: string=?,
        ~fill: string=?,
        ~fillOpacity: string=?,
        ~fillRule: string=?,
        ~filter: string=?,
        ~floodColor: string=?,
        ~floodOpacity: string=?,
        ~glyphOrientationHorizontal: string=?,
        ~glyphOrientationVertical: string=?,
        ~imageRendering: string=?,
        ~kerning: string=?,
        ~lightingColor: string=?,
        ~markerEnd: string=?,
        ~markerMid: string=?,
        ~markerStart: string=?,
        ~pointerEvents: string=?,
        ~shapeRendering: string=?,
        ~stopColor: string=?,
        ~stopOpacity: string=?,
        ~stroke: string=?,
        ~strokeDasharray: string=?,
        ~strokeDashoffset: string=?,
        ~strokeLinecap: string=?,
        ~strokeLinejoin: string=?,
        ~strokeMiterlimit: string=?,
        ~strokeOpacity: string=?,
        ~strokeWidth: string=?,
        ~textAnchor: string=?,
        ~textRendering: string=?,
        /* Ruby Layout Level 1 - WD */
        ~rubyAlign: string=?,
        ~rubyMerge: string=?,
        ~rubyPosition: string=?,
        /* Lists and Counters Level 3 - WD */
        /* listStyle - already defined by CSS2Properties */
        /* listStyleImage - already defined by CSS2Properties */
        /* listStylePosition - already defined by CSS2Properties */
        /* listStyleType - already defined by CSS2Properties */
        /* counterIncrement - already defined by CSS2Properties */
        /* counterReset - already defined by CSS2Properties */
        /* Not added yet
         * -------------
         * Generated Content for Paged Media - WD
         * Generated Content Level 3 - WD
         * Line Grid Level 1 - WD
         * Regions - WD
         * Inline Layout Level 3 - WD
         * Round Display Level 1 - WD
         * Image Values and Replaced Content Level 4 - WD
         * Positioned Layout Level 3 - WD
         * Filter Effects Level 1 -  -WD
         * Exclusions Level 1 - WD
         * Text Level 4 - FPWD
         * SVG Markers - FPWD
         * Motion Path Level 1 - FPWD
         * Color Level 4 - FPWD
         * SVG Strokes - FPWD
         * Table Level 3 - FPWD
         */
        unit
      ) =>
      t;

    /* CSS2Properties: https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSS2Properties */
    external combine: ([@mel.as {json|{}|json}] _, t, t) => t =
      "Object.assign";

    external _dictToStyle: Js.Dict.t(string) => t = "%identity";

    let unsafeAddProp: (t, string, string) => t;

    external unsafeAddStyle: ([@mel.as {json|{}|json}] _, t, Js.t({..})) => t =
      "Object.assign";
  };

  module Server: {
    [@mel.module "react-dom/server"]
    external renderToString: element => string = "renderToString";

    [@mel.module "react-dom/server"]
    external renderToStaticMarkup: element => string = "renderToStaticMarkup";
  };

  [@mel.return nullable]
  external querySelector: string => option(Dom.element) =
    "document.querySelector";

  [@mel.module "react-dom"]
  external render: (element, Dom.element) => unit = "render";

  module Experimental: {
    type root;

    [@mel.module "react-dom"]
    external createRoot: Dom.element => root = "createRoot";

    [@mel.module "react-dom"]
    external createBlockingRoot: Dom.element => root = "createBlockingRoot";

    [@mel.send] external render: (root, element) => unit = "render";
  };

  [@mel.module "react-dom"]
  external hydrate: (element, Dom.element) => unit = "hydrate";

  [@mel.module "react-dom"]
  external createPortal: (element, Dom.element) => element = "createPortal";

  [@mel.module "react-dom"]
  external unmountComponentAtNode: Dom.element => unit =
    "unmountComponentAtNode";

  external domElementToObj: Dom.element => Js.t({..}) = "%identity";

  type style = Style.t;

  type domRef;

  module Ref: {
    type t = domRef;
    type currentDomRef = ref(Js.nullable(Dom.element));
    type callbackDomRef = Js.nullable(Dom.element) => unit;

    external domRef: currentDomRef => domRef = "%identity";
    external callbackDomRef: callbackDomRef => domRef = "%identity";
  };

  /* This list isn't exhaustive. We'll add more as we go. */
  /*
   * Watch out! There are two props types and the only difference is the type of ref.
   * Please keep in sync.
   */
  [@deriving abstract]
  type domProps = {
    [@mel.optional]
    key: option(string),
    [@mel.optional]
    ref: option(domRef),
    [@mel.optional]
    children: option(element),
    /* accessibility */
    /* https://www.w3.org/TR/wai-aria-1.1/ */
    [@mel.optional] [@mel.as "aria-activedescendant"]
    ariaActivedescendant: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-activedescendat */
    [@mel.optional] [@mel.as "aria-atomic"]
    ariaAtomic: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-atomic */
    [@mel.optional] [@mel.as "aria-autocomplete"]
    ariaAutocomplete: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-autocomplete */
    [@mel.optional] [@mel.as "aria-busy"]
    ariaBusy: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-busy */
    [@mel.optional] [@mel.as "aria-checked"]
    ariaChecked: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-checked */
    [@mel.optional] [@mel.as "aria-colcount"]
    ariaColcount: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colcount */
    [@mel.optional] [@mel.as "aria-colindex"]
    ariaColindex: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colindex */
    [@mel.optional] [@mel.as "aria-colspan"]
    ariaColspan: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colspan */
    [@mel.optional] [@mel.as "aria-controls"]
    ariaControls: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-controls */
    [@mel.optional] [@mel.as "aria-current"]
    ariaCurrent: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-current */
    [@mel.optional] [@mel.as "aria-describedby"]
    ariaDescribedby: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-describedby */
    [@mel.optional] [@mel.as "aria-details"]
    ariaDetails: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-details */
    [@mel.optional] [@mel.as "aria-disabled"]
    ariaDisabled: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-disabled */
    [@mel.optional] [@mel.as "aria-errormessage"]
    ariaErrormessage: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-errormessage */
    [@mel.optional] [@mel.as "aria-expanded"]
    ariaExpanded: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-expanded */
    [@mel.optional] [@mel.as "aria-flowto"]
    ariaFlowto: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-flowto */
    [@mel.optional] [@mel.as "aria-grabbed"] /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-relevant */
    ariaGrabbed: option(bool),
    [@mel.optional] [@mel.as "aria-haspopup"]
    ariaHaspopup: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-haspopup */
    [@mel.optional] [@mel.as "aria-hidden"]
    ariaHidden: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-hidden */
    [@mel.optional] [@mel.as "aria-invalid"]
    ariaInvalid: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-invalid */
    [@mel.optional] [@mel.as "aria-keyshortcuts"]
    ariaKeyshortcuts: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-keyshortcuts */
    [@mel.optional] [@mel.as "aria-label"]
    ariaLabel: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-label */
    [@mel.optional] [@mel.as "aria-labelledby"]
    ariaLabelledby: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-labelledby */
    [@mel.optional] [@mel.as "aria-level"]
    ariaLevel: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-level */
    [@mel.optional] [@mel.as "aria-live"]
    ariaLive: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-live */
    [@mel.optional] [@mel.as "aria-modal"]
    ariaModal: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-modal */
    [@mel.optional] [@mel.as "aria-multiline"]
    ariaMultiline: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-multiline */
    [@mel.optional] [@mel.as "aria-multiselectable"]
    ariaMultiselectable: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-multiselectable */
    [@mel.optional] [@mel.as "aria-orientation"]
    ariaOrientation: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-orientation */
    [@mel.optional] [@mel.as "aria-owns"]
    ariaOwns: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-owns */
    [@mel.optional] [@mel.as "aria-placeholder"]
    ariaPlaceholder: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-placeholder */
    [@mel.optional] [@mel.as "aria-posinset"]
    ariaPosinset: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-posinset */
    [@mel.optional] [@mel.as "aria-pressed"]
    ariaPressed: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-pressed */
    [@mel.optional] [@mel.as "aria-readonly"]
    ariaReadonly: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-readonly */
    [@mel.optional] [@mel.as "aria-relevant"]
    ariaRelevant: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-relevant */
    [@mel.optional] [@mel.as "aria-required"]
    ariaRequired: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-required */
    [@mel.optional] [@mel.as "aria-roledescription"]
    ariaRoledescription: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-roledescription */
    [@mel.optional] [@mel.as "aria-rowcount"]
    ariaRowcount: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowcount */
    [@mel.optional] [@mel.as "aria-rowindex"]
    ariaRowindex: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowindex */
    [@mel.optional] [@mel.as "aria-rowindextext"]
    ariaRowindextext: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowindextext */
    [@mel.optional] [@mel.as "aria-rowspan"]
    ariaRowspan: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowspan */
    [@mel.optional] [@mel.as "aria-selected"]
    ariaSelected: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-selected */
    [@mel.optional] [@mel.as "aria-setsize"]
    ariaSetsize: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-setsize */
    [@mel.optional] [@mel.as "aria-sort"]
    ariaSort: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-sort */
    [@mel.optional] [@mel.as "aria-valuemax"]
    ariaValuemax: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuemax */
    [@mel.optional] [@mel.as "aria-valuemin"]
    ariaValuemin: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuemin */
    [@mel.optional] [@mel.as "aria-valuenow"]
    ariaValuenow: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuenow */
    [@mel.optional] [@mel.as "aria-valuetext"]
    ariaValuetext: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuetext */
    /* react textarea/input */
    [@mel.optional]
    defaultChecked: option(bool),
    [@mel.optional]
    defaultValue: option(string),
    /* global html attributes */
    [@mel.optional]
    accessKey: option(string),
    [@mel.optional]
    className: option(string), /* substitute for "class" */
    [@mel.optional]
    contentEditable: option(bool),
    [@mel.optional]
    contextMenu: option(string),
    [@mel.optional]
    dir: option(string), /* "ltr", "rtl" or "auto" */
    [@mel.optional]
    draggable: option(bool),
    [@mel.optional]
    hidden: option(bool),
    [@mel.optional]
    id: option(string),
    [@mel.optional]
    lang: option(string),
    [@mel.optional]
    role: option(string), /* ARIA role */
    [@mel.optional]
    style: option(style),
    [@mel.optional]
    spellCheck: option(bool),
    [@mel.optional]
    tabIndex: option(int),
    [@mel.optional]
    title: option(string),
    /* html5 microdata */
    [@mel.optional]
    itemID: option(string),
    [@mel.optional]
    itemProp: option(string),
    [@mel.optional]
    itemRef: option(string),
    [@mel.optional]
    itemScope: option(bool),
    [@mel.optional]
    itemType: option(string), /* uri */
    /* tag-specific html attributes */
    [@mel.optional] [@mel.as "as"]
    as_: option(string),
    [@mel.optional]
    accept: option(string),
    [@mel.optional]
    acceptCharset: option(string),
    [@mel.optional]
    action: option(string), /* uri */
    [@mel.optional]
    allowFullScreen: option(bool),
    [@mel.optional]
    alt: option(string),
    [@mel.optional]
    async: option(bool),
    [@mel.optional]
    autoComplete: option(string), /* has a fixed, but large-ish, set of possible values */
    [@mel.optional]
    autoCapitalize: option(string), /* Mobile Safari specific */
    [@mel.optional]
    autoFocus: option(bool),
    [@mel.optional]
    autoPlay: option(bool),
    [@mel.optional]
    challenge: option(string),
    [@mel.optional]
    charSet: option(string),
    [@mel.optional]
    checked: option(bool),
    [@mel.optional]
    cite: option(string), /* uri */
    [@mel.optional]
    crossOrigin: option(string), /* anonymous, use-credentials */
    [@mel.optional]
    cols: option(int),
    [@mel.optional]
    colSpan: option(int),
    [@mel.optional]
    content: option(string),
    [@mel.optional]
    controls: option(bool),
    [@mel.optional]
    coords: option(string), /* set of values specifying the coordinates of a region */
    [@mel.optional]
    data: option(string), /* uri */
    [@mel.optional]
    dateTime: option(string), /* "valid date string with optional time" */
    [@mel.optional]
    default: option(bool),
    [@mel.optional]
    defer: option(bool),
    [@mel.optional]
    disabled: option(bool),
    [@mel.optional]
    download: option(string), /* should really be either a boolean, signifying presence, or a string */
    [@mel.optional]
    encType: option(string), /* "application/x-www-form-urlencoded", "multipart/form-data" or "text/plain" */
    [@mel.optional]
    form: option(string),
    [@mel.optional]
    formAction: option(string), /* uri */
    [@mel.optional]
    formTarget: option(string), /* "_blank", "_self", etc. */
    [@mel.optional]
    formMethod: option(string), /* "post", "get", "put" */
    [@mel.optional]
    headers: option(string),
    [@mel.optional]
    height: option(string), /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
    [@mel.optional]
    high: option(int),
    [@mel.optional]
    href: option(string), /* uri */
    [@mel.optional]
    hrefLang: option(string),
    [@mel.optional]
    htmlFor: option(string), /* substitute for "for" */
    [@mel.optional]
    httpEquiv: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    icon: option(string), /* uri? */
    [@mel.optional]
    inputMode: option(string), /* "verbatim", "latin", "numeric", etc. */
    [@mel.optional]
    integrity: option(string),
    [@mel.optional]
    keyType: option(string),
    [@mel.optional]
    kind: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    label: option(string),
    [@mel.optional]
    list: option(string),
    [@mel.optional]
    loop: option(bool),
    [@mel.optional]
    low: option(int),
    [@mel.optional]
    manifest: option(string), /* uri */
    [@mel.optional]
    max: option(string), /* should be int or Js.Date.t */
    [@mel.optional]
    maxLength: option(int),
    [@mel.optional]
    media: option(string), /* a valid media query */
    [@mel.optional]
    mediaGroup: option(string),
    [@mel.optional]
    method: option(string), /* "post" or "get" */
    [@mel.optional]
    min: option(string),
    [@mel.optional]
    minLength: option(int),
    [@mel.optional]
    multiple: option(bool),
    [@mel.optional]
    muted: option(bool),
    [@mel.optional]
    name: option(string),
    [@mel.optional]
    nonce: option(string),
    [@mel.optional]
    noValidate: option(bool),
    [@mel.optional] [@mel.as "open"]
    open_: option(bool), /* use this one. Previous one is deprecated */
    [@mel.optional]
    optimum: option(int),
    [@mel.optional]
    pattern: option(string), /* valid Js RegExp */
    [@mel.optional]
    placeholder: option(string),
    [@mel.optional]
    playsInline: option(bool),
    [@mel.optional]
    poster: option(string), /* uri */
    [@mel.optional]
    preload: option(string), /* "none", "metadata" or "auto" (and "" as a synonym for "auto") */
    [@mel.optional]
    radioGroup: option(string),
    [@mel.optional]
    readOnly: option(bool),
    [@mel.optional]
    rel: option(string), /* a space- or comma-separated (depending on the element) list of a fixed set of "link types" */
    [@mel.optional]
    required: option(bool),
    [@mel.optional]
    reversed: option(bool),
    [@mel.optional]
    rows: option(int),
    [@mel.optional]
    rowSpan: option(int),
    [@mel.optional]
    sandbox: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    scope: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    scoped: option(bool),
    [@mel.optional]
    scrolling: option(string), /* html4 only, "auto", "yes" or "no" */
    /* seamless - supported by React, but removed from the html5 spec */
    [@mel.optional]
    selected: option(bool),
    [@mel.optional]
    shape: option(string),
    [@mel.optional]
    size: option(int),
    [@mel.optional]
    sizes: option(string),
    [@mel.optional]
    span: option(int),
    [@mel.optional]
    src: option(string), /* uri */
    [@mel.optional]
    srcDoc: option(string),
    [@mel.optional]
    srcLang: option(string),
    [@mel.optional]
    srcSet: option(string),
    [@mel.optional]
    start: option(int),
    [@mel.optional]
    step: option(float),
    [@mel.optional]
    summary: option(string), /* deprecated */
    [@mel.optional]
    target: option(string),
    [@mel.optional] [@mel.as "type"]
    type_: option(string), /* has a fixed but large-ish set of possible values */ /* use this one. Previous one is deprecated */
    [@mel.optional]
    useMap: option(string),
    [@mel.optional]
    value: option(string),
    [@mel.optional]
    width: option(string), /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
    [@mel.optional]
    wrap: option(string), /* "hard" or "soft" */
    /* Clipboard events */
    [@mel.optional]
    onCopy: option(Event.Clipboard.t => unit),
    [@mel.optional]
    onCut: option(Event.Clipboard.t => unit),
    [@mel.optional]
    onPaste: option(Event.Clipboard.t => unit),
    /* Composition events */
    [@mel.optional]
    onCompositionEnd: option(Event.Composition.t => unit),
    [@mel.optional]
    onCompositionStart: option(Event.Composition.t => unit),
    [@mel.optional]
    onCompositionUpdate: option(Event.Composition.t => unit),
    /* Keyboard events */
    [@mel.optional]
    onKeyDown: option(Event.Keyboard.t => unit),
    [@mel.optional]
    onKeyPress: option(Event.Keyboard.t => unit),
    [@mel.optional]
    onKeyUp: option(Event.Keyboard.t => unit),
    /* Focus events */
    [@mel.optional]
    onFocus: option(Event.Focus.t => unit),
    [@mel.optional]
    onBlur: option(Event.Focus.t => unit),
    /* Form events */
    [@mel.optional]
    onChange: option(Event.Form.t => unit),
    [@mel.optional]
    onInput: option(Event.Form.t => unit),
    [@mel.optional]
    onSubmit: option(Event.Form.t => unit),
    [@mel.optional]
    onInvalid: option(Event.Form.t => unit),
    /* Mouse events */
    [@mel.optional]
    onClick: option(Event.Mouse.t => unit),
    [@mel.optional]
    onContextMenu: option(Event.Mouse.t => unit),
    [@mel.optional]
    onDoubleClick: option(Event.Mouse.t => unit),
    [@mel.optional]
    onDrag: option(Event.Drag.t => unit),
    [@mel.optional]
    onDragEnd: option(Event.Drag.t => unit),
    [@mel.optional]
    onDragEnter: option(Event.Drag.t => unit),
    [@mel.optional]
    onDragExit: option(Event.Drag.t => unit),
    [@mel.optional]
    onDragLeave: option(Event.Drag.t => unit),
    [@mel.optional]
    onDragOver: option(Event.Drag.t => unit),
    [@mel.optional]
    onDragStart: option(Event.Drag.t => unit),
    [@mel.optional]
    onDrop: option(Event.Drag.t => unit),
    [@mel.optional]
    onMouseDown: option(Event.Mouse.t => unit),
    [@mel.optional]
    onMouseEnter: option(Event.Mouse.t => unit),
    [@mel.optional]
    onMouseLeave: option(Event.Mouse.t => unit),
    [@mel.optional]
    onMouseMove: option(Event.Mouse.t => unit),
    [@mel.optional]
    onMouseOut: option(Event.Mouse.t => unit),
    [@mel.optional]
    onMouseOver: option(Event.Mouse.t => unit),
    [@mel.optional]
    onMouseUp: option(Event.Mouse.t => unit),
    /* Selection events */
    [@mel.optional]
    onSelect: option(Event.Selection.t => unit),
    /* Touch events */
    [@mel.optional]
    onTouchCancel: option(Event.Touch.t => unit),
    [@mel.optional]
    onTouchEnd: option(Event.Touch.t => unit),
    [@mel.optional]
    onTouchMove: option(Event.Touch.t => unit),
    [@mel.optional]
    onTouchStart: option(Event.Touch.t => unit),
    // Pointer events
    [@mel.optional]
    onPointerOver: option(Event.Pointer.t => unit),
    [@mel.optional]
    onPointerEnter: option(Event.Pointer.t => unit),
    [@mel.optional]
    onPointerDown: option(Event.Pointer.t => unit),
    [@mel.optional]
    onPointerMove: option(Event.Pointer.t => unit),
    [@mel.optional]
    onPointerUp: option(Event.Pointer.t => unit),
    [@mel.optional]
    onPointerCancel: option(Event.Pointer.t => unit),
    [@mel.optional]
    onPointerOut: option(Event.Pointer.t => unit),
    [@mel.optional]
    onPointerLeave: option(Event.Pointer.t => unit),
    [@mel.optional]
    onGotPointerCapture: option(Event.Pointer.t => unit),
    [@mel.optional]
    onLostPointerCapture: option(Event.Pointer.t => unit),
    /* UI events */
    [@mel.optional]
    onScroll: option(Event.UI.t => unit),
    /* Wheel events */
    [@mel.optional]
    onWheel: option(Event.Wheel.t => unit),
    /* Media events */
    [@mel.optional]
    onAbort: option(Event.Media.t => unit),
    [@mel.optional]
    onCanPlay: option(Event.Media.t => unit),
    [@mel.optional]
    onCanPlayThrough: option(Event.Media.t => unit),
    [@mel.optional]
    onDurationChange: option(Event.Media.t => unit),
    [@mel.optional]
    onEmptied: option(Event.Media.t => unit),
    [@mel.optional]
    onEncrypetd: option(Event.Media.t => unit),
    [@mel.optional]
    onEnded: option(Event.Media.t => unit),
    [@mel.optional]
    onError: option(Event.Media.t => unit),
    [@mel.optional]
    onLoadedData: option(Event.Media.t => unit),
    [@mel.optional]
    onLoadedMetadata: option(Event.Media.t => unit),
    [@mel.optional]
    onLoadStart: option(Event.Media.t => unit),
    [@mel.optional]
    onPause: option(Event.Media.t => unit),
    [@mel.optional]
    onPlay: option(Event.Media.t => unit),
    [@mel.optional]
    onPlaying: option(Event.Media.t => unit),
    [@mel.optional]
    onProgress: option(Event.Media.t => unit),
    [@mel.optional]
    onRateChange: option(Event.Media.t => unit),
    [@mel.optional]
    onSeeked: option(Event.Media.t => unit),
    [@mel.optional]
    onSeeking: option(Event.Media.t => unit),
    [@mel.optional]
    onStalled: option(Event.Media.t => unit),
    [@mel.optional]
    onSuspend: option(Event.Media.t => unit),
    [@mel.optional]
    onTimeUpdate: option(Event.Media.t => unit),
    [@mel.optional]
    onVolumeChange: option(Event.Media.t => unit),
    [@mel.optional]
    onWaiting: option(Event.Media.t => unit),
    /* Image events */
    [@mel.optional]onLoad: option(Event.Image.t => unit) /* duplicate */, /*~onError: Event.Image.t => unit=?,*/
    /* Animation events */
    [@mel.optional]
    onAnimationStart: option(Event.Animation.t => unit),
    [@mel.optional]
    onAnimationEnd: option(Event.Animation.t => unit),
    [@mel.optional]
    onAnimationIteration: option(Event.Animation.t => unit),
    /* Transition events */
    [@mel.optional]
    onTransitionEnd: option(Event.Transition.t => unit),
    /* svg */
    [@mel.optional]
    accentHeight: option(string),
    [@mel.optional]
    accumulate: option(string),
    [@mel.optional]
    additive: option(string),
    [@mel.optional]
    alignmentBaseline: option(string),
    [@mel.optional]
    allowReorder: option(string),
    [@mel.optional]
    alphabetic: option(string),
    [@mel.optional]
    amplitude: option(string),
    [@mel.optional]
    arabicForm: option(string),
    [@mel.optional]
    ascent: option(string),
    [@mel.optional]
    attributeName: option(string),
    [@mel.optional]
    attributeType: option(string),
    [@mel.optional]
    autoReverse: option(string),
    [@mel.optional]
    azimuth: option(string),
    [@mel.optional]
    baseFrequency: option(string),
    [@mel.optional]
    baseProfile: option(string),
    [@mel.optional]
    baselineShift: option(string),
    [@mel.optional]
    bbox: option(string),
    [@mel.optional] [@mel.as "begin"]
    begin_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    bias: option(string),
    [@mel.optional]
    by: option(string),
    [@mel.optional]
    calcMode: option(string),
    [@mel.optional]
    capHeight: option(string),
    [@mel.optional]
    clip: option(string),
    [@mel.optional]
    clipPath: option(string),
    [@mel.optional]
    clipPathUnits: option(string),
    [@mel.optional]
    clipRule: option(string),
    [@mel.optional]
    colorInterpolation: option(string),
    [@mel.optional]
    colorInterpolationFilters: option(string),
    [@mel.optional]
    colorProfile: option(string),
    [@mel.optional]
    colorRendering: option(string),
    [@mel.optional]
    contentScriptType: option(string),
    [@mel.optional]
    contentStyleType: option(string),
    [@mel.optional]
    cursor: option(string),
    [@mel.optional]
    cx: option(string),
    [@mel.optional]
    cy: option(string),
    [@mel.optional]
    d: option(string),
    [@mel.optional]
    decelerate: option(string),
    [@mel.optional]
    descent: option(string),
    [@mel.optional]
    diffuseConstant: option(string),
    [@mel.optional]
    direction: option(string),
    [@mel.optional]
    display: option(string),
    [@mel.optional]
    divisor: option(string),
    [@mel.optional]
    dominantBaseline: option(string),
    [@mel.optional]
    dur: option(string),
    [@mel.optional]
    dx: option(string),
    [@mel.optional]
    dy: option(string),
    [@mel.optional]
    edgeMode: option(string),
    [@mel.optional]
    elevation: option(string),
    [@mel.optional]
    enableBackground: option(string),
    [@mel.optional] [@mel.as "end"]
    end_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    exponent: option(string),
    [@mel.optional]
    externalResourcesRequired: option(string),
    [@mel.optional]
    fill: option(string),
    [@mel.optional]
    fillOpacity: option(string),
    [@mel.optional]
    fillRule: option(string),
    [@mel.optional]
    filter: option(string),
    [@mel.optional]
    filterRes: option(string),
    [@mel.optional]
    filterUnits: option(string),
    [@mel.optional]
    floodColor: option(string),
    [@mel.optional]
    floodOpacity: option(string),
    [@mel.optional]
    focusable: option(string),
    [@mel.optional]
    fontFamily: option(string),
    [@mel.optional]
    fontSize: option(string),
    [@mel.optional]
    fontSizeAdjust: option(string),
    [@mel.optional]
    fontStretch: option(string),
    [@mel.optional]
    fontStyle: option(string),
    [@mel.optional]
    fontVariant: option(string),
    [@mel.optional]
    fontWeight: option(string),
    [@mel.optional]
    fomat: option(string),
    [@mel.optional]
    from: option(string),
    [@mel.optional]
    fx: option(string),
    [@mel.optional]
    fy: option(string),
    [@mel.optional]
    g1: option(string),
    [@mel.optional]
    g2: option(string),
    [@mel.optional]
    glyphName: option(string),
    [@mel.optional]
    glyphOrientationHorizontal: option(string),
    [@mel.optional]
    glyphOrientationVertical: option(string),
    [@mel.optional]
    glyphRef: option(string),
    [@mel.optional]
    gradientTransform: option(string),
    [@mel.optional]
    gradientUnits: option(string),
    [@mel.optional]
    hanging: option(string),
    [@mel.optional]
    horizAdvX: option(string),
    [@mel.optional]
    horizOriginX: option(string),
    [@mel.optional]
    ideographic: option(string),
    [@mel.optional]
    imageRendering: option(string),
    [@mel.optional] [@mel.as "in"]
    in_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    in2: option(string),
    [@mel.optional]
    intercept: option(string),
    [@mel.optional]
    k: option(string),
    [@mel.optional]
    k1: option(string),
    [@mel.optional]
    k2: option(string),
    [@mel.optional]
    k3: option(string),
    [@mel.optional]
    k4: option(string),
    [@mel.optional]
    kernelMatrix: option(string),
    [@mel.optional]
    kernelUnitLength: option(string),
    [@mel.optional]
    kerning: option(string),
    [@mel.optional]
    keyPoints: option(string),
    [@mel.optional]
    keySplines: option(string),
    [@mel.optional]
    keyTimes: option(string),
    [@mel.optional]
    lengthAdjust: option(string),
    [@mel.optional]
    letterSpacing: option(string),
    [@mel.optional]
    lightingColor: option(string),
    [@mel.optional]
    limitingConeAngle: option(string),
    [@mel.optional]
    local: option(string),
    [@mel.optional]
    markerEnd: option(string),
    [@mel.optional]
    markerHeight: option(string),
    [@mel.optional]
    markerMid: option(string),
    [@mel.optional]
    markerStart: option(string),
    [@mel.optional]
    markerUnits: option(string),
    [@mel.optional]
    markerWidth: option(string),
    [@mel.optional]
    mask: option(string),
    [@mel.optional]
    maskContentUnits: option(string),
    [@mel.optional]
    maskUnits: option(string),
    [@mel.optional]
    mathematical: option(string),
    [@mel.optional]
    mode: option(string),
    [@mel.optional]
    numOctaves: option(string),
    [@mel.optional]
    offset: option(string),
    [@mel.optional]
    opacity: option(string),
    [@mel.optional]
    operator: option(string),
    [@mel.optional]
    order: option(string),
    [@mel.optional]
    orient: option(string),
    [@mel.optional]
    orientation: option(string),
    [@mel.optional]
    origin: option(string),
    [@mel.optional]
    overflow: option(string),
    [@mel.optional]
    overflowX: option(string),
    [@mel.optional]
    overflowY: option(string),
    [@mel.optional]
    overlinePosition: option(string),
    [@mel.optional]
    overlineThickness: option(string),
    [@mel.optional]
    paintOrder: option(string),
    [@mel.optional]
    panose1: option(string),
    [@mel.optional]
    pathLength: option(string),
    [@mel.optional]
    patternContentUnits: option(string),
    [@mel.optional]
    patternTransform: option(string),
    [@mel.optional]
    patternUnits: option(string),
    [@mel.optional]
    pointerEvents: option(string),
    [@mel.optional]
    points: option(string),
    [@mel.optional]
    pointsAtX: option(string),
    [@mel.optional]
    pointsAtY: option(string),
    [@mel.optional]
    pointsAtZ: option(string),
    [@mel.optional]
    preserveAlpha: option(string),
    [@mel.optional]
    preserveAspectRatio: option(string),
    [@mel.optional]
    primitiveUnits: option(string),
    [@mel.optional]
    r: option(string),
    [@mel.optional]
    radius: option(string),
    [@mel.optional]
    refX: option(string),
    [@mel.optional]
    refY: option(string),
    [@mel.optional]
    renderingIntent: option(string),
    [@mel.optional]
    repeatCount: option(string),
    [@mel.optional]
    repeatDur: option(string),
    [@mel.optional]
    requiredExtensions: option(string),
    [@mel.optional]
    requiredFeatures: option(string),
    [@mel.optional]
    restart: option(string),
    [@mel.optional]
    result: option(string),
    [@mel.optional]
    rotate: option(string),
    [@mel.optional]
    rx: option(string),
    [@mel.optional]
    ry: option(string),
    [@mel.optional]
    scale: option(string),
    [@mel.optional]
    seed: option(string),
    [@mel.optional]
    shapeRendering: option(string),
    [@mel.optional]
    slope: option(string),
    [@mel.optional]
    spacing: option(string),
    [@mel.optional]
    specularConstant: option(string),
    [@mel.optional]
    specularExponent: option(string),
    [@mel.optional]
    speed: option(string),
    [@mel.optional]
    spreadMethod: option(string),
    [@mel.optional]
    startOffset: option(string),
    [@mel.optional]
    stdDeviation: option(string),
    [@mel.optional]
    stemh: option(string),
    [@mel.optional]
    stemv: option(string),
    [@mel.optional]
    stitchTiles: option(string),
    [@mel.optional]
    stopColor: option(string),
    [@mel.optional]
    stopOpacity: option(string),
    [@mel.optional]
    strikethroughPosition: option(string),
    [@mel.optional]
    strikethroughThickness: option(string),
    [@mel.optional]
    string: option(string),
    [@mel.optional]
    stroke: option(string),
    [@mel.optional]
    strokeDasharray: option(string),
    [@mel.optional]
    strokeDashoffset: option(string),
    [@mel.optional]
    strokeLinecap: option(string),
    [@mel.optional]
    strokeLinejoin: option(string),
    [@mel.optional]
    strokeMiterlimit: option(string),
    [@mel.optional]
    strokeOpacity: option(string),
    [@mel.optional]
    strokeWidth: option(string),
    [@mel.optional]
    surfaceScale: option(string),
    [@mel.optional]
    systemLanguage: option(string),
    [@mel.optional]
    tableValues: option(string),
    [@mel.optional]
    targetX: option(string),
    [@mel.optional]
    targetY: option(string),
    [@mel.optional]
    textAnchor: option(string),
    [@mel.optional]
    textDecoration: option(string),
    [@mel.optional]
    textLength: option(string),
    [@mel.optional]
    textRendering: option(string),
    [@mel.optional] [@mel.as "to"]
    to_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    transform: option(string),
    [@mel.optional]
    u1: option(string),
    [@mel.optional]
    u2: option(string),
    [@mel.optional]
    underlinePosition: option(string),
    [@mel.optional]
    underlineThickness: option(string),
    [@mel.optional]
    unicode: option(string),
    [@mel.optional]
    unicodeBidi: option(string),
    [@mel.optional]
    unicodeRange: option(string),
    [@mel.optional]
    unitsPerEm: option(string),
    [@mel.optional]
    vAlphabetic: option(string),
    [@mel.optional]
    vHanging: option(string),
    [@mel.optional]
    vIdeographic: option(string),
    [@mel.optional]
    vMathematical: option(string),
    [@mel.optional]
    values: option(string),
    [@mel.optional]
    vectorEffect: option(string),
    [@mel.optional]
    version: option(string),
    [@mel.optional]
    vertAdvX: option(string),
    [@mel.optional]
    vertAdvY: option(string),
    [@mel.optional]
    vertOriginX: option(string),
    [@mel.optional]
    vertOriginY: option(string),
    [@mel.optional]
    viewBox: option(string),
    [@mel.optional]
    viewTarget: option(string),
    [@mel.optional]
    visibility: option(string),
    /*width::string? =>*/
    [@mel.optional]
    widths: option(string),
    [@mel.optional]
    wordSpacing: option(string),
    [@mel.optional]
    writingMode: option(string),
    [@mel.optional]
    x: option(string),
    [@mel.optional]
    x1: option(string),
    [@mel.optional]
    x2: option(string),
    [@mel.optional]
    xChannelSelector: option(string),
    [@mel.optional]
    xHeight: option(string),
    [@mel.optional]
    xlinkActuate: option(string),
    [@mel.optional]
    xlinkArcrole: option(string),
    [@mel.optional]
    xlinkHref: option(string),
    [@mel.optional]
    xlinkRole: option(string),
    [@mel.optional]
    xlinkShow: option(string),
    [@mel.optional]
    xlinkTitle: option(string),
    [@mel.optional]
    xlinkType: option(string),
    [@mel.optional]
    xmlns: option(string),
    [@mel.optional]
    xmlnsXlink: option(string),
    [@mel.optional]
    xmlBase: option(string),
    [@mel.optional]
    xmlLang: option(string),
    [@mel.optional]
    xmlSpace: option(string),
    [@mel.optional]
    y: option(string),
    [@mel.optional]
    y1: option(string),
    [@mel.optional]
    y2: option(string),
    [@mel.optional]
    yChannelSelector: option(string),
    [@mel.optional]
    z: option(string),
    [@mel.optional]
    zoomAndPan: option(string),
    /* RDFa */
    [@mel.optional]
    about: option(string),
    [@mel.optional]
    datatype: option(string),
    [@mel.optional]
    inlist: option(string),
    [@mel.optional]
    prefix: option(string),
    [@mel.optional]
    property: option(string),
    [@mel.optional]
    resource: option(string),
    [@mel.optional]
    typeof: option(string),
    [@mel.optional]
    vocab: option(string),
    /* react-specific */
    [@mel.optional]
    dangerouslySetInnerHTML: option({. "__html": string}),
    [@mel.optional]
    suppressContentEditableWarning: option(bool),
    [@mel.optional]
    suppressHydrationWarning: option(bool),
  };

  // As we've removed `ReactDOMRe.createElement`, this enables patterns like
  // React.createElement(ReactDOM.stringToComponent(multiline ? "textarea" : "input"), ...)
  external stringToComponent: string => component(domProps) = "%identity";

  [@mel.variadic] [@mel.module "react"]
  external createElement:
    (string, ~props: domProps=?, array(element)) => element =
    "createElement";

  [@mel.variadic] [@mel.module "react"]
  external createDOMElementVariadic:
    (string, ~props: domProps=?, array(element)) => element =
    "createElement";

  [@mel.module "react/jsx-runtime"]
  external jsxKeyed: (string, domProps, ~key: string=?, unit) => element =
    "jsx";

  [@mel.module "react/jsx-runtime"]
  external jsx: (string, domProps) => element = "jsx";

  [@mel.module "react/jsx-runtime"]
  external jsxs: (string, domProps) => element = "jsxs";

  [@mel.module "react/jsx-runtime"]
  external jsxsKeyed: (string, domProps, ~key: string=?, unit) => element =
    "jsxs";
};

module ErrorBoundary: {
  /**
 * Important note on this module:
 * As soon as React provides a mechanism for error-catching using functional component,
 * this is likely to be deprecated and/or move to user space.
 */
  type info = {componentStack: string};

  type params('error) = {
    error: 'error,
    info,
  };

  module React := Types;

  [@react.component]
  let make:
    (~children: element, ~fallback: params('error) => element) => element;
};

module Router: {
  /** update the url with the string path. Example: `push("/book/1")`, `push("/books#title")` */
  let push: string => unit;
  /** update the url with the string path. modifies the current history entry instead of creating a new one. Example: `replace("/book/1")`, `replace("/books#title")` */
  let replace: string => unit;
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
  let dangerouslyGetInitialUrl: (~serverUrlString: string=?, unit) => url;
  /** hook for watching url changes.
 * serverUrl is used for ssr. it allows you to specify the url without relying on browser apis existing/working as expected
 */
  let useUrl: (~serverUrl: url=?, unit) => url;
};
