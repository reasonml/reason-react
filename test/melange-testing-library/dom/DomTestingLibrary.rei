module FireEvent = FireEvent;

module ByLabelTextQuery: {
  type options = {
    .
    "selector": Js.undefined(string),
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };
  [@mel.obj]
  external makeOptions:
    (
      ~selector: string=?,
      ~exact: bool=?,
      ~normalizer: string => string=?,
      unit
    ) =>
    options;
};
module ByPlaceholderTextQuery: {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };
  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module ByTextQuery: {
  type options = {
    .
    "exact": Js.undefined(bool),
    "selector": Js.undefined(string),
    "ignore": Js.undefined(string),
    "normalizer": Js.undefined(string => string),
  };
  [@mel.obj]
  external makeOptions:
    (
      ~exact: bool=?,
      ~selector: string=?,
      ~ignore: string=?,
      ~normalizer: string => string=?,
      unit
    ) =>
    options;
};
module ByAltTextQuery: {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };
  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module ByTitleQuery: {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };
  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module ByDisplayValueQuery: {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };
  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module ByRoleQuery: {
  type options = {
    .
    "checked": Js.undefined(bool),
    "collapseWhitespace": Js.undefined(bool),
    "exact": Js.undefined(bool),
    "hidden": Js.undefined(bool),
    "level": Js.undefined(int),
    "pressed": Js.undefined(bool),
    "name": Js.undefined(string),
    "normalizer": Js.undefined(string => string),
    "queryFallbacks": Js.undefined(bool),
    "selected": Js.undefined(bool),
    "trim": Js.undefined(bool),
  };
  [@mel.obj]
  external makeOptions:
    (
      ~checked: bool=?,
      ~collapseWhitespace: bool=?,
      ~exact: bool=?,
      ~hidden: bool=?,
      ~level: int=?,
      ~pressed: bool=?,
      ~name: string=?,
      ~normalizer: string => string=?,
      ~queryFallbacks: bool=?,
      ~selected: bool=?,
      ~trim: bool=?,
      unit
    ) =>
    options;
};
module ByTestIdQuery: {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };
  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module MutationObserver: {
  type options = {
    .
    "attributeFilter": Js.undefined(array(string)),
    "attributeOldValue": Js.undefined(bool),
    "attributes": Js.undefined(bool),
    "characterData": Js.undefined(bool),
    "characterDataOldValue": Js.undefined(bool),
    "childList": Js.undefined(bool),
    "subtree": Js.undefined(bool),
  };
  [@mel.obj]
  external makeOptions:
    (
      ~attributeFilter: array(string)=?,
      ~attributeOldValue: bool=?,
      ~attributes: bool=?,
      ~characterData: bool=?,
      ~characterDataOldValue: bool=?,
      ~childList: bool=?,
      ~subtree: bool=?,
      unit
    ) =>
    options;
};
module WaitFor: {
  type options = {
    .
    "container": Js.undefined(Dom.element),
    "interval": Js.undefined(int),
    "mutationObserverOptions": Js.undefined(MutationObserver.options),
    "onTimeout": Js.undefined(Js.Exn.t => Js.Exn.t),
    "showOriginalStackTrace": Js.undefined(bool),
    "stackTraceError": Js.undefined(Js.Exn.t),
    "timeout": Js.undefined(int),
  };
  [@mel.obj]
  external makeOptions:
    (
      ~container: Dom.element=?,
      ~interval: int=?,
      ~mutationObserverOptions: MutationObserver.options=?,
      ~onTimeout: Js.Exn.t => Js.Exn.t=?,
      ~showOriginalStackTrace: bool=?,
      ~stackTraceError: Js.Exn.t=?,
      ~timeout: int=?,
      unit
    ) =>
    options;
};
module WaitForElement: {
  type options = {
    .
    "container": Js.undefined(Dom.element),
    "timeout": Js.undefined(int),
  };
  [@mel.obj]
  external makeOptions:
    (
      ~container: Dom.element=?,
      ~mutationObserverInit: MutationObserver.options=?,
      ~timeout: int=?,
      unit
    ) =>
    options;
};

let waitFor:
  (~callback: unit => unit, ~options: WaitFor.options=?, unit) =>
  Js.Promise.t('a);

let waitForPromise:
  (~callback: unit => Js.Promise.t('a), ~options: WaitFor.options=?, unit) =>
  Js.Promise.t('b);

let waitForElement:
  (~callback: unit => 'a=?, ~options: WaitForElement.options=?, unit) =>
  Js.Promise.t('a);

let waitForElementToBeRemoved:
  (
    ~callback: [
      | `Func(unit => 'a)
      | `Value('a)
    ],
    ~options: WaitFor.options=?,
    unit
  ) =>
  Js.Promise.t(unit);

let prettyDOM: (~maxLength: int=?, Dom.element) => string;

let logDOM: (~maxLength: int=?, Dom.element) => unit;

module Configure: {
  type options = {
    .
    "_disableExpensiveErrorDiagnostics": Js.undefined(bool),
    "asyncUtilTimeout": Js.undefined(int),
    "asyncWrapper": Js.undefined(unit => unit),
    "computedStyleSupportsPseudoElements": Js.undefined(bool),
    "defaultHidden": Js.undefined(bool),
    "eventWrapper": Js.undefined(unit => unit),
    "getElementError": Js.undefined((string, Dom.element) => Js.Exn.t),
    "showOriginalStackTrace": Js.undefined(bool),
    "testIdAttribute": Js.undefined(string),
    "throwSuggestions": Js.undefined(bool),
  };
  [@mel.obj]
  external makeOptions:
    (
      ~_disableExpensiveErrorDiagnostics: bool=?,
      ~asyncUtilTimeout: int=?,
      ~asyncWrapper: unit => unit=?,
      ~computedStyleSupportsPseudoElements: bool=?,
      ~defaultHidden: bool=?,
      ~eventWrapper: unit => unit=?,
      ~getElementError: (string, Dom.element) => Js.Exn.t=?,
      ~showOriginalStackTrace: bool=?,
      ~testIdAttribute: string=?,
      ~throwSuggestions: bool=?,
      unit
    ) =>
    options;
};

let configure:
  (
    ~update: [
      | `Func(Configure.options => Configure.options)
      | `Object(Configure.options)
    ]
  ) =>
  unit;

[@mel.module "@testing-library/dom"]
external getNodeText: Dom.element => string = "getNodeText";

/**
 * ByLabelText
 */
let getByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByLabelTextQuery.options=?,
    Dom.element
  ) =>
  Dom.element;

let getAllByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByLabelTextQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let queryByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByLabelTextQuery.options=?,
    Dom.element
  ) =>
  Js.null(Dom.element);

let queryAllByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByLabelTextQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let findByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByLabelTextQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(Dom.element);

let findAllByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByLabelTextQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(array(Dom.element));

/**
 * ByPlaceholderText
 */
let getByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByPlaceholderTextQuery.options=?,
    Dom.element
  ) =>
  Dom.element;

let getAllByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByPlaceholderTextQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let queryByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByPlaceholderTextQuery.options=?,
    Dom.element
  ) =>
  Js.null(Dom.element);

let queryAllByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByPlaceholderTextQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let findByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByPlaceholderTextQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(Dom.element);

let findAllByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByPlaceholderTextQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(array(Dom.element));

/**
 * ByText
 */
let getByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTextQuery.options=?,
    Dom.element
  ) =>
  Dom.element;

let getAllByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTextQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let queryByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTextQuery.options=?,
    Dom.element
  ) =>
  Js.null(Dom.element);

let queryAllByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTextQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let findByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTextQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(Dom.element);

let findAllByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTextQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(array(Dom.element));

/**
 * ByAltText
 */
let getByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByAltTextQuery.options=?,
    Dom.element
  ) =>
  Dom.element;

let getAllByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByAltTextQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let queryByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByAltTextQuery.options=?,
    Dom.element
  ) =>
  Js.null(Dom.element);

let queryAllByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByAltTextQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let findByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByAltTextQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(Dom.element);

let findAllByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByAltTextQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(array(Dom.element));

/**
 * ByTitle
 */
let getByTitle:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTitleQuery.options=?,
    Dom.element
  ) =>
  Dom.element;

let getAllByTitle:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTitleQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let queryByTitle:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTitleQuery.options=?,
    Dom.element
  ) =>
  Js.null(Dom.element);

let queryAllByTitle:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTitleQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let findByTitle:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTitleQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(Dom.element);

let findAllByTitle:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTitleQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(array(Dom.element));

/**
 * ByDisplayValue
 */
let getByDisplayValue:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByDisplayValueQuery.options=?,
    Dom.element
  ) =>
  Dom.element;

let getAllByDisplayValue:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByDisplayValueQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let queryByDisplayValue:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByDisplayValueQuery.options=?,
    Dom.element
  ) =>
  Js.null(Dom.element);

let queryAllByDisplayValue:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByDisplayValueQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let findByDisplayValue:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByDisplayValueQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(Dom.element);

let findAllByDisplayValue:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByDisplayValueQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(array(Dom.element));

/**
 * ByRole
 */
let getByRole:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByRoleQuery.options=?,
    Dom.element
  ) =>
  Dom.element;

let getAllByRole:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByRoleQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let queryByRole:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByRoleQuery.options=?,
    Dom.element
  ) =>
  Js.null(Dom.element);

let queryAllByRole:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByRoleQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let findByRole:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByRoleQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(Dom.element);

let findAllByRole:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByRoleQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(array(Dom.element));

/**
 * ByTestId
 */
let getByTestId:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTestIdQuery.options=?,
    Dom.element
  ) =>
  Dom.element;

let getAllByTestId:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTestIdQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let queryByTestId:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTestIdQuery.options=?,
    Dom.element
  ) =>
  Js.null(Dom.element);

let queryAllByTestId:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTestIdQuery.options=?,
    Dom.element
  ) =>
  array(Dom.element);

let findByTestId:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTestIdQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(Dom.element);

let findAllByTestId:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: ByTestIdQuery.options=?,
    Dom.element
  ) =>
  Js.Promise.t(array(Dom.element));
