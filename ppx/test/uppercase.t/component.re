module Box = {
  [@react.component]
  let make = (~children) => {
    <div>
      {children}
    </div>;
  };
};

module Uppercase = {
  [@react.component]
  let make = (~children) => {
    <Box>
      {children}
    </Box>;
  };
};
