include ReactDOM.Props;

[@bs.splice] [@bs.module "react"]
external createDOMElementVariadic:
  (string, ~props: domProps=?, array(React.element)) => React.element =
  "createElement";
