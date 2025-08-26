module Stateful = {
  [@react.component]
  let make = (~title, ~initialValue=0, ~children=React.null) => {
    let (value, setValue) = React.useState(() => initialValue);
    let onClick = _ => setValue(value => value + 1);

    <section>
      <h3> {React.string(title)} </h3>
      <button key="asdf" onClick> value->React.int </button>
      children
    </section>;
  };
};

module Reducer = {
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

    Js.log2("Reducer state", state);

    <section>
      <h3> {React.string("React.useReducer")} </h3>
      <main> state->React.int </main>
      <button onClick={_ => send(Increment)}>
        "Increment"->React.string
      </button>
      <button onClick={_ => send(Decrement)}>
        "Decrement"->React.string
      </button>
    </section>;
  };
};

module ReducerWithMapState = {
  type action =
    | Increment
    | Decrement;

  [@react.component]
  let make = (~initialValue=0) => {
    let (state, send) =
      React.useReducerWithMapState(
        (state, action) =>
          switch (action) {
          | Increment => state + 1
          | Decrement => state - 1
          },
        initialValue,
        initialValue => initialValue + 75,
      );

    Js.log2("ReducerWithMapState state", state);

    <section>
      <h3> {React.string("React.useReducerWithMapState")} </h3>
      <main> state->React.int </main>
      <button onClick={_ => send(Increment)}>
        "Increment"->React.string
      </button>
      <button onClick={_ => send(Decrement)}>
        "Decrement"->React.string
      </button>
    </section>;
  };
};

module WithEffect = {
  [@react.component]
  let make = (~value) => {
    React.useEffect1(
      () => {
        Js.log("useEffect");
        None;
      },
      [|value|],
    );

    React.string("React.useEffect");
  };
};

module RerenderOnEachClick = {
  [@react.component]
  let make = (~value=0, ~callback as _) => {
    let (value, setValue) = React.useState(() => value);
    let onClick = _ =>
      if (value < 3) {
        Js.log2("Clicked with:", value);
        setValue(value => value + 1);
      } else {
        Js.log("Max value reached, not firing a rerender");
        setValue(value => value);
      };

    <section>
      <h3> {React.string("RerenderOnEachClick")} </h3>
      <button onClick> <WithEffect value /> </button>
    </section>;
  };
};

module WithLayoutEffect = {
  [@react.component]
  let make = (~value=0, ~callback) => {
    React.useLayoutEffect1(
      () => {
        callback(value);
        Js.log("useLayoutEffect");
        None;
      },
      [|value|],
    );

    <section> <h3> {React.string("React.useLayoutEffect")} </h3> </section>;
  };
};

module WithRefAndEffect = {
  [@react.component]
  let make = (~callback) => {
    let myRef = React.useRef(1);
    React.useEffect0(() => {
      myRef.current = myRef.current + 1;
      callback(myRef);
      None;
    });

    <section>
      <h3> {React.string("React.useRef and useEffect")} </h3>
      <main> {React.int(myRef.current)} </main>
    </section>;
  };
};

[@mel.module "react"]
external useReducer:
  ([@mel.uncurry] (('state, 'action) => 'state), 'state) =>
  ('state, 'action => unit) =
  "useReducer";

module UseReducerNoProblemo = {
  [@react.component]
  let make = () => {
    let reducer = (v, _) => v + 1;
    let (state, send) = useReducer(reducer, 0);
    Js.log("asdfasd");
    <button onClick={_ => send(0)}> {React.int(state)} </button>;
  };
};

module FragmentsEverywhere = {
  [@react.component]
  let make = () => {
    let items = ["Apple", "Banana", "Cherry", "Date"];
    let numbers = [1, 2, 3, 4, 5];

    <section>
      <h3> {React.string("Fragments Everywhere")} </h3>
      <React.Fragment>
        <p> {React.string("This is inside a fragment")} </p>
        <span> {React.string("Multiple elements together")} </span>
        <small> {React.string("Without a wrapper div")} </small>
      </React.Fragment>
      <div>
        <h4> {React.string("List of items with fragments:")} </h4>
        {items
         |> List.mapi((index, item) =>
              <React.Fragment key={string_of_int(index)}>
                <strong> {React.string(item)} </strong>
                <span>
                  {React.string(" - Item #" ++ string_of_int(index + 1))}
                </span>
                <br />
              </React.Fragment>
            )
         |> Array.of_list
         |> React.array}
      </div>
      <>
        <hr />
        <p> {React.string("Another fragment section")} </p>
        <button> {React.string("Click me")} </button>
        <em> {React.string("Emphasized text")} </em>
      </>
      <div>
        <h4> {React.string("Numbers with fragments:")} </h4>
        {numbers
         |> List.map(num =>
              <React.Fragment key={string_of_int(num)}>
                <div> {React.string("Number: " ++ string_of_int(num))} </div>
                <small>
                  {React.string("Square: " ++ string_of_int(num * num))}
                </small>
                <br />
              </React.Fragment>
            )
         |> Array.of_list
         |> React.array}
      </div>
    </section>;
  };
};

module WithoutForward = {
  [@react.component]
  let make = (~ref=?) => {
    <button ?ref className="FancyButton"> "Click me"->React.string </button>;
  };
};

module DataAttrsDemo = {
  [@react.component]
  let make = () => {
    // Only works on DOM elements, not React components
    <section>
      <h3> {React.string("Zero-Runtime Data Attributes Demo")} </h3>
      
      <div className="demo-single">
        {React.string("Data attributes implemented (see tests for validation)")}
      </div>
      
      <div 
        className="demo-multi"
      >
        {React.string("Data attributes: data_testid becomes data-testid")}
      </div>
      
      <div
        className="demo-container"
        id="main-demo"
        style={ReactDOM.Style.make(~padding="12px", ~border="1px solid #ccc", ())}
      >
        {React.string("Zero-Runtime Data Attributes Demo - compile-time transformation")}
      </div>
      
      <details className="demo-comparison">
        <summary> {React.string("Old vs New Approach Comparison")} </summary>
        <div className="comparison-content">
          <h4> {React.string("Old Runtime Approach (removed):")} </h4>
          <pre>
            {React.string({j|let dataAttrs = [("testid", "demo")] |> Js.Dict.fromList;
<div dataAttrs>...</div>|j})}
          </pre>
          
          <h4> {React.string("New Compile-Time Approach:")} </h4>
          <pre>
            {React.string({j|<div data_testid="demo">...</div>|j})}
          </pre>
          
          <p> {React.string("Benefits: Zero runtime overhead, cleaner syntax, compile-time validation")} </p>
        </div>
      </details>
    </section>;
  };
};

module App = {
  [@react.component]
  let make = (~initialValue) => {
    let value = 99;
    let callback = _number => ();

    <main>
      <Stateful title="Stateful" initialValue />
      <Reducer key="reducer" initialValue />
      <ReducerWithMapState key="reducer-with-map-state" initialValue />
      <RerenderOnEachClick key="rerender-on-each-click" value=0 callback />
      <WithLayoutEffect key="layout-effect" value callback />
      <WithRefAndEffect key="ref-and-effect" callback />
      <UseReducerNoProblemo key="use-reducer-no-problemo" />
      <FragmentsEverywhere key="fragments-everywhere" />
      <WithoutForward key="without-forward" />
      <DataAttrsDemo key="data-attrs-demo" />
    </main>;
  };
};

switch (ReactDOM.querySelector("#root")) {
| Some(el) =>
  let root = ReactDOM.Client.createRoot(el);
  ReactDOM.Client.render(root, <App initialValue=0 />);
| None => Js.log("No root element found")
};
