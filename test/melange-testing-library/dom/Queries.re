module ByLabelTextQuery = {
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
module ByPlaceholderTextQuery = {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };

  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module ByTextQuery = {
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
module ByAltTextQuery = {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };

  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module ByTitleQuery = {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };

  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module ByDisplayValueQuery = {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };

  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};
module ByRoleQuery = {
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
module ByTestIdQuery = {
  type options = {
    .
    "exact": Js.undefined(bool),
    "normalizer": Js.undefined(string => string),
  };

  [@mel.obj]
  external makeOptions:
    (~exact: bool=?, ~normalizer: string => string=?, unit) => options;
};

[@mel.module "@testing-library/dom"]
external getNodeText: Dom.element => string = "getNodeText";

/**
 * ByLabelText
 */
[@mel.module "@testing-library/dom"]
external _getByLabelText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByLabelTextQuery.options)
  ) =>
  Dom.element =
  "getByLabelText";

let getByLabelText = (~matcher, ~options=?, element) =>
  _getByLabelText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _getAllByLabelText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByLabelTextQuery.options)
  ) =>
  array(Dom.element) =
  "getAllByLabelText";

let getAllByLabelText = (~matcher, ~options=?, element) =>
  _getAllByLabelText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryByLabelText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByLabelTextQuery.options)
  ) =>
  Js.null(Dom.element) =
  "queryByLabelText";

let queryByLabelText = (~matcher, ~options=?, element) =>
  _queryByLabelText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryAllByLabelText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByLabelTextQuery.options)
  ) =>
  array(Dom.element) =
  "queryAllByLabelText";

let queryAllByLabelText = (~matcher, ~options=?, element) =>
  _queryAllByLabelText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findByLabelText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByLabelTextQuery.options)
  ) =>
  Js.Promise.t(Dom.element) =
  "findByLabelText";

let findByLabelText = (~matcher, ~options=?, element) =>
  _findByLabelText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findAllByLabelText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByLabelTextQuery.options)
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByLabelText";

let findAllByLabelText = (~matcher, ~options=?, element) =>
  _findAllByLabelText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

/**
 * ByPlaceholderText
 */
[@mel.module "@testing-library/dom"]
external _getByPlaceholderText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options)
  ) =>
  Dom.element =
  "getByPlaceholderText";

let getByPlaceholderText = (~matcher, ~options=?, element) =>
  _getByPlaceholderText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _getAllByPlaceholderText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options)
  ) =>
  array(Dom.element) =
  "getAllByPlaceholderText";

let getAllByPlaceholderText = (~matcher, ~options=?, element) =>
  _getAllByPlaceholderText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryByPlaceholderText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options)
  ) =>
  Js.null(Dom.element) =
  "queryByPlaceholderText";

let queryByPlaceholderText = (~matcher, ~options=?, element) =>
  _queryByPlaceholderText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryAllByPlaceholderText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options)
  ) =>
  array(Dom.element) =
  "queryAllByPlaceholderText";

let queryAllByPlaceholderText = (~matcher, ~options=?, element) =>
  _queryAllByPlaceholderText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findByPlaceholderText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options)
  ) =>
  Js.Promise.t(Dom.element) =
  "findByPlaceholderText";

let findByPlaceholderText = (~matcher, ~options=?, element) =>
  _findByPlaceholderText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findAllByPlaceholderText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options)
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByPlaceholderText";

let findAllByPlaceholderText = (~matcher, ~options=?, element) =>
  _findAllByPlaceholderText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

/**
 * ByText
 */
[@mel.module "@testing-library/dom"]
external _getByText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByTextQuery.options)
  ) =>
  Dom.element =
  "getByText";

let getByText = (~matcher, ~options=?, element) =>
  _getByText(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _getAllByText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByTextQuery.options)
  ) =>
  array(Dom.element) =
  "getAllByText";

let getAllByText = (~matcher, ~options=?, element) =>
  _getAllByText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryByText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByTextQuery.options)
  ) =>
  Js.null(Dom.element) =
  "queryByText";

let queryByText = (~matcher, ~options=?, element) =>
  _queryByText(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _queryAllByText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByTextQuery.options)
  ) =>
  array(Dom.element) =
  "queryAllByText";

let queryAllByText = (~matcher, ~options=?, element) =>
  _queryAllByText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findByText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByTextQuery.options)
  ) =>
  Js.Promise.t(Dom.element) =
  "findByText";

let findByText = (~matcher, ~options=?, element) =>
  _findByText(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _findAllByText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Str(string)
                | `RegExp(Js.Re.t)
                | `Func((string, Dom.element) => bool)
              ],
    ~options: Js.undefined(ByTextQuery.options)
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByText";

let findAllByText = (~matcher, ~options=?, element) =>
  _findAllByText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

/**
 * ByAltText
 */
[@mel.module "@testing-library/dom"]
external _getByAltText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByAltTextQuery.options)
  ) =>
  Dom.element =
  "getByAltText";

let getByAltText = (~matcher, ~options=?, element) =>
  _getByAltText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _getAllByAltText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByAltTextQuery.options)
  ) =>
  array(Dom.element) =
  "getAllByAltText";

let getAllByAltText = (~matcher, ~options=?, element) =>
  _getAllByAltText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryByAltText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByAltTextQuery.options)
  ) =>
  Js.null(Dom.element) =
  "queryByAltText";

let queryByAltText = (~matcher, ~options=?, element) =>
  _queryByAltText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryAllByAltText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByAltTextQuery.options)
  ) =>
  array(Dom.element) =
  "queryAllByAltText";

let queryAllByAltText = (~matcher, ~options=?, element) =>
  _queryAllByAltText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findByAltText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByAltTextQuery.options)
  ) =>
  Js.Promise.t(Dom.element) =
  "findByAltText";

let findByAltText = (~matcher, ~options=?, element) =>
  _findByAltText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findAllByAltText:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByAltTextQuery.options)
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByAltText";

let findAllByAltText = (~matcher, ~options=?, element) =>
  _findAllByAltText(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

/**
 * ByTitle
 */
[@mel.module "@testing-library/dom"]
external _getByTitle:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTitleQuery.options)
  ) =>
  Dom.element =
  "getByTitle";

let getByTitle = (~matcher, ~options=?, element) =>
  _getByTitle(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _getAllByTitle:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTitleQuery.options)
  ) =>
  array(Dom.element) =
  "getAllByTitle";

let getAllByTitle = (~matcher, ~options=?, element) =>
  _getAllByTitle(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryByTitle:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTitleQuery.options)
  ) =>
  Js.null(Dom.element) =
  "queryByTitle";

let queryByTitle = (~matcher, ~options=?, element) =>
  _queryByTitle(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryAllByTitle:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTitleQuery.options)
  ) =>
  array(Dom.element) =
  "queryAllByTitle";

let queryAllByTitle = (~matcher, ~options=?, element) =>
  _queryAllByTitle(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findByTitle:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTitleQuery.options)
  ) =>
  Js.Promise.t(Dom.element) =
  "findByTitle";

let findByTitle = (~matcher, ~options=?, element) =>
  _findByTitle(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _findAllByTitle:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTitleQuery.options)
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByTitle";

let findAllByTitle = (~matcher, ~options=?, element) =>
  _findAllByTitle(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

/**
 * ByDisplayValue
 */
[@mel.module "@testing-library/dom"]
external _getByDisplayValue:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByDisplayValueQuery.options)
  ) =>
  Dom.element =
  "getByDisplayValue";

let getByDisplayValue = (~matcher, ~options=?, element) =>
  _getByDisplayValue(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _getAllByDisplayValue:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByDisplayValueQuery.options)
  ) =>
  array(Dom.element) =
  "getAllByDisplayValue";

let getAllByDisplayValue = (~matcher, ~options=?, element) =>
  _getAllByDisplayValue(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryByDisplayValue:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByDisplayValueQuery.options)
  ) =>
  Js.null(Dom.element) =
  "queryByDisplayValue";

let queryByDisplayValue = (~matcher, ~options=?, element) =>
  _queryByDisplayValue(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryAllByDisplayValue:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByDisplayValueQuery.options)
  ) =>
  array(Dom.element) =
  "queryAllByDisplayValue";

let queryAllByDisplayValue = (~matcher, ~options=?, element) =>
  _queryAllByDisplayValue(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findByDisplayValue:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByDisplayValueQuery.options)
  ) =>
  Js.Promise.t(Dom.element) =
  "findByDisplayValue";

let findByDisplayValue = (~matcher, ~options=?, element) =>
  _findByDisplayValue(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findAllByDisplayValue:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByDisplayValueQuery.options)
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByDisplayValue";

let findAllByDisplayValue = (~matcher, ~options=?, element) =>
  _findAllByDisplayValue(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

/**
 * ByRole
 */
[@mel.module "@testing-library/dom"]
external _getByRole:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByRoleQuery.options)
  ) =>
  Dom.element =
  "getByRole";

let getByRole = (~matcher, ~options=?, element) =>
  _getByRole(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _getAllByRole:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByRoleQuery.options)
  ) =>
  array(Dom.element) =
  "getAllByRole";

let getAllByRole = (~matcher, ~options=?, element) =>
  _getAllByRole(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryByRole:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByRoleQuery.options)
  ) =>
  Js.null(Dom.element) =
  "queryByRole";

let queryByRole = (~matcher, ~options=?, element) =>
  _queryByRole(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _queryAllByRole:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByRoleQuery.options)
  ) =>
  array(Dom.element) =
  "queryAllByRole";

let queryAllByRole = (~matcher, ~options=?, element) =>
  _queryAllByRole(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findByRole:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByRoleQuery.options)
  ) =>
  Js.Promise.t(Dom.element) =
  "findByRole";

let findByRole = (~matcher, ~options=?, element) =>
  _findByRole(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _findAllByRole:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByRoleQuery.options)
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByRole";

let findAllByRole = (~matcher, ~options=?, element) =>
  _findAllByRole(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

/**
 * ByTestId
 */
[@mel.module "@testing-library/dom"]
external _getByTestId:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTestIdQuery.options)
  ) =>
  Dom.element =
  "getByTestId";

let getByTestId = (~matcher, ~options=?, element) =>
  _getByTestId(element, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.module "@testing-library/dom"]
external _getAllByTestId:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTestIdQuery.options)
  ) =>
  array(Dom.element) =
  "getAllByTestId";

let getAllByTestId = (~matcher, ~options=?, element) =>
  _getAllByTestId(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryByTestId:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTestIdQuery.options)
  ) =>
  Js.null(Dom.element) =
  "queryByTestId";

let queryByTestId = (~matcher, ~options=?, element) =>
  _queryByTestId(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _queryAllByTestId:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTestIdQuery.options)
  ) =>
  array(Dom.element) =
  "queryAllByTestId";

let queryAllByTestId = (~matcher, ~options=?, element) =>
  _queryAllByTestId(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findByTestId:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTestIdQuery.options)
  ) =>
  Js.Promise.t(Dom.element) =
  "findByTestId";

let findByTestId = (~matcher, ~options=?, element) =>
  _findByTestId(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.module "@testing-library/dom"]
external _findAllByTestId:
  (
    Dom.element,
    ~matcher: [@mel.unwrap] [
                | `Func((string, Dom.element) => bool)
                | `RegExp(Js.Re.t)
                | `Str(string)
              ],
    ~options: Js.undefined(ByTestIdQuery.options)
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByTestId";

let findAllByTestId = (~matcher, ~options=?, element) =>
  _findAllByTestId(
    element,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );
