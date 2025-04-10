open Jest;
open Jest.Expect;

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

  {
    getState,
    setState,
    subscribe,
  };
};

module DummyStatefulComponent = {
  [@react.component]
  let make = (~initialValue=0, ()) => {
    let (value, setValue) = React.useState(() => initialValue);
    let onClick = _ => setValue(value => value + 1);
    <button onClick> {React.int(value)} </button>;
  };
};

module DummyIncrementReducerComponent = {
  type action =
    | Increment;

  [@react.component]
  let make = (~initialValue=0) => {
    let (state, send) =
      React.useReducer(
        (state, action) =>
          switch (action) {
          | Increment => state + 1
          },
        initialValue,
      );

    <section>
      <main> {React.int(state)} </main>
      <button role="Increment" onClick={_ => {send(Increment)}}>
        {React.string("Increment")}
      </button>
    </section>;
  };
};

module DummyReducerComponent = {
  type action =
    | Increment
    | Decrement;

  [@react.component]
  let make = (~initialValue=0) => {
    let (state, send) =
      React.useReducer(
        (state, action) =>
          switch (action) {
          | Increment => state + 1
          | Decrement => state - 1
          },
        initialValue,
      );

    Js.log2("state", state);

    <>
      <main> {React.int(state)} </main>
      <button role="Increment" onClick={_ => send(Increment)}>
        {React.string("Increment")}
      </button>
      <button role="Decrement" onClick={_ => send(Decrement)}>
        {React.string("Decrement")}
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

    <section>
      <main role="Counter"> state->React.int </main>
      <button role="Increment" onClick={_ => send(Increment)}>
        {React.string("Increment")}
      </button>
      <button role="Decrement" onClick={_ => send(Decrement)}>
        {React.string("Decrement")}
      </button>
    </section>;
  };
};

module WithEffect = {
  [@react.component]
  let make = (~value, ~callback) => {
    React.useEffect1(
      () => {
        callback(value);
        None;
      },
      [|value|],
    );

    <span> {React.int(value)} </span>;
  };
};

module RerenderOnEachClick = {
  [@react.component]
  let make = (~initialValue=0, ~maxValue=3, ~callback) => {
    let (value, setValue) = React.useState(() => initialValue);
    let onClick = _ =>
      if (value < maxValue) {
        setValue(value => value + 1);
      } else {
        /* Fire a setState with the same value */
        setValue(value => value);
      };

    <section>
      <h3> {React.string("RerenderOnEachClick")} </h3>
      <button onClick> <WithEffect value callback /> </button>
    </section>;
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
  let make = (~callback) => {
    let myRef = React.useRef(1);
    React.useEffect0(() => {
      myRef.current = myRef.current + 1;
      callback(myRef);
      None;
    });
    <div />;
  };
};

let getByString = (text, container) =>
  ReactTestingLibrary.getByText(~matcher=`Str(text), container);

let findByPlaceholderText = (text, container) =>
  ReactTestingLibrary.findByPlaceholderText(~matcher=`Str(text), container);

[@mel.get] external tagName: Dom.element => string = "tagName";
[@mel.get] external innerHTML: Dom.element => string = "innerHTML";

let getByTag = (tag, container) => {
  let fn = (_string, element: Dom.element) => {
    element->tagName->Js.String.toLowerCase == tag;
  };
  ReactTestingLibrary.getByText(~matcher=`Func(fn), container);
};

let getByRole = (role, container) => {
  ReactTestingLibrary.getByRole(~matcher=`Str(role), container);
};

let getByInnerHTML = (text, container) => {
  let fn = (inner, _element: Dom.element) => {
    String.equal(inner, text);
  };
  ReactTestingLibrary.getByText(~matcher=`Func(fn), container);
};

describe("Hooks", () => {
  beforeEach(() => ReactTestingLibrary.cleanup());

  test("can render react components", () => {
    let container = ReactTestingLibrary.render(<DummyStatefulComponent />);
    let button = getByTag("button", container);
    expect(DomTestingLibrary.getNodeText(button))->toBe("0");
    FireEvent.click(button);
    expect(DomTestingLibrary.getNodeText(button))->toBe("1");
  });

  test("can render react components with effects", () => {
    let container =
      ReactTestingLibrary.render(
        <RerenderOnEachClick initialValue=0 maxValue=2 callback={_ => ()} />,
      );
    let button = getByTag("button", container);
    let counter = getByTag("span", container);
    FireEvent.click(button); /* 0 -> 1 */
    expect(DomTestingLibrary.getNodeText(counter))->toBe("1");
    FireEvent.click(button); /* 1 -> 2 */
    expect(DomTestingLibrary.getNodeText(counter))->toBe("2");
    /* Limit reached, counter doesn't increase, so no rerenders */
    FireEvent.click(button); /* 2 -> 2 */
    expect(DomTestingLibrary.getNodeText(counter))->toBe("2");
  });

  test("can render react components with effects", () => {
    let callback = Mock.fn();

    let container =
      ReactTestingLibrary.render(
        <RerenderOnEachClick initialValue=0 maxValue=2 callback />,
      );
    let button = getByTag("button", container);
    FireEvent.click(button); /* 0 -> 1 */
    FireEvent.click(button); /* 1 -> 2 */
    /* Limit reached, counter doesn't increase, so no rerenders */
    FireEvent.click(button); /* 2 -> 2 */
    FireEvent.click(button); /* 2 -> 2 */

    let allCalls = callback->Mock.getMock->Mock.calls;
    expect(allCalls)->toEqual([|[|0|], [|1|], [|2|]|]);
  });

  test("useSyncExternalStore", () => {
    let mock = Mock.fn();
    let {subscribe, getState, setState} = store("initial");

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

    let container = ReactTestingLibrary.render(<App />);

    /* Ensure initial value is passed */
    let span = getByTag("span", container);
    expect(DomTestingLibrary.getNodeText(span))->toBe("initial");

    ReactTestingLibrary.act(() => setState("changed"));

    /* Ensure store is being updated */
    let nextState = getState();
    expect(nextState)->toBe("changed");

    /* the state should be propagated to App */
    expect(DomTestingLibrary.getNodeText(span))->toBe("changed");

    /* on the next render */
    ReactTestingLibrary.rerender(<App />, container);

    /* the state should stay 'changed' */
    expect(DomTestingLibrary.getNodeText(span))->toBe("changed");
  });

  test("can render react components with layout effects", () => {
    let callback = Mock.fn();

    let container =
      ReactTestingLibrary.render(
        <DummyComponentWithLayoutEffect value=0 callback />,
      );

    ReactTestingLibrary.act(() => {
      ReactTestingLibrary.rerender(
        <DummyComponentWithLayoutEffect value=1 callback />,
        container,
      )
    });
    ReactTestingLibrary.act(() => {
      ReactTestingLibrary.rerender(
        <DummyComponentWithLayoutEffect value=1 callback />,
        container,
      )
    });
    expect(callback->Mock.getMock->Mock.calls)->toEqual([|[|0|], [|1|]|]);
  });

  test("can work with useRef", () => {
    let myRef = ref(None);
    let callback = reactRef => {
      myRef := Some(reactRef);
    };

    let _ =
      ReactTestingLibrary.render(<DummyComponentWithRefAndEffect callback />);

    switch (myRef.contents) {
    | Some(ref) => expect(ref.current)->toBe(2)
    | None => failwith("no ref")
    };
  });

  test("can render react components with reducers", () => {
    let container =
      ReactTestingLibrary.render(
        <DummyIncrementReducerComponent initialValue=0 />,
      );

    let counter = getByTag("main", container);
    let button = getByTag("button", container);
    expect(counter->innerHTML)->toBe("0");
    FireEvent.click(button);
    expect(counter->innerHTML)->toBe("1");
  });

  test("can render react components with reducers and initial map state", () => {
    let container =
      ReactTestingLibrary.render(<DummyReducerWithMapStateComponent />);

    let counter = getByRole("Counter", container);
    expect(counter->innerHTML)->toBe("1");

    let incrementButton = getByRole("Increment", container);
    FireEvent.click(incrementButton);
    expect(counter->innerHTML)->toBe("2");

    let decrementButton = getByRole("Decrement", container);
    FireEvent.click(decrementButton);
    expect(counter->innerHTML)->toBe("1");
  });
});
