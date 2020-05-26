[@bs.module "react-dom/server"]
external renderToString: React.element => string = "renderToString";

[@bs.module "react-dom/server"]
external renderToStaticMarkup: React.element => string =
  "renderToStaticMarkup";
