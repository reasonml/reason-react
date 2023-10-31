open Jest;
open Jest.Expect;
open ReactDOMTestUtils;
open Belt;

/* https://react.dev/blog/2022/03/08/react-18-upgrade-guide#configuring-your-testing-environment */
[%%mel.raw "globalThis.IS_REACT_ACT_ENVIRONMENT = true"];

type store('a) = {
  subscribe: (unit => unit, unit) => unit,
  getState: unit => 'a,
  setState: 'a => unit,
};

module IndexedCallbacks =
  Belt.Id.MakeComparable({
    type t = (int, unit => unit);
    let cmp = ((aIndex, _), (bIndex, _)) => Stdlib.compare(aIndex, bIndex);
  });

let store = (initialState: 'a) => {
  /* This is a small implementaion of a callback-based store:
     - Holds an initialValue and a bunch of listeners that subscrube to the value changing.
     - When the value is set, all listeners are being called */
  let currentState = ref(initialState);
  let callbacks = Belt.Set.make(~id=(module IndexedCallbacks));
  let listeners = ref(callbacks);

  let getState = (): 'a => {
    currentState.contents;
  };

  let setState = (text: 'a): unit => {
    currentState.contents = text;
    Belt.Set.forEach(listeners.contents, ((_index, listener)) => {
      listener()
    });
  };

  let subscribe = (listener: unit => unit): (unit => unit) => {
    let setLength = Belt.Set.size(listeners.contents);
    let currentIndex = setLength + 1;
    listeners := Belt.Set.add(listeners.contents, (currentIndex, listener));
    () => {
      listeners :=
        Belt.Set.remove(listeners.contents, (currentIndex, listener));
    };
  };

  {getState, setState, subscribe};
};

module DummyStatefulComponent = {
  [@react.component]
  let make = (~initialValue=0, ()) => {
    let (value, setValue) = React.useState(() => initialValue);

    <button key="asdf" onClick={_ => setValue(value => value + 1)}>
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

describe("Hooks", () => {
  let container = ref(None);

  beforeEach(prepareContainer(container));
  afterEach(cleanupContainer(container));

  test("can render react components", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {ReactDOM.Client.render(root, <DummyStatefulComponent />)});

    expect(
      container
      ->DOM.findBySelectorAndTextContent("button", "0")
      ->Option.isSome,
    )
    ->toBe(true);

    let button = container->DOM.findBySelector("button");

    act(() => {
      switch (button) {
      | Some(button) => Simulate.click(button)
      | None => ()
      }
    });

    expect(
      container
      ->DOM.findBySelectorAndTextContent("button", "0")
      ->Option.isSome,
    )
    ->toBe(false);

    expect(
      container
      ->DOM.findBySelectorAndTextContent("button", "1")
      ->Option.isSome,
    )
    ->toBe(true);
  });

  test("can render react components with reducers", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {ReactDOM.Client.render(root, <DummyReducerComponent />)});

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "0")
      ->Option.isSome,
    )
    ->toBe(true);

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

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "0")
      ->Option.isSome,
    )
    ->toBe(false);

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    )
    ->toBe(true);

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

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "0")
      ->Option.isSome,
    )
    ->toBe(true);

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    )
    ->toBe(false);
  });

  test("can render react components with reducers (map state)", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(root, <DummyReducerWithMapStateComponent />)
    });

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    )
    ->toBe(true);

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

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    )
    ->toBe(false);

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "2")
      ->Option.isSome,
    )
    ->toBe(true);

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

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "1")
      ->Option.isSome,
    )
    ->toBe(true);

    expect(
      container
      ->DOM.findBySelectorAndTextContent(".value", "2")
      ->Option.isSome,
    )
    ->toBe(false);
  });

  test("can render react components with effects", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);
    let callback = Mock.fn();

    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyComponentWithEffect value=0 callback />,
      )
    });
    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyComponentWithEffect value=1 callback />,
      )
    });
    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyComponentWithEffect value=1 callback />,
      )
    });

    expect(callback->Mock.getMock->Mock.calls)->toEqual([|[|0|], [|1|]|]);
  });

  test("can render react components with layout effects", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);
    let callback = Mock.fn();

    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyComponentWithLayoutEffect value=0 callback />,
      )
    });
    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyComponentWithLayoutEffect value=1 callback />,
      )
    });
    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyComponentWithLayoutEffect value=1 callback />,
      )
    });

    expect(callback->Mock.getMock->Mock.calls)->toEqual([|[|0|], [|1|]|]);
  });

  test("can work with useRef", () => {
    let container = getContainer(container);
    let myRef = ref(None);
    let callback = reactRef => {
      myRef := Some(reactRef);
    };
    let root = ReactDOM.Client.createRoot(container);

    act(() => {
      ReactDOM.Client.render(
        root,
        <DummyComponentWithRefAndEffect callback />,
      )
    });

    expect(myRef.contents->Option.map(item => item.current))
    ->toEqual(Some(2));
  });

  testAsync("useSyncExternalStore", finish => {
    let {subscribe, getState, setState} = store("initial");
    let mock = Mock.fn();

    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    let subscribeWithMock = args => {
      let _ = mock(.);
      subscribe(args);
    };

    module App = {
      [@react.component]
      let make = () => {
        let snapshot =
          React.useSyncExternalStore(
            ~subscribe=subscribeWithMock,
            ~getSnapshot=getState,
          );
        <span> {React.string(snapshot)} </span>;
      };
    };

    act(() => ReactDOM.Client.render(root, <App />));

    /* Ensure initial value is passed */
    expect(
      container
      ->DOM.findBySelectorAndTextContent("span", "initial")
      ->Option.isSome,
    )
    ->toBe(true);

    act(() => setState("changed"));

    /* Ensure store is being updated */
    let nextState = getState();
    expect(nextState)->toBe("changed");

    /* on next render */
    act(() => ReactDOM.Client.render(root, <App />));

    /* the state should be propagated to App */
    expect(
      container
      ->DOM.findBySelectorAndTextContent("span", "changed")
      ->Option.isSome,
    )
    ->toBe(true);

    finish();
  });
});
