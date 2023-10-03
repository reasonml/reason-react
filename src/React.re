module DOM = DOM;
module ErrorBoundary = ErrorBoundary;
module Event = Event;
module Router = Router;

type element = Types.element;

external null: element = "null";
external float: float => element = "%identity";
external int: int => element = "%identity";
external string: string => element = "%identity";
external array: array(element) => element = "%identity";

type componentLike('props, 'return) = Types.componentLike('props, 'return);
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

type ref('value) = Types.ref('value) = {mutable current: 'value};

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

module Context = Context;

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

include Hooks;

[@mel.set]
external setDisplayName: (component('props), string) => unit = "displayName";

[@mel.get] [@mel.return nullable]
external displayName: component('props) => option(string) = "displayName";
