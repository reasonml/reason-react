open Jest;
open Jest.Expect;
open ReactDOMTestUtils;
open Belt;

module FormData = React.Experimental.FormData;

/* https://react.dev/blog/2022/03/08/react-18-upgrade-guide#configuring-your-testing-environment */
[%%mel.raw "globalThis.IS_REACT_ACT_ENVIRONMENT = true"];

type message = {
  text: string,
  sending: bool,
  key: int,
};

[@mel.send.pipe: Dom.element] external reset: unit = "reset";

let (let.await) = (p, f) => Js.Promise.then_(f, p);

module Thread = {
  [@react.component]
  let make = (~messages, ~sendMessage) => {
    let formRef = React.useRef(Js.Nullable.null);
    let (optimisticMessages, addOptimisticMessage) =
      React.Experimental.useOptimistic(messages, (state, newMessage) =>
        [
          {text: newMessage, sending: true, key: List.length(state) + 1},
          ...state,
        ]
      );

    let formAction = formData => {
      let formMessage = FormData.get("message", formData);
      switch (formMessage) {
      | Some(entry) =>
        switch (Js.Types.classify(entry)) {
        | JSString(text) =>
          addOptimisticMessage(text);
          switch (Js.Nullable.toOption(formRef.current)) {
          | Some(form) => reset(form)
          | None => ()
          };
          let.await _ = sendMessage(formData);
          Js.Promise.resolve();
        | _ => Js.Promise.resolve()
        }
      | None => Js.Promise.resolve()
      };
    };
    <>
      {{
         optimisticMessages->Belt.List.map(message =>
           <div key={Int.toString(message.key)}>
             {React.string(message.text)}
             {message.sending
                ? React.null
                : <small> {React.string("(Enviando...)")} </small>}
           </div>
         );
       }
       ->Belt.List.toArray
       ->React.array}
      {React.cloneElement(
         ReactDOM.createElement(
           "form",
           ~props=ReactDOM.domProps(~ref=ReactDOM.Ref.domRef(formRef), ()),
           [|
             <input type_="text" name="message" placeholder="Hola!" />,
             <button type_="submit"> {React.string("Enviar")} </button>,
           |],
         ),
         {"action": formAction},
       )}
    </>;
  };
};

module App = {
  let deliverMessage = message => {
    Js.Promise.resolve(message);
  };

  [@react.component]
  let make = () => {
    let (messages, setMessages) =
      React.useState(() => [{text: "¡Hola!", sending: false, key: 1}]);

    let sendMessage = formData => {
      let formMessage = FormData.get("message", formData);
      switch (formMessage) {
      | Some(message) =>
        let.await entry = deliverMessage(message);
        switch (Js.Types.classify(entry)) {
        | JSString(text) =>
          let _ =
            setMessages(messages =>
              [{text, sending: true, key: 1}, ...messages]
            );
          Js.Promise.resolve();
        | _ => Js.Promise.resolve()
        };
      | None => Js.Promise.resolve()
      };
    };

    <Thread messages sendMessage />;
  };
};

describe("Form with useOptimistic", () => {
  let container = ref(None);

  beforeEach(prepareContainer(container));
  afterEach(cleanupContainer(container));

  test("should render the form", () => {
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    act(() => ReactDOM.Client.render(root, <App />));

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
});
