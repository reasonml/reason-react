module X_as_main_function = {
  [@react.component]
  let x = () => <div />;
};

module Create_element_as_main_function = {
  [@react.component]
  let createElement = (~lola) => <div> {React.string(lola)} </div>;
};

/* This isn't valid running code, since Foo gets transformed into Foo.make, not createElement. */
module Invalid_case = {
  [@react.component]
  let make = (~lola) => {
    <Create_element_as_main_function lola />;
  };
};

/* If main function is not make, neither createElement, then it can be explicitly annotated */
/* NOTE: If you use `createElement` refmt removes it */
module Valid_case = {
  [@react.component]
  let make = () => {
    <Component_with_x_as_main_function.x />;
  };
};
