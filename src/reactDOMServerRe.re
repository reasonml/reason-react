external renderToString : ReasonReact.reactElement => string =
  "renderToString" [@@bs.val] [@@bs.module "react-dom/server"];

external renderToStaticMarkup : ReasonReact.reactElement => string =
  "renderToStaticMarkup" [@@bs.val] [@@bs.module "react-dom/server"];
