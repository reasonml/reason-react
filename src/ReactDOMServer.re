[@mel.module "react-dom/server"]
external renderToString: React.element => string = "renderToString";

[@mel.module "react-dom/server"]
external renderToStaticMarkup: React.element => string =
  "renderToStaticMarkup";
