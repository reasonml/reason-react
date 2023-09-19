  $ ../ppx.sh --output re input.re
  let fragment = foo =>
    [@bla] ReactDOM.createElement(React.jsxFragment, [|foo|]);
  let poly_children_fragment = (foo, bar) =>
    ReactDOM.createElement(React.jsxFragment, [|foo, bar|]);
  let nested_fragment = (foo, bar, baz) =>
    ReactDOM.createElement(
      React.jsxFragment,
      [|foo, ReactDOM.createElement(React.jsxFragment, [|bar, baz|])|],
    );
  let nested_fragment_with_lower = foo =>
    ReactDOM.createElement(
      React.jsxFragment,
      [|
        ReactDOM.jsx(
          "div",
          ([@merlin.hide] ReactDOM.domProps)(~children=foo, ()),
        ),
      |],
    );
