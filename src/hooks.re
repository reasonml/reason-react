/* HOOKS */

/*
 * Yeah, we know this api isn't great. tl;dr: useReducer instead.
 * It's because useState can take functions or non-function values and treats
 * them differently. Lazy initializer + callback which returns state is the
 * only way to safely have any type of state and be able to update it correctly.
 */

open Types;

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
    ~subscribe: [@mel.uncurry] (unit => unit),
    ~getSnapshot: [@mel.uncurry] (unit => 'snapshot),
    ~getServerSnapshot: [@mel.uncurry] (unit => 'snapshot)=?
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

type callback('input, 'output) = 'input => 'output;
[@mel.module "react"]
external useTransition: unit => (bool, callback(callback(unit, unit), unit)) =
  "useTransition";

[@mel.module "react"] external use: Js.Promise.t('a) => 'a = "use";
