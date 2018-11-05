'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Js_primitive = require("bs-platform/lib/js/js_primitive.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");
var ReasonReactOptimizedCreateClass = require("./ReasonReactOptimizedCreateClass.js");

function createDomElement(s, props, children) {
  var vararg = /* array */[
      s,
      props
    ].concat(children);
  return React.createElement.apply(null, vararg);
}

function anyToUnit() {
  return /* () */0;
}

function anyToTrue() {
  return true;
}

function willReceivePropsDefault(param) {
  return param[/* state */1];
}

function renderDefault() {
  return "RenderNotImplemented";
}

function initialStateDefault() {
  return /* () */0;
}

function reducerDefault(_, _$1) {
  return /* NoUpdate */0;
}

function convertPropsIfTheyreFromJs(props, jsPropsToReason, debugName) {
  var match = props.reasonProps;
  if (match == null) {
    if (jsPropsToReason !== undefined) {
      return /* Element */[Js_primitive.valFromOption(jsPropsToReason)(props)];
    } else {
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "A JS component called the Reason component " + (debugName + " which didn't implement the JS->Reason React props conversion.")
          ];
    }
  } else {
    return match;
  }
}

function createClass(debugName) {
  return ReasonReactOptimizedCreateClass.createClass({
              displayName: debugName,
              subscriptions: null,
              self: (function (state, retainedProps) {
                  var $$this = this ;
                  return /* record */[
                          /* handle */$$this.handleMethod,
                          /* state */state,
                          /* retainedProps */retainedProps,
                          /* send */$$this.sendMethod,
                          /* onUnmount */$$this.onUnmountMethod
                        ];
                }),
              getInitialState: (function () {
                  var thisJs = (this);
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  return {
                          reasonState: Curry._1(convertedReasonProps[0][/* initialState */10], /* () */0)
                        };
                }),
              componentDidMount: (function () {
                  var $$this = this ;
                  var thisJs = (this);
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var component = convertedReasonProps[0];
                  var curTotalState = thisJs.state;
                  var curReasonState = curTotalState.reasonState;
                  var self = $$this.self(curReasonState, component[/* retainedProps */11]);
                  if (component[/* didMount */4] !== anyToUnit) {
                    return Curry._1(component[/* didMount */4], self);
                  } else {
                    return 0;
                  }
                }),
              componentDidUpdate: (function (prevProps, prevState) {
                  var $$this = this ;
                  var thisJs = (this);
                  var curState = thisJs.state;
                  var curReasonState = curState.reasonState;
                  var newJsProps = thisJs.props;
                  var newConvertedReasonProps = convertPropsIfTheyreFromJs(newJsProps, thisJs.jsPropsToReason, debugName);
                  var newComponent = newConvertedReasonProps[0];
                  if (newComponent[/* didUpdate */5] !== anyToUnit) {
                    var match = prevProps === newJsProps;
                    var oldConvertedReasonProps = match ? newConvertedReasonProps : convertPropsIfTheyreFromJs(prevProps, thisJs.jsPropsToReason, debugName);
                    var prevReasonState = prevState.reasonState;
                    var newSelf = $$this.self(curReasonState, newComponent[/* retainedProps */11]);
                    var oldSelf_000 = /* handle */newSelf[/* handle */0];
                    var oldSelf_002 = /* retainedProps */oldConvertedReasonProps[0][/* retainedProps */11];
                    var oldSelf_003 = /* send */newSelf[/* send */3];
                    var oldSelf_004 = /* onUnmount */newSelf[/* onUnmount */4];
                    var oldSelf = /* record */[
                      oldSelf_000,
                      /* state */prevReasonState,
                      oldSelf_002,
                      oldSelf_003,
                      oldSelf_004
                    ];
                    return Curry._1(newComponent[/* didUpdate */5], /* record */[
                                /* oldSelf */oldSelf,
                                /* newSelf */newSelf
                              ]);
                  } else {
                    return 0;
                  }
                }),
              componentWillUnmount: (function () {
                  var $$this = this ;
                  var thisJs = (this);
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var component = convertedReasonProps[0];
                  var curState = thisJs.state;
                  var curReasonState = curState.reasonState;
                  if (component[/* willUnmount */6] !== anyToUnit) {
                    Curry._1(component[/* willUnmount */6], $$this.self(curReasonState, component[/* retainedProps */11]));
                  }
                  var match = $$this.subscriptions;
                  if (match !== null) {
                    match.forEach((function (unsubscribe) {
                            return Curry._1(unsubscribe, /* () */0);
                          }));
                    return /* () */0;
                  } else {
                    return /* () */0;
                  }
                }),
              componentWillUpdate: (function (nextProps, nextState) {
                  var $$this = this ;
                  var thisJs = (this);
                  var newConvertedReasonProps = convertPropsIfTheyreFromJs(nextProps, thisJs.jsPropsToReason, debugName);
                  var newComponent = newConvertedReasonProps[0];
                  if (newComponent[/* willUpdate */7] !== anyToUnit) {
                    var oldJsProps = thisJs.props;
                    var match = nextProps === oldJsProps;
                    var oldConvertedReasonProps = match ? newConvertedReasonProps : convertPropsIfTheyreFromJs(oldJsProps, thisJs.jsPropsToReason, debugName);
                    var curState = thisJs.state;
                    var curReasonState = curState.reasonState;
                    var nextReasonState = nextState.reasonState;
                    var newSelf = $$this.self(nextReasonState, newComponent[/* retainedProps */11]);
                    var oldSelf_000 = /* handle */newSelf[/* handle */0];
                    var oldSelf_002 = /* retainedProps */oldConvertedReasonProps[0][/* retainedProps */11];
                    var oldSelf_003 = /* send */newSelf[/* send */3];
                    var oldSelf_004 = /* onUnmount */newSelf[/* onUnmount */4];
                    var oldSelf = /* record */[
                      oldSelf_000,
                      /* state */curReasonState,
                      oldSelf_002,
                      oldSelf_003,
                      oldSelf_004
                    ];
                    return Curry._1(newComponent[/* willUpdate */7], /* record */[
                                /* oldSelf */oldSelf,
                                /* newSelf */newSelf
                              ]);
                  } else {
                    return 0;
                  }
                }),
              componentWillReceiveProps: (function (nextProps) {
                  var $$this = this ;
                  var thisJs = (this);
                  var newConvertedReasonProps = convertPropsIfTheyreFromJs(nextProps, thisJs.jsPropsToReason, debugName);
                  var newComponent = newConvertedReasonProps[0];
                  if (newComponent[/* willReceiveProps */3] !== willReceivePropsDefault) {
                    var oldJsProps = thisJs.props;
                    var match = nextProps === oldJsProps;
                    var oldConvertedReasonProps = match ? newConvertedReasonProps : convertPropsIfTheyreFromJs(oldJsProps, thisJs.jsPropsToReason, debugName);
                    var oldComponent = oldConvertedReasonProps[0];
                    return thisJs.setState((function (curTotalState, _) {
                                  var curReasonState = curTotalState.reasonState;
                                  var oldSelf = $$this.self(curReasonState, oldComponent[/* retainedProps */11]);
                                  var nextReasonState = Curry._1(newComponent[/* willReceiveProps */3], oldSelf);
                                  if (nextReasonState !== curTotalState) {
                                    return {
                                            reasonState: nextReasonState
                                          };
                                  } else {
                                    return curTotalState;
                                  }
                                }), null);
                  } else {
                    return 0;
                  }
                }),
              shouldComponentUpdate: (function (nextJsProps, nextState, _) {
                  var $$this = this ;
                  var thisJs = (this);
                  var curJsProps = thisJs.props;
                  var oldConvertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var match = nextJsProps === curJsProps;
                  var newConvertedReasonProps = match ? oldConvertedReasonProps : convertPropsIfTheyreFromJs(nextJsProps, thisJs.jsPropsToReason, debugName);
                  var newComponent = newConvertedReasonProps[0];
                  var nextReasonState = nextState.reasonState;
                  var newSelf = $$this.self(nextReasonState, newComponent[/* retainedProps */11]);
                  if (newComponent[/* shouldUpdate */8] !== anyToTrue) {
                    var curState = thisJs.state;
                    var curReasonState = curState.reasonState;
                    var oldSelf_000 = /* handle */newSelf[/* handle */0];
                    var oldSelf_002 = /* retainedProps */oldConvertedReasonProps[0][/* retainedProps */11];
                    var oldSelf_003 = /* send */newSelf[/* send */3];
                    var oldSelf_004 = /* onUnmount */newSelf[/* onUnmount */4];
                    var oldSelf = /* record */[
                      oldSelf_000,
                      /* state */curReasonState,
                      oldSelf_002,
                      oldSelf_003,
                      oldSelf_004
                    ];
                    return Curry._1(newComponent[/* shouldUpdate */8], /* record */[
                                /* oldSelf */oldSelf,
                                /* newSelf */newSelf
                              ]);
                  } else {
                    return true;
                  }
                }),
              onUnmountMethod: (function (subscription) {
                  var $$this = this ;
                  var match = $$this.subscriptions;
                  if (match !== null) {
                    match.push(subscription);
                    return /* () */0;
                  } else {
                    $$this.subscriptions = /* array */[subscription];
                    return /* () */0;
                  }
                }),
              handleMethod: (function (callback) {
                  var $$this = this ;
                  var thisJs = (this);
                  return (function (callbackPayload) {
                      var curState = thisJs.state;
                      var curReasonState = curState.reasonState;
                      var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                      return Curry._2(callback, callbackPayload, $$this.self(curReasonState, convertedReasonProps[0][/* retainedProps */11]));
                    });
                }),
              sendMethod: (function (action) {
                  var $$this = this ;
                  var thisJs = (this);
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var component = convertedReasonProps[0];
                  if (component[/* reducer */12] !== reducerDefault) {
                    var sideEffects = /* record */[/* contents */(function () {
                          return /* () */0;
                        })];
                    var partialStateApplication = Curry._1(component[/* reducer */12], action);
                    return thisJs.setState((function (curTotalState, _) {
                                  var curReasonState = curTotalState.reasonState;
                                  var reasonStateUpdate = Curry._1(partialStateApplication, curReasonState);
                                  if (reasonStateUpdate === /* NoUpdate */0) {
                                    return null;
                                  } else {
                                    var nextTotalState;
                                    if (typeof reasonStateUpdate === "number") {
                                      nextTotalState = curTotalState;
                                    } else {
                                      switch (reasonStateUpdate.tag | 0) {
                                        case 0 : 
                                            nextTotalState = {
                                              reasonState: reasonStateUpdate[0]
                                            };
                                            break;
                                        case 1 : 
                                            sideEffects[/* contents */0] = reasonStateUpdate[0];
                                            nextTotalState = curTotalState;
                                            break;
                                        case 2 : 
                                            sideEffects[/* contents */0] = reasonStateUpdate[1];
                                            nextTotalState = {
                                              reasonState: reasonStateUpdate[0]
                                            };
                                            break;
                                        
                                      }
                                    }
                                    if (nextTotalState !== curTotalState) {
                                      return nextTotalState;
                                    } else {
                                      return null;
                                    }
                                  }
                                }), $$this.handleMethod((function (_, self) {
                                      return Curry._1(sideEffects[/* contents */0], self);
                                    })));
                  } else {
                    return 0;
                  }
                }),
              render: (function () {
                  var $$this = this ;
                  var thisJs = (this);
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var created = convertedReasonProps[0];
                  var curState = thisJs.state;
                  var curReasonState = curState.reasonState;
                  return Curry._1(created[/* render */9], $$this.self(curReasonState, created[/* retainedProps */11]));
                })
            });
}

function basicComponent(debugName) {
  return /* record */[
          /* debugName */debugName,
          /* reactClassInternal */createClass(debugName),
          /* handedOffState : record */[/* contents */undefined],
          /* willReceiveProps */willReceivePropsDefault,
          /* didMount */anyToUnit,
          /* didUpdate */anyToUnit,
          /* willUnmount */anyToUnit,
          /* willUpdate */anyToUnit,
          /* shouldUpdate */anyToTrue,
          /* render */renderDefault,
          /* initialState */initialStateDefault,
          /* retainedProps : () */0,
          /* reducer */reducerDefault,
          /* jsElementWrapped */undefined
        ];
}

var statelessComponent = basicComponent;

var statelessComponentWithRetainedProps = basicComponent;

var reducerComponent = basicComponent;

var reducerComponentWithRetainedProps = basicComponent;

function element($staropt$star, $staropt$star$1, component) {
  var key = $staropt$star !== undefined ? $staropt$star : undefined;
  var ref = $staropt$star$1 !== undefined ? $staropt$star$1 : undefined;
  var element$1 = /* Element */[component];
  var match = component[/* jsElementWrapped */13];
  if (match !== undefined) {
    return Curry._2(match, key, ref);
  } else {
    return React.createElement(component[/* reactClassInternal */1], {
                key: key,
                ref: ref,
                reasonProps: element$1
              });
  }
}

function wrapReasonForJs(component, jsPropsToReason) {
  var uncurriedJsPropsToReason = Curry.__1(jsPropsToReason);
  var tmp = component[/* reactClassInternal */1].prototype;
  tmp.jsPropsToReason = Js_primitive.some(uncurriedJsPropsToReason);
  return component[/* reactClassInternal */1];
}

var dummyInteropComponent = basicComponent("interop");

function wrapJsForReason(reactClass, props, children) {
  var jsElementWrapped = (function (param, param$1) {
      var reactClass$1 = reactClass;
      var props$1 = props;
      var children$1 = children;
      var key = param;
      var ref = param$1;
      var props$2 = Object.assign(Object.assign({ }, props$1), {
            ref: ref,
            key: key
          });
      var varargs = /* array */[
          reactClass$1,
          props$2
        ].concat(children$1);
      return React.createElement.apply(null, varargs);
    });
  return /* record */[
          /* debugName */dummyInteropComponent[/* debugName */0],
          /* reactClassInternal */dummyInteropComponent[/* reactClassInternal */1],
          /* handedOffState */dummyInteropComponent[/* handedOffState */2],
          /* willReceiveProps */dummyInteropComponent[/* willReceiveProps */3],
          /* didMount */dummyInteropComponent[/* didMount */4],
          /* didUpdate */dummyInteropComponent[/* didUpdate */5],
          /* willUnmount */dummyInteropComponent[/* willUnmount */6],
          /* willUpdate */dummyInteropComponent[/* willUpdate */7],
          /* shouldUpdate */dummyInteropComponent[/* shouldUpdate */8],
          /* render */dummyInteropComponent[/* render */9],
          /* initialState */dummyInteropComponent[/* initialState */10],
          /* retainedProps */dummyInteropComponent[/* retainedProps */11],
          /* reducer */dummyInteropComponent[/* reducer */12],
          /* jsElementWrapped */jsElementWrapped
        ];
}

function safeMakeEvent(eventName) {
  if (typeof Event === "function") {
    return new Event(eventName);
  } else {
    var $$event = document.createEvent("Event");
    $$event.initEvent(eventName, true, true);
    return $$event;
  }
}

function path() {
  var match = typeof (window) === "undefined" ? undefined : (window);
  if (match !== undefined) {
    var raw = match.location.pathname;
    switch (raw) {
      case "" : 
      case "/" : 
          return /* [] */0;
      default:
        var raw$1 = raw.slice(1);
        var match$1 = raw$1[raw$1.length - 1 | 0];
        var raw$2 = match$1 === "/" ? raw$1.slice(0, -1) : raw$1;
        var a = raw$2.split("/");
        var _i = a.length - 1 | 0;
        var _res = /* [] */0;
        while(true) {
          var res = _res;
          var i = _i;
          if (i < 0) {
            return res;
          } else {
            _res = /* :: */[
              a[i],
              res
            ];
            _i = i - 1 | 0;
            continue ;
          }
        };
    }
  } else {
    return /* [] */0;
  }
}

function hash() {
  var match = typeof (window) === "undefined" ? undefined : (window);
  if (match !== undefined) {
    var raw = match.location.hash;
    switch (raw) {
      case "" : 
      case "#" : 
          return "";
      default:
        return raw.slice(1);
    }
  } else {
    return "";
  }
}

function search() {
  var match = typeof (window) === "undefined" ? undefined : (window);
  if (match !== undefined) {
    var raw = match.location.search;
    switch (raw) {
      case "" : 
      case "?" : 
          return "";
      default:
        return raw.slice(1);
    }
  } else {
    return "";
  }
}

function push(path) {
  var match = typeof (history) === "undefined" ? undefined : (history);
  var match$1 = typeof (window) === "undefined" ? undefined : (window);
  if (match !== undefined && match$1 !== undefined) {
    match.pushState(null, "", path);
    match$1.dispatchEvent(safeMakeEvent("popstate"));
    return /* () */0;
  } else {
    return /* () */0;
  }
}

function url() {
  return /* record */[
          /* path */path(/* () */0),
          /* hash */hash(/* () */0),
          /* search */search(/* () */0)
        ];
}

function watchUrl(callback) {
  var match = typeof (window) === "undefined" ? undefined : (window);
  if (match !== undefined) {
    var watcherID = function () {
      return Curry._1(callback, url(/* () */0));
    };
    match.addEventListener("popstate", watcherID);
    return watcherID;
  } else {
    return (function () {
        return /* () */0;
      });
  }
}

function unwatchUrl(watcherID) {
  var match = typeof (window) === "undefined" ? undefined : (window);
  if (match !== undefined) {
    match.removeEventListener("popstate", watcherID);
    return /* () */0;
  } else {
    return /* () */0;
  }
}

var Router = [
  push,
  watchUrl,
  unwatchUrl,
  url
];

exports.statelessComponent = statelessComponent;
exports.statelessComponentWithRetainedProps = statelessComponentWithRetainedProps;
exports.reducerComponent = reducerComponent;
exports.reducerComponentWithRetainedProps = reducerComponentWithRetainedProps;
exports.element = element;
exports.wrapReasonForJs = wrapReasonForJs;
exports.createDomElement = createDomElement;
exports.wrapJsForReason = wrapJsForReason;
exports.Router = Router;
/* dummyInteropComponent Not a pure module */
