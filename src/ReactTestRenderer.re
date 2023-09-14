type t;

[@mel.module "react-test-renderer"]
external create: React.element => t = "create";

[@mel.send] external toJSON: t => Js.Json.t = "toJSON";

module Shallow = {
  type t;

  [@mel.module "react-test-renderer/shallow"]
  external createRenderer: unit => t = "createRenderer";

  [@mel.send]
  external render: (t, React.element) => option(React.element) = "render";

  [@mel.send]
  external getRenderOutput: t => option(React.element) = "getRenderOutput";

  [@mel.send] external unmount: t => unit = "unmount";

  let renderWithRenderer = render(createRenderer());
};
