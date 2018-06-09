[@bs.val] [@bs.module "react-dom/server"]
external renderToString : React.reactElement => string =
  "renderToString";

[@bs.val] [@bs.module "react-dom/server"]
external renderToStaticMarkup : React.reactElement => string =
  "renderToStaticMarkup";
