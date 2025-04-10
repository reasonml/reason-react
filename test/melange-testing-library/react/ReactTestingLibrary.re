open DomTestingLibrary;

module FireEvent = {
  include FireEvent;
};

type renderResult;
type queries;
type renderOptions = {
  .
  "container": Js.undefined(Dom.element),
  "baseElement": Js.undefined(Dom.element),
  "hydrate": Js.undefined(bool),
  "wrapper": Js.undefined(Dom.element),
  "queries": Js.undefined(queries),
};

[@mel.module "@testing-library/react"]
external cleanup: unit => unit = "cleanup";

[@mel.module "@testing-library/react"]
external actAsync: (unit => Js.Promise.t('a)) => Js.Promise.t(unit) = "act";

[@mel.module "@testing-library/react"]
external _act: (unit => Js.undefined(Js.Promise.t('a))) => unit = "act";

let act = callback =>
  _act(() => {
    callback();
    // (work-around) BuckleScript compiles `unit` to `0`, this will cause a warning as following:
    // Warning: The callback passed to act(...) function must return undefined, or a Promise.
    Js.Undefined.empty;
  });

[@mel.module "@testing-library/react"]
external _render: (React.element, renderOptions) => renderResult = "render";

[@mel.get] external container: renderResult => Dom.element = "container";

[@mel.get] external baseElement: renderResult => Dom.element = "baseElement";

[@mel.send]
external _debug:
  (Js.undefined(Dom.element), Js.undefined(int), [@mel.this] renderResult) =>
  unit =
  "debug";

[@mel.send]
external unmount: (unit, [@mel.this] renderResult) => bool = "unmount";

[@mel.send]
external rerender: (React.element, [@mel.this] renderResult) => unit =
  "rerender";

[@mel.send]
external asFragment: (unit, [@mel.this] renderResult) => Dom.element =
  "asFragment";

// ByLabelText
[@mel.send]
external _getByLabelText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByLabelTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Dom.element =
  "getByLabelText";

let getByLabelText = (~matcher, ~options=?, result) =>
  _getByLabelText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _getAllByLabelText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByLabelTextQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "getAllByLabelText";

let getAllByLabelText = (~matcher, ~options=?, result) =>
  _getAllByLabelText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryByLabelText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByLabelTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.null(Dom.element) =
  "queryByLabelText";

let queryByLabelText = (~matcher, ~options=?, result) =>
  _queryByLabelText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryAllByLabelText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByLabelTextQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "queryAllByLabelText";

let queryAllByLabelText = (~matcher, ~options=?, result) =>
  _queryAllByLabelText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findByLabelText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByLabelTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(Dom.element) =
  "findByLabelText";

let findByLabelText = (~matcher, ~options=?, result) =>
  _findByLabelText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findAllByLabelText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByLabelTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByLabelText";

let findAllByLabelText = (~matcher, ~options=?, result) =>
  _findAllByLabelText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

// ByPlaceholderText
[@mel.send]
external _getByPlaceholderText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Dom.element =
  "getByPlaceholderText";

let getByPlaceholderText = (~matcher, ~options=?, result) =>
  _getByPlaceholderText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _getAllByPlaceholderText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "getAllByPlaceholderText";

let getAllByPlaceholderText = (~matcher, ~options=?, result) =>
  _getAllByPlaceholderText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryByPlaceholderText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.null(Dom.element) =
  "queryByPlaceholderText";

let queryByPlaceholderText = (~matcher, ~options=?, result) =>
  _queryByPlaceholderText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryAllByPlaceholderText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "queryAllByPlaceholderText";

let queryAllByPlaceholderText = (~matcher, ~options=?, result) =>
  _queryAllByPlaceholderText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findByPlaceholderText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(Dom.element) =
  "findByPlaceholderText";

let findByPlaceholderText = (~matcher, ~options=?, result) =>
  _findByPlaceholderText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findAllByPlaceholderText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByPlaceholderTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByPlaceholderText";

let findAllByPlaceholderText = (~matcher, ~options=?, result) =>
  _findAllByPlaceholderText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

// ByText
[@mel.send]
external _getByText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Dom.element =
  "getByText";

let getByText = (~matcher, ~options=?, result) =>
  _getByText(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _getAllByText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTextQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "getAllByText";

let getAllByText = (~matcher, ~options=?, result) =>
  _getAllByText(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _queryByText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.null(Dom.element) =
  "queryByText";

let queryByText = (~matcher, ~options=?, result) =>
  _queryByText(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _queryAllByText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTextQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "queryAllByText";

let queryAllByText = (~matcher, ~options=?, result) =>
  _queryAllByText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findByText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(Dom.element) =
  "findByText";

let findByText = (~matcher, ~options=?, result) =>
  _findByText(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _findAllByText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByText";

let findAllByText = (~matcher, ~options=?, result) =>
  _findAllByText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

// ByAltText
[@mel.send]
external _getByAltText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByAltTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Dom.element =
  "getByAltText";

let getByAltText = (~matcher, ~options=?, result) =>
  _getByAltText(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _getAllByAltText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByAltTextQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "getAllByAltText";

let getAllByAltText = (~matcher, ~options=?, result) =>
  _getAllByAltText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryByAltText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByAltTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.null(Dom.element) =
  "queryByAltText";

let queryByAltText = (~matcher, ~options=?, result) =>
  _queryByAltText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryAllByAltText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByAltTextQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "queryAllByAltText";

let queryAllByAltText = (~matcher, ~options=?, result) =>
  _queryAllByAltText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findByAltText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByAltTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(Dom.element) =
  "findByAltText";

let findByAltText = (~matcher, ~options=?, result) =>
  _findByAltText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findAllByAltText:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByAltTextQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByAltText";

let findAllByAltText = (~matcher, ~options=?, result) =>
  _findAllByAltText(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

// ByTitle
[@mel.send]
external _getByTitle:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTitleQuery.options),
    [@mel.this] renderResult
  ) =>
  Dom.element =
  "getByTitle";

let getByTitle = (~matcher, ~options=?, result) =>
  _getByTitle(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _getAllByTitle:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTitleQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "getAllByTitle";

let getAllByTitle = (~matcher, ~options=?, result) =>
  _getAllByTitle(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryByTitle:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTitleQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.null(Dom.element) =
  "queryByTitle";

let queryByTitle = (~matcher, ~options=?, result) =>
  _queryByTitle(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _queryAllByTitle:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTitleQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "queryAllByTitle";

let queryAllByTitle = (~matcher, ~options=?, result) =>
  _queryAllByTitle(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findByTitle:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTitleQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(Dom.element) =
  "findByTitle";

let findByTitle = (~matcher, ~options=?, result) =>
  _findByTitle(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _findAllByTitle:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTitleQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByTitle";

let findAllByTitle = (~matcher, ~options=?, result) =>
  _findAllByTitle(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

// ByDisplayValue
[@mel.send]
external _getByDisplayValue:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByDisplayValueQuery.options),
    [@mel.this] renderResult
  ) =>
  Dom.element =
  "getByDisplayValue";

let getByDisplayValue = (~matcher, ~options=?, result) =>
  _getByDisplayValue(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _getAllByDisplayValue:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByDisplayValueQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "getAllByDisplayValue";

let getAllByDisplayValue = (~matcher, ~options=?, result) =>
  _getAllByDisplayValue(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryByDisplayValue:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByDisplayValueQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.null(Dom.element) =
  "queryByDisplayValue";

let queryByDisplayValue = (~matcher, ~options=?, result) =>
  _queryByDisplayValue(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryAllByDisplayValue:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByDisplayValueQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "queryAllByDisplayValue";

let queryAllByDisplayValue = (~matcher, ~options=?, result) =>
  _queryAllByDisplayValue(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findByDisplayValue:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByDisplayValueQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(Dom.element) =
  "findByDisplayValue";

let findByDisplayValue = (~matcher, ~options=?, result) =>
  _findByDisplayValue(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findAllByDisplayValue:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByDisplayValueQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByDisplayValue";

let findAllByDisplayValue = (~matcher, ~options=?, result) =>
  _findAllByDisplayValue(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

// ByRole
[@mel.send]
external _getByRole:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByRoleQuery.options),
    [@mel.this] renderResult
  ) =>
  Dom.element =
  "getByRole";

let getByRole = (~matcher, ~options=?, result) =>
  _getByRole(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _getAllByRole:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByRoleQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "getAllByRole";

let getAllByRole = (~matcher, ~options=?, result) =>
  _getAllByRole(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _queryByRole:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByRoleQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.null(Dom.element) =
  "queryByRole";

let queryByRole = (~matcher, ~options=?, result) =>
  _queryByRole(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _queryAllByRole:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByRoleQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "queryAllByRole";

let queryAllByRole = (~matcher, ~options=?, result) =>
  _queryAllByRole(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findByRole:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByRoleQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(Dom.element) =
  "findByRole";

let findByRole = (~matcher, ~options=?, result) =>
  _findByRole(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _findAllByRole:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByRoleQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByRole";

let findAllByRole = (~matcher, ~options=?, result) =>
  _findAllByRole(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

// ByTestId
[@mel.send]
external _getByTestId:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTestIdQuery.options),
    [@mel.this] renderResult
  ) =>
  Dom.element =
  "getByTestId";

let getByTestId = (~matcher, ~options=?, result) =>
  _getByTestId(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _getAllByTestId:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTestIdQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "getAllByTestId";

let getAllByTestId = (~matcher, ~options=?, result) =>
  _getAllByTestId(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryByTestId:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTestIdQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.null(Dom.element) =
  "queryByTestId";

let queryByTestId = (~matcher, ~options=?, result) =>
  _queryByTestId(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _queryAllByTestId:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTestIdQuery.options),
    [@mel.this] renderResult
  ) =>
  array(Dom.element) =
  "queryAllByTestId";

let queryAllByTestId = (~matcher, ~options=?, result) =>
  _queryAllByTestId(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

[@mel.send]
external _findByTestId:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTestIdQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(Dom.element) =
  "findByTestId";

let findByTestId = (~matcher, ~options=?, result) =>
  _findByTestId(result, ~matcher, ~options=Js.Undefined.fromOption(options));

[@mel.send]
external _findAllByTestId:
  (
    ~matcher:
      [@mel.unwrap] [
        | `Str(string)
        | `RegExp(Js.Re.t)
        | `Func((string, Dom.element) => bool)
      ],
    ~options: Js.undefined(ByTestIdQuery.options),
    [@mel.this] renderResult
  ) =>
  Js.Promise.t(array(Dom.element)) =
  "findAllByTestId";

let findAllByTestId = (~matcher, ~options=?, result) =>
  _findAllByTestId(
    result,
    ~matcher,
    ~options=Js.Undefined.fromOption(options),
  );

let render =
    (
      ~baseElement=?,
      ~container=?,
      ~hydrate=?,
      ~wrapper=?,
      ~queries=?,
      element,
    ) => {
  let baseElement_ =
    switch (container) {
    | Some(container') => Js.Undefined.return(container')
    | None => Js.Undefined.fromOption(baseElement)
    };
  let container_ = Js.Undefined.fromOption(container);

  _render(
    element,
    {
      "baseElement": baseElement_,
      "container": container_,
      "hydrate": Js.Undefined.fromOption(hydrate),
      "wrapper": Js.Undefined.fromOption(wrapper),
      "queries": Js.Undefined.fromOption(queries),
    },
  );
};

let debug = (~el=?, ~maxLengthToPrint=?, ()) =>
  _debug(
    Js.Undefined.fromOption(el),
    Js.Undefined.fromOption(maxLengthToPrint),
  );
