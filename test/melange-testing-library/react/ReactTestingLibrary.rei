module FireEvent: {
  let abort: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let animationEnd: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let animationIteration: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let animationStart: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let blur: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let canPlay: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let canPlayThrough: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let change: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let click: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let compositionEnd: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let compositionStart: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let compositionUpdate: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let contextMenu: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let copy: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let cut: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let dblClick: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let doubleClick: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let drag: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let dragEnd: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let dragEnter: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let dragExit: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let dragLeave: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let dragOver: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let dragStart: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let drop: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let durationChange: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let emptied: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let encrypted: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let ended: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let error: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let focus: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let focusIn: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let focusOut: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let input: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let invalid: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let keyDown: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let keyPress: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let keyUp: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let load: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let loadStart: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let loadedData: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let loadedMetadata: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let mouseDown: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let mouseEnter: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let mouseLeave: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let mouseMove: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let mouseOut: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let mouseOver: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let mouseUp: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let paste: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let pause: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let play: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let playing: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let progress: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let rateChange: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let scroll: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let seeked: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let seeking: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let select: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let stalled: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let submit: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let suspend: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let timeUpdate: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let touchCancel: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let touchEnd: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let touchMove: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let touchStart: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let transitionEnd: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let volumeChange: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let waiting: (~eventInit: Js.t({..})=?, Dom.element) => unit;
  let wheel: (~eventInit: Js.t({..})=?, Dom.element) => unit;
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

let act: (unit => unit) => unit;

[@mel.get] external container: renderResult => Dom.element = "container";

[@mel.get] external baseElement: renderResult => Dom.element = "baseElement";

[@mel.send.pipe: renderResult] external unmount: unit => bool = "unmount";

[@mel.send.pipe: renderResult]
external asFragment: unit => Dom.element = "asFragment";

// ByLabelText
let getByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByLabelTextQuery.options=?,
    renderResult
  ) =>
  Dom.element;

let getAllByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByLabelTextQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let queryByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByLabelTextQuery.options=?,
    renderResult
  ) =>
  Js.null(Dom.element);

let queryAllByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByLabelTextQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let findByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByLabelTextQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(Dom.element);

let findAllByLabelText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByLabelTextQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(array(Dom.element));

// ByPlaceholderText
let getByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByPlaceholderTextQuery.options=?,
    renderResult
  ) =>
  Dom.element;

let getAllByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByPlaceholderTextQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let queryByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByPlaceholderTextQuery.options=?,
    renderResult
  ) =>
  Js.null(Dom.element);

let queryAllByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByPlaceholderTextQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let findByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByPlaceholderTextQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(Dom.element);

let findAllByPlaceholderText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByPlaceholderTextQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(array(Dom.element));

// ByText
let getByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByTextQuery.options=?,
    renderResult
  ) =>
  Dom.element;

let getAllByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByTextQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let queryByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByTextQuery.options=?,
    renderResult
  ) =>
  Js.null(Dom.element);

let queryAllByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByTextQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let findByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByTextQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(Dom.element);

let findAllByText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByTextQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(array(Dom.element));

// ByAltText
let getByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByAltTextQuery.options=?,
    renderResult
  ) =>
  Dom.element;

let getAllByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByAltTextQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let queryByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByAltTextQuery.options=?,
    renderResult
  ) =>
  Js.null(Dom.element);

let queryAllByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByAltTextQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let findByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByAltTextQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(Dom.element);

let findAllByAltText:
  (
    ~matcher: [
      | `Func((string, Dom.element) => bool)
      | `RegExp(Js.Re.t)
      | `Str(string)
    ],
    ~options: DomTestingLibrary.ByAltTextQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(array(Dom.element));

// ByTitle
let getByTitle:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTitleQuery.options=?,
    renderResult
  ) =>
  Dom.element;

let getAllByTitle:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTitleQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let queryByTitle:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTitleQuery.options=?,
    renderResult
  ) =>
  Js.null(Dom.element);

let queryAllByTitle:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTitleQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let findByTitle:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTitleQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(Dom.element);

let findAllByTitle:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTitleQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(array(Dom.element));

// ByDisplayValue
let getByDisplayValue:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByDisplayValueQuery.options=?,
    renderResult
  ) =>
  Dom.element;

let getAllByDisplayValue:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByDisplayValueQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let queryByDisplayValue:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByDisplayValueQuery.options=?,
    renderResult
  ) =>
  Js.null(Dom.element);

let queryAllByDisplayValue:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByDisplayValueQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let findByDisplayValue:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByDisplayValueQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(Dom.element);

let findAllByDisplayValue:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByDisplayValueQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(array(Dom.element));

// ByRole
let getByRole:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByRoleQuery.options=?,
    renderResult
  ) =>
  Dom.element;

let getAllByRole:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByRoleQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let queryByRole:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByRoleQuery.options=?,
    renderResult
  ) =>
  Js.null(Dom.element);

let queryAllByRole:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByRoleQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let findByRole:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByRoleQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(Dom.element);

let findAllByRole:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByRoleQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(array(Dom.element));

// ByTestId
let getByTestId:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTestIdQuery.options=?,
    renderResult
  ) =>
  Dom.element;

let getAllByTestId:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTestIdQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let queryByTestId:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTestIdQuery.options=?,
    renderResult
  ) =>
  Js.null(Dom.element);

let queryAllByTestId:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTestIdQuery.options=?,
    renderResult
  ) =>
  array(Dom.element);

let findByTestId:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTestIdQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(Dom.element);

let findAllByTestId:
  (
    ~matcher: [
      | `Str(string)
      | `RegExp(Js.Re.t)
      | `Func((string, Dom.element) => bool)
    ],
    ~options: DomTestingLibrary.ByTestIdQuery.options=?,
    renderResult
  ) =>
  Js.Promise.t(array(Dom.element));

[@mel.send.pipe: renderResult]
external rerender: React.element => unit = "rerender";

let render:
  (
    ~baseElement: Dom.element=?,
    ~container: Dom.element=?,
    ~hydrate: bool=?,
    ~wrapper: Dom.element=?,
    ~queries: queries=?,
    React.element
  ) =>
  renderResult;

let debug:
  (~el: Dom.element=?, ~maxLengthToPrint: int=?, renderResult) => unit;
