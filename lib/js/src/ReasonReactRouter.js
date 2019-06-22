'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Caml_obj = require("bs-platform/lib/js/caml_obj.js");

function safeMakeEvent(eventName) {
  if (typeof Event === "function") {
    return new Event(eventName);
  } else {
    var $$event = document.createEvent("Event");
    $$event.initEvent(eventName, true, true);
    return $$event;
  }
}

function pathFromString(pathname) {
  switch (pathname) {
    case "" : 
    case "/" : 
        return /* [] */0;
    default:
      var raw = pathname.slice(1);
      var match = raw[raw.length - 1 | 0];
      var raw$1 = match === "/" ? raw.slice(0, -1) : raw;
      var a = raw$1.split("/");
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
}

function pathFromWindow(param) {
  var match = typeof window === "undefined" ? undefined : window;
  if (match !== undefined) {
    return pathFromString(match.location.pathname);
  } else {
    return /* [] */0;
  }
}

function hashFromString(hash) {
  switch (hash) {
    case "" : 
    case "#" : 
        return "";
    default:
      return hash.slice(1);
  }
}

function hashFromWindow(param) {
  var match = typeof window === "undefined" ? undefined : window;
  if (match !== undefined) {
    return hashFromString(match.location.hash);
  } else {
    return "";
  }
}

function searchFromString(search) {
  switch (search) {
    case "" : 
    case "?" : 
        return "";
    default:
      return search.slice(1);
  }
}

function searchFromWindow(param) {
  var match = typeof window === "undefined" ? undefined : window;
  if (match !== undefined) {
    return searchFromString(match.location.search);
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

function urlFromWindow(param) {
  return /* record */[
          /* path */pathFromWindow(/* () */0),
          /* hash */hashFromWindow(/* () */0),
          /* search */searchFromWindow(/* () */0)
        ];
}

function url(pathname, search, hash, param) {
  return /* record */[
          /* path */pathFromString(pathname !== undefined ? pathname : "/"),
          /* hash */hashFromString(hash !== undefined ? hash : ""),
          /* search */searchFromString(search !== undefined ? search : "")
        ];
}

function watchUrl(callback) {
  var match = typeof window === "undefined" ? undefined : window;
  if (match !== undefined) {
    var watcherID = function (param) {
      return Curry._1(callback, urlFromWindow(/* () */0));
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
            return urlFromWindow(/* () */0);
          }
        }));
  var setUrl = match[1];
  var url = match[0];
  React.useEffect((function () {
          var watcherId = watchUrl((function (url) {
                  return Curry._1(setUrl, (function (param) {
                                return url;
                              }));
                }));
          var newUrl = urlFromWindow(/* () */0);
          if (Caml_obj.caml_notequal(newUrl, url)) {
            Curry._1(setUrl, (function (param) {
                    return newUrl;
                  }));
          }
          return (function (param) {
                    return unwatchUrl(watcherId);
                  });
        }), ([]));
  return url;
}

var dangerouslyGetInitialUrl = urlFromWindow;

var getUrl = url;

exports.push = push;
exports.replace = replace;
exports.watchUrl = watchUrl;
exports.unwatchUrl = unwatchUrl;
exports.dangerouslyGetInitialUrl = dangerouslyGetInitialUrl;
exports.getUrl = getUrl;
exports.useUrl = useUrl;
/* react Not a pure module */
