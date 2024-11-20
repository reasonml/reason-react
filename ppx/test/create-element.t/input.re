module Foo = {
  [@react.component]
  let createElement = (~lola) => <div> {React.string(lola)} </div>;
};

/* This isn't valid running code, since Foo gets transformed into Foo.make, not createElement. */
module Invalid_case = {
  [@react.component]
  let make = (~lola) => {
    <Foo lola />;
  };
};
