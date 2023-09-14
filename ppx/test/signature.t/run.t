  $ ../ppx.sh --output re input.re
  module Example = {
    [@mel.obj]
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
    [@mel.obj]
    external makeProps:
      (~myProp: bool=?, ~key: string=?, unit) => {. "myProp": option(bool)};
    external make:
      React.componentLike({. "myProp": option(bool)}, React.element) =
      "A";
  };
  module MyPropIsOptionOptionBool = {
    [@mel.obj]
    external makeProps:
      (~myProp: option(bool)=?, ~key: string=?, unit) =>
      {. "myProp": option(option(bool))};
    external make:
      React.componentLike({. "myProp": option(option(bool))}, React.element) =
      "B";
  };
