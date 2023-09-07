module A = {
  [@react.component] [@bs.module "a"] external make: (~myProp: bool=?) => React.element = "A";
};

module B = {
  [@react.component] [@bs.module "b"] external make: (~myProp: option(bool)=?) => React.element = "B";
};
