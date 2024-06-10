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

[@mel.scope "Object"] external objCreate: 'a => Js.t({..}) = "create";

[@ocaml.warning "-69"]
type state('error) = {error: params('error)};
type reactComponentClass;

[@mel.module "react"] external component: reactComponentClass = "Component";
[@mel.send] external componentCall: (reactComponentClass, _) => unit = "call";

type componentPrototype;
[@mel.get]
external componentPrototype: reactComponentClass => componentPrototype =
  "prototype";

[@ocaml.warning "-21"]
let errorBoundary =
  [@mel.this]
  (
    (self, _props) => {
      componentCall(component, self);
      self##state #= {"error": Js.undefined};
    }
  );

[@mel.set] external setPrototype: (_, _) => unit = "prototype";
setPrototype(errorBoundary, objCreate(componentPrototype(component)));

[@mel.set] [@mel.scope "prototype"]
external setComponentDidCatch:
  (_, [@mel.this] (('self, 'error, 'info) => unit)) => unit =
  "componentDidCatch";

setComponentDidCatch(errorBoundary, [@mel.this] (self, error, info) => {
  self##setState({
    error: {
      error,
      info,
    },
  })
});

[@mel.set] [@mel.scope "prototype"]
external setRender: (_, [@mel.this] ('self => unit)) => unit = "render";
setRender(errorBoundary, [@mel.this] self => {
  switch (Js.Undefined.testAny(self##state##error)) {
  | false => self##props##fallback(self##state##error)
  | true => self##props##children
  }
});

[@react.component]
external make:
  (~children: React.element, ~fallback: params('error) => React.element) =>
  React.element =
  "errorBoundary";

let make = make;
