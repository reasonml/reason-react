'use strict';

var React = require("react");
var ReactDom = require("react-dom");

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
    console.error("ReactDOMRe.hydrateToElementWithId : no element of id " + (id + " found in the HTML."));
    return /* () */0;
  } else {
    ReactDom.hydrate(reactElement, match);
    return /* () */0;
  }
}

var Ref = /* module */[];

function createElementVariadic(domClassName, props, children) {
  var variadicArguments = /* array */[
      domClassName,
      props
    ].concat(children);
  return React.createElement.apply(null, variadicArguments);
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
exports.renderToElementWithId = renderToElementWithId;
exports.hydrateToElementWithClassName = hydrateToElementWithClassName;
exports.hydrateToElementWithId = hydrateToElementWithId;
exports.Ref = Ref;
exports.createElementVariadic = createElementVariadic;
exports.Style = Style;
/* react Not a pure module */
