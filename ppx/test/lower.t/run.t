  $ ../ppx.sh --output re input.re
  let lower =
    ReactDOM.jsx(
      "div",
      {
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_empty_attr =
    ReactDOM.jsx(
      "div",
      {
        "className": "",
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_inline_styles =
    ReactDOM.jsx(
      "div",
      {
        "style": ReactDOM.Style.make(~backgroundColor="gainsboro", ()),
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_inner_html =
    ReactDOM.jsx(
      "div",
      {
        "dangerouslySetInnerHTML": {
          "__html": text,
        },
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_opt_attr =
    ReactDOM.jsx(
      "div",
      {
        "tabIndex": tabIndex,
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lowerWithChildAndProps = foo =>
    ReactDOM.jsx(
      "a",
      {
        "children": foo,
        "tabIndex": 1,
        "href": "https://example.com",
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_child_static =
    ReactDOM.jsx(
      "div",
      {
        "children":
          ReactDOM.jsx(
            "span",
            {
              "nolabel": (),
              "nolabel": (),
            },
          ),
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_child_ident =
    ReactDOM.jsx(
      "div",
      {
        "children": lolaspa,
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_child_single =
    ReactDOM.jsx(
      "div",
      {
        "children":
          ReactDOM.jsx(
            "div",
            {
              "nolabel": (),
              "nolabel": (),
            },
          ),
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_children_multiple = (foo, bar) =>
    ReactDOM.jsxs(
      "lower",
      {
        "children": React.array([|foo, bar|]),
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_child_with_upper_as_children =
    ReactDOM.jsx(
      "div",
      {
        "children": React.jsx(App.make, App.makeProps()),
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_children_nested =
    ReactDOM.jsx(
      "div",
      {
        "children":
          ReactDOM.jsxs(
            "div",
            {
              "children":
                React.array([|
                  ReactDOM.jsx(
                    "h2",
                    {
                      "children": "jsoo-react" |> s,
                      "className": "title",
                      "nolabel": (),
                      "nolabel": (),
                    },
                  ),
                  ReactDOM.jsx(
                    "nav",
                    {
                      "children":
                        ReactDOM.jsx(
                          "ul",
                          {
                            "children":
                              examples
                              |> List.map(e => {
                                   let Key = e.path;
                                   ReactDOM.jsxKeyed(
                                     ~key=Key,
                                     "li",
                                     {
                                       "children":
                                         ReactDOM.jsx(
                                           "a",
                                           {
                                             "children": e.title |> s,
                                             "href": e.path,
                                             "onClick": event => {
                                               ReactEvent.Mouse.preventDefault(
                                                 event,
                                               );
                                               ReactRouter.push(e.path);
                                             },
                                             "nolabel": (),
                                             "nolabel": (),
                                           },
                                         ),
                                       "nolabel": (),
                                       "nolabel": (),
                                     },
                                     (),
                                   );
                                 })
                              |> React.list,
                            "nolabel": (),
                            "nolabel": (),
                          },
                        ),
                      "className": "menu",
                      "nolabel": (),
                      "nolabel": (),
                    },
                  ),
                |]),
              "className": "sidebar",
              "nolabel": (),
              "nolabel": (),
            },
          ),
        "className": "flex-container",
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_ref_with_children =
    ReactDOM.jsx(
      "button",
      {
        "children": children,
        "ref": ref,
        "className": "FancyButton",
        "nolabel": (),
        "nolabel": (),
      },
    );
  let lower_with_many_props =
    ReactDOM.jsx(
      "div",
      {
        "children":
          ReactDOM.jsxs(
            "picture",
            {
              "children":
                React.array([|
                  ReactDOM.jsx(
                    "img",
                    {
                      "src": "picture/img.png",
                      "alt": "test picture/img.png",
                      "id": "idimg",
                      "nolabel": (),
                      "nolabel": (),
                    },
                  ),
                  ReactDOM.jsx(
                    "source",
                    {
                      "type_": "image/webp",
                      "src": "picture/img1.webp",
                      "nolabel": (),
                      "nolabel": (),
                    },
                  ),
                  ReactDOM.jsx(
                    "source",
                    {
                      "type_": "image/jpeg",
                      "src": "picture/img2.jpg",
                      "nolabel": (),
                      "nolabel": (),
                    },
                  ),
                |]),
              "id": "idpicture",
              "nolabel": (),
              "nolabel": (),
            },
          ),
        "translate": "yes",
        "nolabel": (),
        "nolabel": (),
      },
    );
  let some_random_html_element =
    ReactDOM.jsx(
      "text",
      {
        "dx": "1 2",
        "dy": "3 4",
        "nolabel": (),
        "nolabel": (),
      },
    );
