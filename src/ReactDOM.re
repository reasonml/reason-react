/* First time reading an OCaml/Reason/BuckleScript file? */
/* `external` is the foreign function call in OCaml. */
/* here we're saying `I guarantee that on the JS side, we have a `render` function in the module "react-dom"
   that takes in a reactElement, a dom element, and returns unit (nothing) */
/* It's like `let`, except you're pointing the implementation to the JS side. The compiler will inline these
   calls and add the appropriate `require("react-dom")` in the file calling this `render` */

// Helper so that ReactDOM itself doesn't bring any runtime
[@mel.return nullable]
external querySelector: string => option(Dom.element) =
  "document.querySelector";

[@mel.module "react-dom"]
external render: (React.element, Dom.element) => unit = "render";

module Experimental = {
  type root;

  [@mel.module "react-dom"]
  external createRoot: Dom.element => root = "createRoot";

  [@mel.module "react-dom"]
  external createBlockingRoot: Dom.element => root = "createBlockingRoot";

  [@mel.send] external render: (root, React.element) => unit = "render";
};

[@mel.module "react-dom"]
external hydrate: (React.element, Dom.element) => unit = "hydrate";

[@mel.module "react-dom"]
external createPortal: (React.element, Dom.element) => React.element =
  "createPortal";

[@mel.module "react-dom"]
external unmountComponentAtNode: Dom.element => unit =
  "unmountComponentAtNode";

external domElementToObj: Dom.element => Js.t({..}) = "%identity";

type style = ReactDOMStyle.t;

type domRef;

module Ref = {
  type t = domRef;
  type currentDomRef = React.ref(Js.nullable(Dom.element));
  type callbackDomRef = Js.nullable(Dom.element) => unit;

  external domRef: currentDomRef => domRef = "%identity";
  external callbackDomRef: callbackDomRef => domRef = "%identity";
};

module Props = {
  /* This list isn't exhaustive. We'll add more as we go. */
  /*
   * Watch out! There are two props types and the only difference is the type of ref.
   * Please keep in sync.
   */
  [@deriving abstract]
  type domProps = {
    [@mel.optional]
    key: option(string),
    [@mel.optional]
    ref: option(domRef),
    [@mel.optional]
    children: option(React.element),
    /* accessibility */
    /* https://www.w3.org/TR/wai-aria-1.1/ */
    [@mel.optional] [@mel.as "aria-activedescendant"]
    ariaActivedescendant: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-activedescendat */
    [@mel.optional] [@mel.as "aria-atomic"]
    ariaAtomic: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-atomic */
    [@mel.optional] [@mel.as "aria-autocomplete"]
    ariaAutocomplete: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-autocomplete */
    [@mel.optional] [@mel.as "aria-busy"]
    ariaBusy: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-busy */
    [@mel.optional] [@mel.as "aria-checked"]
    ariaChecked: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-checked */
    [@mel.optional] [@mel.as "aria-colcount"]
    ariaColcount: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colcount */
    [@mel.optional] [@mel.as "aria-colindex"]
    ariaColindex: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colindex */
    [@mel.optional] [@mel.as "aria-colspan"]
    ariaColspan: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colspan */
    [@mel.optional] [@mel.as "aria-controls"]
    ariaControls: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-controls */
    [@mel.optional] [@mel.as "aria-current"]
    ariaCurrent: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-current */
    [@mel.optional] [@mel.as "aria-describedby"]
    ariaDescribedby: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-describedby */
    [@mel.optional] [@mel.as "aria-details"]
    ariaDetails: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-details */
    [@mel.optional] [@mel.as "aria-disabled"]
    ariaDisabled: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-disabled */
    [@mel.optional] [@mel.as "aria-errormessage"]
    ariaErrormessage: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-errormessage */
    [@mel.optional] [@mel.as "aria-expanded"]
    ariaExpanded: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-expanded */
    [@mel.optional] [@mel.as "aria-flowto"]
    ariaFlowto: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-flowto */
    [@mel.optional] [@mel.as "aria-grabbed"] /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-relevant */
    ariaGrabbed: option(bool),
    [@mel.optional] [@mel.as "aria-haspopup"]
    ariaHaspopup: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-haspopup */
    [@mel.optional] [@mel.as "aria-hidden"]
    ariaHidden: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-hidden */
    [@mel.optional] [@mel.as "aria-invalid"]
    ariaInvalid: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-invalid */
    [@mel.optional] [@mel.as "aria-keyshortcuts"]
    ariaKeyshortcuts: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-keyshortcuts */
    [@mel.optional] [@mel.as "aria-label"]
    ariaLabel: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-label */
    [@mel.optional] [@mel.as "aria-labelledby"]
    ariaLabelledby: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-labelledby */
    [@mel.optional] [@mel.as "aria-level"]
    ariaLevel: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-level */
    [@mel.optional] [@mel.as "aria-live"]
    ariaLive: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-live */
    [@mel.optional] [@mel.as "aria-modal"]
    ariaModal: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-modal */
    [@mel.optional] [@mel.as "aria-multiline"]
    ariaMultiline: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-multiline */
    [@mel.optional] [@mel.as "aria-multiselectable"]
    ariaMultiselectable: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-multiselectable */
    [@mel.optional] [@mel.as "aria-orientation"]
    ariaOrientation: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-orientation */
    [@mel.optional] [@mel.as "aria-owns"]
    ariaOwns: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-owns */
    [@mel.optional] [@mel.as "aria-placeholder"]
    ariaPlaceholder: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-placeholder */
    [@mel.optional] [@mel.as "aria-posinset"]
    ariaPosinset: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-posinset */
    [@mel.optional] [@mel.as "aria-pressed"]
    ariaPressed: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-pressed */
    [@mel.optional] [@mel.as "aria-readonly"]
    ariaReadonly: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-readonly */
    [@mel.optional] [@mel.as "aria-relevant"]
    ariaRelevant: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-relevant */
    [@mel.optional] [@mel.as "aria-required"]
    ariaRequired: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-required */
    [@mel.optional] [@mel.as "aria-roledescription"]
    ariaRoledescription: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-roledescription */
    [@mel.optional] [@mel.as "aria-rowcount"]
    ariaRowcount: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowcount */
    [@mel.optional] [@mel.as "aria-rowindex"]
    ariaRowindex: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowindex */
    [@mel.optional] [@mel.as "aria-rowindextext"]
    ariaRowindextext: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowindextext */
    [@mel.optional] [@mel.as "aria-rowspan"]
    ariaRowspan: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowspan */
    [@mel.optional] [@mel.as "aria-selected"]
    ariaSelected: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-selected */
    [@mel.optional] [@mel.as "aria-setsize"]
    ariaSetsize: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-setsize */
    [@mel.optional] [@mel.as "aria-sort"]
    ariaSort: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-sort */
    [@mel.optional] [@mel.as "aria-valuemax"]
    ariaValuemax: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuemax */
    [@mel.optional] [@mel.as "aria-valuemin"]
    ariaValuemin: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuemin */
    [@mel.optional] [@mel.as "aria-valuenow"]
    ariaValuenow: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuenow */
    [@mel.optional] [@mel.as "aria-valuetext"]
    ariaValuetext: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuetext */
    /* react textarea/input */
    [@mel.optional]
    defaultChecked: option(bool),
    [@mel.optional]
    defaultValue: option(string),
    /* global html attributes */
    [@mel.optional]
    accessKey: option(string),
    [@mel.optional]
    className: option(string), /* substitute for "class" */
    [@mel.optional]
    contentEditable: option(bool),
    [@mel.optional]
    contextMenu: option(string),
    [@mel.optional]
    dir: option(string), /* "ltr", "rtl" or "auto" */
    [@mel.optional]
    draggable: option(bool),
    [@mel.optional]
    hidden: option(bool),
    [@mel.optional]
    id: option(string),
    [@mel.optional]
    lang: option(string),
    [@mel.optional]
    role: option(string), /* ARIA role */
    [@mel.optional]
    style: option(style),
    [@mel.optional]
    spellCheck: option(bool),
    [@mel.optional]
    tabIndex: option(int),
    [@mel.optional]
    title: option(string),
    /* html5 microdata */
    [@mel.optional]
    itemID: option(string),
    [@mel.optional]
    itemProp: option(string),
    [@mel.optional]
    itemRef: option(string),
    [@mel.optional]
    itemScope: option(bool),
    [@mel.optional]
    itemType: option(string), /* uri */
    /* tag-specific html attributes */
    [@mel.optional] [@mel.as "as"]
    as_: option(string),
    [@mel.optional]
    accept: option(string),
    [@mel.optional]
    acceptCharset: option(string),
    [@mel.optional]
    action: option(string), /* uri */
    [@mel.optional]
    allowFullScreen: option(bool),
    [@mel.optional]
    alt: option(string),
    [@mel.optional]
    async: option(bool),
    [@mel.optional]
    autoComplete: option(string), /* has a fixed, but large-ish, set of possible values */
    [@mel.optional]
    autoCapitalize: option(string), /* Mobile Safari specific */
    [@mel.optional]
    autoFocus: option(bool),
    [@mel.optional]
    autoPlay: option(bool),
    [@mel.optional]
    challenge: option(string),
    [@mel.optional]
    charSet: option(string),
    [@mel.optional]
    checked: option(bool),
    [@mel.optional]
    cite: option(string), /* uri */
    [@mel.optional]
    crossOrigin: option(string), /* anonymous, use-credentials */
    [@mel.optional]
    cols: option(int),
    [@mel.optional]
    colSpan: option(int),
    [@mel.optional]
    content: option(string),
    [@mel.optional]
    controls: option(bool),
    [@mel.optional]
    coords: option(string), /* set of values specifying the coordinates of a region */
    [@mel.optional]
    data: option(string), /* uri */
    [@mel.optional]
    dateTime: option(string), /* "valid date string with optional time" */
    [@mel.optional]
    default: option(bool),
    [@mel.optional]
    defer: option(bool),
    [@mel.optional]
    disabled: option(bool),
    [@mel.optional]
    download: option(string), /* should really be either a boolean, signifying presence, or a string */
    [@mel.optional]
    encType: option(string), /* "application/x-www-form-urlencoded", "multipart/form-data" or "text/plain" */
    [@mel.optional]
    form: option(string),
    [@mel.optional]
    formAction: option(string), /* uri */
    [@mel.optional]
    formTarget: option(string), /* "_blank", "_self", etc. */
    [@mel.optional]
    formMethod: option(string), /* "post", "get", "put" */
    [@mel.optional]
    headers: option(string),
    [@mel.optional]
    height: option(string), /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
    [@mel.optional]
    high: option(int),
    [@mel.optional]
    href: option(string), /* uri */
    [@mel.optional]
    hrefLang: option(string),
    [@mel.optional]
    htmlFor: option(string), /* substitute for "for" */
    [@mel.optional]
    httpEquiv: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    icon: option(string), /* uri? */
    [@mel.optional]
    inputMode: option(string), /* "verbatim", "latin", "numeric", etc. */
    [@mel.optional]
    integrity: option(string),
    [@mel.optional]
    keyType: option(string),
    [@mel.optional]
    kind: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    label: option(string),
    [@mel.optional]
    list: option(string),
    [@mel.optional]
    loop: option(bool),
    [@mel.optional]
    low: option(int),
    [@mel.optional]
    manifest: option(string), /* uri */
    [@mel.optional]
    max: option(string), /* should be int or Js.Date.t */
    [@mel.optional]
    maxLength: option(int),
    [@mel.optional]
    media: option(string), /* a valid media query */
    [@mel.optional]
    mediaGroup: option(string),
    [@mel.optional]
    method: option(string), /* "post" or "get" */
    [@mel.optional]
    min: option(string),
    [@mel.optional]
    minLength: option(int),
    [@mel.optional]
    multiple: option(bool),
    [@mel.optional]
    muted: option(bool),
    [@mel.optional]
    name: option(string),
    [@mel.optional]
    nonce: option(string),
    [@mel.optional]
    noValidate: option(bool),
    [@mel.optional] [@mel.as "open"]
    open_: option(bool), /* use this one. Previous one is deprecated */
    [@mel.optional]
    optimum: option(int),
    [@mel.optional]
    pattern: option(string), /* valid Js RegExp */
    [@mel.optional]
    placeholder: option(string),
    [@mel.optional]
    playsInline: option(bool),
    [@mel.optional]
    poster: option(string), /* uri */
    [@mel.optional]
    preload: option(string), /* "none", "metadata" or "auto" (and "" as a synonym for "auto") */
    [@mel.optional]
    radioGroup: option(string),
    [@mel.optional]
    readOnly: option(bool),
    [@mel.optional]
    rel: option(string), /* a space- or comma-separated (depending on the element) list of a fixed set of "link types" */
    [@mel.optional]
    required: option(bool),
    [@mel.optional]
    reversed: option(bool),
    [@mel.optional]
    rows: option(int),
    [@mel.optional]
    rowSpan: option(int),
    [@mel.optional]
    sandbox: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    scope: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    scoped: option(bool),
    [@mel.optional]
    scrolling: option(string), /* html4 only, "auto", "yes" or "no" */
    /* seamless - supported by React, but removed from the html5 spec */
    [@mel.optional]
    selected: option(bool),
    [@mel.optional]
    shape: option(string),
    [@mel.optional]
    size: option(int),
    [@mel.optional]
    sizes: option(string),
    [@mel.optional]
    span: option(int),
    [@mel.optional]
    src: option(string), /* uri */
    [@mel.optional]
    srcDoc: option(string),
    [@mel.optional]
    srcLang: option(string),
    [@mel.optional]
    srcSet: option(string),
    [@mel.optional]
    start: option(int),
    [@mel.optional]
    step: option(float),
    [@mel.optional]
    summary: option(string), /* deprecated */
    [@mel.optional]
    target: option(string),
    [@mel.optional] [@mel.as "type"]
    type_: option(string), /* has a fixed but large-ish set of possible values */ /* use this one. Previous one is deprecated */
    [@mel.optional]
    useMap: option(string),
    [@mel.optional]
    value: option(string),
    [@mel.optional]
    width: option(string), /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
    [@mel.optional]
    wrap: option(string), /* "hard" or "soft" */
    /* Clipboard events */
    [@mel.optional]
    onCopy: option(ReactEvent.Clipboard.t => unit),
    [@mel.optional]
    onCut: option(ReactEvent.Clipboard.t => unit),
    [@mel.optional]
    onPaste: option(ReactEvent.Clipboard.t => unit),
    /* Composition events */
    [@mel.optional]
    onCompositionEnd: option(ReactEvent.Composition.t => unit),
    [@mel.optional]
    onCompositionStart: option(ReactEvent.Composition.t => unit),
    [@mel.optional]
    onCompositionUpdate: option(ReactEvent.Composition.t => unit),
    /* Keyboard events */
    [@mel.optional]
    onKeyDown: option(ReactEvent.Keyboard.t => unit),
    [@mel.optional]
    onKeyPress: option(ReactEvent.Keyboard.t => unit),
    [@mel.optional]
    onKeyUp: option(ReactEvent.Keyboard.t => unit),
    /* Focus events */
    [@mel.optional]
    onFocus: option(ReactEvent.Focus.t => unit),
    [@mel.optional]
    onBlur: option(ReactEvent.Focus.t => unit),
    /* Form events */
    [@mel.optional]
    onChange: option(ReactEvent.Form.t => unit),
    [@mel.optional]
    onInput: option(ReactEvent.Form.t => unit),
    [@mel.optional]
    onSubmit: option(ReactEvent.Form.t => unit),
    [@mel.optional]
    onInvalid: option(ReactEvent.Form.t => unit),
    /* Mouse events */
    [@mel.optional]
    onClick: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onContextMenu: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onDoubleClick: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onDrag: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragEnd: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragEnter: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragExit: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragLeave: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragOver: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragStart: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDrop: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onMouseDown: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseEnter: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseLeave: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseMove: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseOut: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseOver: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseUp: option(ReactEvent.Mouse.t => unit),
    /* Selection events */
    [@mel.optional]
    onSelect: option(ReactEvent.Selection.t => unit),
    /* Touch events */
    [@mel.optional]
    onTouchCancel: option(ReactEvent.Touch.t => unit),
    [@mel.optional]
    onTouchEnd: option(ReactEvent.Touch.t => unit),
    [@mel.optional]
    onTouchMove: option(ReactEvent.Touch.t => unit),
    [@mel.optional]
    onTouchStart: option(ReactEvent.Touch.t => unit),
    // Pointer events
    [@mel.optional]
    onPointerOver: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerEnter: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerDown: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerMove: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerUp: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerCancel: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerOut: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerLeave: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onGotPointerCapture: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onLostPointerCapture: option(ReactEvent.Pointer.t => unit),
    /* UI events */
    [@mel.optional]
    onScroll: option(ReactEvent.UI.t => unit),
    /* Wheel events */
    [@mel.optional]
    onWheel: option(ReactEvent.Wheel.t => unit),
    /* Media events */
    [@mel.optional]
    onAbort: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onCanPlay: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onCanPlayThrough: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onDurationChange: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onEmptied: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onEncrypetd: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onEnded: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onError: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onLoadedData: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onLoadedMetadata: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onLoadStart: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onPause: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onPlay: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onPlaying: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onProgress: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onRateChange: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onSeeked: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onSeeking: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onStalled: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onSuspend: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onTimeUpdate: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onVolumeChange: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onWaiting: option(ReactEvent.Media.t => unit),
    /* Image events */
    [@mel.optional]onLoad: option(ReactEvent.Image.t => unit) /* duplicate */, /*~onError: ReactEvent.Image.t => unit=?,*/
    /* Animation events */
    [@mel.optional]
    onAnimationStart: option(ReactEvent.Animation.t => unit),
    [@mel.optional]
    onAnimationEnd: option(ReactEvent.Animation.t => unit),
    [@mel.optional]
    onAnimationIteration: option(ReactEvent.Animation.t => unit),
    /* Transition events */
    [@mel.optional]
    onTransitionEnd: option(ReactEvent.Transition.t => unit),
    /* svg */
    [@mel.optional]
    accentHeight: option(string),
    [@mel.optional]
    accumulate: option(string),
    [@mel.optional]
    additive: option(string),
    [@mel.optional]
    alignmentBaseline: option(string),
    [@mel.optional]
    allowReorder: option(string),
    [@mel.optional]
    alphabetic: option(string),
    [@mel.optional]
    amplitude: option(string),
    [@mel.optional]
    arabicForm: option(string),
    [@mel.optional]
    ascent: option(string),
    [@mel.optional]
    attributeName: option(string),
    [@mel.optional]
    attributeType: option(string),
    [@mel.optional]
    autoReverse: option(string),
    [@mel.optional]
    azimuth: option(string),
    [@mel.optional]
    baseFrequency: option(string),
    [@mel.optional]
    baseProfile: option(string),
    [@mel.optional]
    baselineShift: option(string),
    [@mel.optional]
    bbox: option(string),
    [@mel.optional] [@mel.as "begin"]
    begin_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    bias: option(string),
    [@mel.optional]
    by: option(string),
    [@mel.optional]
    calcMode: option(string),
    [@mel.optional]
    capHeight: option(string),
    [@mel.optional]
    clip: option(string),
    [@mel.optional]
    clipPath: option(string),
    [@mel.optional]
    clipPathUnits: option(string),
    [@mel.optional]
    clipRule: option(string),
    [@mel.optional]
    colorInterpolation: option(string),
    [@mel.optional]
    colorInterpolationFilters: option(string),
    [@mel.optional]
    colorProfile: option(string),
    [@mel.optional]
    colorRendering: option(string),
    [@mel.optional]
    contentScriptType: option(string),
    [@mel.optional]
    contentStyleType: option(string),
    [@mel.optional]
    cursor: option(string),
    [@mel.optional]
    cx: option(string),
    [@mel.optional]
    cy: option(string),
    [@mel.optional]
    d: option(string),
    [@mel.optional]
    decelerate: option(string),
    [@mel.optional]
    descent: option(string),
    [@mel.optional]
    diffuseConstant: option(string),
    [@mel.optional]
    direction: option(string),
    [@mel.optional]
    display: option(string),
    [@mel.optional]
    divisor: option(string),
    [@mel.optional]
    dominantBaseline: option(string),
    [@mel.optional]
    dur: option(string),
    [@mel.optional]
    dx: option(string),
    [@mel.optional]
    dy: option(string),
    [@mel.optional]
    edgeMode: option(string),
    [@mel.optional]
    elevation: option(string),
    [@mel.optional]
    enableBackground: option(string),
    [@mel.optional] [@mel.as "end"]
    end_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    exponent: option(string),
    [@mel.optional]
    externalResourcesRequired: option(string),
    [@mel.optional]
    fill: option(string),
    [@mel.optional]
    fillOpacity: option(string),
    [@mel.optional]
    fillRule: option(string),
    [@mel.optional]
    filter: option(string),
    [@mel.optional]
    filterRes: option(string),
    [@mel.optional]
    filterUnits: option(string),
    [@mel.optional]
    floodColor: option(string),
    [@mel.optional]
    floodOpacity: option(string),
    [@mel.optional]
    focusable: option(string),
    [@mel.optional]
    fontFamily: option(string),
    [@mel.optional]
    fontSize: option(string),
    [@mel.optional]
    fontSizeAdjust: option(string),
    [@mel.optional]
    fontStretch: option(string),
    [@mel.optional]
    fontStyle: option(string),
    [@mel.optional]
    fontVariant: option(string),
    [@mel.optional]
    fontWeight: option(string),
    [@mel.optional]
    fomat: option(string),
    [@mel.optional]
    from: option(string),
    [@mel.optional]
    fx: option(string),
    [@mel.optional]
    fy: option(string),
    [@mel.optional]
    g1: option(string),
    [@mel.optional]
    g2: option(string),
    [@mel.optional]
    glyphName: option(string),
    [@mel.optional]
    glyphOrientationHorizontal: option(string),
    [@mel.optional]
    glyphOrientationVertical: option(string),
    [@mel.optional]
    glyphRef: option(string),
    [@mel.optional]
    gradientTransform: option(string),
    [@mel.optional]
    gradientUnits: option(string),
    [@mel.optional]
    hanging: option(string),
    [@mel.optional]
    horizAdvX: option(string),
    [@mel.optional]
    horizOriginX: option(string),
    [@mel.optional]
    ideographic: option(string),
    [@mel.optional]
    imageRendering: option(string),
    [@mel.optional] [@mel.as "in"]
    in_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    in2: option(string),
    [@mel.optional]
    intercept: option(string),
    [@mel.optional]
    k: option(string),
    [@mel.optional]
    k1: option(string),
    [@mel.optional]
    k2: option(string),
    [@mel.optional]
    k3: option(string),
    [@mel.optional]
    k4: option(string),
    [@mel.optional]
    kernelMatrix: option(string),
    [@mel.optional]
    kernelUnitLength: option(string),
    [@mel.optional]
    kerning: option(string),
    [@mel.optional]
    keyPoints: option(string),
    [@mel.optional]
    keySplines: option(string),
    [@mel.optional]
    keyTimes: option(string),
    [@mel.optional]
    lengthAdjust: option(string),
    [@mel.optional]
    letterSpacing: option(string),
    [@mel.optional]
    lightingColor: option(string),
    [@mel.optional]
    limitingConeAngle: option(string),
    [@mel.optional]
    local: option(string),
    [@mel.optional]
    markerEnd: option(string),
    [@mel.optional]
    markerHeight: option(string),
    [@mel.optional]
    markerMid: option(string),
    [@mel.optional]
    markerStart: option(string),
    [@mel.optional]
    markerUnits: option(string),
    [@mel.optional]
    markerWidth: option(string),
    [@mel.optional]
    mask: option(string),
    [@mel.optional]
    maskContentUnits: option(string),
    [@mel.optional]
    maskUnits: option(string),
    [@mel.optional]
    mathematical: option(string),
    [@mel.optional]
    mode: option(string),
    [@mel.optional]
    numOctaves: option(string),
    [@mel.optional]
    offset: option(string),
    [@mel.optional]
    opacity: option(string),
    [@mel.optional]
    operator: option(string),
    [@mel.optional]
    order: option(string),
    [@mel.optional]
    orient: option(string),
    [@mel.optional]
    orientation: option(string),
    [@mel.optional]
    origin: option(string),
    [@mel.optional]
    overflow: option(string),
    [@mel.optional]
    overflowX: option(string),
    [@mel.optional]
    overflowY: option(string),
    [@mel.optional]
    overlinePosition: option(string),
    [@mel.optional]
    overlineThickness: option(string),
    [@mel.optional]
    paintOrder: option(string),
    [@mel.optional]
    panose1: option(string),
    [@mel.optional]
    pathLength: option(string),
    [@mel.optional]
    patternContentUnits: option(string),
    [@mel.optional]
    patternTransform: option(string),
    [@mel.optional]
    patternUnits: option(string),
    [@mel.optional]
    pointerEvents: option(string),
    [@mel.optional]
    points: option(string),
    [@mel.optional]
    pointsAtX: option(string),
    [@mel.optional]
    pointsAtY: option(string),
    [@mel.optional]
    pointsAtZ: option(string),
    [@mel.optional]
    preserveAlpha: option(string),
    [@mel.optional]
    preserveAspectRatio: option(string),
    [@mel.optional]
    primitiveUnits: option(string),
    [@mel.optional]
    r: option(string),
    [@mel.optional]
    radius: option(string),
    [@mel.optional]
    refX: option(string),
    [@mel.optional]
    refY: option(string),
    [@mel.optional]
    renderingIntent: option(string),
    [@mel.optional]
    repeatCount: option(string),
    [@mel.optional]
    repeatDur: option(string),
    [@mel.optional]
    requiredExtensions: option(string),
    [@mel.optional]
    requiredFeatures: option(string),
    [@mel.optional]
    restart: option(string),
    [@mel.optional]
    result: option(string),
    [@mel.optional]
    rotate: option(string),
    [@mel.optional]
    rx: option(string),
    [@mel.optional]
    ry: option(string),
    [@mel.optional]
    scale: option(string),
    [@mel.optional]
    seed: option(string),
    [@mel.optional]
    shapeRendering: option(string),
    [@mel.optional]
    slope: option(string),
    [@mel.optional]
    spacing: option(string),
    [@mel.optional]
    specularConstant: option(string),
    [@mel.optional]
    specularExponent: option(string),
    [@mel.optional]
    speed: option(string),
    [@mel.optional]
    spreadMethod: option(string),
    [@mel.optional]
    startOffset: option(string),
    [@mel.optional]
    stdDeviation: option(string),
    [@mel.optional]
    stemh: option(string),
    [@mel.optional]
    stemv: option(string),
    [@mel.optional]
    stitchTiles: option(string),
    [@mel.optional]
    stopColor: option(string),
    [@mel.optional]
    stopOpacity: option(string),
    [@mel.optional]
    strikethroughPosition: option(string),
    [@mel.optional]
    strikethroughThickness: option(string),
    [@mel.optional]
    string: option(string),
    [@mel.optional]
    stroke: option(string),
    [@mel.optional]
    strokeDasharray: option(string),
    [@mel.optional]
    strokeDashoffset: option(string),
    [@mel.optional]
    strokeLinecap: option(string),
    [@mel.optional]
    strokeLinejoin: option(string),
    [@mel.optional]
    strokeMiterlimit: option(string),
    [@mel.optional]
    strokeOpacity: option(string),
    [@mel.optional]
    strokeWidth: option(string),
    [@mel.optional]
    surfaceScale: option(string),
    [@mel.optional]
    systemLanguage: option(string),
    [@mel.optional]
    tableValues: option(string),
    [@mel.optional]
    targetX: option(string),
    [@mel.optional]
    targetY: option(string),
    [@mel.optional]
    textAnchor: option(string),
    [@mel.optional]
    textDecoration: option(string),
    [@mel.optional]
    textLength: option(string),
    [@mel.optional]
    textRendering: option(string),
    [@mel.optional] [@mel.as "to"]
    to_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    transform: option(string),
    [@mel.optional]
    u1: option(string),
    [@mel.optional]
    u2: option(string),
    [@mel.optional]
    underlinePosition: option(string),
    [@mel.optional]
    underlineThickness: option(string),
    [@mel.optional]
    unicode: option(string),
    [@mel.optional]
    unicodeBidi: option(string),
    [@mel.optional]
    unicodeRange: option(string),
    [@mel.optional]
    unitsPerEm: option(string),
    [@mel.optional]
    vAlphabetic: option(string),
    [@mel.optional]
    vHanging: option(string),
    [@mel.optional]
    vIdeographic: option(string),
    [@mel.optional]
    vMathematical: option(string),
    [@mel.optional]
    values: option(string),
    [@mel.optional]
    vectorEffect: option(string),
    [@mel.optional]
    version: option(string),
    [@mel.optional]
    vertAdvX: option(string),
    [@mel.optional]
    vertAdvY: option(string),
    [@mel.optional]
    vertOriginX: option(string),
    [@mel.optional]
    vertOriginY: option(string),
    [@mel.optional]
    viewBox: option(string),
    [@mel.optional]
    viewTarget: option(string),
    [@mel.optional]
    visibility: option(string),
    /*width::string? =>*/
    [@mel.optional]
    widths: option(string),
    [@mel.optional]
    wordSpacing: option(string),
    [@mel.optional]
    writingMode: option(string),
    [@mel.optional]
    x: option(string),
    [@mel.optional]
    x1: option(string),
    [@mel.optional]
    x2: option(string),
    [@mel.optional]
    xChannelSelector: option(string),
    [@mel.optional]
    xHeight: option(string),
    [@mel.optional]
    xlinkActuate: option(string),
    [@mel.optional]
    xlinkArcrole: option(string),
    [@mel.optional]
    xlinkHref: option(string),
    [@mel.optional]
    xlinkRole: option(string),
    [@mel.optional]
    xlinkShow: option(string),
    [@mel.optional]
    xlinkTitle: option(string),
    [@mel.optional]
    xlinkType: option(string),
    [@mel.optional]
    xmlns: option(string),
    [@mel.optional]
    xmlnsXlink: option(string),
    [@mel.optional]
    xmlBase: option(string),
    [@mel.optional]
    xmlLang: option(string),
    [@mel.optional]
    xmlSpace: option(string),
    [@mel.optional]
    y: option(string),
    [@mel.optional]
    y1: option(string),
    [@mel.optional]
    y2: option(string),
    [@mel.optional]
    yChannelSelector: option(string),
    [@mel.optional]
    z: option(string),
    [@mel.optional]
    zoomAndPan: option(string),
    /* RDFa */
    [@mel.optional]
    about: option(string),
    [@mel.optional]
    datatype: option(string),
    [@mel.optional]
    inlist: option(string),
    [@mel.optional]
    prefix: option(string),
    [@mel.optional]
    property: option(string),
    [@mel.optional]
    resource: option(string),
    [@mel.optional]
    typeof: option(string),
    [@mel.optional]
    vocab: option(string),
    /* react-specific */
    [@mel.optional]
    dangerouslySetInnerHTML: option({. "__html": string}),
    [@mel.optional]
    suppressContentEditableWarning: option(bool),
    [@mel.optional]
    suppressHydrationWarning: option(bool),
  };

  /* This list isn't exhaustive. We'll add more as we go. */
  /*
   * Watch out! There are two props types and the only difference is the type of ref.
   * Please keep in sync.
   */
  [@deriving abstract]
  type props = {
    [@mel.optional]
    key: option(string),
    [@mel.optional]
    ref: option(Js.nullable(Dom.element) => unit),
    /* accessibility */
    /* https://www.w3.org/TR/wai-aria-1.1/ */
    [@mel.optional] [@mel.as "aria-activedescendant"]
    ariaActivedescendant: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-activedescendat */
    [@mel.optional] [@mel.as "aria-atomic"]
    ariaAtomic: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-atomic */
    [@mel.optional] [@mel.as "aria-autocomplete"]
    ariaAutocomplete: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-autocomplete */
    [@mel.optional] [@mel.as "aria-busy"]
    ariaBusy: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-busy */
    [@mel.optional] [@mel.as "aria-checked"]
    ariaChecked: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-checked */
    [@mel.optional] [@mel.as "aria-colcount"]
    ariaColcount: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colcount */
    [@mel.optional] [@mel.as "aria-colindex"]
    ariaColindex: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colindex */
    [@mel.optional] [@mel.as "aria-colspan"]
    ariaColspan: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-colspan */
    [@mel.optional] [@mel.as "aria-controls"]
    ariaControls: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-controls */
    [@mel.optional] [@mel.as "aria-current"]
    ariaCurrent: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-current */
    [@mel.optional] [@mel.as "aria-describedby"]
    ariaDescribedby: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-describedby */
    [@mel.optional] [@mel.as "aria-details"]
    ariaDetails: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-details */
    [@mel.optional] [@mel.as "aria-disabled"]
    ariaDisabled: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-disabled */
    [@mel.optional] [@mel.as "aria-errormessage"]
    ariaErrormessage: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-errormessage */
    [@mel.optional] [@mel.as "aria-expanded"]
    ariaExpanded: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-expanded */
    [@mel.optional] [@mel.as "aria-flowto"]
    ariaFlowto: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-flowto */
    [@mel.optional] [@mel.as "aria-grabbed"] /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-relevant */
    ariaGrabbed: option(bool),
    [@mel.optional] [@mel.as "aria-haspopup"]
    ariaHaspopup: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-haspopup */
    [@mel.optional] [@mel.as "aria-hidden"]
    ariaHidden: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-hidden */
    [@mel.optional] [@mel.as "aria-invalid"]
    ariaInvalid: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-invalid */
    [@mel.optional] [@mel.as "aria-keyshortcuts"]
    ariaKeyshortcuts: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-keyshortcuts */
    [@mel.optional] [@mel.as "aria-label"]
    ariaLabel: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-label */
    [@mel.optional] [@mel.as "aria-labelledby"]
    ariaLabelledby: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-labelledby */
    [@mel.optional] [@mel.as "aria-level"]
    ariaLevel: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-level */
    [@mel.optional] [@mel.as "aria-live"]
    ariaLive: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-live */
    [@mel.optional] [@mel.as "aria-modal"]
    ariaModal: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-modal */
    [@mel.optional] [@mel.as "aria-multiline"]
    ariaMultiline: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-multiline */
    [@mel.optional] [@mel.as "aria-multiselectable"]
    ariaMultiselectable: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-multiselectable */
    [@mel.optional] [@mel.as "aria-orientation"]
    ariaOrientation: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-orientation */
    [@mel.optional] [@mel.as "aria-owns"]
    ariaOwns: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-owns */
    [@mel.optional] [@mel.as "aria-placeholder"]
    ariaPlaceholder: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-placeholder */
    [@mel.optional] [@mel.as "aria-posinset"]
    ariaPosinset: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-posinset */
    [@mel.optional] [@mel.as "aria-pressed"]
    ariaPressed: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-pressed */
    [@mel.optional] [@mel.as "aria-readonly"]
    ariaReadonly: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-readonly */
    [@mel.optional] [@mel.as "aria-relevant"]
    ariaRelevant: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-relevant */
    [@mel.optional] [@mel.as "aria-required"]
    ariaRequired: option(bool), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-required */
    [@mel.optional] [@mel.as "aria-roledescription"]
    ariaRoledescription: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-roledescription */
    [@mel.optional] [@mel.as "aria-rowcount"]
    ariaRowcount: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowcount */
    [@mel.optional] [@mel.as "aria-rowindex"]
    ariaRowindex: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowindex */
    [@mel.optional] [@mel.as "aria-rowindextext"]
    ariaRowindextext: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowindextext */
    [@mel.optional] [@mel.as "aria-rowspan"]
    ariaRowspan: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-rowspan */
    [@mel.optional] [@mel.as "aria-selected"]
    ariaSelected: option(bool), /* string */ /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-selected */
    [@mel.optional] [@mel.as "aria-setsize"]
    ariaSetsize: option(int), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-setsize */
    [@mel.optional] [@mel.as "aria-sort"]
    ariaSort: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-sort */
    [@mel.optional] [@mel.as "aria-valuemax"]
    ariaValuemax: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuemax */
    [@mel.optional] [@mel.as "aria-valuemin"]
    ariaValuemin: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuemin */
    [@mel.optional] [@mel.as "aria-valuenow"]
    ariaValuenow: option(float), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuenow */
    [@mel.optional] [@mel.as "aria-valuetext"]
    ariaValuetext: option(string), /* https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-valuetext */
    /* react textarea/input */
    [@mel.optional]
    defaultChecked: option(bool),
    [@mel.optional]
    defaultValue: option(string),
    /* global html attributes */
    [@mel.optional]
    accessKey: option(string),
    [@mel.optional]
    className: option(string), /* substitute for "class" */
    [@mel.optional]
    contentEditable: option(bool),
    [@mel.optional]
    contextMenu: option(string),
    [@mel.optional]
    dir: option(string), /* "ltr", "rtl" or "auto" */
    [@mel.optional]
    draggable: option(bool),
    [@mel.optional]
    hidden: option(bool),
    [@mel.optional]
    id: option(string),
    [@mel.optional]
    lang: option(string),
    [@mel.optional]
    role: option(string), /* ARIA role */
    [@mel.optional]
    style: option(style),
    [@mel.optional]
    spellCheck: option(bool),
    [@mel.optional]
    tabIndex: option(int),
    [@mel.optional]
    title: option(string),
    /* html5 microdata */
    [@mel.optional]
    itemID: option(string),
    [@mel.optional]
    itemProp: option(string),
    [@mel.optional]
    itemRef: option(string),
    [@mel.optional]
    itemScope: option(bool),
    [@mel.optional]
    itemType: option(string), /* uri */
    /* tag-specific html attributes */
    [@mel.optional] [@mel.as "as"]
    as_: option(string),
    [@mel.optional]
    accept: option(string),
    [@mel.optional]
    acceptCharset: option(string),
    [@mel.optional]
    action: option(string), /* uri */
    [@mel.optional]
    allowFullScreen: option(bool),
    [@mel.optional]
    alt: option(string),
    [@mel.optional]
    async: option(bool),
    [@mel.optional]
    autoComplete: option(string), /* has a fixed, but large-ish, set of possible values */
    [@mel.optional]
    autoCapitalize: option(string), /* Mobile Safari specific */
    [@mel.optional]
    autoFocus: option(bool),
    [@mel.optional]
    autoPlay: option(bool),
    [@mel.optional]
    challenge: option(string),
    [@mel.optional]
    charSet: option(string),
    [@mel.optional]
    checked: option(bool),
    [@mel.optional]
    cite: option(string), /* uri */
    [@mel.optional]
    crossorigin: option(bool),
    [@mel.optional]
    cols: option(int),
    [@mel.optional]
    colSpan: option(int),
    [@mel.optional]
    content: option(string),
    [@mel.optional]
    controls: option(bool),
    [@mel.optional]
    coords: option(string), /* set of values specifying the coordinates of a region */
    [@mel.optional]
    data: option(string), /* uri */
    [@mel.optional]
    dateTime: option(string), /* "valid date string with optional time" */
    [@mel.optional]
    default: option(bool),
    [@mel.optional]
    defer: option(bool),
    [@mel.optional]
    disabled: option(bool),
    [@mel.optional]
    download: option(string), /* should really be either a boolean, signifying presence, or a string */
    [@mel.optional]
    encType: option(string), /* "application/x-www-form-urlencoded", "multipart/form-data" or "text/plain" */
    [@mel.optional]
    form: option(string),
    [@mel.optional]
    formAction: option(string), /* uri */
    [@mel.optional]
    formTarget: option(string), /* "_blank", "_self", etc. */
    [@mel.optional]
    formMethod: option(string), /* "post", "get", "put" */
    [@mel.optional]
    headers: option(string),
    [@mel.optional]
    height: option(string), /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
    [@mel.optional]
    high: option(int),
    [@mel.optional]
    href: option(string), /* uri */
    [@mel.optional]
    hrefLang: option(string),
    [@mel.optional]
    htmlFor: option(string), /* substitute for "for" */
    [@mel.optional]
    httpEquiv: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    icon: option(string), /* uri? */
    [@mel.optional]
    inputMode: option(string), /* "verbatim", "latin", "numeric", etc. */
    [@mel.optional]
    integrity: option(string),
    [@mel.optional]
    keyType: option(string),
    [@mel.optional]
    kind: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    label: option(string),
    [@mel.optional]
    list: option(string),
    [@mel.optional]
    loop: option(bool),
    [@mel.optional]
    low: option(int),
    [@mel.optional]
    manifest: option(string), /* uri */
    [@mel.optional]
    max: option(string), /* should be int or Js.Date.t */
    [@mel.optional]
    maxLength: option(int),
    [@mel.optional]
    media: option(string), /* a valid media query */
    [@mel.optional]
    mediaGroup: option(string),
    [@mel.optional]
    method: option(string), /* "post" or "get" */
    [@mel.optional]
    min: option(string),
    [@mel.optional]
    minLength: option(int),
    [@mel.optional]
    multiple: option(bool),
    [@mel.optional]
    muted: option(bool),
    [@mel.optional]
    name: option(string),
    [@mel.optional]
    nonce: option(string),
    [@mel.optional]
    noValidate: option(bool),
    [@mel.optional] [@mel.as "open"]
    open_: option(bool), /* use this one. Previous one is deprecated */
    [@mel.optional]
    optimum: option(int),
    [@mel.optional]
    pattern: option(string), /* valid Js RegExp */
    [@mel.optional]
    placeholder: option(string),
    [@mel.optional]
    poster: option(string), /* uri */
    [@mel.optional]
    preload: option(string), /* "none", "metadata" or "auto" (and "" as a synonym for "auto") */
    [@mel.optional]
    radioGroup: option(string),
    [@mel.optional]
    readOnly: option(bool),
    [@mel.optional]
    rel: option(string), /* a space- or comma-separated (depending on the element) list of a fixed set of "link types" */
    [@mel.optional]
    required: option(bool),
    [@mel.optional]
    reversed: option(bool),
    [@mel.optional]
    rows: option(int),
    [@mel.optional]
    rowSpan: option(int),
    [@mel.optional]
    sandbox: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    scope: option(string), /* has a fixed set of possible values */
    [@mel.optional]
    scoped: option(bool),
    [@mel.optional]
    scrolling: option(string), /* html4 only, "auto", "yes" or "no" */
    /* seamless - supported by React, but removed from the html5 spec */
    [@mel.optional]
    selected: option(bool),
    [@mel.optional]
    shape: option(string),
    [@mel.optional]
    size: option(int),
    [@mel.optional]
    sizes: option(string),
    [@mel.optional]
    span: option(int),
    [@mel.optional]
    src: option(string), /* uri */
    [@mel.optional]
    srcDoc: option(string),
    [@mel.optional]
    srcLang: option(string),
    [@mel.optional]
    srcSet: option(string),
    [@mel.optional]
    start: option(int),
    [@mel.optional]
    step: option(float),
    [@mel.optional]
    summary: option(string), /* deprecated */
    [@mel.optional]
    target: option(string),
    [@mel.optional] [@mel.as "type"]
    type_: option(string), /* has a fixed but large-ish set of possible values */ /* use this one. Previous one is deprecated */
    [@mel.optional]
    useMap: option(string),
    [@mel.optional]
    value: option(string),
    [@mel.optional]
    width: option(string), /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
    [@mel.optional]
    wrap: option(string), /* "hard" or "soft" */
    /* Clipboard events */
    [@mel.optional]
    onCopy: option(ReactEvent.Clipboard.t => unit),
    [@mel.optional]
    onCut: option(ReactEvent.Clipboard.t => unit),
    [@mel.optional]
    onPaste: option(ReactEvent.Clipboard.t => unit),
    /* Composition events */
    [@mel.optional]
    onCompositionEnd: option(ReactEvent.Composition.t => unit),
    [@mel.optional]
    onCompositionStart: option(ReactEvent.Composition.t => unit),
    [@mel.optional]
    onCompositionUpdate: option(ReactEvent.Composition.t => unit),
    /* Keyboard events */
    [@mel.optional]
    onKeyDown: option(ReactEvent.Keyboard.t => unit),
    [@mel.optional]
    onKeyPress: option(ReactEvent.Keyboard.t => unit),
    [@mel.optional]
    onKeyUp: option(ReactEvent.Keyboard.t => unit),
    /* Focus events */
    [@mel.optional]
    onFocus: option(ReactEvent.Focus.t => unit),
    [@mel.optional]
    onBlur: option(ReactEvent.Focus.t => unit),
    /* Form events */
    [@mel.optional]
    onChange: option(ReactEvent.Form.t => unit),
    [@mel.optional]
    onInput: option(ReactEvent.Form.t => unit),
    [@mel.optional]
    onSubmit: option(ReactEvent.Form.t => unit),
    [@mel.optional]
    onInvalid: option(ReactEvent.Form.t => unit),
    /* Mouse events */
    [@mel.optional]
    onClick: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onContextMenu: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onDoubleClick: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onDrag: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragEnd: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragEnter: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragExit: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragLeave: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragOver: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDragStart: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onDrop: option(ReactEvent.Drag.t => unit),
    [@mel.optional]
    onMouseDown: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseEnter: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseLeave: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseMove: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseOut: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseOver: option(ReactEvent.Mouse.t => unit),
    [@mel.optional]
    onMouseUp: option(ReactEvent.Mouse.t => unit),
    /* Selection events */
    [@mel.optional]
    onSelect: option(ReactEvent.Selection.t => unit),
    /* Touch events */
    [@mel.optional]
    onTouchCancel: option(ReactEvent.Touch.t => unit),
    [@mel.optional]
    onTouchEnd: option(ReactEvent.Touch.t => unit),
    [@mel.optional]
    onTouchMove: option(ReactEvent.Touch.t => unit),
    [@mel.optional]
    onTouchStart: option(ReactEvent.Touch.t => unit),
    // Pointer events
    [@mel.optional]
    onPointerOver: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerEnter: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerDown: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerMove: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerUp: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerCancel: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerOut: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onPointerLeave: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onGotPointerCapture: option(ReactEvent.Pointer.t => unit),
    [@mel.optional]
    onLostPointerCapture: option(ReactEvent.Pointer.t => unit),
    /* UI events */
    [@mel.optional]
    onScroll: option(ReactEvent.UI.t => unit),
    /* Wheel events */
    [@mel.optional]
    onWheel: option(ReactEvent.Wheel.t => unit),
    /* Media events */
    [@mel.optional]
    onAbort: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onCanPlay: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onCanPlayThrough: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onDurationChange: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onEmptied: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onEncrypetd: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onEnded: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onError: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onLoadedData: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onLoadedMetadata: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onLoadStart: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onPause: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onPlay: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onPlaying: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onProgress: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onRateChange: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onSeeked: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onSeeking: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onStalled: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onSuspend: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onTimeUpdate: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onVolumeChange: option(ReactEvent.Media.t => unit),
    [@mel.optional]
    onWaiting: option(ReactEvent.Media.t => unit),
    /* Image events */
    [@mel.optional]onLoad: option(ReactEvent.Image.t => unit) /* duplicate */, /*~onError: ReactEvent.Image.t => unit=?,*/
    /* Animation events */
    [@mel.optional]
    onAnimationStart: option(ReactEvent.Animation.t => unit),
    [@mel.optional]
    onAnimationEnd: option(ReactEvent.Animation.t => unit),
    [@mel.optional]
    onAnimationIteration: option(ReactEvent.Animation.t => unit),
    /* Transition events */
    [@mel.optional]
    onTransitionEnd: option(ReactEvent.Transition.t => unit),
    /* svg */
    [@mel.optional]
    accentHeight: option(string),
    [@mel.optional]
    accumulate: option(string),
    [@mel.optional]
    additive: option(string),
    [@mel.optional]
    alignmentBaseline: option(string),
    [@mel.optional]
    allowReorder: option(string),
    [@mel.optional]
    alphabetic: option(string),
    [@mel.optional]
    amplitude: option(string),
    [@mel.optional]
    arabicForm: option(string),
    [@mel.optional]
    ascent: option(string),
    [@mel.optional]
    attributeName: option(string),
    [@mel.optional]
    attributeType: option(string),
    [@mel.optional]
    autoReverse: option(string),
    [@mel.optional]
    azimuth: option(string),
    [@mel.optional]
    baseFrequency: option(string),
    [@mel.optional]
    baseProfile: option(string),
    [@mel.optional]
    baselineShift: option(string),
    [@mel.optional]
    bbox: option(string),
    [@mel.optional] [@mel.as "begin"]
    begin_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    bias: option(string),
    [@mel.optional]
    by: option(string),
    [@mel.optional]
    calcMode: option(string),
    [@mel.optional]
    capHeight: option(string),
    [@mel.optional]
    clip: option(string),
    [@mel.optional]
    clipPath: option(string),
    [@mel.optional]
    clipPathUnits: option(string),
    [@mel.optional]
    clipRule: option(string),
    [@mel.optional]
    colorInterpolation: option(string),
    [@mel.optional]
    colorInterpolationFilters: option(string),
    [@mel.optional]
    colorProfile: option(string),
    [@mel.optional]
    colorRendering: option(string),
    [@mel.optional]
    contentScriptType: option(string),
    [@mel.optional]
    contentStyleType: option(string),
    [@mel.optional]
    cursor: option(string),
    [@mel.optional]
    cx: option(string),
    [@mel.optional]
    cy: option(string),
    [@mel.optional]
    d: option(string),
    [@mel.optional]
    decelerate: option(string),
    [@mel.optional]
    descent: option(string),
    [@mel.optional]
    diffuseConstant: option(string),
    [@mel.optional]
    direction: option(string),
    [@mel.optional]
    display: option(string),
    [@mel.optional]
    divisor: option(string),
    [@mel.optional]
    dominantBaseline: option(string),
    [@mel.optional]
    dur: option(string),
    [@mel.optional]
    dx: option(string),
    [@mel.optional]
    dy: option(string),
    [@mel.optional]
    edgeMode: option(string),
    [@mel.optional]
    elevation: option(string),
    [@mel.optional]
    enableBackground: option(string),
    [@mel.optional] [@mel.as "end"]
    end_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    exponent: option(string),
    [@mel.optional]
    externalResourcesRequired: option(string),
    [@mel.optional]
    fill: option(string),
    [@mel.optional]
    fillOpacity: option(string),
    [@mel.optional]
    fillRule: option(string),
    [@mel.optional]
    filter: option(string),
    [@mel.optional]
    filterRes: option(string),
    [@mel.optional]
    filterUnits: option(string),
    [@mel.optional]
    floodColor: option(string),
    [@mel.optional]
    floodOpacity: option(string),
    [@mel.optional]
    focusable: option(string),
    [@mel.optional]
    fontFamily: option(string),
    [@mel.optional]
    fontSize: option(string),
    [@mel.optional]
    fontSizeAdjust: option(string),
    [@mel.optional]
    fontStretch: option(string),
    [@mel.optional]
    fontStyle: option(string),
    [@mel.optional]
    fontVariant: option(string),
    [@mel.optional]
    fontWeight: option(string),
    [@mel.optional]
    fomat: option(string),
    [@mel.optional]
    from: option(string),
    [@mel.optional]
    fx: option(string),
    [@mel.optional]
    fy: option(string),
    [@mel.optional]
    g1: option(string),
    [@mel.optional]
    g2: option(string),
    [@mel.optional]
    glyphName: option(string),
    [@mel.optional]
    glyphOrientationHorizontal: option(string),
    [@mel.optional]
    glyphOrientationVertical: option(string),
    [@mel.optional]
    glyphRef: option(string),
    [@mel.optional]
    gradientTransform: option(string),
    [@mel.optional]
    gradientUnits: option(string),
    [@mel.optional]
    hanging: option(string),
    [@mel.optional]
    horizAdvX: option(string),
    [@mel.optional]
    horizOriginX: option(string),
    [@mel.optional]
    ideographic: option(string),
    [@mel.optional]
    imageRendering: option(string),
    [@mel.optional] [@mel.as "in"]
    in_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    in2: option(string),
    [@mel.optional]
    intercept: option(string),
    [@mel.optional]
    k: option(string),
    [@mel.optional]
    k1: option(string),
    [@mel.optional]
    k2: option(string),
    [@mel.optional]
    k3: option(string),
    [@mel.optional]
    k4: option(string),
    [@mel.optional]
    kernelMatrix: option(string),
    [@mel.optional]
    kernelUnitLength: option(string),
    [@mel.optional]
    kerning: option(string),
    [@mel.optional]
    keyPoints: option(string),
    [@mel.optional]
    keySplines: option(string),
    [@mel.optional]
    keyTimes: option(string),
    [@mel.optional]
    lengthAdjust: option(string),
    [@mel.optional]
    letterSpacing: option(string),
    [@mel.optional]
    lightingColor: option(string),
    [@mel.optional]
    limitingConeAngle: option(string),
    [@mel.optional]
    local: option(string),
    [@mel.optional]
    markerEnd: option(string),
    [@mel.optional]
    markerHeight: option(string),
    [@mel.optional]
    markerMid: option(string),
    [@mel.optional]
    markerStart: option(string),
    [@mel.optional]
    markerUnits: option(string),
    [@mel.optional]
    markerWidth: option(string),
    [@mel.optional]
    mask: option(string),
    [@mel.optional]
    maskContentUnits: option(string),
    [@mel.optional]
    maskUnits: option(string),
    [@mel.optional]
    mathematical: option(string),
    [@mel.optional]
    mode: option(string),
    [@mel.optional]
    numOctaves: option(string),
    [@mel.optional]
    offset: option(string),
    [@mel.optional]
    opacity: option(string),
    [@mel.optional]
    operator: option(string),
    [@mel.optional]
    order: option(string),
    [@mel.optional]
    orient: option(string),
    [@mel.optional]
    orientation: option(string),
    [@mel.optional]
    origin: option(string),
    [@mel.optional]
    overflow: option(string),
    [@mel.optional]
    overflowX: option(string),
    [@mel.optional]
    overflowY: option(string),
    [@mel.optional]
    overlinePosition: option(string),
    [@mel.optional]
    overlineThickness: option(string),
    [@mel.optional]
    paintOrder: option(string),
    [@mel.optional]
    panose1: option(string),
    [@mel.optional]
    pathLength: option(string),
    [@mel.optional]
    patternContentUnits: option(string),
    [@mel.optional]
    patternTransform: option(string),
    [@mel.optional]
    patternUnits: option(string),
    [@mel.optional]
    pointerEvents: option(string),
    [@mel.optional]
    points: option(string),
    [@mel.optional]
    pointsAtX: option(string),
    [@mel.optional]
    pointsAtY: option(string),
    [@mel.optional]
    pointsAtZ: option(string),
    [@mel.optional]
    preserveAlpha: option(string),
    [@mel.optional]
    preserveAspectRatio: option(string),
    [@mel.optional]
    primitiveUnits: option(string),
    [@mel.optional]
    r: option(string),
    [@mel.optional]
    radius: option(string),
    [@mel.optional]
    refX: option(string),
    [@mel.optional]
    refY: option(string),
    [@mel.optional]
    renderingIntent: option(string),
    [@mel.optional]
    repeatCount: option(string),
    [@mel.optional]
    repeatDur: option(string),
    [@mel.optional]
    requiredExtensions: option(string),
    [@mel.optional]
    requiredFeatures: option(string),
    [@mel.optional]
    restart: option(string),
    [@mel.optional]
    result: option(string),
    [@mel.optional]
    rotate: option(string),
    [@mel.optional]
    rx: option(string),
    [@mel.optional]
    ry: option(string),
    [@mel.optional]
    scale: option(string),
    [@mel.optional]
    seed: option(string),
    [@mel.optional]
    shapeRendering: option(string),
    [@mel.optional]
    slope: option(string),
    [@mel.optional]
    spacing: option(string),
    [@mel.optional]
    specularConstant: option(string),
    [@mel.optional]
    specularExponent: option(string),
    [@mel.optional]
    speed: option(string),
    [@mel.optional]
    spreadMethod: option(string),
    [@mel.optional]
    startOffset: option(string),
    [@mel.optional]
    stdDeviation: option(string),
    [@mel.optional]
    stemh: option(string),
    [@mel.optional]
    stemv: option(string),
    [@mel.optional]
    stitchTiles: option(string),
    [@mel.optional]
    stopColor: option(string),
    [@mel.optional]
    stopOpacity: option(string),
    [@mel.optional]
    strikethroughPosition: option(string),
    [@mel.optional]
    strikethroughThickness: option(string),
    [@mel.optional]
    string: option(string),
    [@mel.optional]
    stroke: option(string),
    [@mel.optional]
    strokeDasharray: option(string),
    [@mel.optional]
    strokeDashoffset: option(string),
    [@mel.optional]
    strokeLinecap: option(string),
    [@mel.optional]
    strokeLinejoin: option(string),
    [@mel.optional]
    strokeMiterlimit: option(string),
    [@mel.optional]
    strokeOpacity: option(string),
    [@mel.optional]
    strokeWidth: option(string),
    [@mel.optional]
    surfaceScale: option(string),
    [@mel.optional]
    systemLanguage: option(string),
    [@mel.optional]
    tableValues: option(string),
    [@mel.optional]
    targetX: option(string),
    [@mel.optional]
    targetY: option(string),
    [@mel.optional]
    textAnchor: option(string),
    [@mel.optional]
    textDecoration: option(string),
    [@mel.optional]
    textLength: option(string),
    [@mel.optional]
    textRendering: option(string),
    [@mel.optional] [@mel.as "to"]
    to_: option(string), /* use this one. Previous one is deprecated */
    [@mel.optional]
    transform: option(string),
    [@mel.optional]
    u1: option(string),
    [@mel.optional]
    u2: option(string),
    [@mel.optional]
    underlinePosition: option(string),
    [@mel.optional]
    underlineThickness: option(string),
    [@mel.optional]
    unicode: option(string),
    [@mel.optional]
    unicodeBidi: option(string),
    [@mel.optional]
    unicodeRange: option(string),
    [@mel.optional]
    unitsPerEm: option(string),
    [@mel.optional]
    vAlphabetic: option(string),
    [@mel.optional]
    vHanging: option(string),
    [@mel.optional]
    vIdeographic: option(string),
    [@mel.optional]
    vMathematical: option(string),
    [@mel.optional]
    values: option(string),
    [@mel.optional]
    vectorEffect: option(string),
    [@mel.optional]
    version: option(string),
    [@mel.optional]
    vertAdvX: option(string),
    [@mel.optional]
    vertAdvY: option(string),
    [@mel.optional]
    vertOriginX: option(string),
    [@mel.optional]
    vertOriginY: option(string),
    [@mel.optional]
    viewBox: option(string),
    [@mel.optional]
    viewTarget: option(string),
    [@mel.optional]
    visibility: option(string),
    /*width::string? =>*/
    [@mel.optional]
    widths: option(string),
    [@mel.optional]
    wordSpacing: option(string),
    [@mel.optional]
    writingMode: option(string),
    [@mel.optional]
    x: option(string),
    [@mel.optional]
    x1: option(string),
    [@mel.optional]
    x2: option(string),
    [@mel.optional]
    xChannelSelector: option(string),
    [@mel.optional]
    xHeight: option(string),
    [@mel.optional]
    xlinkActuate: option(string),
    [@mel.optional]
    xlinkArcrole: option(string),
    [@mel.optional]
    xlinkHref: option(string),
    [@mel.optional]
    xlinkRole: option(string),
    [@mel.optional]
    xlinkShow: option(string),
    [@mel.optional]
    xlinkTitle: option(string),
    [@mel.optional]
    xlinkType: option(string),
    [@mel.optional]
    xmlns: option(string),
    [@mel.optional]
    xmlnsXlink: option(string),
    [@mel.optional]
    xmlBase: option(string),
    [@mel.optional]
    xmlLang: option(string),
    [@mel.optional]
    xmlSpace: option(string),
    [@mel.optional]
    y: option(string),
    [@mel.optional]
    y1: option(string),
    [@mel.optional]
    y2: option(string),
    [@mel.optional]
    yChannelSelector: option(string),
    [@mel.optional]
    z: option(string),
    [@mel.optional]
    zoomAndPan: option(string),
    /* RDFa */
    [@mel.optional]
    about: option(string),
    [@mel.optional]
    datatype: option(string),
    [@mel.optional]
    inlist: option(string),
    [@mel.optional]
    prefix: option(string),
    [@mel.optional]
    property: option(string),
    [@mel.optional]
    resource: option(string),
    [@mel.optional]
    typeof: option(string),
    [@mel.optional]
    vocab: option(string),
    /* react-specific */
    [@mel.optional]
    dangerouslySetInnerHTML: option({. "__html": string}),
    [@mel.optional]
    suppressHydrationWarning: option(bool),
    [@mel.optional]
    suppressContentEditableWarning: option(bool),
  };
};

include Props;

// As we've removed `ReactDOMRe.createElement`, this enables patterns like
// React.createElement(ReactDOM.stringToComponent(multiline ? "textarea" : "input"), ...)
external stringToComponent: string => React.component(domProps) = "%identity";

module Style = ReactDOMStyle;

[@mel.variadic] [@mel.module "react"]
external createElement:
  (string, ~props: props=?, array(React.element)) => React.element =
  "createElement";

[@mel.variadic] [@mel.module "react"]
external createDOMElementVariadic:
  (string, ~props: domProps=?, array(React.element)) => React.element =
  "createElement";

[@mel.module "react/jsx-runtime"]
external jsxKeyed: (string, domProps, ~key: string=?, unit) => React.element =
  "jsx";

[@mel.module "react/jsx-runtime"]
external jsx: (string, domProps) => React.element = "jsx";

[@mel.module "react/jsx-runtime"]
external jsxs: (string, domProps) => React.element = "jsxs";

[@mel.module "react/jsx-runtime"]
external jsxsKeyed: (string, domProps, ~key: string=?, unit) => React.element =
  "jsxs";
