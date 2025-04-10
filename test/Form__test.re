open Jest;

type message = {
  text: string,
  sending: bool,
  key: int,
};

[@mel.send] external reset: Dom.element => unit = "reset";

let (let.await) = (p, f) => Js.Promise.then_(f, p);

module Thread = {
  [@react.component]
  let make = (~messages, ~sendMessage) => {
    let formRef = React.useRef(Js.Nullable.null);
    let (optimisticMessages, addOptimisticMessage) =
      React.Experimental.useOptimistic(messages, (state, newMessage) =>
        [
          {
            text: newMessage,
            sending: true,
            key: List.length(state) + 1,
          },
          ...state,
        ]
      );

    let formAction = formData => {
      let formMessage = Js.FormData.get(~name="message", formData);
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
      <div id="messages">
        {{
           optimisticMessages->Belt.List.map(message =>
             <span key={Belt.Int.toString(message.key)}>
               {React.string(message.text)}
               {message.sending
                  ? React.null
                  : <small> {React.string("(Enviando...)")} </small>}
             </span>
           );
         }
         ->Belt.List.toArray
         ->React.array}
      </div>
      {React.cloneElement(
         ReactDOM.createElement(
           "form",
           ~props=ReactDOM.domProps(~ref=ReactDOM.Ref.domRef(formRef), ()),
           [|
             <input type_="text" name="message" placeholder="message" />,
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
      React.useState(() =>
        [
          {
            text: {j|¡Hola!|j},
            sending: false,
            key: 1,
          },
        ]
      );

    let sendMessage = formData => {
      let formMessage = Js.FormData.get(~name="message", formData);
      switch (formMessage) {
      | Some(message) =>
        let.await entry = deliverMessage(message);
        switch (Js.Types.classify(entry)) {
        | JSString(text) =>
          let _ =
            setMessages(messages =>
              [
                {
                  text,
                  sending: true,
                  key: 1,
                },
                ...messages,
              ]
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

let (let.await) = (p, f) => Js.Promise.then_(f, p);

let findByString = (text, container) =>
  ReactTestingLibrary.findByText(~matcher=`Str(text), container);

let findByPlaceholderText = (text, container) =>
  ReactTestingLibrary.findByPlaceholderText(~matcher=`Str(text), container);

describe("Form with useOptimistic", () => {
  testPromise("should render the form", finish => {
    let container = ReactTestingLibrary.render(<App />);

    ReactTestingLibrary.actAsync(() => {
      let.await _ = findByString({j|¡Hola!|j}, container);

      let.await button = findByString("Enviar", container);
      let.await input = findByPlaceholderText("message", container);

      FireEvent.change(
        input,
        ~eventInit={
          "target": {
            "value": "Let's go!",
          },
        },
      );

      FireEvent.click(button);
      let.await _newMessage = findByString("Let's go!", container);
      /* If the promise resolve, means the node is found in the DOM */
      finish();
    });
  })
});
