[@mel.module "react-dom/server"]
external renderToString: Types.element => string = "renderToString";

[@mel.module "react-dom/server"]
external renderToStaticMarkup: Types.element => string =
  "renderToStaticMarkup";
