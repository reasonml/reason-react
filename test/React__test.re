open Jest;
open Expect;

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
           {
             "key": string_of_int(index),
             "role": Int.to_string(index),
           },
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
      <div role="value"> value->React.int </div>;
    };
  };
};

[@mel.get] external tagName: Dom.element => string = "tagName";
[@mel.get] external innerHTML: Dom.element => string = "innerHTML";

let getByRole = (role, container) => {
  ReactTestingLibrary.getByRole(~matcher=`Str(role), container);
};

let getByTag = (tag, container) => {
  let fn = (_string, element: Dom.element) => {
    element->tagName->Js.String.toLowerCase == tag;
  };
  ReactTestingLibrary.getByText(~matcher=`Func(fn), container);
};

[@mel.send]
external getAttribute: (Dom.element, string) => option(string) =
  "getAttribute";

describe("React", () => {
  test("can render DOM elements", () => {
    let container =
      ReactTestingLibrary.render(<div role="display"> <span /> </div>);
    let div = getByRole("display", container);
    expect(div->innerHTML)->toBe("<span></span>");
  });

  test("can render null elements", () => {
    let container =
      ReactTestingLibrary.render(<div role="display"> React.null </div>);
    let div = getByRole("display", container);
    expect(div->innerHTML)->toBe("");
  });

  test("can render string elements", () => {
    let container =
      ReactTestingLibrary.render(
        <div role="display"> "Hello world!"->React.string </div>,
      );
    let div = getByRole("display", container);
    expect(div->innerHTML)->toBe("Hello world!");
  });

  test("can render int elements", () => {
    let container =
      ReactTestingLibrary.render(
        <div role="display"> 12345->React.int </div>,
      );
    let div = getByRole("display", container);
    expect(div->innerHTML)->toBe("12345");
  });

  test("can render float elements", () => {
    let container =
      ReactTestingLibrary.render(
        <div role="display"> 12.345->React.float </div>,
      );
    let div = getByRole("display", container);
    expect(div->innerHTML)->toBe("12.345");
  });

  test("can render array of elements", () => {
    let array =
      Array.map(
        item => {
          <div role={Int.to_string(item)} key={string_of_int(item)}>
            item->React.int
          </div>
        },
        [|1, 2, 3|],
      );
    let container =
      ReactTestingLibrary.render(<div> {React.array(array)} </div>);
    let div = getByRole("1", container);
    expect(div->innerHTML)->toBe("1");
    let div = getByRole("2", container);
    expect(div->innerHTML)->toBe("2");
    let div = getByRole("3", container);
    expect(div->innerHTML)->toBe("3");
  });

  test("can clone an element with data-* attributes", () => {
    let container =
      ReactTestingLibrary.render(
        React.cloneElement(
          <div> "Hello"->React.string </div>,
          {"data-name": "World"},
        ),
      );
    let output = ReactTestingLibrary.container(container)->innerHTML;
    let found = Js.String.includes(~search="data-name=\"World\"", output);
    expect(found)->toBe(true);
  });

  test("can work with React refs", () => {
    let reactRef = React.createRef();
    expect(reactRef.current)->toEqual(Js.Nullable.null);
    reactRef.current = Js.Nullable.return(1);
    expect(reactRef.current)->toEqual(Js.Nullable.return(1));
  });

  test("Children", () => {
    let container =
      ReactTestingLibrary.render(
        <DummyComponentThatMapsChildren>
          <div> 1->React.int </div>
          <div> 2->React.int </div>
          <div> 3->React.int </div>
        </DummyComponentThatMapsChildren>,
      );

    let div = getByRole("0", container);
    expect(div->innerHTML)->toBe("1");
    let div = getByRole("1", container);
    expect(div->innerHTML)->toBe("2");
    let div = getByRole("2", container);
    expect(div->innerHTML)->toBe("3");
  });

  test("Context", () => {
    let container =
      ReactTestingLibrary.render(
        <DummyContext.Provider value=10>
          <DummyContext.Consumer />
        </DummyContext.Provider>,
      );

    expect(getByRole("value", container)->innerHTML)->toBe("10");
  });

  test("Events", () => {
    let value = ref("");
    let container =
      ReactTestingLibrary.render(
        <input
          role="input"
          onChange={event => {value :=  event->React.Event.Form.target##value}}
        />,
      );

    let input = getByRole("input", container);
    FireEvent.change(
      input,
      ~eventInit={
        "target": {
          "value": "Let's go!",
        },
      },
    );

    expect(value.contents)->toEqual("Let's go!");
  });

  test("React.Fragment with key", () => {
    let title = Some("foo");
    let container =
      ReactTestingLibrary.render(
        <React.Fragment key=?title>
          <div role="child"> "Child"->React.string </div>
        </React.Fragment>,
      );

    expect(getByRole("child", container)->innerHTML)->toBe("Child");
  });

  test("Type inference with keys", () => {
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

    let container =
      ReactTestingLibrary.render(
        render({
          name: "Joe",
          imageUrl: "https://foo.png",
        }),
      );
    let image = getByRole("img", container);
    expect(image->getAttribute("src"))->toEqual(Some("https://foo.png"));
  });

  test("React.act", () => {
    module Counter = {
      [@react.component]
      let make = () => {
        let (count, setCount) = React.useState(() => 0);

        <div>
          <button role="Increment" onClick={_ => setCount(prev => prev + 1)}>
            {React.string("Increment")}
          </button>
          <span role="counter"> {React.string(string_of_int(count))} </span>
        </div>;
      };
    };

    let containerRef: ref(option(ReactTestingLibrary.renderResult)) =
      ref(None);

    React.act(() => {
      let container = ReactTestingLibrary.render(<Counter />);
      let button = getByRole("Increment", container);
      FireEvent.click(button);
      containerRef.contents = Some(container);
      Js.Promise.resolve();
    });

    switch (containerRef.contents) {
    | Some(container) =>
      expect(getByRole("counter", container)->innerHTML)->toBe("1")
    | None => failwith("Container is null")
    };
  });

  test("ErrorBoundary + Suspense", () => {
    [%mel.raw "console.error = () => {}"] |> ignore;

    try({
      let container =
        ReactTestingLibrary.render(
          <ReasonReactErrorBoundary
            fallback={({error: _, info}) => {
              expect(
                info.componentStack
                ->Js.String.includes(~search="ComponentThatThrows"),
              )
              ->toBe(true);
              <strong role="error"> "An error occured"->React.string </strong>;
            }}>
            <ComponentThatThrows value=1 />
          </ReasonReactErrorBoundary>,
        );

      let error = getByRole("error", container);
      expect(error->innerHTML)->toBe("An error occured");
    }) {
    | _error =>
      /* We catch the exception here to not populate the error to the toplevel */
      ()
    };
  });

  test(
    "Memo and normal components rendering with equal and different props", () => {
    module Normal = {
      let renders = ref(0);

      [@react.component]
      let make = (~a) => {
        renders := renders^ + 1;
        <div> {Printf.sprintf("`a` is %s", a) |> React.string} </div>;
      };
    };

    module Memo = {
      let renders = ref(0);

      [@react.component]
      let make =
        React.memo((~a) => {
          renders := renders^ + 1;
          <div> {Printf.sprintf("`a` is %s", a) |> React.string} </div>;
        });
    };

    let container =
      ReactTestingLibrary.render(
        <div> <Normal a="a" /> <Memo a="a" /> </div>,
      );

    expect(Normal.renders^)->toBe(1);
    expect(Memo.renders^)->toBe(1);

    ReactTestingLibrary.rerender(
      <div> <Normal a="a" /> <Memo a="a" /> </div>,
      container,
    );

    expect(Normal.renders^)->toBe(2);
    expect(Memo.renders^)->toBe(1);

    ReactTestingLibrary.rerender(
      <div> <Normal a="b" /> <Memo a="b" /> </div>,
      container,
    );

    expect(Normal.renders^)->toBe(3);
    expect(Memo.renders^)->toBe(2);
  });
});
