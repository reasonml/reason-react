open Jest;

external toObject: ReactTestRenderer.t => Js.t({.}) = "%identity";

module Tester = {
  [@react.component]
  let make = () => <div> {React.string("Tester")} </div>;
};

describe("ReactTestRenderer", () => {
  open Expect;

  test("create returns ReactTestInstance", () => {
    let component = ReactTestRenderer.create(<Tester />);
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
    let component = ReactTestRenderer.create(<Tester />);
    let json = ReactTestRenderer.toJSON(component);
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
    let renderer = ReactTestRenderer.Shallow.createRenderer();
    let isDefined =
      renderer
      |> Js.Undefined.return
      |> Js.Undefined.toOption
      |> Option.is_some;
    expect(isDefined)->toBe(true);
  });

  test("render accepts renderer", () => {
    let renderer = ReactTestRenderer.Shallow.createRenderer();
    let render = ReactTestRenderer.Shallow.render(renderer);
    expect(Js.typeof(render))->toEqual("function");
  });

  test("render will render a component", () => {
    let renderer = ReactTestRenderer.Shallow.createRenderer();
    let component =
      ReactTestRenderer.Shallow.render(renderer, <Tester />)->Option.get;
    expect(component == element)->toBe(true);
  });

  test("renderWithRenderer will render a component", () => {
    let component =
      ReactTestRenderer.Shallow.renderWithRenderer(<Tester />)->Option.get;

    expect(component == element)->toBe(true);
  });

  test("getRenderOutput returns element", () => {
    let renderer = ReactTestRenderer.Shallow.createRenderer();

    ReactTestRenderer.Shallow.render(renderer, <Tester />) |> ignore;

    let component =
      ReactTestRenderer.Shallow.getRenderOutput(renderer)->Option.get;

    expect(component == element)->toBe(true);
  });

  test("unmount removes the node", () => {
    let renderer = ReactTestRenderer.Shallow.createRenderer();

    ReactTestRenderer.Shallow.render(renderer, <Tester />) |> ignore;
    ReactTestRenderer.Shallow.unmount(renderer);

    let component =
      ReactTestRenderer.Shallow.getRenderOutput(renderer)
      ->Option.get
      ->Js.Null.return;

    expect(component)->toEqual(Js.null);
  });
});
