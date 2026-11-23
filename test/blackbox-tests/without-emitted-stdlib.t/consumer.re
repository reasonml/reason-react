module App = {
  [@react.component]
  let make = () => <div> "Hello"->React.string </div>;
};

let url =
  ReasonReactRouter.dangerouslyGetInitialUrl(~serverUrlString="/foo/bar", ());

let findText = ReactDOMTestUtils.DOM.findBySelectorAndTextContent;
let findPartialText = ReactDOMTestUtils.DOM.findBySelectorAndPartialTextContent;
let renderToPipeableStream = ReactDOMServerNode.renderToPipeableStream;
