'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Caml_option = require("bs-platform/lib/js/caml_option.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");
var ReasonReactOptimizedCreateClass = require("./ReasonReactOptimizedCreateClass.js");

function createDomElement(s, props, children) {
  var vararg = [
      s,
      props
    ].concat(children);
  return React.createElement.apply(null, vararg);
}

function anyToUnit(param) {
  return /* () */0;
}

function anyToTrue(param) {
  return true;
}

function willReceivePropsDefault(param) {
  return param.state;
}

function renderDefault(_self) {
  return "RenderNotImplemented";
}

function initialStateDefault(param) {
  return /* () */0;
}

function reducerDefault(_action, _state) {
  return /* NoUpdate */0;
}

function convertPropsIfTheyreFromJs(props, jsPropsToReason, debugName) {
  var match = props.reasonProps;
  if (match == null) {
    if (jsPropsToReason !== undefined) {
      return /* Element */[Caml_option.valFromOption(jsPropsToReason)(props)];
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
                  return {
                          handle: $$this.handleMethod,
                          state: state,
                          retainedProps: retainedProps,
                          send: $$this.sendMethod,
                          onUnmount: $$this.onUnmountMethod
                        };
                }),
              getInitialState: (function () {
                  var thisJs = this;
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  return {
                          reasonState: Curry._1(convertedReasonProps[0].initialState, /* () */0)
                        };
                }),
              componentDidMount: (function () {
                  var $$this = this ;
                  var thisJs = this;
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var component = convertedReasonProps[0];
                  var curTotalState = thisJs.state;
                  var curReasonState = curTotalState.reasonState;
                  var self = $$this.self(curReasonState, component.retainedProps);
                  if (component.didMount !== anyToUnit) {
                    return Curry._1(component.didMount, self);
                  } else {
                    return 0;
                  }
                }),
              componentDidUpdate: (function (prevProps, prevState) {
                  var $$this = this ;
                  var thisJs = this;
                  var curState = thisJs.state;
                  var curReasonState = curState.reasonState;
                  var newJsProps = thisJs.props;
                  var newConvertedReasonProps = convertPropsIfTheyreFromJs(newJsProps, thisJs.jsPropsToReason, debugName);
                  var newComponent = newConvertedReasonProps[0];
                  if (newComponent.didUpdate !== anyToUnit) {
                    var oldConvertedReasonProps = prevProps === newJsProps ? newConvertedReasonProps : convertPropsIfTheyreFromJs(prevProps, thisJs.jsPropsToReason, debugName);
                    var prevReasonState = prevState.reasonState;
                    var newSelf = $$this.self(curReasonState, newComponent.retainedProps);
                    var oldSelf_handle = newSelf.handle;
                    var oldSelf_retainedProps = oldConvertedReasonProps[0].retainedProps;
                    var oldSelf_send = newSelf.send;
                    var oldSelf_onUnmount = newSelf.onUnmount;
                    var oldSelf = {
                      handle: oldSelf_handle,
                      state: prevReasonState,
                      retainedProps: oldSelf_retainedProps,
                      send: oldSelf_send,
                      onUnmount: oldSelf_onUnmount
                    };
                    return Curry._1(newComponent.didUpdate, {
                                oldSelf: oldSelf,
                                newSelf: newSelf
                              });
                  } else {
                    return 0;
                  }
                }),
              componentWillUnmount: (function () {
                  var $$this = this ;
                  var thisJs = this;
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var component = convertedReasonProps[0];
                  var curState = thisJs.state;
                  var curReasonState = curState.reasonState;
                  if (component.willUnmount !== anyToUnit) {
                    Curry._1(component.willUnmount, $$this.self(curReasonState, component.retainedProps));
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
                  var thisJs = this;
                  var newConvertedReasonProps = convertPropsIfTheyreFromJs(nextProps, thisJs.jsPropsToReason, debugName);
                  var newComponent = newConvertedReasonProps[0];
                  if (newComponent.willUpdate !== anyToUnit) {
                    var oldJsProps = thisJs.props;
                    var oldConvertedReasonProps = nextProps === oldJsProps ? newConvertedReasonProps : convertPropsIfTheyreFromJs(oldJsProps, thisJs.jsPropsToReason, debugName);
                    var curState = thisJs.state;
                    var curReasonState = curState.reasonState;
                    var nextReasonState = nextState.reasonState;
                    var newSelf = $$this.self(nextReasonState, newComponent.retainedProps);
                    var oldSelf_handle = newSelf.handle;
                    var oldSelf_retainedProps = oldConvertedReasonProps[0].retainedProps;
                    var oldSelf_send = newSelf.send;
                    var oldSelf_onUnmount = newSelf.onUnmount;
                    var oldSelf = {
                      handle: oldSelf_handle,
                      state: curReasonState,
                      retainedProps: oldSelf_retainedProps,
                      send: oldSelf_send,
                      onUnmount: oldSelf_onUnmount
                    };
                    return Curry._1(newComponent.willUpdate, {
                                oldSelf: oldSelf,
                                newSelf: newSelf
                              });
                  } else {
                    return 0;
                  }
                }),
              componentWillReceiveProps: (function (nextProps) {
                  var $$this = this ;
                  var thisJs = this;
                  var newConvertedReasonProps = convertPropsIfTheyreFromJs(nextProps, thisJs.jsPropsToReason, debugName);
                  var newComponent = newConvertedReasonProps[0];
                  if (newComponent.willReceiveProps !== willReceivePropsDefault) {
                    var oldJsProps = thisJs.props;
                    var oldConvertedReasonProps = nextProps === oldJsProps ? newConvertedReasonProps : convertPropsIfTheyreFromJs(oldJsProps, thisJs.jsPropsToReason, debugName);
                    var oldComponent = oldConvertedReasonProps[0];
                    return thisJs.setState((function (curTotalState, param) {
                                  var curReasonState = curTotalState.reasonState;
                                  var oldSelf = $$this.self(curReasonState, oldComponent.retainedProps);
                                  var nextReasonState = Curry._1(newComponent.willReceiveProps, oldSelf);
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
              shouldComponentUpdate: (function (nextJsProps, nextState, param) {
                  var $$this = this ;
                  var thisJs = this;
                  var curJsProps = thisJs.props;
                  var oldConvertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var newConvertedReasonProps = nextJsProps === curJsProps ? oldConvertedReasonProps : convertPropsIfTheyreFromJs(nextJsProps, thisJs.jsPropsToReason, debugName);
                  var newComponent = newConvertedReasonProps[0];
                  var nextReasonState = nextState.reasonState;
                  var newSelf = $$this.self(nextReasonState, newComponent.retainedProps);
                  if (newComponent.shouldUpdate !== anyToTrue) {
                    var curState = thisJs.state;
                    var curReasonState = curState.reasonState;
                    var oldSelf_handle = newSelf.handle;
                    var oldSelf_retainedProps = oldConvertedReasonProps[0].retainedProps;
                    var oldSelf_send = newSelf.send;
                    var oldSelf_onUnmount = newSelf.onUnmount;
                    var oldSelf = {
                      handle: oldSelf_handle,
                      state: curReasonState,
                      retainedProps: oldSelf_retainedProps,
                      send: oldSelf_send,
                      onUnmount: oldSelf_onUnmount
                    };
                    return Curry._1(newComponent.shouldUpdate, {
                                oldSelf: oldSelf,
                                newSelf: newSelf
                              });
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
                    $$this.subscriptions = [subscription];
                    return /* () */0;
                  }
                }),
              handleMethod: (function (callback) {
                  var $$this = this ;
                  var thisJs = this;
                  return (function (callbackPayload) {
                      var curState = thisJs.state;
                      var curReasonState = curState.reasonState;
                      var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                      return Curry._2(callback, callbackPayload, $$this.self(curReasonState, convertedReasonProps[0].retainedProps));
                    });
                }),
              sendMethod: (function (action) {
                  var $$this = this ;
                  var thisJs = this;
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var component = convertedReasonProps[0];
                  if (component.reducer !== reducerDefault) {
                    var sideEffects = {
                      contents: (function (prim) {
                          return /* () */0;
                        })
                    };
                    var partialStateApplication = Curry._1(component.reducer, action);
                    return thisJs.setState((function (curTotalState, param) {
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
                                        case /* Update */0 :
                                            nextTotalState = {
                                              reasonState: reasonStateUpdate[0]
                                            };
                                            break;
                                        case /* SideEffects */1 :
                                            sideEffects.contents = reasonStateUpdate[0];
                                            nextTotalState = curTotalState;
                                            break;
                                        case /* UpdateWithSideEffects */2 :
                                            sideEffects.contents = reasonStateUpdate[1];
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
                                }), $$this.handleMethod((function (param, self) {
                                      return Curry._1(sideEffects.contents, self);
                                    })));
                  } else {
                    return 0;
                  }
                }),
              render: (function () {
                  var $$this = this ;
                  var thisJs = this;
                  var convertedReasonProps = convertPropsIfTheyreFromJs(thisJs.props, thisJs.jsPropsToReason, debugName);
                  var created = convertedReasonProps[0];
                  var curState = thisJs.state;
                  var curReasonState = curState.reasonState;
                  return Curry._1(created.render, $$this.self(curReasonState, created.retainedProps));
                })
            });
}

function basicComponent(debugName) {
  return {
          debugName: debugName,
          reactClassInternal: createClass(debugName),
          handedOffState: {
            contents: undefined
          },
          willReceiveProps: willReceivePropsDefault,
          didMount: anyToUnit,
          didUpdate: anyToUnit,
          willUnmount: anyToUnit,
          willUpdate: anyToUnit,
          shouldUpdate: anyToTrue,
          render: renderDefault,
          initialState: initialStateDefault,
          retainedProps: /* () */0,
          reducer: reducerDefault,
          jsElementWrapped: undefined
        };
}

var statelessComponent = basicComponent;

var statelessComponentWithRetainedProps = basicComponent;

var reducerComponent = basicComponent;

var reducerComponentWithRetainedProps = basicComponent;

function element($staropt$star, $staropt$star$1, component) {
  var key = $staropt$star !== undefined ? $staropt$star : undefined;
  var ref = $staropt$star$1 !== undefined ? $staropt$star$1 : undefined;
  var element$1 = /* Element */[component];
  var match = component.jsElementWrapped;
  if (match !== undefined) {
    return Curry._2(match, key, ref);
  } else {
    return React.createElement(component.reactClassInternal, {
                key: key,
                ref: ref,
                reasonProps: element$1
              });
  }
}

function wrapReasonForJs(component, jsPropsToReason) {
  var uncurriedJsPropsToReason = Curry.__1(jsPropsToReason);
  component.reactClassInternal.prototype.jsPropsToReason = Caml_option.some(uncurriedJsPropsToReason);
  return component.reactClassInternal;
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
      var varargs = [
          reactClass$1,
          props$2
        ].concat(children$1);
      return React.createElement.apply(null, varargs);
    });
  return {
          debugName: dummyInteropComponent.debugName,
          reactClassInternal: dummyInteropComponent.reactClassInternal,
          handedOffState: dummyInteropComponent.handedOffState,
          willReceiveProps: dummyInteropComponent.willReceiveProps,
          didMount: dummyInteropComponent.didMount,
          didUpdate: dummyInteropComponent.didUpdate,
          willUnmount: dummyInteropComponent.willUnmount,
          willUpdate: dummyInteropComponent.willUpdate,
          shouldUpdate: dummyInteropComponent.shouldUpdate,
          render: dummyInteropComponent.render,
          initialState: dummyInteropComponent.initialState,
          retainedProps: dummyInteropComponent.retainedProps,
          reducer: dummyInteropComponent.reducer,
          jsElementWrapped: jsElementWrapped
        };
}

var Router = /* alias */0;

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
