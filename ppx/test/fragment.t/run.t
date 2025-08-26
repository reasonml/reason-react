  $ ../ppx.sh --output re input.re
  let fragment = foo =>
    [@bla]
    React.jsx(
      React.jsxFragment,
      {
        "children": React.array([|foo|]),
        "nolabel": (),
      },
    );
  let just_one_child = foo =>
    React.jsx(
      React.jsxFragment,
      {
        "children": React.array([|bar|]),
        "nolabel": (),
      },
    );
  let poly_children_fragment = (foo, bar) =>
    React.jsxs(
      React.jsxFragment,
      {
        "children": React.array([|foo, bar|]),
        "nolabel": (),
      },
    );
  let nested_fragment = (foo, bar, baz) =>
    React.jsxs(
      React.jsxFragment,
      {
        "children":
          React.array([|
            foo,
            React.jsxs(
              React.jsxFragment,
              {
                "children": React.array([|bar, baz|]),
                "nolabel": (),
              },
            ),
          |]),
        "nolabel": (),
      },
    );
  let nested_fragment_with_lower = foo =>
    React.jsx(
      React.jsxFragment,
      {
        "children":
          React.array([|
            ReactDOM.jsx(
              "div",
              {
                "children": foo,
                "nolabel": (),
                "nolabel": (),
              },
            ),
          |]),
        "nolabel": (),
      },
    );
