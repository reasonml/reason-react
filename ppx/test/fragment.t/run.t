  $ ../ppx.sh --output re input.re
  let fragment = foo =>
    [@bla] React.DOM.createElement(React.jsxFragment, [|foo|]);
  let poly_children_fragment = (foo, bar) =>
    React.DOM.createElement(React.jsxFragment, [|foo, bar|]);
  let nested_fragment = (foo, bar, baz) =>
    React.DOM.createElement(
      React.jsxFragment,
      [|foo, React.DOM.createElement(React.jsxFragment, [|bar, baz|])|],
    );
  let nested_fragment_with_lower = foo =>
    React.DOM.createElement(
      React.jsxFragment,
      [|
        React.DOM.jsx(
          "div",
          ([@merlin.hide] React.DOM.domProps)(~children=foo, ()),
        ),
      |],
    );
