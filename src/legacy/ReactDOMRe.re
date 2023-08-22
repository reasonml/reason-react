include ReactDOM.Props;

[@mel.splice] [@mel.module "react"]
external createDOMElementVariadic:
  (string, ~props: domProps=?, array(React.element)) => React.element =
  "createElement";

[@mel.splice] [@mel.module "react"]
external createElement:
  (string, ~props: props=?, array(React.element)) => React.element =
  "createElement";
