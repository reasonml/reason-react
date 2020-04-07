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
  "raw-macro:<@js><@1/>+<@2/></@js><@php><@1/>.<@2/>";
external charCodeAt: (platformString, int) => int =
  "raw-macro:<@js><@1/>.charCodeAt(<@2/>)</@js><@php>PHP\\ord(<@1>[<@2/>])<@/php>";

let emptyHTML = toPlatformString("");

/**
 * Escapes platform string recursive helper so as to avoid boxing penalty.
 */
let rec escapePlatformStringLoop =
        (html, lastIndex, index, s: platformString, len) =>
  if (index === len) {
    flush_all();
    lastIndex === 0
      ? s : lastIndex !== index ? concat(html, sub(s, lastIndex, len)) : html;
  } else {
    let code = charCodeAt(s, index);
    switch (code) {
    /* '"' */
    | 34 =>
      let su = sub(s, lastIndex, index);
      let html = concat(html, su);
      let lastIndex = index + 1;
      let html = concat(html, toPlatformString("&quot;"));
      escapePlatformStringLoop(html, lastIndex, index + 1, s, len);
    /* '&' */
    | 38 =>
      let su = sub(s, lastIndex, index);
      let html = concat(html, su);
      let lastIndex = index + 1;
      let html = concat(html, toPlatformString("&amp;"));
      escapePlatformStringLoop(html, lastIndex, index + 1, s, len);
    /* "'"   modified from escape-html; used to be '&#39' */
    | 39 =>
      let su = sub(s, lastIndex, index);
      let html = concat(html, su);
      let lastIndex = index + 1;
      let html = concat(html, toPlatformString("&#x27;"));
      escapePlatformStringLoop(html, lastIndex, index + 1, s, len);
    /* '<' */
    | 60 =>
      let html = concat(html, sub(s, lastIndex, index));
      let lastIndex = index + 1;
      let html = concat(html, toPlatformString("&lt;"));
      escapePlatformStringLoop(html, lastIndex, index + 1, s, len);
    /* '>' */
    | 62 =>
      let html = concat(html, sub(s, lastIndex, index));
      let lastIndex = index + 1;
      let html = concat(html, toPlatformString("&gt;"));
      escapePlatformStringLoop(html, lastIndex, index + 1, s, len);
    | _ => escapePlatformStringLoop(html, lastIndex, index + 1, s, len)
    };
  };

/*
 * See [performance](https://jsperf.com/react-escape-vs-loop) for preliminary benchmarks.
 */
let escapeHtml = s => {
  let platformString = toPlatformString(s);
  fromPlatformString(
    escapePlatformStringLoop(
      emptyHTML,
      0,
      0,
      platformString,
      len(platformString),
    ),
  );
};
