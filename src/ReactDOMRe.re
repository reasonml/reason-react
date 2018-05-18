/* First time reading an OCaml/Reason/BuckleScript file? */
/* `external` is the foreign function call in OCaml. */
/* here we're saying `I guarantee that on the JS side, we have a `render` function in the module "react-dom"
   that takes in a reactElement, a dom element, and returns unit (nothing) */
/* It's like `let`, except you're pointing the implementation to the JS side. The compiler will inline these
   calls and add the appropriate `require("react-dom")` in the file calling this `render` */
[@bs.val] [@bs.module "react-dom"]
external render : (ReasonReact.reactElement, Dom.element) => unit = "render";

[@bs.val]
external _getElementsByClassName : string => array(Dom.element) =
  "document.getElementsByClassName";

[@bs.val] [@bs.return nullable]
external _getElementById : string => option(Dom.element) =
  "document.getElementById";

let renderToElementWithClassName = (reactElement, className) =>
  switch (_getElementsByClassName(className)) {
  | [||] =>
    raise(
      Invalid_argument(
        "ReactDOMRe.renderToElementWithClassName: no element of class "
        ++ className
        ++ " found in the HTML.",
      ),
    )
  | elements => render(reactElement, Array.unsafe_get(elements, 0))
  };

let renderToElementWithId = (reactElement, id) =>
  switch (_getElementById(id)) {
  | None =>
    raise(
      Invalid_argument(
        "ReactDOMRe.renderToElementWithId : no element of id "
        ++ id
        ++ " found in the HTML.",
      ),
    )
  | Some(element) => render(reactElement, element)
  };

[@bs.val] [@bs.module "react-dom"]
external hydrate : (ReasonReact.reactElement, Dom.element) => unit = "hydrate";

let hydrateToElementWithClassName = (reactElement, className) =>
  switch (_getElementsByClassName(className)) {
  | [||] =>
    raise(
      Invalid_argument(
        "ReactDOMRe.hydrateToElementWithClassName: no element of class "
        ++ className
        ++ " found in the HTML.",
      ),
    )
  | elements => hydrate(reactElement, Array.unsafe_get(elements, 0))
  };

let hydrateToElementWithId = (reactElement, id) =>
  switch (_getElementById(id)) {
  | None =>
    raise(
      Invalid_argument(
        "ReactDOMRe.hydrateToElementWithId : no element of id "
        ++ id
        ++ " found in the HTML.",
      ),
    )
  | Some(element) => hydrate(reactElement, element)
  };

[@bs.val] [@bs.module "react-dom"]
external createPortal :
  (ReasonReact.reactElement, Dom.element) => ReasonReact.reactElement =
  "createPortal";

[@bs.val] [@bs.module "react-dom"]
external unmountComponentAtNode : Dom.element => unit =
  "unmountComponentAtNode";

[@bs.val] [@bs.module "react-dom"]
external findDOMNode : ReasonReact.reactRef => Dom.element = "findDOMNode";

external domElementToObj : Dom.element => Js.t({..}) = "%identity";

type style;

/* This list isn't exhaustive. We'll add more as we go. */
[@bs.deriving abstract]
type props = {
  [@bs.optional] key: string,
  [@bs.optional] ref: Js.nullable(Dom.element) => unit,
  /* accessibility */
  [@bs.optional] [@bs.as "aria-current"] ariaCurrent: string,
  [@bs.optional] [@bs.as "aria-details"] ariaDetails: string,
  [@bs.optional] [@bs.as "aria-disabled"] ariaDisabled: string,
  [@bs.optional] [@bs.as "aria-hidden"] ariaHidden: string,
  [@bs.optional] [@bs.as "aria-invalid"] ariaInvalid: string,
  [@bs.optional] [@bs.as "aria-keyshortcuts"] ariaKeyshortcuts: string,
  [@bs.optional] [@bs.as "aria-label"] ariaLabel: string,
  [@bs.optional] [@bs.as "aria-roledescription"] ariaRoledescription: string,
  /* Widget Attributes */
  [@bs.optional] [@bs.as "aria-autocomplete"] ariaAutocomplete: string,
  [@bs.optional] [@bs.as "aria-checked"] ariaChecked: string,
  [@bs.optional] [@bs.as "aria-expanded"] ariaExpanded: string,
  [@bs.optional] [@bs.as "aria-haspopup"] ariaHaspopup: string,
  [@bs.optional] [@bs.as "aria-level"] ariaLevel: string,
  [@bs.optional] [@bs.as "aria-modal"] ariaModal: string,
  [@bs.optional] [@bs.as "aria-multiline"] ariaMultiline: string,
  [@bs.optional] [@bs.as "aria-multiselectable"] ariaMultiselectable: string,
  [@bs.optional] [@bs.as "aria-orientation"] ariaOrientation: string,
  [@bs.optional] [@bs.as "aria-placeholder"] ariaPlaceholder: string,
  [@bs.optional] [@bs.as "aria-pressed"] ariaPressed: string,
  [@bs.optional] [@bs.as "aria-readonly"] ariaReadonly: string,
  [@bs.optional] [@bs.as "aria-required"] ariaRequired: string,
  [@bs.optional] [@bs.as "aria-selected"] ariaSelected: string,
  [@bs.optional] [@bs.as "aria-sort"] ariaSort: string,
  [@bs.optional] [@bs.as "aria-valuemax"] ariaValuemax: string,
  [@bs.optional] [@bs.as "aria-valuemin"] ariaValuemin: string,
  [@bs.optional] [@bs.as "aria-valuenow"] ariaValuenow: string,
  [@bs.optional] [@bs.as "aria-valuetext"] ariaValuetext: string,
  /* Live Region Attributes */
  [@bs.optional] [@bs.as "aria-atomic"] ariaAtomic: string,
  [@bs.optional] [@bs.as "aria-busy"] ariaBusy: string,
  [@bs.optional] [@bs.as "aria-live"] ariaLive: string,
  [@bs.optional] [@bs.as "aria-relevant"] ariaRelevant: string,
  /* Drag-and-Drop Attributes */
  [@bs.optional] [@bs.as "aria-dropeffect"] ariaDropeffect: string,
  [@bs.optional] [@bs.as "aria-grabbed"] ariaGrabbed: string,
  /* Relationship Attributes */
  [@bs.optional] [@bs.as "aria-activedescendant"] ariaActivedescendant: string,
  [@bs.optional] [@bs.as "aria-colcount"] ariaColcount: string,
  [@bs.optional] [@bs.as "aria-colindex"] ariaColindex: string,
  [@bs.optional] [@bs.as "aria-colspan"] ariaColspan: string,
  [@bs.optional] [@bs.as "aria-controls"] ariaControls: string,
  [@bs.optional] [@bs.as "aria-describedby"] ariaDescribedby: string,
  [@bs.optional] [@bs.as "aria-errormessage"] ariaErrormessage: string,
  [@bs.optional] [@bs.as "aria-flowto"] ariaFlowto: string,
  [@bs.optional] [@bs.as "aria-labelledby"] ariaLabelledby: string,
  [@bs.optional] [@bs.as "aria-owns"] ariaOwns: string,
  [@bs.optional] [@bs.as "aria-posinset"] ariaPosinset: string,
  [@bs.optional] [@bs.as "aria-rowcount"] ariaRowcount: string,
  [@bs.optional] [@bs.as "aria-rowindex"] ariaRowindex: string,
  [@bs.optional] [@bs.as "aria-rowspan"] ariaRowspan: string,
  [@bs.optional] [@bs.as "aria-setsize"] ariaSetsize: string,
  /* react textarea/input */
  [@bs.optional] defaultChecked: bool,
  [@bs.optional] defaultValue: string,
  /* global html attributes */
  [@bs.optional] accessKey: string,
  [@bs.optional] className: string, /* substitute for "class" */
  [@bs.optional] contentEditable: bool,
  [@bs.optional] contextMenu: string,
  [@bs.optional] dir: string, /* "ltr", "rtl" or "auto" */
  [@bs.optional] draggable: bool,
  [@bs.optional] hidden: bool,
  [@bs.optional] id: string,
  [@bs.optional] lang: string,
  [@bs.optional] role: string, /* ARIA role */
  [@bs.optional] style: style,
  [@bs.optional] spellCheck: bool,
  [@bs.optional] tabIndex: int,
  [@bs.optional] title: string,
  /* html5 microdata */
  [@bs.optional] itemID: string,
  [@bs.optional] itemProp: string,
  [@bs.optional] itemRef: string,
  [@bs.optional] itemScope: bool,
  [@bs.optional] itemType: string, /* uri */
  /* tag-specific html attributes */
  [@bs.optional] accept: string,
  [@bs.optional] acceptCharset: string,
  [@bs.optional] action: string, /* uri */
  [@bs.optional] allowFullScreen: bool,
  [@bs.optional] alt: string,
  [@bs.optional] async: bool,
  [@bs.optional] autoComplete: string, /* has a fixed, but large-ish, set of possible values */
  [@bs.optional] autoFocus: bool,
  [@bs.optional] autoPlay: bool,
  [@bs.optional] challenge: string,
  [@bs.optional] charSet: string,
  [@bs.optional] checked: bool,
  [@bs.optional] cite: string, /* uri */
  [@bs.optional] crossorigin: bool,
  [@bs.optional] cols: int,
  [@bs.optional] colSpan: int,
  [@bs.optional] content: string,
  [@bs.optional] controls: bool,
  [@bs.optional] coords: string, /* set of values specifying the coordinates of a region */
  [@bs.optional] data: string, /* uri */
  [@bs.optional] dateTime: string, /* "valid date string with optional time" */
  [@bs.optional] default: bool,
  [@bs.optional] defer: bool,
  [@bs.optional] disabled: bool,
  [@bs.optional] download: string, /* should really be either a boolean, signifying presence, or a string */
  [@bs.optional] encType: string, /* "application/x-www-form-urlencoded", "multipart/form-data" or "text/plain" */
  [@bs.optional] form: string,
  [@bs.optional] formAction: string, /* uri */
  [@bs.optional] formTarget: string, /* "_blank", "_self", etc. */
  [@bs.optional] formMethod: string, /* "post", "get", "put" */
  [@bs.optional] headers: string,
  [@bs.optional] height: string, /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
  [@bs.optional] high: int,
  [@bs.optional] href: string, /* uri */
  [@bs.optional] hrefLang: string,
  [@bs.optional] htmlFor: string, /* substitute for "for" */
  [@bs.optional] httpEquiv: string, /* has a fixed set of possible values */
  [@bs.optional] icon: string, /* uri? */
  [@bs.optional] inputMode: string, /* "verbatim", "latin", "numeric", etc. */
  [@bs.optional] integrity: string,
  [@bs.optional] keyType: string,
  [@bs.optional] kind: string, /* has a fixed set of possible values */
  [@bs.optional] label: string,
  [@bs.optional] list: string,
  [@bs.optional] loop: bool,
  [@bs.optional] low: int,
  [@bs.optional] manifest: string, /* uri */
  [@bs.optional] max: string, /* should be int or Js.Date.t */
  [@bs.optional] maxLength: int,
  [@bs.optional] media: string, /* a valid media query */
  [@bs.optional] mediaGroup: string,
  [@bs.optional] method: string, /* "post" or "get" */
  [@bs.optional] min: int,
  [@bs.optional] minLength: int,
  [@bs.optional] multiple: bool,
  [@bs.optional] muted: bool,
  [@bs.optional] name: string,
  [@bs.optional] nonce: string,
  [@bs.optional] noValidate: bool,
  [@bs.optional] _open: bool,
  [@bs.optional] [@bs.as "open"] open_: bool, /* use this one. Previous one is deprecated */
  [@bs.optional] optimum: int,
  [@bs.optional] pattern: string, /* valid Js RegExp */
  [@bs.optional] placeholder: string,
  [@bs.optional] poster: string, /* uri */
  [@bs.optional] preload: string, /* "none", "metadata" or "auto" (and "" as a synonym for "auto") */
  [@bs.optional] radioGroup: string,
  [@bs.optional] readOnly: bool,
  [@bs.optional] rel: string, /* a space- or comma-separated (depending on the element) list of a fixed set of "link types" */
  [@bs.optional] required: bool,
  [@bs.optional] reversed: bool,
  [@bs.optional] rows: int,
  [@bs.optional] rowSpan: int,
  [@bs.optional] sandbox: string, /* has a fixed set of possible values */
  [@bs.optional] scope: string, /* has a fixed set of possible values */
  [@bs.optional] scoped: bool,
  [@bs.optional] scrolling: string, /* html4 only, "auto", "yes" or "no" */
  /* seamless - supported by React, but removed from the html5 spec */
  [@bs.optional] selected: bool,
  [@bs.optional] shape: string,
  [@bs.optional] size: int,
  [@bs.optional] sizes: string,
  [@bs.optional] span: int,
  [@bs.optional] src: string, /* uri */
  [@bs.optional] srcDoc: string,
  [@bs.optional] srcLang: string,
  [@bs.optional] srcSet: string,
  [@bs.optional] start: int,
  [@bs.optional] step: float,
  [@bs.optional] summary: string, /* deprecated */
  [@bs.optional] target: string,
  [@bs.optional] _type: string, /* has a fixed but large-ish set of possible values */
  [@bs.optional] [@bs.as "type"] type_: string, /* has a fixed but large-ish set of possible values */ /* use this one. Previous one is deprecated */
  [@bs.optional] useMap: string,
  [@bs.optional] value: string,
  [@bs.optional] width: string, /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
  [@bs.optional] wrap: string, /* "hard" or "soft" */
  /* Clipboard events */
  [@bs.optional] onCopy: ReactEventRe.Clipboard.t => unit,
  [@bs.optional] onCut: ReactEventRe.Clipboard.t => unit,
  [@bs.optional] onPaste: ReactEventRe.Clipboard.t => unit,
  /* Composition events */
  [@bs.optional] onCompositionEnd: ReactEventRe.Composition.t => unit,
  [@bs.optional] onCompositionStart: ReactEventRe.Composition.t => unit,
  [@bs.optional] onCompositionUpdate: ReactEventRe.Composition.t => unit,
  /* Keyboard events */
  [@bs.optional] onKeyDown: ReactEventRe.Keyboard.t => unit,
  [@bs.optional] onKeyPress: ReactEventRe.Keyboard.t => unit,
  [@bs.optional] onKeyUp: ReactEventRe.Keyboard.t => unit,
  /* Focus events */
  [@bs.optional] onFocus: ReactEventRe.Focus.t => unit,
  [@bs.optional] onBlur: ReactEventRe.Focus.t => unit,
  /* Form events */
  [@bs.optional] onChange: ReactEventRe.Form.t => unit,
  [@bs.optional] onInput: ReactEventRe.Form.t => unit,
  [@bs.optional] onSubmit: ReactEventRe.Form.t => unit,
  /* Mouse events */
  [@bs.optional] onClick: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onContextMenu: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDoubleClick: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDrag: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDragEnd: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDragEnter: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDragExit: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDragLeave: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDragOver: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDragStart: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onDrop: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onMouseDown: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onMouseEnter: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onMouseLeave: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onMouseMove: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onMouseOut: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onMouseOver: ReactEventRe.Mouse.t => unit,
  [@bs.optional] onMouseUp: ReactEventRe.Mouse.t => unit,
  /* Selection events */
  [@bs.optional] onSelect: ReactEventRe.Selection.t => unit,
  /* Touch events */
  [@bs.optional] onTouchCancel: ReactEventRe.Touch.t => unit,
  [@bs.optional] onTouchEnd: ReactEventRe.Touch.t => unit,
  [@bs.optional] onTouchMove: ReactEventRe.Touch.t => unit,
  [@bs.optional] onTouchStart: ReactEventRe.Touch.t => unit,
  /* UI events */
  [@bs.optional] onScroll: ReactEventRe.UI.t => unit,
  /* Wheel events */
  [@bs.optional] onWheel: ReactEventRe.Wheel.t => unit,
  /* Media events */
  [@bs.optional] onAbort: ReactEventRe.Media.t => unit,
  [@bs.optional] onCanPlay: ReactEventRe.Media.t => unit,
  [@bs.optional] onCanPlayThrough: ReactEventRe.Media.t => unit,
  [@bs.optional] onDurationChange: ReactEventRe.Media.t => unit,
  [@bs.optional] onEmptied: ReactEventRe.Media.t => unit,
  [@bs.optional] onEncrypetd: ReactEventRe.Media.t => unit,
  [@bs.optional] onEnded: ReactEventRe.Media.t => unit,
  [@bs.optional] onError: ReactEventRe.Media.t => unit,
  [@bs.optional] onLoadedData: ReactEventRe.Media.t => unit,
  [@bs.optional] onLoadedMetadata: ReactEventRe.Media.t => unit,
  [@bs.optional] onLoadStart: ReactEventRe.Media.t => unit,
  [@bs.optional] onPause: ReactEventRe.Media.t => unit,
  [@bs.optional] onPlay: ReactEventRe.Media.t => unit,
  [@bs.optional] onPlaying: ReactEventRe.Media.t => unit,
  [@bs.optional] onProgress: ReactEventRe.Media.t => unit,
  [@bs.optional] onRateChange: ReactEventRe.Media.t => unit,
  [@bs.optional] onSeeked: ReactEventRe.Media.t => unit,
  [@bs.optional] onSeeking: ReactEventRe.Media.t => unit,
  [@bs.optional] onStalled: ReactEventRe.Media.t => unit,
  [@bs.optional] onSuspend: ReactEventRe.Media.t => unit,
  [@bs.optional] onTimeUpdate: ReactEventRe.Media.t => unit,
  [@bs.optional] onVolumeChange: ReactEventRe.Media.t => unit,
  [@bs.optional] onWaiting: ReactEventRe.Media.t => unit,
  /* Image events */
  [@bs.optional] onLoad: ReactEventRe.Image.t => unit /* duplicate */, /*~onError: ReactEventRe.Image.t => unit=?,*/
  /* Animation events */
  [@bs.optional] onAnimationStart: ReactEventRe.Animation.t => unit,
  [@bs.optional] onAnimationEnd: ReactEventRe.Animation.t => unit,
  [@bs.optional] onAnimationIteration: ReactEventRe.Animation.t => unit,
  /* Transition events */
  [@bs.optional] onTransitionEnd: ReactEventRe.Transition.t => unit,
  /* svg */
  [@bs.optional] accentHeight: string,
  [@bs.optional] accumulate: string,
  [@bs.optional] additive: string,
  [@bs.optional] alignmentBaseline: string,
  [@bs.optional] allowReorder: string,
  [@bs.optional] alphabetic: string,
  [@bs.optional] amplitude: string,
  [@bs.optional] arabicForm: string,
  [@bs.optional] ascent: string,
  [@bs.optional] attributeName: string,
  [@bs.optional] attributeType: string,
  [@bs.optional] autoReverse: string,
  [@bs.optional] azimuth: string,
  [@bs.optional] baseFrequency: string,
  [@bs.optional] baseProfile: string,
  [@bs.optional] baselineShift: string,
  [@bs.optional] bbox: string,
  [@bs.optional] _begin: string,
  [@bs.optional] [@bs.as "begin"] begin_: string, /* use this one. Previous one is deprecated */
  [@bs.optional] bias: string,
  [@bs.optional] by: string,
  [@bs.optional] calcMode: string,
  [@bs.optional] capHeight: string,
  [@bs.optional] clip: string,
  [@bs.optional] clipPath: string,
  [@bs.optional] clipPathUnits: string,
  [@bs.optional] clipRule: string,
  [@bs.optional] colorInterpolation: string,
  [@bs.optional] colorInterpolationFilters: string,
  [@bs.optional] colorProfile: string,
  [@bs.optional] colorRendering: string,
  [@bs.optional] contentScriptType: string,
  [@bs.optional] contentStyleType: string,
  [@bs.optional] cursor: string,
  [@bs.optional] cx: string,
  [@bs.optional] cy: string,
  [@bs.optional] d: string,
  [@bs.optional] decelerate: string,
  [@bs.optional] descent: string,
  [@bs.optional] diffuseConstant: string,
  [@bs.optional] direction: string,
  [@bs.optional] display: string,
  [@bs.optional] divisor: string,
  [@bs.optional] dominantBaseline: string,
  [@bs.optional] dur: string,
  [@bs.optional] dx: string,
  [@bs.optional] dy: string,
  [@bs.optional] edgeMode: string,
  [@bs.optional] elevation: string,
  [@bs.optional] enableBackground: string,
  [@bs.optional] _end: string,
  [@bs.optional] [@bs.as "end"] end_: string, /* use this one. Previous one is deprecated */
  [@bs.optional] exponent: string,
  [@bs.optional] externalResourcesRequired: string,
  [@bs.optional] fill: string,
  [@bs.optional] fillOpacity: string,
  [@bs.optional] fillRule: string,
  [@bs.optional] filter: string,
  [@bs.optional] filterRes: string,
  [@bs.optional] filterUnits: string,
  [@bs.optional] floodColor: string,
  [@bs.optional] floodOpacity: string,
  [@bs.optional] focusable: string,
  [@bs.optional] fontFamily: string,
  [@bs.optional] fontSize: string,
  [@bs.optional] fontSizeAdjust: string,
  [@bs.optional] fontStretch: string,
  [@bs.optional] fontStyle: string,
  [@bs.optional] fontVariant: string,
  [@bs.optional] fontWeight: string,
  [@bs.optional] fomat: string,
  [@bs.optional] from: string,
  [@bs.optional] fx: string,
  [@bs.optional] fy: string,
  [@bs.optional] g1: string,
  [@bs.optional] g2: string,
  [@bs.optional] glyphName: string,
  [@bs.optional] glyphOrientationHorizontal: string,
  [@bs.optional] glyphOrientationVertical: string,
  [@bs.optional] glyphRef: string,
  [@bs.optional] gradientTransform: string,
  [@bs.optional] gradientUnits: string,
  [@bs.optional] hanging: string,
  [@bs.optional] horizAdvX: string,
  [@bs.optional] horizOriginX: string,
  [@bs.optional] ideographic: string,
  [@bs.optional] imageRendering: string,
  [@bs.optional] _in: string,
  [@bs.optional] [@bs.as "in"] in_: string, /* use this one. Previous one is deprecated */
  [@bs.optional] in2: string,
  [@bs.optional] intercept: string,
  [@bs.optional] k: string,
  [@bs.optional] k1: string,
  [@bs.optional] k2: string,
  [@bs.optional] k3: string,
  [@bs.optional] k4: string,
  [@bs.optional] kernelMatrix: string,
  [@bs.optional] kernelUnitLength: string,
  [@bs.optional] kerning: string,
  [@bs.optional] keyPoints: string,
  [@bs.optional] keySplines: string,
  [@bs.optional] keyTimes: string,
  [@bs.optional] lengthAdjust: string,
  [@bs.optional] letterSpacing: string,
  [@bs.optional] lightingColor: string,
  [@bs.optional] limitingConeAngle: string,
  [@bs.optional] local: string,
  [@bs.optional] markerEnd: string,
  [@bs.optional] markerHeight: string,
  [@bs.optional] markerMid: string,
  [@bs.optional] markerStart: string,
  [@bs.optional] markerUnits: string,
  [@bs.optional] markerWidth: string,
  [@bs.optional] mask: string,
  [@bs.optional] maskContentUnits: string,
  [@bs.optional] maskUnits: string,
  [@bs.optional] mathematical: string,
  [@bs.optional] mode: string,
  [@bs.optional] numOctaves: string,
  [@bs.optional] offset: string,
  [@bs.optional] opacity: string,
  [@bs.optional] operator: string,
  [@bs.optional] order: string,
  [@bs.optional] orient: string,
  [@bs.optional] orientation: string,
  [@bs.optional] origin: string,
  [@bs.optional] overflow: string,
  [@bs.optional] overflowX: string,
  [@bs.optional] overflowY: string,
  [@bs.optional] overlinePosition: string,
  [@bs.optional] overlineThickness: string,
  [@bs.optional] paintOrder: string,
  [@bs.optional] panose1: string,
  [@bs.optional] pathLength: string,
  [@bs.optional] patternContentUnits: string,
  [@bs.optional] patternTransform: string,
  [@bs.optional] patternUnits: string,
  [@bs.optional] pointerEvents: string,
  [@bs.optional] points: string,
  [@bs.optional] pointsAtX: string,
  [@bs.optional] pointsAtY: string,
  [@bs.optional] pointsAtZ: string,
  [@bs.optional] preserveAlpha: string,
  [@bs.optional] preserveAspectRatio: string,
  [@bs.optional] primitiveUnits: string,
  [@bs.optional] r: string,
  [@bs.optional] radius: string,
  [@bs.optional] refX: string,
  [@bs.optional] refY: string,
  [@bs.optional] renderingIntent: string,
  [@bs.optional] repeatCount: string,
  [@bs.optional] repeatDur: string,
  [@bs.optional] requiredExtensions: string,
  [@bs.optional] requiredFeatures: string,
  [@bs.optional] restart: string,
  [@bs.optional] result: string,
  [@bs.optional] rotate: string,
  [@bs.optional] rx: string,
  [@bs.optional] ry: string,
  [@bs.optional] scale: string,
  [@bs.optional] seed: string,
  [@bs.optional] shapeRendering: string,
  [@bs.optional] slope: string,
  [@bs.optional] spacing: string,
  [@bs.optional] specularConstant: string,
  [@bs.optional] specularExponent: string,
  [@bs.optional] speed: string,
  [@bs.optional] spreadMethod: string,
  [@bs.optional] startOffset: string,
  [@bs.optional] stdDeviation: string,
  [@bs.optional] stemh: string,
  [@bs.optional] stemv: string,
  [@bs.optional] stitchTiles: string,
  [@bs.optional] stopColor: string,
  [@bs.optional] stopOpacity: string,
  [@bs.optional] strikethroughPosition: string,
  [@bs.optional] strikethroughThickness: string,
  [@bs.optional] string: string,
  [@bs.optional] stroke: string,
  [@bs.optional] strokeDasharray: string,
  [@bs.optional] strokeDashoffset: string,
  [@bs.optional] strokeLinecap: string,
  [@bs.optional] strokeLinejoin: string,
  [@bs.optional] strokeMiterlimit: string,
  [@bs.optional] strokeOpacity: string,
  [@bs.optional] strokeWidth: string,
  [@bs.optional] surfaceScale: string,
  [@bs.optional] systemLanguage: string,
  [@bs.optional] tableValues: string,
  [@bs.optional] targetX: string,
  [@bs.optional] targetY: string,
  [@bs.optional] textAnchor: string,
  [@bs.optional] textDecoration: string,
  [@bs.optional] textLength: string,
  [@bs.optional] textRendering: string,
  [@bs.optional] _to: string,
  [@bs.optional] [@bs.as "to"] to_: string, /* use this one. Previous one is deprecated */
  [@bs.optional] transform: string,
  [@bs.optional] u1: string,
  [@bs.optional] u2: string,
  [@bs.optional] underlinePosition: string,
  [@bs.optional] underlineThickness: string,
  [@bs.optional] unicode: string,
  [@bs.optional] unicodeBidi: string,
  [@bs.optional] unicodeRange: string,
  [@bs.optional] unitsPerEm: string,
  [@bs.optional] vAlphabetic: string,
  [@bs.optional] vHanging: string,
  [@bs.optional] vIdeographic: string,
  [@bs.optional] vMathematical: string,
  [@bs.optional] values: string,
  [@bs.optional] vectorEffect: string,
  [@bs.optional] version: string,
  [@bs.optional] vertAdvX: string,
  [@bs.optional] vertAdvY: string,
  [@bs.optional] vertOriginX: string,
  [@bs.optional] vertOriginY: string,
  [@bs.optional] viewBox: string,
  [@bs.optional] viewTarget: string,
  [@bs.optional] visibility: string,
  /*width::string? =>*/
  [@bs.optional] widths: string,
  [@bs.optional] wordSpacing: string,
  [@bs.optional] writingMode: string,
  [@bs.optional] x: string,
  [@bs.optional] x1: string,
  [@bs.optional] x2: string,
  [@bs.optional] xChannelSelector: string,
  [@bs.optional] xHeight: string,
  [@bs.optional] xlinkActuate: string,
  [@bs.optional] xlinkArcrole: string,
  [@bs.optional] xlinkHref: string,
  [@bs.optional] xlinkRole: string,
  [@bs.optional] xlinkShow: string,
  [@bs.optional] xlinkTitle: string,
  [@bs.optional] xlinkType: string,
  [@bs.optional] xmlns: string,
  [@bs.optional] xmlnsXlink: string,
  [@bs.optional] xmlBase: string,
  [@bs.optional] xmlLang: string,
  [@bs.optional] xmlSpace: string,
  [@bs.optional] y: string,
  [@bs.optional] y1: string,
  [@bs.optional] y2: string,
  [@bs.optional] yChannelSelector: string,
  [@bs.optional] z: string,
  [@bs.optional] zoomAndPan: string,
  /* RDFa */
  [@bs.optional] about: string,
  [@bs.optional] datatype: string,
  [@bs.optional] inlist: string,
  [@bs.optional] prefix: string,
  [@bs.optional] property: string,
  [@bs.optional] resource: string,
  [@bs.optional] typeof: string,
  [@bs.optional] vocab: string,
  /* react-specific */
  [@bs.optional] dangerouslySetInnerHTML: {. "__html": string},
  [@bs.optional] suppressContentEditableWarning: bool,
};

external objToDOMProps : Js.t({..}) => props = "%identity";

[@deprecated "Please use ReactDOMRe.props instead"] type reactDOMProps = props;

[@bs.splice] [@bs.val] [@bs.module "react"]
external createElement :
  (string, ~props: props=?, array(ReasonReact.reactElement)) =>
  ReasonReact.reactElement =
  "createElement";

module Style = {
  type t = style;
  [@bs.obj]
  external make :
    (
      ~azimuth: string=?,
      ~background: string=?,
      ~backgroundAttachment: string=?,
      ~backgroundColor: string=?,
      ~backgroundImage: string=?,
      ~backgroundPosition: string=?,
      ~backgroundRepeat: string=?,
      ~border: string=?,
      ~borderCollapse: string=?,
      ~borderColor: string=?,
      ~borderSpacing: string=?,
      ~borderStyle: string=?,
      ~borderTop: string=?,
      ~borderRight: string=?,
      ~borderBottom: string=?,
      ~borderLeft: string=?,
      ~borderTopColor: string=?,
      ~borderRightColor: string=?,
      ~borderBottomColor: string=?,
      ~borderLeftColor: string=?,
      ~borderTopStyle: string=?,
      ~borderRightStyle: string=?,
      ~borderBottomStyle: string=?,
      ~borderLeftStyle: string=?,
      ~borderTopWidth: string=?,
      ~borderRightWidth: string=?,
      ~borderBottomWidth: string=?,
      ~borderLeftWidth: string=?,
      ~borderWidth: string=?,
      ~bottom: string=?,
      ~captionSide: string=?,
      ~clear: string=?,
      ~clip: string=?,
      ~color: string=?,
      ~content: string=?,
      ~counterIncrement: string=?,
      ~counterReset: string=?,
      ~cue: string=?,
      ~cueAfter: string=?,
      ~cueBefore: string=?,
      ~cursor: string=?,
      ~direction: string=?,
      ~display: string=?,
      ~elevation: string=?,
      ~emptyCells: string=?,
      ~float: string=?,
      ~font: string=?,
      ~fontFamily: string=?,
      ~fontSize: string=?,
      ~fontSizeAdjust: string=?,
      ~fontStretch: string=?,
      ~fontStyle: string=?,
      ~fontVariant: string=?,
      ~fontWeight: string=?,
      ~height: string=?,
      ~left: string=?,
      ~letterSpacing: string=?,
      ~lineHeight: string=?,
      ~listStyle: string=?,
      ~listStyleImage: string=?,
      ~listStylePosition: string=?,
      ~listStyleType: string=?,
      ~margin: string=?,
      ~marginTop: string=?,
      ~marginRight: string=?,
      ~marginBottom: string=?,
      ~marginLeft: string=?,
      ~markerOffset: string=?,
      ~marks: string=?,
      ~maxHeight: string=?,
      ~maxWidth: string=?,
      ~minHeight: string=?,
      ~minWidth: string=?,
      ~orphans: string=?,
      ~outline: string=?,
      ~outlineColor: string=?,
      ~outlineStyle: string=?,
      ~outlineWidth: string=?,
      ~overflow: string=?,
      ~overflowX: string=?,
      ~overflowY: string=?,
      ~padding: string=?,
      ~paddingTop: string=?,
      ~paddingRight: string=?,
      ~paddingBottom: string=?,
      ~paddingLeft: string=?,
      ~page: string=?,
      ~pageBreakAfter: string=?,
      ~pageBreakBefore: string=?,
      ~pageBreakInside: string=?,
      ~pause: string=?,
      ~pauseAfter: string=?,
      ~pauseBefore: string=?,
      ~pitch: string=?,
      ~pitchRange: string=?,
      ~playDuring: string=?,
      ~position: string=?,
      ~quotes: string=?,
      ~richness: string=?,
      ~right: string=?,
      ~size: string=?,
      ~speak: string=?,
      ~speakHeader: string=?,
      ~speakNumeral: string=?,
      ~speakPunctuation: string=?,
      ~speechRate: string=?,
      ~stress: string=?,
      ~tableLayout: string=?,
      ~textAlign: string=?,
      ~textDecoration: string=?,
      ~textIndent: string=?,
      ~textShadow: string=?,
      ~textTransform: string=?,
      ~top: string=?,
      ~unicodeBidi: string=?,
      ~verticalAlign: string=?,
      ~visibility: string=?,
      ~voiceFamily: string=?,
      ~volume: string=?,
      ~whiteSpace: string=?,
      ~widows: string=?,
      ~width: string=?,
      ~wordSpacing: string=?,
      ~zIndex: string=?,
      /* Below properties based on https://www.w3.org/Style/CSS/all-properties */
      /* Color Level 3 - REC */
      ~opacity: string=?,
      /* Backgrounds and Borders Level 3 - CR */
      /* backgroundRepeat - already defined by CSS2Properties */
      /* backgroundAttachment - already defined by CSS2Properties */
      ~backgroundOrigin: string=?,
      ~backgroundSize: string=?,
      ~backgroundClip: string=?,
      ~borderRadius: string=?,
      ~borderTopLeftRadius: string=?,
      ~borderTopRightRadius: string=?,
      ~borderBottomLeftRadius: string=?,
      ~borderBottomRightRadius: string=?,
      ~borderImage: string=?,
      ~borderImageSource: string=?,
      ~borderImageSlice: string=?,
      ~borderImageWidth: string=?,
      ~borderImageOutset: string=?,
      ~borderImageRepeat: string=?,
      ~boxShadow: string=?,
      /* Multi-column Layout - CR */
      ~columns: string=?,
      ~columnCount: string=?,
      ~columnFill: string=?,
      ~columnGap: string=?,
      ~columnRule: string=?,
      ~columnRuleColor: string=?,
      ~columnRuleStyle: string=?,
      ~columnRuleWidth: string=?,
      ~columnSpan: string=?,
      ~columnWidth: string=?,
      ~breakAfter: string=?,
      ~breakBefore: string=?,
      ~breakInside: string=?,
      /* Speech - CR */
      ~rest: string=?,
      ~restAfter: string=?,
      ~restBefore: string=?,
      ~speakAs: string=?,
      ~voiceBalance: string=?,
      ~voiceDuration: string=?,
      ~voicePitch: string=?,
      ~voiceRange: string=?,
      ~voiceRate: string=?,
      ~voiceStress: string=?,
      ~voiceVolume: string=?,
      /* Image Values and Replaced Content Level 3 - CR */
      ~objectFit: string=?,
      ~objectPosition: string=?,
      ~imageResolution: string=?,
      ~imageOrientation: string=?,
      /* Flexible Box Layout - CR */
      ~alignContent: string=?,
      ~alignItems: string=?,
      ~alignSelf: string=?,
      ~flex: string=?,
      ~flexBasis: string=?,
      ~flexDirection: string=?,
      ~flexFlow: string=?,
      ~flexGrow: string=?,
      ~flexShrink: string=?,
      ~flexWrap: string=?,
      ~justifyContent: string=?,
      ~order: string=?,
      /* Text Decoration Level 3 - CR */
      /* textDecoration - already defined by CSS2Properties */
      ~textDecorationColor: string=?,
      ~textDecorationLine: string=?,
      ~textDecorationSkip: string=?,
      ~textDecorationStyle: string=?,
      ~textEmphasis: string=?,
      ~textEmphasisColor: string=?,
      ~textEmphasisPosition: string=?,
      ~textEmphasisStyle: string=?,
      /* textShadow - already defined by CSS2Properties */
      ~textUnderlinePosition: string=?,
      /* Fonts Level 3 - CR */
      ~fontFeatureSettings: string=?,
      ~fontKerning: string=?,
      ~fontLanguageOverride: string=?,
      /* fontSizeAdjust - already defined by CSS2Properties */
      /* fontStretch - already defined by CSS2Properties */
      ~fontSynthesis: string=?,
      ~forntVariantAlternates: string=?,
      ~fontVariantCaps: string=?,
      ~fontVariantEastAsian: string=?,
      ~fontVariantLigatures: string=?,
      ~fontVariantNumeric: string=?,
      ~fontVariantPosition: string=?,
      /* Cascading and Inheritance Level 3 - CR */
      ~all: string=?,
      /* Writing Modes Level 3 - CR */
      ~glyphOrientationVertical: string=?,
      ~textCombineUpright: string=?,
      ~textOrientation: string=?,
      ~writingMode: string=?,
      /* Shapes Level 1 - CR */
      ~shapeImageThreshold: string=?,
      ~shapeMargin: string=?,
      ~shapeOutside: string=?,
      /* Masking Level 1 - CR */
      ~clipPath: string=?,
      ~clipRule: string=?,
      ~mask: string=?,
      ~maskBorder: string=?,
      ~maskBorderMode: string=?,
      ~maskBorderOutset: string=?,
      ~maskBorderRepeat: string=?,
      ~maskBorderSlice: string=?,
      ~maskBorderSource: string=?,
      ~maskBorderWidth: string=?,
      ~maskClip: string=?,
      ~maskComposite: string=?,
      ~maskImage: string=?,
      ~maskMode: string=?,
      ~maskOrigin: string=?,
      ~maskPosition: string=?,
      ~maskRepeat: string=?,
      ~maskSize: string=?,
      ~maskType: string=?,
      /* Compositing and Blending Level 1 - CR */
      ~backgroundBlendMode: string=?,
      ~isolation: string=?,
      ~mixBlendMode: string=?,
      /* Fragmentation Level 3 - CR */
      ~boxDecorationBreak: string=?,
      /* breakAfter - already defined by Multi-column Layout */
      /* breakBefore - already defined by Multi-column Layout */
      /* breakInside - already defined by Multi-column Layout */
      /* Basic User Interface Level 3 - CR */
      ~boxSizing: string=?,
      ~caretColor: string=?,
      ~navDown: string=?,
      ~navLeft: string=?,
      ~navRight: string=?,
      ~navUp: string=?,
      ~outlineOffset: string=?,
      ~resize: string=?,
      ~textOverflow: string=?,
      /* Grid Layout Level 1 - CR */
      ~grid: string=?,
      ~gridArea: string=?,
      ~gridAutoColumns: string=?,
      ~gridAutoFlow: string=?,
      ~gridAutoRows: string=?,
      ~gridColumn: string=?,
      ~gridColumnEnd: string=?,
      ~gridColumnGap: string=?,
      ~gridColumnStart: string=?,
      ~gridGap: string=?,
      ~gridRow: string=?,
      ~gridRowEnd: string=?,
      ~gridRowGap: string=?,
      ~gridRowStart: string=?,
      ~gridTemplate: string=?,
      ~gridTemplateAreas: string=?,
      ~gridTemplateColumns: string=?,
      ~gridTemplateRows: string=?,
      /* Will Change Level 1 - CR */
      ~willChange: string=?,
      /* Text Level 3 - LC */
      ~hangingPunctuation: string=?,
      ~hyphens: string=?,
      /* letterSpacing - already defined by CSS2Properties */
      ~lineBreak: string=?,
      ~overflowWrap: string=?,
      ~tabSize: string=?,
      /* textAlign - already defined by CSS2Properties */
      ~textAlignLast: string=?,
      ~textJustify: string=?,
      ~wordBreak: string=?,
      ~wordWrap: string=?,
      /* Animations - WD */
      ~animation: string=?,
      ~animationDelay: string=?,
      ~animationDirection: string=?,
      ~animationDuration: string=?,
      ~animationFillMode: string=?,
      ~animationIterationCount: string=?,
      ~animationName: string=?,
      ~animationPlayState: string=?,
      ~animationTimingFunction: string=?,
      /* Transitions - WD */
      ~transition: string=?,
      ~transitionDelay: string=?,
      ~transitionDuration: string=?,
      ~transitionProperty: string=?,
      ~transitionTimingFunction: string=?,
      /* Transforms Level 1 - WD */
      ~backfaceVisibility: string=?,
      ~perspective: string=?,
      ~perspectiveOrigin: string=?,
      ~transform: string=?,
      ~transformOrigin: string=?,
      ~transformStyle: string=?,
      /* Box Alignment Level 3 - WD */
      /* alignContent - already defined by Flexible Box Layout */
      /* alignItems - already defined by Flexible Box Layout */
      ~justifyItems: string=?,
      ~justifySelf: string=?,
      ~placeContent: string=?,
      ~placeItems: string=?,
      ~placeSelf: string=?,
      /* Basic User Interface Level 4 - FPWD */
      ~appearance: string=?,
      ~caret: string=?,
      ~caretAnimation: string=?,
      ~caretShape: string=?,
      ~userSelect: string=?,
      /* Overflow Level 3 - WD */
      ~maxLines: string=?,
      /* Basix Box Model - WD */
      ~marqueeDirection: string=?,
      ~marqueeLoop: string=?,
      ~marqueeSpeed: string=?,
      ~marqueeStyle: string=?,
      ~overflowStyle: string=?,
      ~rotation: string=?,
      ~rotationPoint: string=?,
      /* SVG 1.1 - REC */
      ~alignmentBaseline: string=?,
      ~baselineShift: string=?,
      ~clip: string=?,
      ~clipPath: string=?,
      ~clipRule: string=?,
      ~colorInterpolation: string=?,
      ~colorInterpolationFilters: string=?,
      ~colorProfile: string=?,
      ~colorRendering: string=?,
      ~cursor: string=?,
      ~dominantBaseline: string=?,
      ~fill: string=?,
      ~fillOpacity: string=?,
      ~fillRule: string=?,
      ~filter: string=?,
      ~floodColor: string=?,
      ~floodOpacity: string=?,
      ~glyphOrientationHorizontal: string=?,
      ~glyphOrientationVertical: string=?,
      ~imageRendering: string=?,
      ~kerning: string=?,
      ~lightingColor: string=?,
      ~markerEnd: string=?,
      ~markerMid: string=?,
      ~markerStart: string=?,
      ~pointerEvents: string=?,
      ~shapeRendering: string=?,
      ~stopColor: string=?,
      ~stopOpacity: string=?,
      ~stroke: string=?,
      ~strokeDasharray: string=?,
      ~strokeDashoffset: string=?,
      ~strokeLinecap: string=?,
      ~strokeLinejoin: string=?,
      ~strokeMiterlimit: string=?,
      ~strokeOpacity: string=?,
      ~strokeWidth: string=?,
      ~textAnchor: string=?,
      ~textRendering: string=?,
      /* Ruby Layout Level 1 - WD */
      ~rubyAlign: string=?,
      ~rubyMerge: string=?,
      ~rubyPosition: string=?,
      /* Lists and Counters Level 3 - WD */
      /* listStyle - already defined by CSS2Properties */
      /* listStyleImage - already defined by CSS2Properties */
      /* listStylePosition - already defined by CSS2Properties */
      /* listStyleType - already defined by CSS2Properties */
      /* counterIncrement - already defined by CSS2Properties */
      /* counterReset - already defined by CSS2Properties */
      /* Not added yet
       * -------------
       * Generated Content for Paged Media - WD
       * Generated Content Level 3 - WD
       * Line Grid Level 1 - WD
       * Regions - WD
       * Inline Layout Level 3 - WD
       * Round Display Level 1 - WD
       * Image Values and Replaced Content Level 4 - WD
       * Positioned Layout Level 3 - WD
       * Filter Effects Level 1 -  -WD
       * Exclusions Level 1 - WD
       * Text Level 4 - FPWD
       * SVG Markers - FPWD
       * Motion Path Level 1 - FPWD
       * Color Level 4 - FPWD
       * SVG Strokes - FPWD
       * Table Level 3 - FPWD
       */
      unit
    ) =>
    style =
    "";
  /* CSS2Properties: https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSS2Properties */
  let combine: (style, style) => style =
    (a, b) => {
      let a: Js.t({..}) = Obj.magic(a);
      let b: Js.t({..}) = Obj.magic(b);
      Js.Obj.assign(Js.Obj.assign(Js.Obj.empty(), a), b) |> Obj.magic;
    };
  let unsafeAddProp: (style, string, string) => style =
    (style, property, value) => {
      let propStyle: style = {
        let dict = Js.Dict.empty();
        Js.Dict.set(dict, property, value);
        Obj.magic(dict);
      };
      combine(style, propStyle);
    };
};
