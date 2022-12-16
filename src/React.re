type element;

[@bs.val] external null: element = "null";

external float: float => element = "%identity";
external int: int => element = "%identity";
external string: string => element = "%identity";

external array: array(element) => element = "%identity";

type componentLike('props, 'return) = 'props => 'return;

type component('props) = componentLike('props, element);

/* this function exists to prepare for making `component` abstract */
external component: componentLike('props, element) => component('props) = "%identity";

[@bs.module "react"]
external createElement: (component('props), 'props) => element =
  "createElement";

[@bs.module "react"]
external cloneElement: (element, 'props) => element = "cloneElement";

[@bs.splice] [@bs.module "react"]
external createElementVariadic:
  (component('props), 'props, array(element)) => element =
  "createElement";

[@bs.module "react"] [@deprecated "Please use JSX syntax directly."]
external jsxKeyed: (component('props), 'props, string) => element = "jsx";

[@bs.module "react"] [@deprecated "Please use JSX syntax directly."]
external jsx: (component('props), 'props) => element = "jsx";

[@bs.module "react"] [@deprecated "Please use JSX syntax directly."]
external jsxs: (component('props), 'props) => element = "jsxs";

[@bs.module "react"] [@deprecated "Please use JSX syntax directly."]
external jsxsKeyed: (component('props), 'props, string) => element = "jsxs";

type ref('value) = {mutable current: 'value};

module Ref = {
  [@deprecated "Please use the type React.ref instead"]
  type t('value) = ref('value);

  [@deprecated "Please directly read from ref.current instead"] [@bs.get]
  external current: ref('value) => 'value = "current";

  [@deprecated "Please directly assign to ref.current instead"] [@bs.set]
  external setCurrent: (ref('value), 'value) => unit = "current";
};

[@bs.module "react"]
external createRef: unit => ref(Js.nullable('a)) = "createRef";

module Children = {
  [@bs.module "react"] [@bs.scope "Children"] [@bs.val]
  external map: (element, element => element) => element = "map";
  [@bs.module "react"] [@bs.scope "Children"] [@bs.val]
  external mapWithIndex:
    (element, [@bs.uncurry] ((element, int) => element)) => element =
    "map";
  [@bs.module "react"] [@bs.scope "Children"] [@bs.val]
  external forEach: (element, element => unit) => unit = "forEach";
  [@bs.module "react"] [@bs.scope "Children"] [@bs.val]
  external forEachWithIndex:
    (element, [@bs.uncurry] ((element, int) => unit)) => unit =
    "forEach";
  [@bs.module "react"] [@bs.scope "Children"] [@bs.val]
  external count: element => int = "count";
  [@bs.module "react"] [@bs.scope "Children"] [@bs.val]
  external only: element => element = "only";
  [@bs.module "react"] [@bs.scope "Children"] [@bs.val]
  external toArray: element => array(element) = "toArray";
};

module Context = {
  type t('props);

  [@bs.obj]
  external makeProps:
    (~value: 'props, ~children: element, unit) =>
    {
      .
      "value": 'props,
      "children": element,
    };

  [@bs.get]
  external provider:
    t('props) =>
    component({
      .
      "value": 'props,
      "children": element,
    }) =
    "Provider";
};

[@bs.module "react"]
external createContext: 'a => Context.t('a) = "createContext";

[@bs.module "react"]
external forwardRef:
  ([@bs.uncurry] (('props, Js.Nullable.t(ref('a))) => element)) =>
  component('props) =
  "forwardRef";

[@bs.module "react"]
external memo: component('props) => component('props) = "memo";

[@bs.module "react"]
external memoCustomCompareProps:
  (component('props), [@bs.uncurry] (('props, 'props) => bool)) =>
  component('props) =
  "memo";

module Fragment = {
  [@bs.obj]
  external makeProps:
    (~children: element, ~key: 'key=?, unit) => {. "children": element};
  [@bs.module "react"]
  external make: component({. "children": element}) = "Fragment";
};

module StrictMode = {
  [@bs.obj]
  external makeProps:
    (~children: element, ~key: 'key=?, unit) => {. "children": element};
  [@bs.module "react"]
  external make: component({. "children": element}) = "StrictMode";
};

module Suspense = {
  [@bs.obj]
  external makeProps:
    (~children: element=?, ~fallback: element=?, ~key: 'key=?, unit) =>
    {
      .
      "children": option(element),
      "fallback": option(element),
    };
  [@bs.module "react"]
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
  [@bs.obj]
  external makeProps:
    (
      ~children: element=?,
      ~revealOrder: [@bs.string] [ | `forwards | `backwards | `together]=?,
      ~tail: [@bs.string] [ | `collapsed | `hidden]=?,
      unit
    ) =>
    {
      .
      "children": option(element),
      "revealOrder": option(revealOrder),
      "tail": option(tail),
    };

  [@bs.module "react"]
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
[@bs.module "react"]
external useState:
  ([@bs.uncurry] (unit => 'state)) => ('state, ('state => 'state) => unit) =
  "useState";

[@bs.module "react"]
external useReducer:
  ([@bs.uncurry] (('state, 'action) => 'state), 'state) =>
  ('state, 'action => unit) =
  "useReducer";

[@bs.module "react"]
external useReducerWithMapState:
  (
    [@bs.uncurry] (('state, 'action) => 'state),
    'initialState,
    [@bs.uncurry] ('initialState => 'state)
  ) =>
  ('state, 'action => unit) =
  "useReducer";

[@bs.module "react"]
external useEffect: ([@bs.uncurry] (unit => option(unit => unit))) => unit =
  "useEffect";
[@bs.module "react"]
external useEffect0:
  ([@bs.uncurry] (unit => option(unit => unit)), [@bs.as {json|[]|json}] _) =>
  unit =
  "useEffect";
[@bs.module "react"]
external useEffect1:
  ([@bs.uncurry] (unit => option(unit => unit)), array('a)) => unit =
  "useEffect";
[@bs.module "react"]
external useEffect2:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b)) => unit =
  "useEffect";
[@bs.module "react"]
external useEffect3:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c)) => unit =
  "useEffect";
[@bs.module "react"]
external useEffect4:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd)) => unit =
  "useEffect";
[@bs.module "react"]
external useEffect5:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd, 'e)) =>
  unit =
  "useEffect";
[@bs.module "react"]
external useEffect6:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd, 'e, 'f)) =>
  unit =
  "useEffect";
[@bs.module "react"]
external useEffect7:
  (
    [@bs.uncurry] (unit => option(unit => unit)),
    ('a, 'b, 'c, 'd, 'e, 'f, 'g)
  ) =>
  unit =
  "useEffect";

[@bs.module "react"]
external useLayoutEffect:
  ([@bs.uncurry] (unit => option(unit => unit))) => unit =
  "useLayoutEffect";
[@bs.module "react"]
external useLayoutEffect0:
  ([@bs.uncurry] (unit => option(unit => unit)), [@bs.as {json|[]|json}] _) =>
  unit =
  "useLayoutEffect";
[@bs.module "react"]
external useLayoutEffect1:
  ([@bs.uncurry] (unit => option(unit => unit)), array('a)) => unit =
  "useLayoutEffect";
[@bs.module "react"]
external useLayoutEffect2:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b)) => unit =
  "useLayoutEffect";
[@bs.module "react"]
external useLayoutEffect3:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c)) => unit =
  "useLayoutEffect";
[@bs.module "react"]
external useLayoutEffect4:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd)) => unit =
  "useLayoutEffect";
[@bs.module "react"]
external useLayoutEffect5:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd, 'e)) =>
  unit =
  "useLayoutEffect";
[@bs.module "react"]
external useLayoutEffect6:
  ([@bs.uncurry] (unit => option(unit => unit)), ('a, 'b, 'c, 'd, 'e, 'f)) =>
  unit =
  "useLayoutEffect";
[@bs.module "react"]
external useLayoutEffect7:
  (
    [@bs.uncurry] (unit => option(unit => unit)),
    ('a, 'b, 'c, 'd, 'e, 'f, 'g)
  ) =>
  unit =
  "useLayoutEffect";

[@bs.module "react"]
external useMemo: ([@bs.uncurry] (unit => 'any)) => 'any = "useMemo";
[@bs.module "react"]
external useMemo0:
  ([@bs.uncurry] (unit => 'any), [@bs.as {json|[]|json}] _) => 'any =
  "useMemo";
[@bs.module "react"]
external useMemo1: ([@bs.uncurry] (unit => 'any), array('a)) => 'any =
  "useMemo";
[@bs.module "react"]
external useMemo2: ([@bs.uncurry] (unit => 'any), ('a, 'b)) => 'any =
  "useMemo";
[@bs.module "react"]
external useMemo3: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c)) => 'any =
  "useMemo";
[@bs.module "react"]
external useMemo4: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd)) => 'any =
  "useMemo";
[@bs.module "react"]
external useMemo5:
  ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e)) => 'any =
  "useMemo";
[@bs.module "react"]
external useMemo6:
  ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f)) => 'any =
  "useMemo";
[@bs.module "react"]
external useMemo7:
  ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'any =
  "useMemo";

/* This is used as return values  */
type callback('input, 'output) = 'input => 'output;

[@bs.module "react"]
external useCallback:
  ([@bs.uncurry] ('input => 'output)) => callback('input, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback0:
  ([@bs.uncurry] ('input => 'output), [@bs.as {json|[]|json}] _) =>
  callback('input, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback1:
  ([@bs.uncurry] ('input => 'output), array('a)) => callback('input, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback2:
  ([@bs.uncurry] ('input => 'output), ('a, 'b)) => callback('input, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback3:
  ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c)) =>
  callback('input, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback4:
  ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd)) =>
  callback('input, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback5:
  ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e)) =>
  callback('input, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback6:
  ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f)) =>
  callback('input, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback7:
  ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) =>
  callback('input, 'output) =
  "useCallback";

[@bs.module "react"]
external useContext: Context.t('any) => 'any = "useContext";

[@bs.module "react"] external useRef: 'value => ref('value) = "useRef";

[@bs.module "react"]
external useImperativeHandle0:
  (
    Js.Nullable.t(ref('value)),
    [@bs.uncurry] (unit => 'value),
    [@bs.as {json|[]|json}] _
  ) =>
  unit =
  "useImperativeHandle";

[@bs.module "react"]
external useImperativeHandle1:
  (Js.Nullable.t(ref('value)), [@bs.uncurry] (unit => 'value), array('a)) =>
  unit =
  "useImperativeHandle";

[@bs.module "react"]
external useImperativeHandle2:
  (Js.Nullable.t(ref('value)), [@bs.uncurry] (unit => 'value), ('a, 'b)) =>
  unit =
  "useImperativeHandle";

[@bs.module "react"]
external useImperativeHandle3:
  (
    Js.Nullable.t(ref('value)),
    [@bs.uncurry] (unit => 'value),
    ('a, 'b, 'c)
  ) =>
  unit =
  "useImperativeHandle";

[@bs.module "react"]
external useImperativeHandle4:
  (
    Js.Nullable.t(ref('value)),
    [@bs.uncurry] (unit => 'value),
    ('a, 'b, 'c, 'd)
  ) =>
  unit =
  "useImperativeHandle";

[@bs.module "react"]
external useImperativeHandle5:
  (
    Js.Nullable.t(ref('value)),
    [@bs.uncurry] (unit => 'value),
    ('a, 'b, 'c, 'd, 'e)
  ) =>
  unit =
  "useImperativeHandle";

[@bs.module "react"]
external useImperativeHandle6:
  (
    Js.Nullable.t(ref('value)),
    [@bs.uncurry] (unit => 'value),
    ('a, 'b, 'c, 'd, 'e, 'f)
  ) =>
  unit =
  "useImperativeHandle";

[@bs.module "react"]
external useImperativeHandle7:
  (
    Js.Nullable.t(ref('value)),
    [@bs.uncurry] (unit => 'value),
    ('a, 'b, 'c, 'd, 'e, 'f, 'g)
  ) =>
  unit =
  "useImperativeHandle";

module Uncurried = {
  [@bs.module "react"]
  external useState:
    ([@bs.uncurry] (unit => 'state)) =>
    ('state, (. ('state => 'state)) => unit) =
    "useState";

  [@bs.module "react"]
  external useReducer:
    ([@bs.uncurry] (('state, 'action) => 'state), 'state) =>
    ('state, (. 'action) => unit) =
    "useReducer";

  [@bs.module "react"]
  external useReducerWithMapState:
    (
      [@bs.uncurry] (('state, 'action) => 'state),
      'initialState,
      [@bs.uncurry] ('initialState => 'state)
    ) =>
    ('state, (. 'action) => unit) =
    "useReducer";

  type callback('input, 'output) = (. 'input) => 'output;

  [@bs.module "react"]
  external useCallback:
    ([@bs.uncurry] ('input => 'output)) => callback('input, 'output) =
    "useCallback";
  [@bs.module "react"]
  external useCallback0:
    ([@bs.uncurry] ('input => 'output), [@bs.as {json|[]|json}] _) =>
    callback('input, 'output) =
    "useCallback";
  [@bs.module "react"]
  external useCallback1:
    ([@bs.uncurry] ('input => 'output), array('a)) =>
    callback('input, 'output) =
    "useCallback";
  [@bs.module "react"]
  external useCallback2:
    ([@bs.uncurry] ('input => 'output), ('a, 'b)) =>
    callback('input, 'output) =
    "useCallback";
  [@bs.module "react"]
  external useCallback3:
    ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c)) =>
    callback('input, 'output) =
    "useCallback";
  [@bs.module "react"]
  external useCallback4:
    ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd)) =>
    callback('input, 'output) =
    "useCallback";
  [@bs.module "react"]
  external useCallback5:
    ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e)) =>
    callback('input, 'output) =
    "useCallback";
  [@bs.module "react"]
  external useCallback6:
    ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f)) =>
    callback('input, 'output) =
    "useCallback";
  [@bs.module "react"]
  external useCallback7:
    ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) =>
    callback('input, 'output) =
    "useCallback";
};

type transitionConfig = {timeoutMs: int};

[@bs.module "react"]
external useTransition:
  (~config: transitionConfig=?, unit) =>
  (callback(callback(unit, unit), unit), bool) =
  "useTransition";

[@bs.set]
external setDisplayName: (component('props), string) => unit = "displayName";

[@bs.get] [@bs.return nullable]
external displayName: component('props) => option(string) = "displayName";
