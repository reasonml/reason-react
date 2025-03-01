[@mel.module "react-server-dom-webpack/client"]
external createFromReadableStream:
  Js.ReadableStream.t => Js.Promise.t(React.element) =
  "createFromReadableStream";

[@mel.module "react-server-dom-webpack/client"]
external createFromFetch: Js.Promise.t(Js.Fetch.response) => React.element =
  "createFromFetch";
