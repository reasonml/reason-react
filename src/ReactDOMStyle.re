type t;

[@bs.obj]
external make:
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
  t;

/* CSS2Properties: https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSS2Properties */
[@bs.val]
external combine: ([@bs.as {json|{}|json}] _, t, t) => t = "Object.assign";

external _dictToStyle: Js.Dict.t(string) => t = "%identity";

let unsafeAddProp = (style, key, value) => {
  let dict = Js.Dict.empty();
  Js.Dict.set(dict, key, value);
  combine(style, _dictToStyle(dict));
};

[@bs.val]
external unsafeAddStyle: ([@bs.as {json|{}|json}] _, t, Js.t({..})) => t =
  "Object.assign";
