  $ ../ppx.sh --output re input.re
  let fragment = foo =>
    [@bla]
    React.jsx(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(~children=[|foo|], ()),
    );
  let poly_children_fragment = (foo, bar) =>
    React.jsx(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(~children=[|foo, bar|], ()),
    );
  let nested_fragment = (foo, bar, baz) =>
    React.jsx(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=[|
          foo,
          React.jsx(
            React.jsxFragment,
            ([@merlin.hide] ReactDOM.domProps)(~children=[|bar, baz|], ()),
          ),
        |],
        (),
      ),
    );
  let nested_fragment_with_lower = foo =>
    React.jsx(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=[|
          ReactDOM.jsx(
            "div",
            ([@merlin.hide] ReactDOM.domProps)(~children=foo, ()),
          ),
        |],
        (),
      ),
    );
