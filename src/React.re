type element;

[@bs.val] external null: element = "null";

external string: string => element = "%identity";

external array: array(element) => element = "%identity";

type componentLike('props, 'return) = 'props => 'return;

type component('props) = componentLike('props, element);

[@bs.module "react"]
external createElement: (component('props), 'props) => element = "";

[@bs.splice] [@bs.module "react"]
external createElementVariadic:
  (component('props), 'props, array(element)) => element =
  "createElement";

module Ref = {
  type t('value);

  [@bs.get] external current: t('value) => 'value = "current";
  [@bs.set] external setCurrent: (t('value), 'value) => unit = "current";

  type domRef = t(Js.nullable(Dom.element));

  type refForRecordAPI = Js.nullable(Dom.element) => unit;

  /* These are both hacky interop things because React has n different ways of dealing with refs */
  external refForRecordAPI: domRef => refForRecordAPI = "%identity";
  external refForHooks: refForRecordAPI => domRef = "%identity";
};

module Context = {
  type t('props);

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

[@bs.module "react"] external createContext: 'a => Context.t('a) = "";

[@bs.module "react"]
external forwardRef:
  ([@bs.uncurry] (('props, Js.Nullable.t(Ref.t('a))) => element)) =>
  component('props) =
  "";

[@bs.module "react"]
external memo: component('props) => component('props) = "";

[@bs.module "react"]
external memoCustomCompareProps:
  (component('props), [@bs.uncurry] (('props, 'props) => bool)) =>
  component('props) =
  "memo";

module Fragment = {
  [@bs.obj]
  external makeProps:
    (~children: element=?, ~key: 'key=?, unit) =>
    {. "children": option(element)} =
    "";
  [@bs.module "react"]
  external make: component({. "children": option(element)}) = "Fragment";
};

module Suspense = {
  [@bs.obj]
  external makeProps:
    (
      ~children: element=?,
      ~fallback: element=?,
      ~maxDuration: int=?,
      ~key: 'key=?,
      unit
    ) =>
    {
      .
      "children": option(element),
      "fallback": option(element),
      "maxDuration": option(int),
    } =
    "";
  [@bs.module "react"]
  external make:
    component({
      .
      "children": option(element),
      "fallback": option(element),
      "maxDuration": option(int),
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
[@bs.module "react"]
external useState: (unit => 'state) => ('state, ('state => 'state) => unit) =
  "";

[@bs.module "react"]
external useReducer:
  ([@bs.uncurry] (('state, 'action) => 'state), 'state) =>
  ('state, 'action => unit) =
  "";

[@bs.module "react"]
external useReducerWithMapState:
  (
    [@bs.uncurry] (('state, 'action) => 'state),
    'initialState,
    'initialState => 'state
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
external useEffect3: (unit => option(unit => unit), ('a, 'b, 'c)) => unit =
  "useEffect";
[@bs.module "react"]
external useEffect4: (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit =
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
external useMemo3: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c)) => 't =
  "useMemo";
[@bs.module "react"]
external useMemo4: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd)) => 't =
  "useMemo";
[@bs.module "react"]
external useMemo5: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e)) => 't =
  "useMemo";
[@bs.module "react"]
external useMemo6:
  ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f)) => 't =
  "useMemo";

/* This is used as return values  */
type callback('input, 'output) = 'input => 'output;

[@bs.module "react"]
external useCallback:
  ([@bs.uncurry] ('input => 'output)) => callback('intput, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback0:
  ([@bs.uncurry] ('input => 'output), [@bs.as {json|[]|json}] _) =>
  callback('intput, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback1:
  ([@bs.uncurry] ('input => 'output), array('a)) =>
  callback('intput, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback2:
  ([@bs.uncurry] ('input => 'output), ('a, 'b)) => callback('intput, 'output) =
  "useCallback";
[@bs.module "react"]
external useCallback3:
  ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c)) =>
  callback('intput, 'output) =
  "useCallback";

[@bs.module "react"] external useContext: Context.t('any) => 'any = "";

[@bs.module "react"] external useRef: 'value => Ref.t('value) = "";

[@bs.set]
external setDisplayName: (component('props), string) => unit = "displayName";
