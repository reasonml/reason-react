open Jest;
open Expect;

module Button_with_ref = {
  [@react.component]
  let make = (~children, ~ref) => {
    <button ref role="FancyButton"> children </button>;
  };
};

let getByRole = (role, container) => {
  ReactTestingLibrary.getByRole(~matcher=`Str(role), container);
};

[@mel.get] external innerHTML: Dom.element => string = "innerHTML";

describe("ref", () => {
  test("can be passed as prop to a component", () => {
    let domRef = React.createRef();
    let container =
      ReactTestingLibrary.render(
        <Button_with_ref ref={ReactDOM.Ref.domRef(domRef)}>
          {React.string("Click me")}
        </Button_with_ref>,
      );
    let button = getByRole("FancyButton", container);
    expect(button->innerHTML)->toBe("Click me");
  })
});
