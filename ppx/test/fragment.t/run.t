  $ ../ppx.sh --output re input.re
  let fragment = foo => [@bla] React.jsx(React.jsxFragment, [|foo|]);
  let poly_children_fragment = (foo, bar) =>
    React.jsx(React.jsxFragment, [|foo, bar|]);
  let nested_fragment = (foo, bar, baz) =>
    React.jsx(
      React.jsxFragment,
      [|foo, React.jsx(React.jsxFragment, [|bar, baz|])|],
    );
  let nested_fragment_with_lower = foo =>
    React.jsx(
      React.jsxFragment,
      [|
        ReactDOM.jsx(
          "div",
          ([@merlin.hide] ReactDOM.domProps)(~children=foo, ()),
        ),
      |],
    );
