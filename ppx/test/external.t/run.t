  $ ../ppx.sh --output re input.re
  module External = {
    [@mel.obj]
    external componentProps:
      (~a: int, ~b: string, ~key: string=?, unit) =>
      {
        .
        "a": int,
        "b": string,
      };
    [@otherAttribute "bla"]
    external component:
      React.componentLike(
        {
          .
          "a": int,
          "b": string,
        },
        React.element,
      ) =
      {|require("my-react-library").MyReactComponent|};
  };
