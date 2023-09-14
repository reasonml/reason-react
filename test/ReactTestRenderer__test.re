open Jest;

external toObject: ReactTest.Renderer.t => Js.t({.}) = "%identity";

module Tester = {
  [@react.component]
  let make = () => <div> {React.string("Tester")} </div>;
};

describe("reactTestRenderer", () => {
  open Expect;

  test("create returns ReactTestInstance", () => {
    let component = ReactTest.Renderer.create(<Tester />);
    let keys = Js.Obj.keys(component);

    expect(keys)
    ->toEqual(
        arrayContaining([|
          "_Scheduler",
          "root",
          "toJSON",
          "toTree",
          "update",
          "unmount",
          "unstable_flushSync",
          "getInstance",
        |]),
      );
  });

  test("toJSON returns test rendered JSON", () => {
    let component = ReactTest.Renderer.create(<Tester />);
    let json = ReactTest.Renderer.toJSON(component);
    let expected =
      Js.Json.parseExn(
        {|
      {
        "type": "div",
        "props": {},
        "children": [ "Tester" ]
      }
    |},
      );
    expect(json == expected)->toBe(true);
  });
});

let element = <div> {React.string("Tester")} </div>;

describe("reactShallowRenderer", () => {
  open Expect;

  test("createRenderer", () => {
    let renderer = ReactTest.Renderer.Shallow.createRenderer();
    let isDefined =
      renderer
      |> Js.Undefined.return
      |> Js.Undefined.toOption
      |> Option.is_some;
    expect(isDefined)->toBe(true);
  });

  test("render accepts renderer", () => {
    let renderer = ReactTest.Renderer.Shallow.createRenderer();
    let render = ReactTest.Renderer.Shallow.render(renderer);
    expect(Js.typeof(render))->toEqual("function");
  });

  test("render will render a component", () => {
    let renderer = ReactTest.Renderer.Shallow.createRenderer();
    let component =
      ReactTest.Renderer.Shallow.render(renderer, <Tester />)->Option.get;
    expect(component == element)->toBe(true);
  });

  test("renderWithRenderer will render a component", () => {
    let component =
      ReactTest.Renderer.Shallow.renderWithRenderer(<Tester />)->Option.get;

    expect(component == element)->toBe(true);
  });

  test("getRenderOutput returns element", () => {
    let renderer = ReactTest.Renderer.Shallow.createRenderer();

    ReactTest.Renderer.Shallow.render(renderer, <Tester />) |> ignore;

    let component =
      ReactTest.Renderer.Shallow.getRenderOutput(renderer)->Option.get;

    expect(component == element)->toBe(true);
  });

  test("unmount removes the node", () => {
    let renderer = ReactTest.Renderer.Shallow.createRenderer();

    ReactTest.Renderer.Shallow.render(renderer, <Tester />) |> ignore;
    ReactTest.Renderer.Shallow.unmount(renderer);

    let component =
      ReactTest.Renderer.Shallow.getRenderOutput(renderer)
      ->Option.get
      ->Js.Null.return;

    expect(component)->toEqual(Js.null);
  });
});
