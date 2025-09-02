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
    <section>
      <h3> {React.string("Data Attributes Demo")} </h3>
      
      <p> {React.string("Demonstrating common use cases for HTML data attributes with ReasonReact")} </p>
      
      <div className="demo-testing" data_testid="test-automation">
        <h4> {React.string("Testing & QA")} </h4>
        <button data_testid="submit-btn" data_cy="submit" onClick={_ => Js.log("Form submitted")}>
          {React.string("Submit Form")}
        </button>
        <input data_testid="email-input" data_cy="email" placeholder="Enter email" />
      </div>
      
      <div className="demo-analytics" data_analytics="user-engagement">
        <h4> {React.string("Analytics & Tracking")} </h4>
        <button data_action="click" data_category="engagement" data_label="cta-button" onClick={_ => Js.log("Tracked click")}>
          {React.string("Call to Action")}
        </button>
        <a href="#" data_track="external-link" data_destination="docs">
          {React.string("External Documentation")}
        </a>
      </div>
      
      <div className="demo-state" data_theme="dark" data_variant="compact">
        <h4> {React.string("Component State")} </h4>
        <div data_status="active" data_priority="high">
          {React.string("High Priority Task")}
        </div>
        <span data_badge="new" data_count="5">
          {React.string("Notifications")}
        </span>
      </div>
      
      <div className="demo-a11y">
        <h4> {React.string("Accessibility Support")} </h4>
        <button data_tooltip="Save your current progress" data_placement="top">
          {React.string("Save")}
        </button>
        <div data_role="alert" data_level="error">
          {React.string("Please fix validation errors")}
        </div>
      </div>
      
      <div 
        className="demo-complex"
        data_testid="user-card"
        data_analytics="profile-view"
        data_theme="light"
        data_status="premium"
        style={ReactDOM.Style.make(~padding="16px", ~border="2px solid #0066cc", ())}
      >
        <h4> {React.string("Complex Example")} </h4>
        <p> {React.string("Multiple data attributes working together for testing, analytics, theming, and state management.")} </p>
      </div>
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