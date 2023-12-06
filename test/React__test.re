open Jest;
open Jest.Expect;
open ReactDOMTestUtils;
open Belt;

/* https://react.dev/blog/2022/03/08/react-18-upgrade-guide#configuring-your-testing-environment */
[%%mel.raw "globalThis.IS_REACT_ACT_ENVIRONMENT = true"];

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

describe("React", () => {
  let container = ref(None);

  beforeEach(prepareContainer(container));
  afterEach(cleanupContainer(container));

  test("can render DOM elements", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(root, <div> "Hello world!"->React.string </div>)
    });

    expect(
      container
      ->DOM.findBySelectorAndTextContent("div", "Hello world!")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("can render null elements", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => ReactDOM.Client.render(root, <div> React.null </div>));

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("can render string elements", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(root, <div> "Hello"->React.string </div>)
    });

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "Hello")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("can render int elements", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => ReactDOM.Client.render(root, <div> 12345->React.int </div>));

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "12345")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("can render float elements", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(root, <div> 12.345->React.float </div>)
    });

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "12.345")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("can render array of elements", () => {
    let container = getContainer(container);
    let array =
      [|1, 2, 3|]
      ->Array.map(item => {<div key={j|$item|j}> item->React.int </div>});
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(root, <div> array->React.array </div>)
    });

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "1")
      ->Option.isSome,
    )
    ->toBe(true);

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "2")
      ->Option.isSome,
    )
    ->toBe(true);

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "3")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("can clone an element", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(
        root,
        React.cloneElement(
          <div> "Hello"->React.string </div>,
          {"data-name": "World"},
        ),
      )
    });

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent(
          "div[data-name='World']",
          "Hello",
        )
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("can work with React refs", () => {
    let reactRef = React.createRef();
    expect(reactRef.current)->toEqual(Js.Nullable.null);
    reactRef.current = Js.Nullable.return(1);
    expect(reactRef.current)->toEqual(Js.Nullable.return(1));
  });

  test("Children", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyComponentThatMapsChildren>
          <div> 1->React.int </div>
          <div> 2->React.int </div>
          <div> 3->React.int </div>
        </DummyComponentThatMapsChildren>,
      )
    });

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div[data-index='0']", "1")
      ->Option.isSome,
    )
    ->toBe(true);

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div[data-index='1']", "2")
      ->Option.isSome,
    )
    ->toBe(true);

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div[data-index='2']", "3")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("Context", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyContext.Provider value=10>
          <DummyContext.Consumer />
        </DummyContext.Provider>,
      )
    });

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "10")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("Events", () => {
    let container = getContainer(container);
    let value = ref("");
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(
        root,
        <input
          name="test-input"
          onChange={event => {value :=  event->React.Event.Form.target##value}}
        />,
      )
    });

    switch (container->DOM.findBySelector("input[name='test-input']")) {
    | Some(input) => input->Simulate.changeWithValue("My value")
    | None => ()
    };

    expect(value.contents)->toEqual("My value");
  });

  test("React.Fragment with key", () => {
    let container = getContainer(container);
    let title = Some("foo");
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(
        root,
        <React.Fragment key=?title>
          <div> "Child"->React.string </div>
        </React.Fragment>,
      )
    });

    expect(
      container
      ->DOM.findBySelectorAndPartialTextContent("div", "Child")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("Type inference with keys", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    module Author = {
      type t = {
        name: string,
        imageUrl: string,
      };
    };

    let render = author =>
      <div key={author.Author.name}>
        <div> <img src={author.imageUrl} /> </div>
      </div>;

    act(() => {
      ReactDOM.Client.render(
        root,
        render({name: "Joe", imageUrl: "https://foo.png"}),
      )
    });

    expect(container->DOM.findBySelector("img")->Option.isSome)->toBe(true);
  });

  try(
    test("ErrorBoundary", () => {
      let container = getContainer(container);
      let root = ReactDOM.Client.createRoot(container);

      act(() => {
        ReactDOM.Client.render(
          root,
          <ReasonReactErrorBoundary
            fallback={({error: _, info}) => {
              expect(
                info.componentStack
                ->Js.String.includes(~search="ComponentThatThrows"),
              )
              ->toBe(true);
              <strong> "An error occured"->React.string </strong>;
            }}>
            <ComponentThatThrows value=1 />
          </ReasonReactErrorBoundary>,
        )
      });

      expect(
        container
        ->DOM.findBySelectorAndTextContent("strong", "An error occured")
        ->Option.isSome,
      )
      ->toBe(true);
    })
  ) {
  | _error =>
    /* We catch the exception here to not populate the error to the toplevel */
    ()
  };
});
