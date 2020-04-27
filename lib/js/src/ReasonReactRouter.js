'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");

function safeMakeEvent(eventName) {
  if (typeof Event === "function") {
    return new Event(eventName);
  } else {
    var $$event = document.createEvent("Event");
    $$event.initEvent(eventName, true, true);
    return $$event;
  }
}

function path(param) {
  var match = typeof window === "undefined" ? undefined : window;
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

function hash(param) {
  var match = typeof window === "undefined" ? undefined : window;
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

function search(param) {
  var match = typeof window === "undefined" ? undefined : window;
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
  var match = typeof history === "undefined" ? undefined : history;
  var match$1 = typeof window === "undefined" ? undefined : window;
  if (match !== undefined && match$1 !== undefined) {
    match.pushState(null, "", path);
    match$1.dispatchEvent(safeMakeEvent("popstate"));
    return /* () */0;
  } else {
    return /* () */0;
  }
}

function replace(path) {
  var match = typeof history === "undefined" ? undefined : history;
  var match$1 = typeof window === "undefined" ? undefined : window;
  if (match !== undefined && match$1 !== undefined) {
    match.replaceState(null, "", path);
    match$1.dispatchEvent(safeMakeEvent("popstate"));
    return /* () */0;
  } else {
    return /* () */0;
  }
}

function urlNotEqual(a, b) {
  if (a.hash !== b.hash || a.search !== b.search) {
    return true;
  } else {
    var _aList = a.path;
    var _bList = b.path;
    while(true) {
      var bList = _bList;
      var aList = _aList;
      if (aList) {
        if (bList && aList[0] === bList[0]) {
          _bList = bList[1];
          _aList = aList[1];
          continue ;
        } else {
          return true;
        }
      } else if (bList) {
        return true;
      } else {
        return false;
      }
    };
  }
}

function url(param) {
  return {
          path: path(/* () */0),
          hash: hash(/* () */0),
          search: search(/* () */0)
        };
}

function watchUrl(callback) {
  var match = typeof window === "undefined" ? undefined : window;
  if (match !== undefined) {
    var watcherID = function (param) {
      return Curry._1(callback, url(/* () */0));
    };
    match.addEventListener("popstate", watcherID);
    return watcherID;
  } else {
    return (function (param) {
        return /* () */0;
      });
  }
}

function unwatchUrl(watcherID) {
  var match = typeof window === "undefined" ? undefined : window;
  if (match !== undefined) {
    match.removeEventListener("popstate", watcherID);
    return /* () */0;
  } else {
    return /* () */0;
  }
}

function useUrl(serverUrl, param) {
  var match = React.useState((function () {
          if (serverUrl !== undefined) {
            return serverUrl;
          } else {
            return url(/* () */0);
          }
        }));
  var setUrl = match[1];
  var url$1 = match[0];
  React.useEffect((function () {
          var watcherId = watchUrl((function (url) {
                  return Curry._1(setUrl, (function (param) {
                                return url;
                              }));
                }));
          var newUrl = url(/* () */0);
          if (urlNotEqual(newUrl, url$1)) {
            Curry._1(setUrl, (function (param) {
                    return newUrl;
                  }));
          }
          return (function (param) {
                    return unwatchUrl(watcherId);
                  });
        }), ([]));
  return url$1;
}

var dangerouslyGetInitialUrl = url;

exports.push = push;
exports.replace = replace;
exports.watchUrl = watchUrl;
exports.unwatchUrl = unwatchUrl;
exports.dangerouslyGetInitialUrl = dangerouslyGetInitialUrl;
exports.useUrl = useUrl;
/* react Not a pure module */
