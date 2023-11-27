[@deriving abstract]
type options = {
  [@mel.optional]
  bootstrapScriptContent: option(string),
  [@mel.optional]
  bootstrapScripts: option(array(string)),
  [@mel.optional]
  bootstrapModules: option(array(string)),
  [@mel.optional]
  identifierPrefix: option(string),
  [@mel.optional]
  namespaceURI: option(string),
  [@mel.optional]
  nonce: option(string),
  [@mel.optional]
  onAllReady: option(unit => unit),
  [@mel.optional]
  onError: option(Js.Exn.t => unit),
  [@mel.optional]
  onShellReady: option(unit => unit),
  [@mel.optional]
  onShellError: option(Js.Exn.t => unit),
  [@mel.optional]
  progressiveChunkSize: option(int),
};

type pipeableStream = {
  /* Using empty object instead of Node.stream since Melange don't provide a binding to node's Stream (https://nodejs.org/api/stream.html) */
  pipe: Js.t({.}) => unit,
  abort: unit => unit,
};

[@mel.module "react-dom/server"]
external renderToPipeableStream: (React.element, options) => pipeableStream =
  "renderToPipeableStream";

let renderToPipeableStream =
    (
      ~bootstrapScriptContent=?,
      ~bootstrapScripts=?,
      ~bootstrapModules=?,
      ~identifierPrefix=?,
      ~namespaceURI=?,
      ~nonce=?,
      ~onAllReady=?,
      ~onError=?,
      ~onShellReady=?,
      ~onShellError=?,
      ~progressiveChunkSize=?,
      element,
    ) =>
  renderToPipeableStream(
    element,
    options(
      ~bootstrapScriptContent?,
      ~bootstrapScripts?,
      ~bootstrapModules?,
      ~identifierPrefix?,
      ~namespaceURI?,
      ~nonce?,
      ~onAllReady?,
      ~onError?,
      ~onShellReady?,
      ~onShellError?,
      ~progressiveChunkSize?,
      (),
    ),
  );
