Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ refmt --parse re --print ml input.re > output.ml
  $ reason-react-ppx --impl output.ml -o temp.ml
  $ refmt --parse ml --print re temp.ml
  module A = {
    [@bs.obj]
    external makeProps:
      (~myProp: bool=?, ~key: string=?, unit) => {. "myProp": option(bool)};
    [@bs.module "a"]
    external make:
      React.componentLike({. "myProp": option(bool)}, React.element) =
      "A";
  };
  module B = {
    [@bs.obj]
    external makeProps:
      (~myProp: option(bool)=?, ~key: string=?, unit) =>
      {. "myProp": option(option(bool))};
    [@bs.module "b"]
    external make:
      React.componentLike({. "myProp": option(option(bool))}, React.element) =
      "B";
  };
