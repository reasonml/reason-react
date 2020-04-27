'use strict';

var React = require("react");
var ReactDom = require("react-dom");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

function renderToElementWithClassName(reactElement, className) {
  var elements = document.getElementsByClassName(className);
  if (elements.length !== 0) {
    ReactDom.render(reactElement, elements[0]);
    return /* () */0;
  } else {
    console.error("ReactDOMRe.renderToElementWithClassName: no element of class " + (className + " found in the HTML."));
    return /* () */0;
  }
}

function renderToElementWithId(reactElement, id) {
  var match = document.getElementById(id);
  if (match == null) {
    console.error("ReactDOMRe.renderToElementWithId : no element of id " + (id + " found in the HTML."));
    return /* () */0;
  } else {
    ReactDom.render(reactElement, match);
    return /* () */0;
  }
}

function hydrateToElementWithClassName(reactElement, className) {
  var elements = document.getElementsByClassName(className);
  if (elements.length !== 0) {
    ReactDom.hydrate(reactElement, elements[0]);
    return /* () */0;
  } else {
    console.error("ReactDOMRe.hydrateToElementWithClassName: no element of class " + (className + " found in the HTML."));
    return /* () */0;
  }
}

function hydrateToElementWithId(reactElement, id) {
  var match = document.getElementById(id);
  if (match == null) {
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "ReactDOMRe.hydrateToElementWithId : no element of id " + (id + " found in the HTML.")
        ];
  } else {
    ReactDom.hydrate(reactElement, match);
    return /* () */0;
  }
}

var Ref = { };

function createElementVariadic(domClassName, props, children) {
  var variadicArguments = [
      domClassName,
      props
    ].concat(children);
  return React.createElement.apply(null, variadicArguments);
}

function unsafeAddProp(style, key, value) {
  var dict = { };
  dict[key] = value;
  return Object.assign(({}), style, dict);
}

var Style = {
  unsafeAddProp: unsafeAddProp
};

exports.renderToElementWithClassName = renderToElementWithClassName;
exports.renderToElementWithId = renderToElementWithId;
exports.hydrateToElementWithClassName = hydrateToElementWithClassName;
exports.hydrateToElementWithId = hydrateToElementWithId;
exports.Ref = Ref;
exports.createElementVariadic = createElementVariadic;
exports.Style = Style;
/* react Not a pure module */
