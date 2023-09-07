Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ refmt --parse re --print ml input.re > output.ml
  $ reason-react-ppx --impl output.ml -o temp.ml
  $ refmt --parse ml --print re temp.ml
  module Example = {
    [@bs.obj]
    external makeProps:
      (
        ~cond: bool,
        ~noWrap: bool=?,
        ~href: string,
        ~id: string=?,
        ~color: color,
        ~mode: linkMode=?,
        ~children: React.element,
        ~key: string=?,
        unit
      ) =>
      {
        .
        "cond": bool,
        "noWrap": option(bool),
        "href": string,
        "id": option(string),
        "color": color,
        "mode": option(linkMode),
        "children": React.element,
      };
    external make:
      React.componentLike(
        {
          .
          "cond": bool,
          "noWrap": option(bool),
          "href": string,
          "id": option(string),
          "color": color,
          "mode": option(linkMode),
          "children": React.element,
        },
        React.element,
      );
  };
  module MyPropIsOptionBool = {
    [@bs.obj]
    external makeProps:
      (~myProp: bool=?, ~key: string=?, unit) => {. "myProp": option(bool)};
    external make:
      React.componentLike({. "myProp": option(bool)}, React.element) =
      "A";
  };
  module MyPropIsOptionOptionBool = {
    [@bs.obj]
    external makeProps:
      (~myProp: option(bool)=?, ~key: string=?, unit) =>
      {. "myProp": option(option(bool))};
    external make:
      React.componentLike({. "myProp": option(option(bool))}, React.element) =
      "B";
  };
