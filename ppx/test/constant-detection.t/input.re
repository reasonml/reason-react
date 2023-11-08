module Foo = {
  [@react.component]
  let make = (~id) => {
    <div key=id> [|<div />, "a"|] "a" 'b' 3 false </div>;
  };
};

module Bar = {
  [@react.component]
  let make = () => {
    let a = 42;
    <div> a </div>;
  };
};
