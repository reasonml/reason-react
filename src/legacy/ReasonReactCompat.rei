[@deprecated "The compat layer is going to be removed in the next version"]
let wrapReactForReasonReact:
  (React.component('props), 'props, 'children) =>
  ReasonReact.component(
    ReasonReact.stateless,
    ReasonReact.noRetainedProps,
    ReasonReact.actionless,
  );

[@deprecated "The compat layer is going to be removed in the next version"]
let wrapReasonReactForReact:
  (
    ~component: ReasonReact.componentSpec('a, 'b, 'c, 'd, 'e),
    ReasonReact.jsPropsToReason('props, 'g, 'h, 'i)
  ) =>
  React.component('props);
