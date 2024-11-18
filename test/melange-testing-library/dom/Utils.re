module MutationObserver = {
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

module WaitFor = {
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

module WaitForElement = {
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

[@mel.module "@testing-library/dom"]
external _waitFor:
  (unit => unit, Js.undefined(WaitFor.options)) => Js.Promise.t('a) =
  "waitFor";

let waitFor = (~callback, ~options=?, ()) =>
  _waitFor(callback, Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _waitForPromise:
  (unit => Js.Promise.t('a), Js.undefined(WaitFor.options)) =>
  Js.Promise.t('b) =
  "waitFor";

let waitForPromise = (~callback, ~options=?, ()) =>
  _waitForPromise(callback, Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _waitForElement:
  (Js.undefined(unit => 'a), Js.undefined(WaitForElement.options)) =>
  Js.Promise.t('a) =
  "waitForElement";

let waitForElement = (~callback=?, ~options=?, ()) =>
  _waitForElement(
    Js.Undefined.fromOption(callback),
    Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _waitForElementToBeRemoved:
  (
    ~callback: [@mel.unwrap] [ | `Func(unit => 'a) | `Value('a)],
    Js.undefined(WaitFor.options)
  ) =>
  Js.Promise.t(unit) =
  "waitForElementToBeRemoved";

let waitForElementToBeRemoved = (~callback, ~options=?, ()) =>
  _waitForElementToBeRemoved(~callback, Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _prettyDOM: (Dom.element, Js.undefined(int)) => string = "prettyDOM";

let prettyDOM = (~maxLength=?, element) =>
  _prettyDOM(element, Js.Undefined.fromOption(maxLength));

[@mel.module "@testing-library/dom"]
external _logDOM: (Dom.element, Js.undefined(int)) => unit = "logDOM";

let logDOM = (~maxLength=?, element) =>
  _logDOM(element, Js.Undefined.fromOption(maxLength));

module Configure = {
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

[@mel.module "@testing-library/dom"]
external configureWithFn: (Js.t({..}) => Js.t({..})) => unit = "configure";

[@mel.module "@testing-library/dom"]
external configureWithObject: Configure.options => unit = "configure";

let configure =
    (
      ~update: [
         | `Func(Configure.options => Configure.options)
         | `Object(Configure.options)
       ],
    ) => {
  switch (update) {
  | `Func(fn) => configureWithFn(fn)
  | `Object(obj) => configureWithObject(obj)
  };
};
