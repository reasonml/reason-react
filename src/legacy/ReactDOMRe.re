include ReactDOM.Props;

[@bs.splice] [@bs.module "react"]
external createDOMElementVariadic:
  (string, ~props: domProps=?, array(React.element)) => React.element =
  "createElement";

[@bs.splice] [@bs.val] [@bs.module "react"]
external createElement:
  (string, ~props: props=?, array(React.element)) => React.element =
  "createElement";
