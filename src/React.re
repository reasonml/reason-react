type element;

external null: element = "null";

external float: float => element = "%identity";
external int: int => element = "%identity";
external string: string => element = "%identity";

external array: array(element) => element = "%identity";

type componentLike('props, 'return) = 'props => 'return;

type component('props) = componentLike('props, element);

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

module Ref = {
  [@deprecated "Please use the type React.ref instead"]
  type t('value) = ref('value);

  [@deprecated "Please directly read from ref.current instead"] [@mel.get]
  external current: ref('value) => 'value = "current";

  [@deprecated "Please directly assign to ref.current instead"] [@mel.set]
  external setCurrent: (ref('value), 'value) => unit = "current";
};

[@mel.module "react"]
external createRef: unit => ref(Js.nullable('a)) = "createRef";

module Children = {
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

module Context = {
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

module Fragment = {
  [@mel.obj]
  external makeProps: (~children: element, unit) => {. "children": element};

  [@mel.module "react"]
  external make: component({. "children": element}) = "Fragment";
};

module StrictMode = {
  [@mel.obj]
  external makeProps: (~children: element, unit) => {. "children": element};
  [@mel.module "react"]
  external make: component({. "children": element}) = "StrictMode";
};

module Suspense = {
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
module SuspenseList = {
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
  ([@mel.uncurry] ('input => 'output), ('a, 'b)) => callback('input, 'output) =
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

module Uncurried = {
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
