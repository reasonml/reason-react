  $ ../ppx.sh --output re input.re
  let upper = React.jsx(Upper.make, Upper.makeProps());
  let upper_prop = React.jsx(Upper.make, Upper.makeProps(~count, ()));
  let upper_children_single = foo =>
    React.jsx(Upper.make, Upper.makeProps(~children=foo, ()));
  let upper_children_multiple = (foo, bar) =>
    React.jsxs(Upper.make, Upper.makeProps(~children=[|foo, bar|], ()));
  let upper_children =
    React.jsx(
      Page.make,
      Page.makeProps(
        ~children=
          ReactDOM.jsx(
            "h1",
            ([@merlin.hide] ReactDOM.domProps)(
              ~children=React.string("Yep"),
              (),
            ),
          ),
        ~moreProps="hgalo",
        (),
      ),
    );
  let upper_nested_module =
    React.jsx(Foo.Bar.make, Foo.Bar.makeProps(~a=1, ~b="1", ()));
  let upper_child_expr =
    React.jsx(Div.make, Div.makeProps(~children=React.int(1), ()));
  let upper_child_ident =
    React.jsx(Div.make, Div.makeProps(~children=lola, ()));
  let upper_all_kinds_of_props =
    React.jsx(
      MyComponent.make,
      MyComponent.makeProps(
        ~children=
          ReactDOM.jsx(
            "div",
            ([@merlin.hide] ReactDOM.domProps)(~children="hello", ()),
          ),
        ~booleanAttribute=true,
        ~stringAttribute="string",
        ~intAttribute=1,
        ~forcedOptional=?Some("hello"),
        ~onClick=send(handleClick),
        (),
      ),
    );
  let upper_ref_with_children =
    React.jsx(
      FancyButton.make,
      FancyButton.makeProps(
        ~children=ReactDOM.jsx("div", ([@merlin.hide] ReactDOM.domProps)()),
        ~ref=buttonRef,
        (),
      ),
    );
