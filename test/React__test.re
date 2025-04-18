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
[@mel.set] external setInnerHTML: (Dom.element, string) => unit = "innerHTML";

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
[@mel.set] external setTitle: (Dom.element, string) => unit = "title";
[@mel.get] external getTitle: Dom.element => string = "title";

let (let.await) = (p, f) => Js.Promise.then_(f, p);

external createElement: string => Dom.element = "document.createElement";
[@mel.send]
external appendChild: (Dom.element, Dom.element) => unit = "appendChild";
external document: Dom.element = "document";
external body: Dom.element = "document.body";
external querySelector: (string, Dom.element) => option(Dom.element) =
  "document.querySelector";

[@mel.new]
external mouseEvent: (string, Js.t('a)) => Dom.event = "MouseEvent";

[@mel.send]
external dispatchEvent: (Dom.element, Dom.event) => unit = "dispatchEvent";

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
          {React.array([|
             <div> 1->React.int </div>,
             <div> 2->React.int </div>,
             <div> 3->React.int </div>,
           |])}
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

  module Counter = {
    [@react.component]
    let make = () => {
      let (count, setCount) = React.useState(() => 0);

      React.useEffect1(
        () => {
          document->setTitle(
            "You clicked " ++ Int.to_string(count) ++ " times",
          );
          None;
        },
        [|count|],
      );

      <div>
        <button
          className="Increment" onClick={_ => setCount(prev => prev + 1)}>
          {React.string("Increment")}
        </button>
        <span className="Value"> {React.string(string_of_int(count))} </span>
      </div>;
    };
  };

  testPromise("act", finish => {
    /* This test doesn't use ReactTestingLibrary to test the act API, and the code comes from
       https://react.dev/reference/react/act example */

    let container: Dom.element = createElement("div");
    body->appendChild(container);

    let.await () =
      React.act(() => {
        let root = ReactDOM.Client.createRoot(container);
        ReactDOM.Client.render(root, <Counter />);
      });

    let valueElement = querySelector(".Value", container);
    switch (valueElement) {
    | Some(value) => expect(value->innerHTML)->toBe("0")
    | None => failwith("Can't find 'Value' element")
    };

    let title = getTitle(document);
    expect(title)->toBe("You clicked 0 times");

    let.await () =
      React.act(() => {
        let buttonElement = querySelector(".Increment", container);
        switch (buttonElement) {
        | Some(button) =>
          dispatchEvent(button, mouseEvent("click", {"bubbles": true}))
        | None => failwith("Can't find 'Increment' button")
        };
      });

    let valueElement = querySelector(".Value", container);
    switch (valueElement) {
    | Some(value) => expect(value->innerHTML)->toBe("1")
    | None => failwith("Can't find 'Value' element")
    };

    let title = getTitle(document);
    expect(title)->toBe("You clicked 1 times");

    finish();
  });

  testPromise("actAsync", finish => {
    /* This test doesn't use ReactTestingLibrary to test the act API, and the code comes from
       https://react.dev/reference/react/act example */

    body->setInnerHTML("");
    let container: Dom.element = createElement("div");
    body->appendChild(container);

    let.await () =
      React.actAsync(() => {
        let root = ReactDOM.Client.createRoot(container);
        ReactDOM.Client.render(root, <Counter />);
        Js.Promise.resolve();
      });

    let valueElement = querySelector(".Value", container);
    switch (valueElement) {
    | Some(value) => expect(value->innerHTML)->toBe("0")
    | None => failwith("Can't find 'Value' element")
    };

    let title = getTitle(document);
    expect(title)->toBe("You clicked 0 times");

    let.await () =
      React.actAsync(() => {
        let buttonElement = querySelector(".Increment", container);
        switch (buttonElement) {
        | Some(button) =>
          dispatchEvent(button, mouseEvent("click", {"bubbles": true}))
        | None => failwith("Can't find 'Increment' button")
        };
        Js.Promise.resolve();
      });

    let valueElement = querySelector(".Value", container);
    switch (valueElement) {
    | Some(value) => expect(value->innerHTML)->toBe("1")
    | None => failwith("Can't find 'Value' element")
    };

    let title = getTitle(document);
    expect(title)->toBe("You clicked 1 times");

    finish();
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

  test("Can define components with custom children", () => {
    module Test = {
      type t = {name: string};
      [@react.component]
      let make = (~children) => {
        React.array(
          Belt.Array.map(children, c =>
            <div role={c.name}> {React.string(c.name)} </div>
          ),
        );
      };
    };

    let container =
      ReactTestingLibrary.render(
        <Test> {[|{Test.name: "foo"}, {name: "bar"}|]} </Test>,
      );

    let foo = getByRole("foo", container);
    expect(foo->innerHTML)->toBe("foo");

    let bar = getByRole("bar", container);
    expect(bar->innerHTML)->toBe("bar");
  });

  test("Can render components with multiple children", () => {
    module MyComponent = {
      [@react.component]
      let make = (~children) => {
        <section role="container"> children </section>;
      };
    };

    let container =
      ReactTestingLibrary.render(
        <MyComponent>
          <div role="child1"> {React.string("child1")} </div>
          <div role="child2"> {React.string("child2")} </div>
        </MyComponent>,
      );

    let section = getByRole("container", container);
    expect(section->tagName->Js.String.toLowerCase)->toBe("section");

    let child1 = getByRole("child1", container);
    expect(child1->innerHTML)->toBe("child1");

    let child2 = getByRole("child2", container);
    expect(child2->innerHTML)->toBe("child2");
  });

  test("Can render components with a single child", () => {
    module MyComponent = {
      [@react.component]
      let make = (~children) => {
        <section role="container"> children </section>;
      };
    };

    let container =
      ReactTestingLibrary.render(
        <MyComponent>
          <div role="child"> {React.string("child")} </div>
        </MyComponent>,
      );

    let section = getByRole("container", container);
    expect(section->tagName->Js.String.toLowerCase)->toBe("section");

    let child = getByRole("child", container);
    expect(child->innerHTML)->toBe("child");
  });
});
