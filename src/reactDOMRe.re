/* First time reading an OCaml/Reason/BuckleScript file? */
/* `external` is the foreign function call in OCaml. */

/* here we're saying `I guarantee that on the JS side, we have a `render` function in the module "react-dom"
   that takes in a reactElement, a dom element, and returns unit (nothing) */

/* It's like `let`, except you're pointing the implementation to the JS side. The compiler will inline these
   calls and add the appropriate `require("react-dom")` in the file calling this `render` */

external render : ReasonReact.reactElement => Dom.element => unit =
  "render" [@@bs.val] [@@bs.module "react-dom"];

external _getElementsByClassName : string => array Dom.element =
  "document.getElementsByClassName" [@@bs.val];
external _getElementById : string => option Dom.element =
  "document.getElementById" [@@bs.val] [@@bs.return null_to_opt];

let renderToElementWithClassName reactElement className => {
  let elements = _getElementsByClassName className;
  if (Array.length elements == 0) {
    raise (
      Invalid_argument (
        "ReactDOMRE.renderToElementWithClassName: no element of class " ^
        className ^ " found in the HTML."
      )
    )
  } else {
    render reactElement elements.(0)
  }
};

let renderToElementWithId reactElement id =>
  switch (_getElementById id) {
  | None =>
    raise (
      Invalid_argument (
        "ReactDOMRE.renderToElementWithId : no element of id " ^ id ^ " found in the HTML."
      )
    )
  | Some element => render reactElement element
  };

external unmountComponentAtNode : Dom.element => unit =
  "unmountComponentAtNode" [@@bs.val] [@@bs.module "react-dom"];

external findDOMNode : ReasonReact.reactRef => Dom.element =
  "findDOMNode" [@@bs.val] [@@bs.module "react-dom"];

external domElementToObj : Dom.element => Js.t {..} = "%identity";

type reactDOMProps;

external objToDOMProps : Js.t {..} => reactDOMProps = "%identity";

type style;

/* This list isn't exhaustive. We'll add more as we go. */
external props :
  key::string? =>
  ref::(Js.null Dom.element => unit)? =>

  /* react textarea/input */
  defaultChecked::Js.boolean? =>
  defaultValue::string? =>

  /* global html attributes */
  accessKey::string? =>
  className::string? => /* substitute for "class" */
  contentEditable::Js.boolean? =>
  contextMenu::string? =>
  dir::string? => /* "ltr", "rtl" or "auto" */
  draggable::Js.boolean? =>
  hidden::Js.boolean? =>
  id::string? =>
  lang::string? =>
  role::string? => /* ARIA role */
  style::style? =>
  spellCheck::Js.boolean? =>
  tabIndex::int? =>
  title::string? =>

  /* html5 microdata */
  itemID::string? =>
  itemProp::string? =>
  itemRef::string? =>
  itemScope::Js.boolean? =>
  itemType::string? => /* uri */


  /* tag-specific html attributes */
  accept::string? =>
  acceptCharset::string? =>
  action::string? => /* uri */
  allowFullScreen::Js.boolean? =>
  alt::string? =>
  async::Js.boolean? =>
  autoComplete::string? => /* has a fixed, but large-ish, set of possible values */
  autoFocus::Js.boolean? =>
  autoPlay::Js.boolean? =>
  challenge::string? =>
  charSet::string? =>
  checked::Js.boolean? =>
  cite::string? => /* uri */
  cols::int? =>
  colSpan::int? =>
  content::string? =>
  controls::Js.boolean? =>
  coords::string? => /* set of values specifying the coordinates of a region */
  data::string? => /* uri */
  dateTime::string? => /* "valid date string with optional time" */
  default::Js.boolean? =>
  defer::Js.boolean? =>
  disabled::Js.boolean? =>
  download::string? => /* should really be either a boolean, signifying presence, or a string */
  encType::string? => /* "application/x-www-form-urlencoded", "multipart/form-data" or "text/plain" */
  form::string? =>
  formAction::string? => /* uri */
  headers::string? =>
  height::string? => /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
  high::int? =>
  href::string? => /* uri */
  hrefLang::string? =>
  htmlFor::string? => /* substitute for "for" */
  httpEquiv::string? => /* has a fixed set of possible values */
  icon::string? => /* uri? */
  integrity::string? =>
  keyType::string? =>
  kind::string? => /* has a fixed set of possible values */
  label::string? =>
  list::string? =>
  low::int? =>
  manifest::string? => /* uri */
  max::string? => /* should be int or Js.Date.t */
  maxLength::int? =>
  media::string? => /* a valid media query */
  method::string? => /* "post" or "get" */
  min::int? =>
  minLength::int? =>
  multiple::Js.boolean? =>
  muted::Js.boolean? =>
  name::string? =>
  noValidate::Js.boolean? =>
  open::Js.boolean? =>
  optimum::int? =>
  pattern::string? => /* valid Js RegExp */
  placeholder::string? =>
  poster::string? => /* uri */
  preload::string? => /* "none", "metadata" or "auto" (and "" as a synonym for "auto") */
  radioGroup::string? =>
  readOnly::Js.boolean? =>
  rel::string? => /* a space- or comma-separated (depending on the element) list of a fixed set of "link types" */
  required::Js.boolean? =>
  reversed::Js.boolean? =>
  rows::int? =>
  rowSpan::int? =>
  sandbox::string? => /* has a fixed set of possible values */
  scope::string? => /* has a fixed set of possible values */
  scoped::Js.boolean? =>
  scrolling::string? => /* html4 only, "auto", "yes" or "no" */
  /* seamless - supported by React, but removed from the html5 spec */
  selected::Js.boolean? =>
  shape::string? =>
  size::int? =>
  sizes::string? =>
  span::int? =>
  src::string? => /* uri */
  srcDoc::string? =>
  srcLang::string? =>
  srcSet::string? =>
  start::int? =>
  step::float? =>
  summary::string? => /* deprecated */
  target::string? =>
  _type::string? => /* has a fixed but large-ish set of possible values */
  useMap::string? =>
  value::string? =>
  width::string? => /* in html5 this can only be a number, but in html4 it can ba a percentage as well */
  wrap::string? => /* "hard" or "soft" */

  /* Clipboard events */
  onCopy::(ReactEventRe.Clipboard.t => unit)? =>
  onCut::(ReactEventRe.Clipboard.t => unit)? =>
  onPaste::(ReactEventRe.Clipboard.t => unit)? =>

  /* Composition events */
  onCompositionEnd::(ReactEventRe.Composition.t => unit)? =>
  onCompositionStart::(ReactEventRe.Composition.t => unit)? =>
  onCompositionUpdate::(ReactEventRe.Composition.t => unit)? =>

  /* Keyboard events */
  onKeyDown::(ReactEventRe.Keyboard.t => unit)? =>
  onKeyPress::(ReactEventRe.Keyboard.t => unit)? =>
  onKeyUp::(ReactEventRe.Keyboard.t => unit)? =>

  /* Focus events */
  onFocus::(ReactEventRe.Focus.t => unit)? =>
  onBlur::(ReactEventRe.Focus.t => unit)? =>

  /* Form events */
  onChange::(ReactEventRe.Form.t => unit)? =>
  onInput::(ReactEventRe.Form.t => unit)? =>
  onSubmit::(ReactEventRe.Form.t => unit)? =>

  /* Mouse events */
  onClick::(ReactEventRe.Mouse.t => unit)? =>
  onContextMenu::(ReactEventRe.Mouse.t => unit)? =>
  onDoubleClick::(ReactEventRe.Mouse.t => unit)? =>
  onDrag::(ReactEventRe.Mouse.t => unit)? =>
  onDragEnd::(ReactEventRe.Mouse.t => unit)? =>
  onDragEnter::(ReactEventRe.Mouse.t => unit)? =>
  onDragExit::(ReactEventRe.Mouse.t => unit)? =>
  onDragLeave::(ReactEventRe.Mouse.t => unit)? =>
  onDragOver::(ReactEventRe.Mouse.t => unit)? =>
  onDragStart::(ReactEventRe.Mouse.t => unit)? =>
  onDrop::(ReactEventRe.Mouse.t => unit)? =>
  onMouseDown::(ReactEventRe.Mouse.t => unit)? =>
  onMouseEnter::(ReactEventRe.Mouse.t => unit)? =>
  onMouseLeave::(ReactEventRe.Mouse.t => unit)? =>
  onMouseMove::(ReactEventRe.Mouse.t => unit)? =>
  onMouseOut::(ReactEventRe.Mouse.t => unit)? =>
  onMouseOver::(ReactEventRe.Mouse.t => unit)? =>
  onMouseUp::(ReactEventRe.Mouse.t => unit)? =>

  /* Selection events */
  onSelect::(ReactEventRe.Selection.t => unit)? =>

  /* Touch events */
  onTouchCancel::(ReactEventRe.Touch.t => unit)? =>
  onTouchEnd::(ReactEventRe.Touch.t => unit)? =>
  onTouchMove::(ReactEventRe.Touch.t => unit)? =>
  onTouchStart::(ReactEventRe.Touch.t => unit)? =>

  /* UI events */
  onScroll::(ReactEventRe.UI.t => unit)? =>

  /* Wheel events */
  onWheel::(ReactEventRe.Wheel.t => unit)? =>

  /* Media events */
  onAbort::(ReactEventRe.Media.t => unit)? =>
  onCanPlay::(ReactEventRe.Media.t => unit)? =>
  onCanPlayThrough::(ReactEventRe.Media.t => unit)? =>
  onDurationChange::(ReactEventRe.Media.t => unit)? =>
  onEmptied::(ReactEventRe.Media.t => unit)? =>
  onEncrypetd::(ReactEventRe.Media.t => unit)? =>
  onEnded::(ReactEventRe.Media.t => unit)? =>
  onError::(ReactEventRe.Media.t => unit)? =>
  onLoadedData::(ReactEventRe.Media.t => unit)? =>
  onLoadedMetadata::(ReactEventRe.Media.t => unit)? =>
  onLoadStart::(ReactEventRe.Media.t => unit)? =>
  onPause::(ReactEventRe.Media.t => unit)? =>
  onPlay::(ReactEventRe.Media.t => unit)? =>
  onPlaying::(ReactEventRe.Media.t => unit)? =>
  onProgress::(ReactEventRe.Media.t => unit)? =>
  onRateChange::(ReactEventRe.Media.t => unit)? =>
  onSeeked::(ReactEventRe.Media.t => unit)? =>
  onSeeking::(ReactEventRe.Media.t => unit)? =>
  onStalled::(ReactEventRe.Media.t => unit)? =>
  onSuspend::(ReactEventRe.Media.t => unit)? =>
  onTimeUpdate::(ReactEventRe.Media.t => unit)? =>
  onVolumeChange::(ReactEventRe.Media.t => unit)? =>
  onWaiting::(ReactEventRe.Media.t => unit)? =>

  /* Image events */
  onLoad::(ReactEventRe.Image.t => unit)? =>
  /*onError::(ReactEventRe.Image.t => unit)? =>*/ /* duplicate */

  /* Animation events */
  onAnimationStart::(ReactEventRe.Animation.t => unit)? =>
  onAnimationEnd::(ReactEventRe.Animation.t => unit)? =>
  onAnimationIteration::(ReactEventRe.Animation.t => unit)? =>

  /* Transition events */
  onTransitionEnd::(ReactEventRe.Transition.t => unit)? =>

  /* svg */
  accentHeight::string? =>
  accumulate::string? =>
  additive::string? =>
  alignmentBaseline::string? =>
  allowReorder::string? =>
  alphabetic::string? =>
  amplitude::string? =>
  arabicForm::string? =>
  ascent::string? =>
  attributeName::string? =>
  attributeType::string? =>
  autoReverse::string? =>
  azimuth::string? =>
  baseFrequency::string? =>
  baseProfile::string? =>
  baselineShift::string? =>
  bbox::string? =>
  begin::string? =>
  bias::string? =>
  by::string? =>
  calcMode::string? =>
  capHeight::string? =>
  clip::string? =>
  clipPath::string? =>
  clipPathUnits::string? =>
  clipRule::string? =>
  colorInterpolation::string? =>
  colorInterpolationFilters::string? =>
  colorProfile::string? =>
  colorRendering::string? =>
  contentScriptType::string? =>
  contentStyleType::string? =>
  cursor::string? =>
  cx::string? =>
  cy::string? =>
  d::string? =>
  decelerate::string? =>
  descent::string? =>
  diffuseConstant::string? =>
  direction::string? =>
  display::string? =>
  divisor::string? =>
  dominantBaseline::string? =>
  dur::string? =>
  dx::string? =>
  dy::string? =>
  edgeMode::string? =>
  elevation::string? =>
  enableBackground::string? =>
  end::string? =>
  exponent::string? =>
  externalResourcesRequired::string? =>
  fill::string? =>
  fillOpacity::string? =>
  fillRule::string? =>
  filter::string? =>
  filterRes::string? =>
  filterUnits::string? =>
  floodColor::string? =>
  floodOpacity::string? =>
  focusable::string? =>
  fontFamily::string? =>
  fontSize::string? =>
  fontSizeAdjust::string? =>
  fontStretch::string? =>
  fotStyle::string? =>
  fontVariant::string? =>
  fontWeight::string? =>
  fomat::string? =>
  from::string? =>
  fx::string? =>
  fy::string? =>
  g1::string? =>
  g2::string? =>
  glyphName::string? =>
  glyphOrientationHorizontal::string? =>
  glyphOrientationVertical::string? =>
  glyphRef::string? =>
  gradientTransform::string? =>
  gradientUnits::string? =>
  hanging::string? =>
  horizAdvX::string? =>
  horizOriginX::string? =>
  ideographic::string? =>
  imageRendering::string? =>
  in::string? =>
  in2::string? =>
  intercept::string? =>
  k::string? =>
  k1::string? =>
  k2::string? =>
  k3::string? =>
  k4::string? =>
  kernelMatrix::string? =>
  kernelUnitLength::string? =>
  kerning::string? =>
  keyPoints::string? =>
  keySplines::string? =>
  keyTimes::string? =>
  lengthAdjust::string? =>
  letterSpacing::string? =>
  lightingColor::string? =>
  limitingConeAngle::string? =>
  local::string? =>
  markerEnd::string? =>
  markerHeight::string? =>
  markerMid::string? =>
  markerStart::string? =>
  markerUnits::string? =>
  markerWidth::string? =>
  mask::string? =>
  maskContentUnits::string? =>
  maskUnits::string? =>
  mathematical::string? =>
  mode::string? =>
  numOctaves::string? =>
  offset::string? =>
  opacity::string? =>
  operator::string? =>
  order::string? =>
  orient::string? =>
  orientation::string? =>
  origin::string? =>
  overflow::string? =>
  overlinePosition::string? =>
  overlineThickness::string? =>
  paintOrder::string? =>
  panose1::string? =>
  pathLength::string? =>
  patternContentUnits::string? =>
  patternTransform::string? =>
  patternUnits::string? =>
  pointerEvents::string? =>
  points::string? =>
  pointsAtX::string? =>
  pointsAtY::string? =>
  pointsAtZ::string? =>
  preserveAlpha::string? =>
  preserveAspectRatio::string? =>
  primitiveUnits::string? =>
  r::string? =>
  radius::string? =>
  refX::string? =>
  refY::string? =>
  renderingIntent::string? =>
  repeatCount::string? =>
  repeatDur::string? =>
  requiredExtensions::string? =>
  requiredFeatures::string? =>
  restart::string? =>
  result::string? =>
  rotate::string? =>
  rx::string? =>
  ry::string? =>
  scale::string? =>
  seed::string? =>
  shapeRendering::string? =>
  slope::string? =>
  spacing::string? =>
  specularConstant::string? =>
  specularExponent::string? =>
  speed::string? =>
  spreadMethod::string? =>
  startOffset::string? =>
  stdDeviation::string? =>
  stemh::string? =>
  stemv::string? =>
  stitchTiles::string? =>
  stopColor::string? =>
  stopOpacity::string? =>
  strikethroughPosition::string? =>
  strikethroughThickness::string? =>
  string::string? =>
  stroke::string? =>
  strokeDasharray::string? =>
  strokeDashoffset::string? =>
  strokeLinecap::string? =>
  strokeLinejoin::string? =>
  strokeMiterlimit::string? =>
  strokeOpacity::string? =>
  strokeWidth::string? =>
  surfaceScale::string? =>
  systemLanguage::string? =>
  tableValues::string? =>
  targetX::string? =>
  targetY::string? =>
  textAnchor::string? =>
  textDecoration::string? =>
  textLength::string? =>
  textRendering::string? =>
  _to::string? =>
  transform::string? =>
  u1::string? =>
  u2::string? =>
  underlinePosition::string? =>
  underlineThickness::string? =>
  unicode::string? =>
  unicodeBidi::string? =>
  unicodeRange::string? =>
  unitsPerEm::string? =>
  vAlphabetic::string? =>
  vHanging::string? =>
  vIdeographic::string? =>
  vMathematical::string? =>
  values::string? =>
  vectorEffect::string? =>
  version::string? =>
  vertAdvX::string? =>
  vertAdvY::string? =>
  vertOriginX::string? =>
  vertOriginY::string? =>
  viewBox::string? =>
  viewTarget::string? =>
  visibility::string? =>
  /*width::string? =>*/
  widths::string? =>
  wordSpacing::string? =>
  writingMode::string? =>
  x::string? =>
  x1::string? =>
  x2::string? =>
  xChannelSelector::string? =>
  xHeight::string? =>
  xlinkActuate::string? =>
  xlinkArcrole::string? =>
  xlinkHref::string? =>
  xlinkRole::string? =>
  xlinkShow::string? =>
  xlinkTitle::string? =>
  xlinkType::string? =>
  xmlns::string? =>
  xmlnsXlink::string? =>
  xmlBase::string? =>
  xmlLang::string? =>
  xmlSpace::string? =>
  y::string? =>
  y1::string? =>
  y2::string? =>
  yChannelSelector::string? =>
  z::string? =>
  zoomAndPan::string? =>

  /* RDFa */
  about::string? =>
  datatype::string? =>
  inlist::string? =>
  prefix::string? =>
  property::string? =>
  resource::string? =>
  typeof::string? =>
  vocab::string? =>

  /* react-specific */
  dangerouslySetInnerHTML::Js.t {. __html: string }? =>
  suppressContentEditableWarning::Js.boolean? =>

  unit =>
  reactDOMProps =
  "" [@@bs.obj];

external createElement :
  string => props::reactDOMProps? => array ReasonReact.reactElement => ReasonReact.reactElement =
  "createElement" [@@bs.splice] [@@bs.val] [@@bs.module "react"];

module Style = {
  type t = style;

  external make :

    /* CSS2Properties: https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSS2Properties */
    azimuth::string? =>
    background::string? =>
    backgroundAttachment::string? =>
    backgroundColor::string? =>
    backgroundImage::string? =>
    backgroundPosition::string? =>
    backgroundRepeat::string? =>
    border::string? =>
    borderCollapse::string? =>
    borderColor::string? =>
    borderSpacing::string? =>
    borderStyle::string? =>
    borderTop::string? =>
    borderRight::string? =>
    borderBottom::string? =>
    borderLeft::string? =>
    borderTopColor::string? =>
    borderRightColor::string? =>
    borderBottomColor::string? =>
    borderLeftColor::string? =>
    borderTopStyle::string? =>
    borderRightStyle::string? =>
    borderBottomStyle::string? =>
    borderLeftStyle::string? =>
    borderTopWidth::string? =>
    borderRightWidth::string? =>
    borderBottomWidth::string? =>
    borderLeftWidth::string? =>
    borderWidth::string? =>
    bottom::string? =>
    captionSide::string? =>
    clear::string? =>
    clip::string? =>
    color::string? =>
    content::string? =>
    counterIncrement::string? =>
    counterReset::string? =>
    cue::string? =>
    cueAfter::string? =>
    cueBefore::string? =>
    cursor::string? =>
    direction::string? =>
    display::string? =>
    elevation::string? =>
    emptyCells::string? =>
    float::string? =>
    font::string? =>
    fontFamily::string? =>
    fontSize::string? =>
    fontSizeAdjust::string? =>
    fontStretch::string? =>
    fontStyle::string? =>
    fontVariant::string? =>
    fontWeight::string? =>
    height::string? =>
    left::string? =>
    letterSpacing::string? =>
    lineHeight::string? =>
    listStyle::string? =>
    listStyleImage::string? =>
    listStylePosition::string? =>
    listStyleType::string? =>
    margin::string? =>
    marginTop::string? =>
    marginRight::string? =>
    marginBottom::string? =>
    marginLeft::string? =>
    markerOffset::string? =>
    marks::string? =>
    maxHeight::string? =>
    maxWidth::string? =>
    minHeight::string? =>
    minWidth::string? =>
    orphans::string? =>
    outline::string? =>
    outlineColor::string? =>
    outlineStyle::string? =>
    outlineWidth::string? =>
    overflow::string? =>
    padding::string? =>
    paddingTop::string? =>
    paddingRight::string? =>
    paddingBottom::string? =>
    paddingLeft::string? =>
    page::string? =>
    pageBreakAfter::string? =>
    pageBreakBefore::string? =>
    pageBreakInside::string? =>
    pause::string? =>
    pauseAfter::string? =>
    pauseBefore::string? =>
    pitch::string? =>
    pitchRange::string? =>
    playDuring::string? =>
    position::string? =>
    quotes::string? =>
    richness::string? =>
    right::string? =>
    size::string? =>
    speak::string? =>
    speakHeader::string? =>
    speakNumeral::string? =>
    speakPunctuation::string? =>
    speechRate::string? =>
    stress::string? =>
    tableLayout::string? =>
    textAlign::string? =>
    textDecoration::string? =>
    textIndent::string? =>
    textShadow::string? =>
    textTransform::string? =>
    top::string? =>
    unicodeBidi::string? =>
    verticalAlign::string? =>
    visibility::string? =>
    voiceFamily::string? =>
    volume::string? =>
    whiteSpace::string? =>
    widows::string? =>
    width::string? =>
    wordSpacing::string? =>
    zIndex::string? =>

    /* Below properties based on https://www.w3.org/Style/CSS/all-properties */

    /* Color Level 3 - REC */
    opacity::string? =>

    /* Backgrounds and Borders Level 3 - CR */
    /* backgroundRepeat - already defined by CSS2Properties */
    /* backgroundAttachment - already defined by CSS2Properties */
    backgroundOrigin::string? =>
    backgroundSize::string? =>
    backgroundClip::string? =>
    borderRadius::string? =>
    borderTopLeftRadius::string? =>
    borderTopRightRadius::string? =>
    borderBottomLeftRadius::string? =>
    borderBottomRightRadius::string? =>
    borderImage::string? =>
    borderImageSource::string? =>
    borderImageSlice::string? =>
    borderImageWidth::string? =>
    borderImageOutset::string? =>
    borderImageRepeat::string? =>
    boxShadow::string? =>

    /* Multi-column Layout - CR */
    columns::string? =>
    columnCount::string? =>
    columnFill::string? =>
    columnGap::string? =>
    columnRule::string? =>
    columnRuleColor::string? =>
    columnRuleStyle::string? =>
    columnRuleWidth::string? =>
    columnSpan::string? =>
    columnWidth::string? =>
    breakAfter::string? =>
    breakBefore::string? =>
    breakInside::string? =>

    /* Speech - CR */
    rest::string? =>
    restAfter::string? =>
    restBefore::string? =>
    speakAs::string? =>
    voiceBalance::string? =>
    voiceDuration::string? =>
    voicePitch::string? =>
    voiceRange::string? =>
    voiceRate::string? =>
    voiceStress::string? =>
    voiceVolume::string? =>

    /* Image Values and Replaced Content Level 3 - CR */
    objectFit::string? =>
    objectPosition::string? =>
    imageResolution::string? =>
    imageOrientation::string? =>

    /* Flexible Box Layout - CR */
    alignContent::string? =>
    alignItems::string? =>
    alignSelf::string? =>
    flex::string? =>
    flexBasis::string? =>
    flexDirection::string? =>
    flexFlow::string? =>
    flexGrow::string? =>
    flexShrink::string? =>
    flexWrap::string? =>
    justifyContent::string? =>
    order::string? =>

    /* Text Decoration Level 3 - CR */
    /* textDecoration - already defined by CSS2Properties */
    textDecorationColor::string? =>
    textDecorationLine::string? =>
    textDecorationSkip::string? =>
    textDecorationStyle::string? =>
    textEmphasis::string? =>
    textEmphasisColor::string? =>
    textEmphasisPosition::string? =>
    textEmphasisStyle::string? =>
    /* textShadow - already defined by CSS2Properties */
    textUnderlinePosition::string? =>

    /* Fonts Level 3 - CR */
    fontFeatureSettings::string? =>
    fontKerning::string? =>
    fontLanguageOverride::string? =>
    /* fontSizeAdjust - already defined by CSS2Properties */
    /* fontStretch - already defined by CSS2Properties */
    fontSynthesis::string? =>
    forntVariantAlternates::string? =>
    fontVariantCaps::string? =>
    fontVariantEastAsian::string? =>
    fontVariantLigatures::string? =>
    fontVariantNumeric::string? =>
    fontVariantPosition::string? =>

    /* Cascading and Inheritance Level 3 - CR */
    all::string? =>

    /* Writing Modes Level 3 - CR */
    glyphOrientationVertical::string? =>
    textCombineUpright::string? =>
    textOrientation::string? =>
    writingMode::string? =>

    /* Shapes Level 1 - CR */
    shapeImageThreshold::string? =>
    shapeMargin::string? =>
    shapeOutside::string? =>

    /* Masking Level 1 - CR */
    clipPath::string? =>
    clipRule::string? =>
    mask::string? =>
    maskBorder::string? =>
    maskBorderMode::string? =>
    maskBorderOutset::string? =>
    maskBorderRepeat::string? =>
    maskBorderSlice::string? =>
    maskBorderSource::string? =>
    maskBorderWidth::string? =>
    maskClip::string? =>
    maskComposite::string? =>
    maskImage::string? =>
    maskMode::string? =>
    maskOrigin::string? =>
    maskPosition::string? =>
    maskRepeat::string? =>
    maskSize::string? =>
    maskType::string? =>

    /* Compositing and Blending Level 1 - CR */
    backgroundBlendMode::string? =>
    isolation::string? =>
    mixBlendMode::string? =>

    /* Fragmentation Level 3 - CR */
    boxDecorationBreak::string? =>
    /* breakAfter - already defined by Multi-column Layout */
    /* breakBefore - already defined by Multi-column Layout */
    /* breakInside - already defined by Multi-column Layout */

    /* Basic User Interface Level 3 - CR */
    boxSizing::string? =>
    caretColor::string? =>
    navDown::string? =>
    navLeft::string? =>
    navRight::string? =>
    navUp::string? =>
    outlineOffset::string? =>
    resize::string? =>
    textOverflow::string? =>

    /* Grid Layout Level 1 - CR */
    grid::string? =>
    gridArea::string? =>
    gridAutoColumns::string? =>
    gridAutoFlow::string? =>
    gridAutoRows::string? =>
    gridColumn::string? =>
    gridColumnEnd::string? =>
    gridColumnGap::string? =>
    gridColumnStart::string? =>
    gridGap::string? =>
    gridRow::string? =>
    gridRowEnd::string? =>
    gridRowGap::string? =>
    gridRowStart::string? =>
    gridTemplate::string? =>
    gridTempalteAreas::string? =>
    gridTemplateColumns::string? =>
    gridTemplateRows::string? =>

    /* Will Change Level 1 - CR */
    willChange::string? =>

    /* Text Level 3 - LC */
    hangingPunctuation::string? =>
    hyphens::string? =>
    /* letterSpacing - already defined by CSS2Properties */
    lineBreak::string? =>
    overflowWrap::string? =>
    tabSize::string? =>
    /* textAlign - already defined by CSS2Properties */
    textAlignLast::string? =>
    textJustify::string? =>
    wordBreak::string? =>
    wordWrap::string? =>

    /* Animations - WD */
    animation::string? =>
    animationDelay::string? =>
    animationDirection::string? =>
    animationDuration::string? =>
    animationFillMode::string? =>
    animationIterationCount::string? =>
    animationName::string? =>
    animationPlayState::string? =>
    animationTimingFunction::string? =>

    /* Transitions - WD */
    transition::string? =>
    transitionDelay::string? =>
    transitionDuration::string? =>
    transitionProperty::string? =>
    transitionTimingFunction::string? =>

    /* Transforms Level 1 - WD */
    backfaceVisibility::string? =>
    perspective::string? =>
    perspectiveOrigin::string? =>
    transform::string? =>
    transformOrigin::string? =>
    transformStyle::string? =>

    /* Box Alignment Level 3 - WD */
    /* alignContent - already defined by Flexible Box Layout */
    /* alignItems - already defined by Flexible Box Layout */
    justifyItems::string? =>
    justifySelf::string? =>
    placeContent::string? =>
    placeItems::string? =>
    placeSelf::string? =>

    /* Basic User Interface Level 4 - FPWD */
    appearance::string? =>
    caret::string? =>
    caretAnimation::string? =>
    caretShape::string? =>
    userSelect::string? =>

    /* Overflow Level 3 - WD */
    maxLines::string? =>

    /* Basix Box Model - WD */
    marqueeDirection::string? =>
    marqueeLoop::string? =>
    marqueeSpeed::string? =>
    marqueeStyle::string? =>
    overflowStyle::string? =>
    rotation::string? =>
    rotationPoint::string? =>

    /* SVG 1.1 - REC */
    alignmentBaseline::string? =>
    baselineShift::string? =>
    clip::string? =>
    clipPath::string? =>
    clipRule::string? =>
    colorInterpolation::string? =>
    colorInterpolationFilters::string? =>
    colorProfile::string? =>
    colorRendering::string? =>
    cursor::string? =>
    dominantBaseline::string? =>
    fill::string? =>
    fillOpacity::string? =>
    fillRule::string? =>
    filter::string? =>
    floodColor::string? =>
    floodOpacity::string? =>
    glyphOrientationHorizontal::string? =>
    glyphOrientationVertical::string? =>
    imageRendering::string? =>
    kerning::string? =>
    lightingColor::string? =>
    markerEnd::string? =>
    markerMid::string? =>
    markerStart::string? =>
    pointerEvents::string? =>
    shapeRendering::string? =>
    stopColor::string? =>
    stopOpacity::string? =>
    stroke::string? =>
    strokeDasharray::string? =>
    strokeDashoffset::string? =>
    strokeLinecap::string? =>
    strokeLinejoin::string? =>
    strokeMiterlimit::string? =>
    strokeOpacity::string? =>
    strokeWidth::string? =>
    textAnchor::string? =>
    textRendering::string? =>

    /* Ruby Layout Level 1 - WD */
    rubyAlign::string? =>
    rubyMerge::string? =>
    rubyPosition::string? =>

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

    unit =>
    style = "" [@@bs.obj];

    let combine: style => style => style =
      fun a b => {
        let a: Js.t {..} = Obj.magic a;
        let b: Js.t {..} = Obj.magic b;
        Js.Obj.assign (Js.Obj.assign (Js.Obj.empty ()) a) b |> Obj.magic
      };

    let unsafeAddProp: style => string => string => style =
      fun style property value => {
        let propStyle: style = {
          let dict = Js.Dict.empty ();
          Js.Dict.set dict property value;
          Obj.magic dict
        };
        combine style propStyle
      };
}
