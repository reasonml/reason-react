module External = {
  [@react.component] [@otherAttribute "bla"]
  external component: (~a: int, ~b: string) => React.element =
    {|require("my-react-library").MyReactComponent|};
};
