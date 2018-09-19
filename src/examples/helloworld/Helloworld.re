module Helloworld = {
  let component = ReasonReact.statelessComponent("Counter");
  let make = _ => {
    ...component,
    render: _self => <div> "Helloworld"->ReasonReact.string </div>,
  };
};

ReactDOMRe.renderToElementWithId(<Helloworld />, "root");
