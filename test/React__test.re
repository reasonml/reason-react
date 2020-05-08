open TestFramework;
open ReactTestUtils;
open Belt;

module DummyStatefulComponent = {
  [@react.component]
  let make = (~initialValue=0, ()) => {
    let (value, setValue) = React.useState(() => initialValue);

    <button onClick={_ => setValue(value => value + 1)}>
      {value->React.int}
    </button>;
  };
};

module DummyReducerComponent = {
  type action =
    | Increment
    | Decrement;
  [@react.component]
  let make = (~initialValue=0, ()) => {
    let (state, send) =
      React.useReducer(
        (state, action) =>
          switch (action) {
          | Increment => state + 1
          | Decrement => state - 1
          },
        initialValue,
      );

    <>
      <div className="value"> {state->React.int} </div>
      <button onClick={_ => send(Increment)}>
        "Increment"->React.string
      </button>
      <button onClick={_ => send(Decrement)}>
        "Decrement"->React.string
      </button>
    </>;
  };
};

describe("React", ({test, beforeEach, afterEach}) => {
  let container = ref(None);

  beforeEach(prepareContainer(container));
  afterEach(cleanupContainer(container));

  test("can render DOM elements", ({expect}) => {
    let container = getContainer(container);

    act(() => {
      ReactDOMRe.render(<div> "Hello world!"->React.string </div>, container)
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent("div", "Hello world!")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can render react components", ({expect}) => {
    let container = getContainer(container);

    act(() => {ReactDOMRe.render(<DummyStatefulComponent />, container)});

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent("button", "0")
      ->Option.isSome,
    ).
      toBeTrue();

    let button = container->DOM.findBySelector("button");

    act(() => {
      switch (button) {
      | Some(button) => Simulate.click(button)
      | None => ()
      }
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent("button", "0")
      ->Option.isSome,
    ).
      toBeFalse();

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent("button", "1")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can render react components with reducers", ({expect}) => {
    let container = getContainer(container);

    act(() => {ReactDOMRe.render(<DummyReducerComponent />, container)});

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent(".value", "0")
      ->Option.isSome,
    ).
      toBeTrue();

    let button =
      container->DOM.findBySelectorAndPartialTextContent(
        "button",
        "Increment",
      );

    act(() => {
      switch (button) {
      | Some(button) => Simulate.click(button)
      | None => ()
      }
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent(".value", "0")
      ->Option.isSome,
    ).
      toBeFalse();

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    ).
      toBeTrue();

    let button =
      container->DOM.findBySelectorAndPartialTextContent(
        "button",
        "Decrement",
      );

    act(() => {
      switch (button) {
      | Some(button) => Simulate.click(button)
      | None => ()
      }
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent(".value", "0")
      ->Option.isSome,
    ).
      toBeTrue();

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    ).
      toBeFalse();
  });
});
