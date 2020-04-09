/**
 * Escapes special characters and HTML entities in a given html string.
 */
type platformString;
external fromPlatformString: platformString => string = "caml_js_to_string";
external toPlatformString: string => platformString = "caml_js_from_string";
external len: platformString => int =
  "raw-macro:<@js><@1/>.length</@js><@php>Str\\length(<@1/>)<@/php>";

/**
 * Takes a substring of a platform string.
 *
 * sub(platformString, startIndex, oneGreaterThanEndIndex)
 *
 * If `oneGreaterThanEndIndex` is <= `startIndex`, empty string is returned.
 *
 */
external sub: (platformString, int, int) => platformString =
  "raw-macro:<@js><@1/>.substring(<@2/>, <@3/>)</@js><@php>PHP\\substr(<@1/>, <@2/>, <@2/> > <@3/> ? 0 : <@3/>-<@2/>)</@php>";
external concat: (platformString, platformString) => platformString =
  "raw-macro:<@js><@1/>+<@2/></@js><@php><@1/>.<@2/></@php>";
external charCodeAt: (platformString, int) => int =
  "raw-macro:<@js><@1/>.charCodeAt(<@2/>)</@js><@php>PHP\\ord(<@1>[<@2/>])<@/php>";
