type info = {componentStack: string};

type params('error) = {
  error: 'error,
  info,
};

[@react.component]
let make:
  (~children: React.element, ~fallback: params('error) => React.element) =>
  React.element;
