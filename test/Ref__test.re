open Jest;
open Jest.Expect;
open ReactDOMTestUtils;
open Belt;

/* https://react.dev/blog/2022/03/08/react-18-upgrade-guide#configuring-your-testing-environment */
[%%mel.raw "globalThis.IS_REACT_ACT_ENVIRONMENT = true"];

module Button_with_ref = {
  [@react.component]
  let make = (~children, ~ref) => {
    <button ref className="FancyButton"> children </button>;
  };
};

describe("React - Ref", () => {
  let container = ref(None);

  beforeEach(prepareContainer(container));
  afterEach(cleanupContainer(container));

  test("can render DOM elements", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);
    let domRef = React.createRef();

    act(() => {
      ReactDOM.Client.render(
        root,
        <Button_with_ref ref={ReactDOM.Ref.domRef(domRef)}>
          "Click me"->React.string
        </Button_with_ref>,
      )
    });

    expect(
      container
      ->DOM.findBySelectorAndTextContent("button", "Click me")
      ->Option.isSome,
    )
    ->toBe(true);
  });
});
