open Jest;
open Jest.Expect;
open ReactTest.Utils;
open Belt;

/* https://react.dev/blog/2022/03/08/react-18-upgrade-guide#configuring-your-testing-environment */
[%%mel.raw "globalThis.IS_REACT_ACT_ENVIRONMENT = true"];

type store('a) = {
  subscribe: (unit => unit) => unit => unit,
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

describe("Hooks", () => {
  let container = ref(None);

  beforeEach(prepareContainer(container));
  afterEach(cleanupContainer(container));

  testAsync("useSyncExternalStore", finish => {
    let {subscribe, getState, setState} = store("initial");
    let mock = Mock.fn();

    let container = getContainer(container);
    let root = React.DOM.Client.createRoot(container);

    let subscribeWithMock = args => {
      let _ = mock(. ());
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

    act(() => React.DOM.Client.render(root, <App />));

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
    act(() => React.DOM.Client.render(root, <App />));

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
