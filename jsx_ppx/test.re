[@bs.config {jsx: 3}];

[@react.component]
let make = (~a, ~b, _) => {
    Js.log("This function should be named `Test`");
    <div />
};


module Foo = {
    [@react.component]
    [@bs.module "Foo"]
    external component: (~a:int, ~b:string, _) => React.element = "";
};

// <Foo.component a=1 b="1" />;

module Bar = {
    [@react.component]
    let make = (~a, ~b, _) => {
        Js.log("This function should be named `Test$Bar`");
        <div />
    };
    [@react.component]
    let component = (~a, ~b, _) => {
        Js.log("This function should be named `Test$Bar$component`");
        <div />
    };
}

module type X_int = {
    let x: int;
};

module Func = (M: X_int) => {
    let x = M.x + 1;
    [@react.component]
    let make = React.forwardRef((~a, ~b, ref) => {
        Js.log("This function should be named `Test$Func`", M.x);
        <div ref />
    });
};



[@react.component]
let make = (~a=1, ~b=?, _) => {
    Js.log("This function should be named `Test`");
    <div />
};


[@react.component]
[@bs.module "Foo"]
external component: (~a:int=?, ~b:string, ~c:option(Js.Nullable.t(Js.t(foo)))=?, _) => React.element = ""; 


[@react.component]
let make = (~a=1, ~b=?, _) => {
    <div />
};

module Issue369Optionals = {
  module One = {
    [@react.component]
    let make = (~prop: string="") => React.null;
  };

  module Two = {
    [@react.component]
    let make = (~prop: option(string)="") => React.null;
  };

  module All = {
    [@react.component]
    let make = (
      ~labelled,
      ~labelledT: string,
      ~optional=?,
      ~optionalT: option(string)=?,
      ~default="",
      ~defaultT: string="",
    ) => React.null;
  };

  let one = <One prop="foo" />;
  let two = <Two prop=Some("foo") />;
};


module Recursive = {
  module One = {
    [@react.component]
    let rec make = (~prop1, ~prop2) => {
      prop2
      ? <div onClick={_ => prop1(prop2)}> {React.string("Cities")} </div>
      : React.createElement(component, componentProps(~prop1, ~prop2, ()));
    }
    [@react.component]
    and component = (~prop1, ~prop2) => {
      <div onClick={_ => prop1(prop2)}> {React.string("Cities")} </div>;
    };
  };

  let one = <One prop=(_ => ()) prop2=false />;
};

module Issue378Destructuring = {
  module One = {
    [@react.component]
    let make = (~tuple as (a, b)) => React.null;
  };

  let one = <One tuple={(1, 2)} />;
};

module Blocks = {
  module One = {
    [@react.component]
    let make = {
      let foo = 1;
      Js.log(foo);
      (~prop) => React.null;
    };
  };

  let one = <One prop=1 />;
};

module Error = {
  module MiniHelmetJsCompat = {
    [@bs.module "react-helmet"]
    external make: (~title: string=?) => React.element = "default";
  };

  [@react.component]
  let make = (~title: string=?) => {
    MiniHelmetJsCompat.make(~title);
  };
};