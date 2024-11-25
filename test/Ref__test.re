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
    let content =
      switch (Js.Nullable.toOption(domRef.current)) {
      | Some(element) => element->innerHTML
      | None => failwith("No element found")
      };
    expect(content)->toBe("Click me");
  });

  test("with callback ref", () => {
    let callbackRef = Mock.fn();

    let refWithCleanup =
      ReactDOM.Ref.callbackDomRef(_ref => {ignore(callbackRef())});

    let _container =
      ReactTestingLibrary.render(
        <Button_with_ref ref=refWithCleanup>
          {React.string("Click me")}
        </Button_with_ref>,
      );

    expect(callbackRef->Mock.getMock)->toHaveBeenCalled();
  });

  let (let.await) = (p, f) => Js.Promise.then_(f, p);

  testPromise("with callback ref and cleanup", finish => {
    let callbackRef = Mock.fnWithImplementation(_ => ());
    let callbackCleanupRef = Mock.fnWithImplementation(_ => ());

    let refWithCleanup =
      ReactDOM.Ref.callbackRefWithCleanup(_ref => {
        callbackRef();
        () => {
          callbackCleanupRef();
        };
      });

    let.await _ =
      ReactTestingLibrary.actAsync(() => {
        let _container =
          ReactTestingLibrary.render(
            <Button_with_ref ref=refWithCleanup>
              {React.string("Click me")}
            </Button_with_ref>,
          );
        Js.Promise.resolve();
      });

    expect(callbackRef->Mock.getMock)->toHaveBeenCalledTimes(1);
    expect(callbackCleanupRef->Mock.getMock)->toHaveBeenCalledTimes(0);

    ReactTestingLibrary.cleanup();
    expect(callbackCleanupRef->Mock.getMock)->toHaveBeenCalledTimes(1);
    finish();
  });
});
