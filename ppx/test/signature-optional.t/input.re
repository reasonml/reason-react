module Greeting: {
  [@react.component]
  let make: (~mockup: string=?) => React.element;
} = {
  [@react.component]
  let make = (~mockup: option(string)=?) => {
    <button> {React.string("Hello!")} </button>;
  };
};
