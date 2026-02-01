  $ bash ../ppx.sh --output re input.re
  let lower = ReactDOM.jsx("div", ([@merlin.hide] ReactDOM.domProps)());
  let lower_empty_attr =
    ReactDOM.jsx("div", ([@merlin.hide] ReactDOM.domProps)(~className="", ()));
  let lower_inline_styles =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~style=ReactDOM.Style.make(~backgroundColor="gainsboro", ()),
        (),
      ),
    );
  let lower_inner_html =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~dangerouslySetInnerHTML={ "__html": text },
        (),
      ),
    );
  let lower_opt_attr =
    ReactDOM.jsx("div", ([@merlin.hide] ReactDOM.domProps)(~tabIndex?, ()));
  let lowerWithChildAndProps = foo =>
    ReactDOM.jsx(
      "a",
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=foo,
        ~tabIndex=1,
        ~href="https://example.com",
        (),
      ),
    );
  let lower_child_static =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=ReactDOM.jsx("span", ([@merlin.hide] ReactDOM.domProps)()),
        (),
      ),
    );
  let lower_child_ident =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(~children=lolaspa, ()),
    );
  let lower_child_single =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=ReactDOM.jsx("div", ([@merlin.hide] ReactDOM.domProps)()),
        (),
      ),
    );
  let lower_children_multiple = (foo, bar) =>
    ReactDOM.jsxs(
      "lower",
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=React.array([|foo, bar|]),
        (),
      ),
    );
  let lower_child_with_upper_as_children =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=React.jsx(App.make, App.makeProps()),
        (),
      ),
    );
  let lower_children_nested =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=
          ReactDOM.jsxs(
            "div",
            ([@merlin.hide] ReactDOM.domProps)(
              ~children=
                React.array([|
                  ReactDOM.jsx(
                    "h2",
                    ([@merlin.hide] ReactDOM.domProps)(
                      ~children="jsoo-react" |> s,
                      ~className="title",
                      (),
                    ),
                  ),
                  ReactDOM.jsx(
                    "nav",
                    ([@merlin.hide] ReactDOM.domProps)(
                      ~children=
                        ReactDOM.jsx(
                          "ul",
                          ([@merlin.hide] ReactDOM.domProps)(
                            ~children=
                              examples
                              |> List.map(e => {
                                   let Key = e.path;
                                   ReactDOM.jsxKeyed(
                                     ~key=Key,
                                     "li",
                                     ([@merlin.hide] ReactDOM.domProps)(
                                       ~children=
                                         ReactDOM.jsx(
                                           "a",
                                           ([@merlin.hide] ReactDOM.domProps)(
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
                                 })
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
    ReactDOM.jsx(
      "button",
      ([@merlin.hide] ReactDOM.domProps)(
        ~children,
        ~ref,
        ~className="FancyButton",
        (),
      ),
    );
  let lower_with_many_props =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~children=
          ReactDOM.jsxs(
            "picture",
            ([@merlin.hide] ReactDOM.domProps)(
              ~children=
                React.array([|
                  ReactDOM.jsx(
                    "img",
                    ([@merlin.hide] ReactDOM.domProps)(
                      ~src="picture/img.png",
                      ~alt="test picture/img.png",
                      ~id="idimg",
                      (),
                    ),
                  ),
                  ReactDOM.jsx(
                    "source",
                    ([@merlin.hide] ReactDOM.domProps)(
                      ~type_="image/webp",
                      ~src="picture/img1.webp",
                      (),
                    ),
                  ),
                  ReactDOM.jsx(
                    "source",
                    ([@merlin.hide] ReactDOM.domProps)(
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
    ReactDOM.jsx(
      "text",
      ([@merlin.hide] ReactDOM.domProps)(~dx="1 2", ~dy="3 4", ()),
    );
