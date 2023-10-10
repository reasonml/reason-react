module Greeting: {
  [@react.component]
  let make: (~mockup: string=?) => React.element;
} = {
  [@react.component]
  let make = (~mockup: option(string)=?) => {
    <button> {React.string("Hello!")} </button>;
  };
};

module MyPropIsOptionBool = {
  [@react.component] external make: (~myProp: bool=?) => React.element = "A";
};

module MyPropIsOptionOptionBool = {
  [@react.component]
  external make: (~myProp: option(bool)=?) => React.element = "B";
};

module MyPropIsOptionOptionBoolWithSig: {
  [@react.component]
  external make: (~myProp: option(bool)=?) => React.element = "B";
} = {
  [@react.component]
  external make: (~myProp: option(bool)=?) => React.element = "B";
};

module MyPropIsOptionOptionBoolWithValSig: {
  [@react.component]
  let make: (~myProp: option(bool)=?) => React.element;
} = {
  [@react.component]
  external make: (~myProp: option(bool)=?) => React.element = "B";
};

module MyPropIsOptionOptionBoolLetWithValSig: {
  [@react.component]
  let make: (~myProp: option(bool)=?) => React.element;
} = {
  [@react.component]
  let make = (~myProp: option(option(bool))=?) => React.null;
};
