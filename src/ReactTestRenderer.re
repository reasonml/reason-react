type t;

[@mel.module "react-test-renderer"]
external create: React.element('a) => t = "create";

[@mel.send] external toJSON: t => Js.Json.t = "toJSON";
[@mel.send] external toObject: t => Js.t({..}) = "%identity";

module Shallow = {
  type t;

  [@mel.module "react-test-renderer/shallow"]
  external createRenderer: unit => t = "createRenderer";

  [@mel.send]
  external render: (t, React.element('a)) => option(React.element('a)) =
    "render";

  [@mel.send]
  external getRenderOutput: t => option(React.element('a)) =
    "getRenderOutput";

  [@mel.send] external unmount: t => unit = "unmount";

  let renderWithRenderer = value => render(createRenderer(), value);
};
