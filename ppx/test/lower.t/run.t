  $ ../ppx.sh --output re input.re
  let lower = React.DOM.jsx("div", ([@merlin.hide] React.DOM.domProps)());
  let lower_empty_attr =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(~className="", ()),
    );
  let lower_inline_styles =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(
        ~style=ReactDOM.Style.make(~backgroundColor="gainsboro", ()),
        (),
      ),
    );
  let lower_inner_html =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(
        ~dangerouslySetInnerHTML={"__html": text},
        (),
      ),
    );
  let lower_opt_attr =
    React.DOM.jsx("div", ([@merlin.hide] React.DOM.domProps)(~tabIndex?, ()));
  let lowerWithChildAndProps = foo =>
    React.DOM.jsx(
      "a",
      ([@merlin.hide] React.DOM.domProps)(
        ~children=foo,
        ~tabIndex=1,
        ~href="https://example.com",
        (),
      ),
    );
  let lower_child_static =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(
        ~children=React.DOM.jsx("span", ([@merlin.hide] React.DOM.domProps)()),
        (),
      ),
    );
  let lower_child_ident =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(~children=lolaspa, ()),
    );
  let lower_child_single =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(
        ~children=React.DOM.jsx("div", ([@merlin.hide] React.DOM.domProps)()),
        (),
      ),
    );
  let lower_children_multiple = (foo, bar) =>
    React.DOM.jsxs(
      "lower",
      ([@merlin.hide] React.DOM.domProps)(
        ~children=React.array([|foo, bar|]),
        (),
      ),
    );
  let lower_child_with_upper_as_children =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(
        ~children=React.jsx(App.make, App.makeProps()),
        (),
      ),
    );
  let lower_children_nested =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(
        ~children=
          React.DOM.jsxs(
            "div",
            ([@merlin.hide] React.DOM.domProps)(
              ~children=
                React.array([|
                  React.DOM.jsx(
                    "h2",
                    ([@merlin.hide] React.DOM.domProps)(
                      ~children="jsoo-react" |> s,
                      ~className="title",
                      (),
                    ),
                  ),
                  React.DOM.jsx(
                    "nav",
                    ([@merlin.hide] React.DOM.domProps)(
                      ~children=
                        React.DOM.jsx(
                          "ul",
                          ([@merlin.hide] React.DOM.domProps)(
                            ~children=
                              examples
                              |> List.map(e =>
                                   let Key = e.path;
                                   React.DOM.jsxKeyed(
                                     ~key=Key,
                                     "li",
                                     ([@merlin.hide] React.DOM.domProps)(
                                       ~children=
                                         React.DOM.jsx(
                                           "a",
                                           ([@merlin.hide] React.DOM.domProps)(
                                             ~children=e.title |> s,
                                             ~href=e.path,
                                             ~onClick=
                                               event => {
                                                 ReactEvent.Mouse.preventDefault(
                                                   event,
                                                 );
                                                 ReactRouter.push(e.path);
                                               },
                                             (),
                                           ),
                                         ),
                                       (),
                                     ),
                                     (),
                                   );
                                 )
                              |> React.list,
                            (),
                          ),
                        ),
                      ~className="menu",
                      (),
                    ),
                  ),
                |]),
              ~className="sidebar",
              (),
            ),
          ),
        ~className="flex-container",
        (),
      ),
    );
  let lower_ref_with_children =
    React.DOM.jsx(
      "button",
      ([@merlin.hide] React.DOM.domProps)(
        ~children,
        ~ref,
        ~className="FancyButton",
        (),
      ),
    );
  let lower_with_many_props =
    React.DOM.jsx(
      "div",
      ([@merlin.hide] React.DOM.domProps)(
        ~children=
          React.DOM.jsxs(
            "picture",
            ([@merlin.hide] React.DOM.domProps)(
              ~children=
                React.array([|
                  React.DOM.jsx(
                    "img",
                    ([@merlin.hide] React.DOM.domProps)(
                      ~src="picture/img.png",
                      ~alt="test picture/img.png",
                      ~id="idimg",
                      (),
                    ),
                  ),
                  React.DOM.jsx(
                    "source",
                    ([@merlin.hide] React.DOM.domProps)(
                      ~type_="image/webp",
                      ~src="picture/img1.webp",
                      (),
                    ),
                  ),
                  React.DOM.jsx(
                    "source",
                    ([@merlin.hide] React.DOM.domProps)(
                      ~type_="image/jpeg",
                      ~src="picture/img2.jpg",
                      (),
                    ),
                  ),
                |]),
              ~id="idpicture",
              (),
            ),
          ),
        ~translate="yes",
        (),
      ),
    );
  let some_random_html_element =
    React.DOM.jsx(
      "text",
      ([@merlin.hide] React.DOM.domProps)(~dx="1 2", ~dy="3 4", ()),
    );
