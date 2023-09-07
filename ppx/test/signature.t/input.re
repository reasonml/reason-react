module Example = {
  [@react.component]
  external make:
    (
      ~cond: bool,
      ~noWrap: bool=?,
      ~href: string,
      ~id: string=?,
      ~color: color,
      ~mode: linkMode=?,
      ~children: React.element
    ) =>
    React.element;
};

module MyPropIsOptionBool = {
  [@react.component] external make: (~myProp: bool=?) => React.element = "A";
};

module MyPropIsOptionOptionBool = {
  [@react.component] external make: (~myProp: option(bool)=?) => React.element = "B";
};
