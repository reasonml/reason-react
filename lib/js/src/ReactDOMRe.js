'use strict';

var ReactDom = require("react-dom");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

function render(reactElement, container) {
  var element;
  if (container.tag) {
    var selector = container[0];
    var match = document.querySelector(selector);
    if (match == null) {
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "ReactDOMRe.render: no element for the selector " + (selector + " found in the HTML.")
          ];
    } else {
      element = match;
    }
  } else {
    element = container[0];
  }
  ReactDom.render(reactElement, element);
  return /* () */0;
}

function hydrate(reactElement, container) {
  var element;
  if (container.tag) {
    var selector = container[0];
    var match = document.querySelector(selector);
    if (match == null) {
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "ReactDOMRe.hydrate: no element for the selector " + (selector + " found in the HTML.")
          ];
    } else {
      element = match;
    }
  } else {
    element = container[0];
  }
  ReactDom.hydrate(reactElement, element);
  return /* () */0;
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

exports.render = render;
exports.hydrate = hydrate;
exports.Style = Style;
/* react-dom Not a pure module */
