module Component_with_x_as_main_function = {
  [@react.component]
  let x = () => <div />;
};

module Component_with_createElement_as_main_function = {
  [@react.component]
  let createElement = (~lola) => <div> {React.string(lola)} </div>;
};

module Parent_rendering = {
  [@react.component]
  let make = () => {
    <Component_with_x_as_main_function.x />;
    <Component_with_createElement_as_main_function lola="lola" />;
  };
};
