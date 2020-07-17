open TestFramework;
open ReactTestUtils;
open Belt;

module DummyStatefulComponent = {
  [@react.component]
  let make = (~initialValue=0, ()) => {
    let (value, setValue) = React.useState(() => initialValue);

    <button onClick={_ => setValue(value => value + 1)}>
      value->React.int
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
      <div className="value"> state->React.int </div>
      <button onClick={_ => send(Increment)}>
        "Increment"->React.string
      </button>
      <button onClick={_ => send(Decrement)}>
        "Decrement"->React.string
      </button>
    </>;
  };
};

module DummyReducerWithMapStateComponent = {
  type action =
    | Increment
    | Decrement;
  [@react.component]
  let make = (~initialValue=0, ()) => {
    let (state, send) =
      React.useReducerWithMapState(
        (state, action) =>
          switch (action) {
          | Increment => state + 1
          | Decrement => state - 1
          },
        initialValue,
        initialValue => initialValue + 1,
      );

    <>
      <div className="value"> state->React.int </div>
      <button onClick={_ => send(Increment)}>
        "Increment"->React.string
      </button>
      <button onClick={_ => send(Decrement)}>
        "Decrement"->React.string
      </button>
    </>;
  };
};

module DummyComponentWithEffect = {
  [@react.component]
  let make = (~value=0, ~callback, ()) => {
    React.useEffect1(
      () => {
        callback(value);
        None;
      },
      [|value|],
    );

    <div />;
  };
};

module DummyComponentWithLayoutEffect = {
  [@react.component]
  let make = (~value=0, ~callback, ()) => {
    React.useLayoutEffect1(
      () => {
        callback(value);
        None;
      },
      [|value|],
    );

    <div />;
  };
};

module DummyComponentWithRefAndEffect = {
  [@react.component]
  let make = (~callback, ()) => {
    let myRef = React.useRef(1);
    React.useEffect0(() => {
      myRef.current = myRef.current + 1;
      callback(myRef);
      None;
    });
    <div />;
  };
};

module DummyComponentThatMapsChildren = {
  [@react.component]
  let make = (~children, ()) => {
    <div>
      {children->React.Children.mapWithIndex((element, index) => {
         React.cloneElement(
           element,
           {"key": {j|$index|j}, "data-index": index},
         )
       })}
    </div>;
  };
};

module DummyContext = {
  let context = React.createContext(0);
  module Provider = {
    include React.Context;
    let make = context->React.Context.provider;
  };

  module Consumer = {
    [@react.component]
    let make = () => {
      let value = React.useContext(context);
      <div> value->React.int </div>;
    };
  };
};

module ComponentThatThrows = {
  exception TestError;
  [@react.component]
  let make = (~shouldThrow=true, ~value) => {
    if (shouldThrow) {
      raise(TestError);
    };
    <div> value->React.int </div>;
  };
};

describe("React", ({test, beforeEach, afterEach}) => {
  let container = ref(None);

  beforeEach(prepareContainer(container));
  afterEach(cleanupContainer(container));

  test("can render DOM elements", ({expect}) => {
    let container = getContainer(container);

    act(() => {
      ReactDOM.render(<div> "Hello world!"->React.string </div>, container)
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent("div", "Hello world!")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can render null elements", ({expect}) => {
    let container = getContainer(container);

    act(() => {ReactDOM.render(<div> React.null </div>, container)});

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can render string elements", ({expect}) => {
    let container = getContainer(container);

    act(() => {
      ReactDOM.render(<div> "Hello"->React.string </div>, container)
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "Hello")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can render int elements", ({expect}) => {
    let container = getContainer(container);

    act(() => {ReactDOM.render(<div> 12345->React.int </div>, container)});

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "12345")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can render float elements", ({expect}) => {
    let container = getContainer(container);

    act(() => {ReactDOM.render(<div> 12.345->React.float </div>, container)});

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "12.345")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can render array of elements", ({expect}) => {
    let container = getContainer(container);
    let array =
      [|1, 2, 3|]
      ->Array.map(item => {<div key={j|$item|j}> item->React.int </div>});

    act(() => {ReactDOM.render(<div> array->React.array </div>, container)});

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "1")
      ->Option.isSome,
    ).
      toBeTrue();

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "2")
      ->Option.isSome,
    ).
      toBeTrue();

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "3")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can clone an element", ({expect}) => {
    let container = getContainer(container);

    act(() => {
      ReactDOM.render(
        React.cloneElement(
          <div> "Hello"->React.string </div>,
          {"data-name": "World"},
        ),
        container,
      )
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent(
          "div[data-name='World']",
          "Hello",
        )
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("can render react components", ({expect}) => {
    let container = getContainer(container);

    act(() => {ReactDOM.render(<DummyStatefulComponent />, container)});

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

    act(() => {ReactDOM.render(<DummyReducerComponent />, container)});

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

  test("can render react components with reducers (map state)", ({expect}) => {
    let container = getContainer(container);

    act(() => {
      ReactDOM.render(<DummyReducerWithMapStateComponent />, container)
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent(".value", "1")
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
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    ).
      toBeFalse();

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent(".value", "2")
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
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    ).
      toBeTrue();

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent(".value", "2")
      ->Option.isSome,
    ).
      toBeFalse();
  });

  test("can render react components with effects", ({expect}) => {
    let container = getContainer(container);
    let callback = Mock.fn();

    act(() => {
      ReactDOM.render(
        <DummyComponentWithEffect value=0 callback />,
        container,
      )
    });
    act(() => {
      ReactDOM.render(
        <DummyComponentWithEffect value=1 callback />,
        container,
      )
    });
    act(() => {
      ReactDOM.render(
        <DummyComponentWithEffect value=1 callback />,
        container,
      )
    });

    expect.value(callback->Mock.getMock->Mock.calls).toEqual([|
      [|0|],
      [|1|],
    |]);
  });

  test("can render react components with layout effects", ({expect}) => {
    let container = getContainer(container);
    let callback = Mock.fn();

    act(() => {
      ReactDOM.render(
        <DummyComponentWithLayoutEffect value=0 callback />,
        container,
      )
    });
    act(() => {
      ReactDOM.render(
        <DummyComponentWithLayoutEffect value=1 callback />,
        container,
      )
    });
    act(() => {
      ReactDOM.render(
        <DummyComponentWithLayoutEffect value=1 callback />,
        container,
      )
    });

    expect.value(callback->Mock.getMock->Mock.calls).toEqual([|
      [|0|],
      [|1|],
    |]);
  });

  test("can work with React refs", ({expect}) => {
    let reactRef = React.createRef();
    expect.value(reactRef.current).toEqual(Js.Nullable.null);
    reactRef.current = Js.Nullable.return(1);
    expect.value(reactRef.current).toEqual(Js.Nullable.return(1));
  });

  test("can work with useRef", ({expect}) => {
    let container = getContainer(container);
    let myRef = ref(None);
    let callback = reactRef => {
      myRef := Some(reactRef);
    };

    act(() => {
      ReactDOM.render(<DummyComponentWithRefAndEffect callback />, container)
    });

    expect.value(myRef.contents->Option.map(item => item.current)).toEqual(
      Some(2),
    );
  });

  test("Children", ({expect}) => {
    let container = getContainer(container);

    act(() => {
      ReactDOM.render(
        <DummyComponentThatMapsChildren>
          <div> 1->React.int </div>
          <div> 2->React.int </div>
          <div> 3->React.int </div>
        </DummyComponentThatMapsChildren>,
        container,
      )
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div[data-index='0']", "1")
      ->Option.isSome,
    ).
      toBeTrue();

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div[data-index='1']", "2")
      ->Option.isSome,
    ).
      toBeTrue();

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div[data-index='2']", "3")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("Context", ({expect}) => {
    let container = getContainer(container);

    act(() => {
      ReactDOM.render(
        <DummyContext.Provider value=10>
          <DummyContext.Consumer />
        </DummyContext.Provider>,
        container,
      )
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "10")
      ->Option.isSome,
    ).
      toBeTrue();
  });

  test("Events", ({expect}) => {
    let container = getContainer(container);
    let value = ref("");

    act(() => {
      ReactDOM.render(
        <input
          name="test-input"
          onChange={event => {value :=  event->ReactEvent.Form.target##value}}
        />,
        container,
      )
    });

    switch (container->DOM.findBySelector("input[name='test-input']")) {
    | Some(input) => input->Simulate.changeWithValue("My value")
    | None => ()
    };

    expect.string(value.contents).toEqual("My value");
  });

  test("ErrorBoundary", ({expect}) => {
    let container = getContainer(container);

    act(() => {
      ReactDOM.render(
        <ReasonReactErrorBoundary
          fallback={({error, info}) => {
            expect.value(error).toEqual(ComponentThatThrows.TestError);
            expect.bool(
              info.componentStack->Js.String2.includes("ComponentThatThrows"),
            ).
              toBeTrue();
            <strong> "An error occured"->React.string </strong>;
          }}>
          <ComponentThatThrows value=1 />
        </ReasonReactErrorBoundary>,
        container,
      )
    });

    expect.bool(
      container
      ->DOM.findBySelectorAndTextContent("strong", "An error occured")
      ->Option.isSome,
    ).
      toBeTrue();
  });
});
