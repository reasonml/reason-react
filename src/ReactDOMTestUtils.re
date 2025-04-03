type undefined = Js.undefined(unit);

let undefined: undefined = Js.Undefined.empty;

[@mel.module "react"]
external reactAct: ((. unit) => undefined) => unit = "act";

[@deprecated "use React.act instead"]
let act: (unit => unit) => unit =
  func => {
    let reactFunc =
      (.) => {
        func();
        undefined;
      };
    reactAct(reactFunc);
  };

[@mel.module "react"]
external reactActAsync: ((. unit) => Js.Promise.t('a)) => Js.Promise.t(unit) =
  "act";

[@deprecated "use React.actAsync instead"]
let actAsync = func => {
  let reactFunc =
    (.) => {
      func();
    };
  reactActAsync(reactFunc);
};

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
[@mel.module "react-dom/test-utils"]
external isElement: 'element => bool = "isElement";

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
[@mel.module "react-dom/test-utils"]
external isElementOfType: ('element, React.component('props)) => bool =
  "isElementOfType";

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
[@mel.module "react-dom/test-utils"]
external isDOMComponent: 'element => bool = "isDOMComponent";

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
[@mel.module "react-dom/test-utils"]
external isCompositeComponent: 'element => bool = "isCompositeComponent";

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
[@mel.module "react-dom/test-utils"]
external isCompositeComponentWithType:
  ('element, React.component('props)) => bool =
  "isCompositeComponentWithType";

module Simulate = {
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external click: Dom.element => unit = "click";

  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external clickWithEvent: (Dom.element, 'event) => unit = "click";
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external change: Dom.element => unit = "change";

  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external blur: Dom.element => unit = "blur";

  [@mel.module "react-dom/test-utils"] [@mel.scope "Simulate"]
  external changeWithEvent: (Dom.element, 'event) => unit = "change";

  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  let changeWithValue = (element, value) => {
    let event = {
      "target": {
        "value": value,
      },
    };
    changeWithEvent(element, event);
  };

  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  let changeWithChecked = (element, value) => {
    let event = {
      "target": {
        "checked": value,
      },
    };
    changeWithEvent(element, event);
  };
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external canPlay: Dom.element => unit = "canPlay";
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external timeUpdate: Dom.element => unit = "timeUpdate";
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external ended: Dom.element => unit = "ended";
  [@mel.module "react-dom/test-utils"] [@mel.scope "Simulate"]
  external focus: Dom.element => unit = "focus";
};

external document: Dom.document = "document";

[@mel.return nullable] [@mel.send]
external querySelector: (Dom.element, string) => option(Dom.element) =
  "querySelector";

[@mel.send]
external querySelectorAll:
  (Dom.element, string) => Js.Array.array_like(Dom.element) =
  "querySelectorAll";

[@mel.get] external textContent: Dom.element => string = "textContent";

[@mel.return nullable] [@mel.get]
external body: Dom.document => option(Dom.element) = "body";

[@mel.send]
external createElement: (Dom.document, string) => Dom.element =
  "createElement";

[@mel.send] external remove: Dom.element => unit = "remove";

[@mel.send]
external appendChild: (Dom.element, Dom.element) => Dom.element =
  "appendChild";

let querySelectorAll = (element, string) => {
  Js.Array.from(querySelectorAll(element, string));
};

module DOM = {
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
  ]
  [@mel.return nullable]
  [@mel.get]
  external value: Dom.element => option(string) = "value";

  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
  ]
  let findBySelector = (element, selector) =>
    querySelector(element, selector);

  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
  ]
  let findByAllSelector = (element, selector) =>
    querySelectorAll(element, selector);

  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
  ]
  let findBySelectorAndTextContent = (element, selector, content) =>
    querySelectorAll(element, selector)
    |> Array.find_opt(node => node->textContent === content);

  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
  ]
  let findBySelectorAndPartialTextContent = (element, selector, content) =>
    querySelectorAll(element, selector)
    |> Array.find_opt(node =>
         Js.String.includes(~search=content, node->textContent)
       );
};

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
let prepareContainer = (container: ref(option(Dom.element)), ()) => {
  let containerElement = document->createElement("div");
  let _: option(_) =
    Option.map(body => body->appendChild(containerElement), document->body);
  container := Some(containerElement);
};

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
let cleanupContainer = (container: ref(option(Dom.element)), ()) => {
  let _: option(_) = Option.map(remove, container^);
  container := None;
};

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
let getContainer = container => {
  container.contents->Option.get;
};
