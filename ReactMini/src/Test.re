module ReasonReact = React;

module ReactDOMRe = React.ReactDOMRe;


/**
 * The simplest component. Composes nothing!
 */
module Box = {
  let component = ReasonReact.statefulComponent "Box";
  let make ::title="ImABox" onClick::_=? _children => {
    ...component,
    initialState: fun () => (),
    render: fun _self => ReasonReact.stringToElement title
  };
};

module BoxWrapper = {
  let component = ReasonReact.statelessComponent "BoxWrapper";
  let make ::title="ImABox" ::twoBoxes=false onClick::_=? _children => {
    ...component,
    initialState: fun () => (),
    render: fun _self =>
      twoBoxes ? <div> <Box title /> <Box title /> </div> : <div> <Box title /> </div>
  };
};


/**
 * Box with component ids.
 */
module BoxWithCID = {
  let component = ReasonReact.statelessComponent useCID::true "BoxWithID";
  let make ::title="ImABox" _children => {
    ...component,
    render: fun _self => ReasonReact.stringToElement title
  };
};

module BoxList = {
  type action =
    | Create string
    | Reverse;
  let component = ReasonReact.reducerComponent "BoxList";
  let make ::runAction ::useCID=false _children => {
    ...component,
    initialState: fun () => [],
    reducer: fun action state =>
      switch action {
      | Create title =>
        ReasonReact.Update [useCID ? <BoxWithCID title /> : <Box title />, ...state]
      | Reverse => ReasonReact.Update (List.rev state)
      },
    render: fun {state, reduce} => {
      ReasonReact.RunAction.initialize ::reduce runAction;
      ReasonReact.listToElement state
    }
  };
};


/**
 * This component demonstrates several things:
 *
 * 1. Demonstration of making internal state hidden / abstract. Components
 * should encapsulate their state representation and should be free to change
 * it.
 *
 * 2. Demonstrates an equivalent of `componentWillReceiveProps`.
 * `componentWillReceiveProps` is like an "edge trigger" on props, and the
 * first item of the tuple shows how we implement that with this API.
 */
module ChangeCounter = {
  type state = {
    numChanges: int,
    mostRecentLabel: string
  };
  let component = ReasonReact.reducerComponent "ChangeCounter";
  let make ::label _children => {
    ...component,
    initialState: fun () => {mostRecentLabel: label, numChanges: 10},
    reducer: fun () state => ReasonReact.Update {...state, numChanges: state.numChanges + 1000},
    willReceiveProps: fun {state, reduce} =>
      label != state.mostRecentLabel ?
        {
          reduce (fun () => ()) ();
          reduce (fun () => ()) ();
          {mostRecentLabel: label, numChanges: state.numChanges + 1}
        } :
        state,
    render: fun {state: {numChanges, mostRecentLabel}} => {
      let title = Printf.sprintf "[%d, \"%s\"]" numChanges mostRecentLabel;
      <div> <Box title /> </div>
    }
  };
};

module StatelessButton = {
  let component = ReasonReact.statelessComponent "StatelessButton";
  let make initialClickCount::_="noclicks" test::_="default" _children => {
    ...component,
    render: fun _self => <div> <Box /> </div>
  };
};

module ButtonWrapper = {
  type state = {buttonWrapperState: int};
  let component = ReasonReact.statefulComponent "ButtonWrapper";
  let make ::wrappedText="default" _children => {
    ...component,
    initialState: fun () => {buttonWrapperState: 0},
    render: fun {state} =>
      <div>
        (ReasonReact.stringToElement (string_of_int state.buttonWrapperState))
        <StatelessButton initialClickCount=("wrapped:" ^ wrappedText ^ ":wrapped") />
        <StatelessButton initialClickCount=("wrapped:" ^ wrappedText ^ ":wrapped") />
      </div>
  };
};

let buttonWrapperJsx = <ButtonWrapper wrappedText="TestButtonUpdated!!!" />;

module ButtonWrapperWrapper = {
  let component = ReasonReact.statefulComponent "ButtonWrapperWrapper";
  let make ::wrappedText="default" _children => {
    ...component,
    initialState: fun () => "buttonWrapperWrapperState",
    render: fun {state} =>
      <div>
        (ReasonReact.stringToElement state)
        (ReasonReact.stringToElement ("wrappedText:" ^ wrappedText))
        buttonWrapperJsx
      </div>
  };
};

module TestUtils = {
  open React;
  let logMsg ::msg => logString ("\n" ^ msg ^ "\n-------------------");
  let startTest ::msg => {
    GlobalState.reset ();
    if (msg != "") {
      logString ("\n\n******* " ^ msg ^ " *******")
    }
  };

  /** Print a renderedElement */
  let printRenderedElement (renderedElement: RenderedElement.t) =>
    OutputTree.print (OutputTree.fromRenderedElement renderedElement);

  /** Print a list of renderedElement */
  let printRenderedElementList el =>
    printRenderedElement (RenderedElement.listToRenderedElement el);
  let renderAndPrint ::msg reactElement => {
    logMsg ::msg;
    let rendered = RenderedElement.render reactElement;
    logString (printRenderedElement rendered);
    rendered
  };
  let checkApplyUpdateLogs updateLog renderedElement newRenderedElement => {
    let outputTree = OutputTree.fromRenderedElement renderedElement;
    let newOutputTree = OutputTree.fromRenderedElement newRenderedElement;
    let outputTreeAfterApply = OutputTree.applyUpdateLog updateLog outputTree;
    let newOutputTreeString = OutputTree.print newOutputTree;
    let outputTreeAfterApplyString = OutputTree.print outputTreeAfterApply;
    if (newOutputTreeString != outputTreeAfterApplyString) {
      logString "Tree expected after updateLog:";
      logString newOutputTreeString;
      logString "Tree found:";
      logString outputTreeAfterApplyString;
      assert false
    }
  };
  let updateAndPrint ::msg renderedElement reactElement => {
    logMsg ::msg;
    let (newRenderedElement, updateLog) = RenderedElement.update renderedElement reactElement;
    checkApplyUpdateLogs updateLog renderedElement newRenderedElement;
    logString (printRenderedElement newRenderedElement);
    newRenderedElement
  };
  let flushAndPrint ::msg renderedElement => {
    logMsg ::msg;
    let (newRenderedElement, updateLog) = RenderedElement.flushPendingUpdates renderedElement;
    checkApplyUpdateLogs updateLog renderedElement newRenderedElement;
    logString (printRenderedElement newRenderedElement);
    newRenderedElement
  };
  let printAll renderedElements => {
    logMsg msg::"Trees rendered";
    print_string (printRenderedElementList renderedElements)
  };
};

module RunTest1 = {
  open TestUtils;
  startTest msg::"Test 1";
  let rendered0 = renderAndPrint msg::"BoxWrapper with one box" <BoxWrapper />;
  let rendered1 =
    updateAndPrint msg::"BoxWrapper with two boxes" rendered0 <BoxWrapper twoBoxes=true />;
  printAll [rendered0, rendered1];
};

module RunTest2 = {
  open TestUtils;
  startTest msg::"Test 2";
  let rendered0 = renderAndPrint msg::"Initial Tree" <ChangeCounter label="defaultText" />;
  let rendered1 =
    updateAndPrint
      msg::"Updating Tree With Same Label (ChangeCounter)"
      rendered0
      <ChangeCounter label="defaultText" />;
  let rendered2 =
    updateAndPrint
      msg::"Updating Tree With New Label (ChangeCounter)"
      rendered1
      <ChangeCounter label="updatedText" />;
  let rendered2f = flushAndPrint msg::"Flushing (ChangeCounter)" rendered2;
  let rendered2f = flushAndPrint msg::"Flushing #2 (ChangeCounter)" rendered2f;
  let rendered2f = flushAndPrint msg::"Flushing #3 (ChangeCounter)" rendered2f;
  let rendered3 =
    updateAndPrint
      msg::"Updating Tree With New Root Type (ButtonWrapperWrapper)"
      rendered2f
      <ButtonWrapperWrapper wrappedText="updatedText" />;
  let rendered4 =
    updateAndPrint
      msg::"Updating Tree With Same Root Type as Previous (ButtonWrapperWrapper)"
      rendered3
      <ButtonWrapperWrapper wrappedText="updatedTextmodified" />;
  printAll [rendered0, rendered1, rendered2, rendered2f, rendered3, rendered4];
};

module RunTestListsWithCID = {
  open ReasonReact;
  open TestUtils;
  startTest msg::"Test Lists With CID";
  let runAction = RunAction.create ();
  let rendered0 = renderAndPrint msg::"Initial BoxList" <BoxList useCID=true runAction />;
  RunAction.run runAction action::(BoxList.Create "Hello");
  let rendered1 = flushAndPrint msg::"Add Hello then Flush" rendered0;
  RunAction.run runAction action::(BoxList.Create "World");
  let rendered2 = flushAndPrint msg::"Add World then Flush" rendered1;
  RunAction.run runAction action::BoxList.Reverse;
  let rendered3 = flushAndPrint msg::"Reverse then Flush" rendered2;
  printAll [rendered0, rendered1, rendered2, rendered3];
};

module RunTestListsWithoutCID = {
  open ReasonReact;
  open TestUtils;
  startTest msg::"Test Lists Without CID";
  let runAction = RunAction.create ();
  let rendered0 = renderAndPrint msg::"Initial BoxList" <BoxList useCID=false runAction />;
  RunAction.run runAction action::(BoxList.Create "Hello");
  let rendered1 = flushAndPrint msg::"Add Hello then Flush" rendered0;
  RunAction.run runAction action::(BoxList.Create "World");
  let rendered2 = flushAndPrint msg::"Add World then Flush" rendered1;
  RunAction.run runAction action::BoxList.Reverse;
  let rendered3 = flushAndPrint msg::"Reverse then Flush" rendered2;
  printAll [rendered0, rendered1, rendered2, rendered3];
};

module TestDeepMove = {
  open TestUtils;
  startTest msg::"Test Deep Move Box With CID";
  let box = <BoxWithCID title="box to move" />;
  let rendered0 = renderAndPrint msg::"Initial Box" box;
  let rendered1 =
    updateAndPrint
      msg::"Add 2 Levels of div"
      rendered0
      <div>
        (ReasonReact.stringToElement "first level before")
        <div>
          (ReasonReact.stringToElement "second level before")
          box
          (ReasonReact.stringToElement "second level after")
        </div>
        (ReasonReact.stringToElement "first level after")
      </div>;
  printAll [rendered0, rendered1];
};

module PerfTest = {
  open TestUtils;
  open ReasonReact;
  let savedDebug = !GlobalState.debug;
  let runAction = RunAction.create ();
  let iterationsWithoutFlush = 0;
  let iterationsWithFlush = 1000000;
  let testLogUpdate = false;
  let useCID = true;
  let runTest () => {
    startTest msg::"";
    GlobalState.debug := false;
    GlobalState.useTailHack := true;
    let rendered0 = renderAndPrint msg::"Initial BoxList" <BoxList useCID runAction />;
    let currentRenderedElement = ref rendered0;
    let currentOutputTree = ref (OutputTree.fromRenderedElement !currentRenderedElement);
    for i in 1 to iterationsWithoutFlush {
      RunAction.run runAction action::(BoxList.Create (string_of_int i))
    };
    let (newRenderedElement, updateLog) =
      RenderedElement.flushPendingUpdates !currentRenderedElement;
    currentRenderedElement := newRenderedElement;
    currentOutputTree := OutputTree.applyUpdateLog updateLog !currentOutputTree;
    for i in 1 to iterationsWithFlush {
      RunAction.run runAction action::(BoxList.Create (string_of_int i));
      let (newRenderedElement, updateLog) =
        RenderedElement.flushPendingUpdates !currentRenderedElement;
      currentRenderedElement := newRenderedElement;
      currentOutputTree := OutputTree.applyUpdateLog updateLog !currentOutputTree
    };
    if (
      testLogUpdate
      && OutputTree.print (OutputTree.fromRenderedElement !currentRenderedElement)
      != OutputTree.print !currentOutputTree
    ) {
      assert false
    };
    GlobalState.debug := savedDebug
  };
  /* runTest (); */
};