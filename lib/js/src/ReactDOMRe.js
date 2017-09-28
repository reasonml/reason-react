'use strict';

var ReactDom                = require("react-dom");
var Caml_array              = require("bs-platform/lib/js/caml_array.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

function renderToElementWithClassName(reactElement, className) {
  var elements = document.getElementsByClassName(className);
  if (elements.length) {
    ReactDom.render(reactElement, Caml_array.caml_array_get(elements, 0));
    return /* () */0;
  } else {
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "ReactDOMRE.renderToElementWithClassName: no element of class " + (className + " found in the HTML.")
        ];
  }
}

function renderToElementWithId(reactElement, id) {
  var match = document.getElementById(id);
  if (match == null) {
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "ReactDOMRE.renderToElementWithId : no element of id " + (id + " found in the HTML.")
        ];
  } else {
    ReactDom.render(reactElement, match);
    return /* () */0;
  }
}

function combine(a, b) {
  return Object.assign(Object.assign({ }, a), b);
}

function unsafeAddProp(style, property, value) {
  var dict = { };
  dict[property] = value;
  return combine(style, dict);
}

var Style = /* module */[
  /* combine */combine,
  /* unsafeAddProp */unsafeAddProp
];

exports.renderToElementWithClassName = renderToElementWithClassName;
exports.renderToElementWithId        = renderToElementWithId;
exports.Style                        = Style;
/* react-dom Not a pure module */
