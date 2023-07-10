type t;

[@bs.module "react-test-renderer"] [@bs.val] external create :
  React.element => t = "create";

[@bs.send] external toJSON :
  t => Js.Json.t = "toJSON";

module Shallow = {
  type t;

  [@bs.module "react-test-renderer/shallow"] [@bs.val] external createRenderer :
    unit => t = "createRenderer";

  [@bs.send] external render :
    t => React.element => option(React.element) = "render";

  [@bs.send] external getRenderOutput :
    t => option(React.element) = "getRenderOutput";

  [@bs.send] external unmount :
    t => unit = "unmount";

  let renderWithRenderer = render(createRenderer());
}
