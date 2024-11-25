let act: [@deprecated "use React.act instead"] ((unit => unit) => unit);

let actAsync:
  [@deprecated "use React.actAsync instead"] (
    (unit => Js.Promise.t('a)) => Js.Promise.t(unit)
  );

[@mel.module "react-dom/test-utils"]
[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
external isElement: 'element => bool = "isElement";

[@mel.module "react-dom/test-utils"]
[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
external isElementOfType: ('element, React.component('props)) => bool =
  "isElementOfType";

[@mel.module "react-dom/test-utils"]
[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
external isDOMComponent: 'element => bool = "isDOMComponent";

[@mel.module "react-dom/test-utils"]
[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
external isCompositeComponent: 'element => bool = "isCompositeComponent";

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
[@mel.module "react-dom/test-utils"]
external isCompositeComponentWithType:
  ('element, React.component('props)) => bool =
  "isCompositeComponentWithType";

module Simulate: {
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
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external changeWithEvent: (Dom.element, 'event) => unit = "change";
  let changeWithValue: (Dom.element, string) => unit;
  let changeWithChecked: (Dom.element, bool) => unit;
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
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
  ]
  [@mel.module "react-dom/test-utils"]
  [@mel.scope "Simulate"]
  external focus: Dom.element => unit = "focus";
};

module DOM: {
  [@deprecated
    "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
  ]
  [@mel.return nullable]
  [@mel.get]
  external value: Dom.element => option(string) = "value";

  let findBySelector:
    [@deprecated
      "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
    ] (
      (Dom.element, string) => option(Dom.element)
    );
  let findByAllSelector:
    [@deprecated
      "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
    ] (
      (Dom.element, string) => array(Dom.element)
    );
  let findBySelectorAndTextContent:
    [@deprecated
      "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
    ] (
      (Dom.element, string, string) => option(Dom.element)
    );
  let findBySelectorAndPartialTextContent:
    [@deprecated
      "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-webapi instead."
    ] (
      (Dom.element, string, string) => option(Dom.element)
    );
};

[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
let prepareContainer: (Stdlib.ref(option(Dom.element)), unit) => unit;
[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
let cleanupContainer: (Stdlib.ref(option(Dom.element)), unit) => unit;
[@deprecated
  "ReactDOMTestUtils is deprecated, and will be removed in next version. Please use melange-testing-library instead."
]
let getContainer: Stdlib.ref(option(Dom.element)) => Dom.element;
