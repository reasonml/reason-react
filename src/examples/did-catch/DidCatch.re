module Child = {
  type action =
    | Error;
  type state = {error: bool};
  let component = ReasonReact.reducerComponent("Error");
  let make = (~value as _, _) =>
    ReasonReact.Reducer({
      ...component,
      reducer: (action, _state) =>
        switch (action) {
        | Error => Update({error: true})
        },
      render: ({state, send}) =>
        <div>
          {
            state.error ?
              {
                raise(Invalid_argument("Error from <Child />"))->ignore;
                ReasonReact.null;
              } :
              ReasonReact.null
          }
          <button onClick={_ => send(Error)}>
            "throw error"->ReasonReact.string
          </button>
        </div>,
    });
};

module DidCatch = {
  type action =
    | HandleError(string);
  type state = {error: option(string)};
  let component = ReasonReact.reducerComponent("DidCatch");
  let make = children =>
    ReasonReact.Reducer({
      ...component,
      initialState: () => {error: None},
      reducer: (action, _state) =>
        switch (action) {
        | HandleError(string) => Update({error: Some(string)})
        },
      didMount: _ => Js.log("didMount"),
      willUpdate: ({oldSelf, newSelf}) => {
        Js.log("willUpdate");
        Js.log2(oldSelf.state, newSelf.state);
      },
      didUpdate: ({oldSelf, newSelf}) => {
        Js.log("didUpdate");
        Js.log2(oldSelf.state, newSelf.state);
      },
      didCatch: ({send}, exn, info) => {
        Js.log(info.componentStack);
        switch (exn) {
        | Invalid_argument(value) => send(HandleError(value))
        | _ => ()
        };
      },
      render: ({state}) =>
        <div>
          {
            switch (state.error) {
            | Some(error) =>
              ("An error occured: " ++ error)->ReasonReact.string
            | None =>
              switch (children) {
              | [|child|] => child
              | _ => ReasonReact.null
              }
            }
          }
        </div>,
    });
};

ReactDOMRe.renderToElementWithId(
  <DidCatch> <Child value="1" /> </DidCatch>,
  "root",
);
