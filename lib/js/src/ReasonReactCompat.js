'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Caml_obj = require("bs-platform/lib/js/caml_obj.js");

function useRecordApi(componentSpec) {
  var partial_arg = componentSpec[/* initialState */10];
  var initialState = React.useMemo((function () {
          return Curry._1(partial_arg, /* () */0);
        }), ([]));
  var unmountSideEffects = React.useRef(/* array */[]);
  var match = React.useReducer((function (fullState, action) {
          var recordApiStateReturn = Curry._2(componentSpec[/* reducer */12], action, fullState[/* state */1]);
          if (typeof recordApiStateReturn === "number") {
            return fullState;
          } else {
            switch (recordApiStateReturn.tag | 0) {
              case 0 : 
                  return /* record */[
                          /* sideEffects : array */[],
                          /* state */recordApiStateReturn[0]
                        ];
              case 1 : 
                  return /* record */[
                          /* sideEffects *//* array */[recordApiStateReturn[0]].concat(fullState[/* sideEffects */0]),
                          /* state */fullState[/* state */1]
                        ];
              case 2 : 
                  return /* record */[
                          /* sideEffects *//* array */[recordApiStateReturn[1]].concat(fullState[/* sideEffects */0]),
                          /* state */recordApiStateReturn[0]
                        ];
              
            }
          }
        }), /* record */[
        /* sideEffects : array */[],
        /* state */initialState
      ]);
  var send = match[1];
  var match$1 = match[0];
  var sideEffects = match$1[/* sideEffects */0];
  var self = [];
  Caml_obj.caml_update_dummy(self, /* record */[
        /* handle */(function (fn, payload) {
            return Curry._2(fn, payload, self);
          }),
        /* state */match$1[/* state */1],
        /* retainedProps */componentSpec[/* retainedProps */11],
        /* send */send,
        /* onUnmount */(function (sideEffect) {
            unmountSideEffects.current.push(sideEffect);
            return /* () */0;
          })
      ]);
  var state = Curry._1(componentSpec[/* willReceiveProps */3], self);
  var self$1 = [];
  Caml_obj.caml_update_dummy(self$1, /* record */[
        /* handle */(function (fn, payload) {
            return Curry._2(fn, payload, self$1);
          }),
        /* state */state,
        /* retainedProps */componentSpec[/* retainedProps */11],
        /* send */send,
        /* onUnmount */(function (sideEffect) {
            unmountSideEffects.current.push(sideEffect);
            return /* () */0;
          })
      ]);
  var oldSelf = React.useRef(self$1);
  var hasBeenCalled = React.useRef(false);
  React.useLayoutEffect((function (param) {
          Curry._1(componentSpec[/* didMount */4], self$1);
          return (function (param) {
                    unmountSideEffects.current.forEach((function (fn) {
                            return Curry._1(fn, /* () */0);
                          }));
                    unmountSideEffects.current = /* array */[];
                    return Curry._1(componentSpec[/* willUnmount */6], self$1);
                  });
        }), ([]));
  React.useLayoutEffect((function (param) {
          if (hasBeenCalled.current) {
            hasBeenCalled.current = true;
          } else {
            Curry._1(componentSpec[/* didUpdate */5], /* record */[
                  /* oldSelf */oldSelf.current,
                  /* newSelf */self$1
                ]);
          }
          sideEffects.forEach((function (fn) {
                  return Curry._1(fn, self$1);
                }));
          oldSelf.current = self$1;
          return undefined;
        }));
  var mostRecentAllowedRender = React.useRef(React.useMemo((function (param) {
              return Curry._1(componentSpec[/* render */9], self$1);
            }), ([])));
  if (hasBeenCalled.current && oldSelf.current[/* state */1] !== state && Curry._1(componentSpec[/* shouldUpdate */8], /* record */[
          /* oldSelf */oldSelf.current,
          /* newSelf */self$1
        ])) {
    Curry._1(componentSpec[/* willUpdate */7], /* record */[
          /* oldSelf */oldSelf.current,
          /* newSelf */self$1
        ]);
    mostRecentAllowedRender.current = Curry._1(componentSpec[/* render */9], self$1);
  }
  return mostRecentAllowedRender.current;
}

exports.useRecordApi = useRecordApi;
/* react Not a pure module */
