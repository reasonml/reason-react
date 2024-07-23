module Foo = {
  [@react.component]
  let createElement = (~lola) => <div> {React.string(lola)} </div>;
};

module Bar = {
  [@react.component]
  let make = (~lola) => {
    <Foo lola />;
  };
};
