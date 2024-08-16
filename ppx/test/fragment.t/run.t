  $ ../ppx.sh --output re input.re
  let fragment = foo =>
    [@bla]
    React.jsx(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(~children=React.array([|foo|]), ()),
    );
  let just_one_child = foo =>
    React.jsx(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(~children=React.array([|bar|]), ()),
    );
  let poly_children_fragment = (foo, bar) =>
    React.jsxs(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=React.array([|foo, bar|]),
        (),
      ),
    );
  let nested_fragment = (foo, bar, baz) =>
    React.jsxs(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=
          React.array([|
            foo,
            React.jsxs(
              React.jsxFragment,
              ([@merlin.hide] ReactDOM.domProps)(
                ~children=React.array([|bar, baz|]),
                (),
              ),
            ),
          |]),
        (),
      ),
    );
  let nested_fragment_with_lower = foo =>
    React.jsx(
      React.jsxFragment,
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=
          React.array([|
            ReactDOM.jsx(
              "div",
              ([@merlin.hide] ReactDOM.domProps)(~children=foo, ()),
            ),
          |]),
        (),
      ),
    );
