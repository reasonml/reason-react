module type X_int = {let x: int;};

module Func = (M: X_int) => {
  let x = M.x + 1;
  [@react.component]
  let make = (~a, ~b) => {
    print_endline("This function should be named `Test$Func`", M.x);
    <div />;
  };
};
