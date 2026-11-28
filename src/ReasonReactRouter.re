external (===): ('a, 'a) => bool = "%eq";
external (!==): ('a, 'a) => bool = "%noteq";
external (||): (bool, bool) => bool = "%sequor";

external window: Dom.window = "window";
external history: Dom.history = "history";

let window = () =>
  if (Js.typeof(window) === "undefined") {
    None;
  } else {
    Some(window);
  };

let history = () =>
  if (Js.typeof(history) === "undefined") {
    None;
  } else {
    Some(history);
  };

[@mel.get] external location: Dom.window => Dom.location = "location";

[@mel.send]
/* actually the cb is Dom.event => unit, but let's restrict the access for now */
external addEventListener: (Dom.window, string, unit => unit) => unit =
  "addEventListener";

[@mel.send]
external removeEventListener: (Dom.window, string, unit => unit) => unit =
  "removeEventListener";

[@mel.send]
external dispatchEvent: (Dom.window, Dom.event) => unit = "dispatchEvent";

[@mel.get] external pathname: Dom.location => string = "pathname";

[@mel.get] external hash: Dom.location => string = "hash";

[@mel.get] external search: Dom.location => string = "search";

[@mel.send]
external pushState:
  (Dom.history, [@mel.as {json|null|json}] _, [@mel.as ""] _, ~href: string) =>
  unit =
  "pushState";

[@mel.send]
external replaceState:
  (Dom.history, [@mel.as {json|null|json}] _, [@mel.as ""] _, ~href: string) =>
  unit =
  "replaceState";

external event: 'a = "Event";

[@mel.new] external makeEventIE11Compatible: string => Dom.event = "Event";

[@mel.scope "document"]
external createEventNonIEBrowsers: string => Dom.event = "createEvent";

[@mel.send]
external initEventNonIEBrowsers: (Dom.event, string, bool, bool) => unit =
  "initEvent";

let safeMakeEvent = eventName =>
  if (Js.typeof(event) === "function") {
    makeEventIE11Compatible(eventName);
  } else {
    let event = createEventNonIEBrowsers("Event");
    initEventNonIEBrowsers(event, eventName, true, true);
    event;
  };

/* if we ever roll our own parser in the future, make sure you test all url combinations
   e.g. foo.com/?#bar
   */
/* sigh URLSearchParams doesn't work on IE11, edge16, etc. */
/* actually you know what, not gonna provide search for now. It's a mess.
   We'll let users roll their own solution/data structure for now */
let pathParse = str =>
  switch (str) {
  | ""
  | "/" => []
  | raw =>
    /* remove the preceeding /, which every pathname seems to have */
    let raw = Js.String.slice(~start=1, raw);
    /* remove search portion if present in string */
    let raw =
      switch (Js.String.split(~sep="?", ~limit=2, raw)) {
      | [|path, _|] => path
      | _ => raw
      };

    Js.String.split(~sep="/", raw)
    ->Js.Array.reduceRight(
        ~f=(res, item) =>
          switch (item) {
          | "" => res
          | _ => [item, ...res]
          },
        ~init=[],
      );
  };
let path = (~serverUrlString=?, ()) =>
  switch (serverUrlString, window()) {
  | (None, None) => []
  | (Some(serverUrlString), _) => pathParse(serverUrlString)
  | (_, Some(window: Dom.window)) => pathParse(window->location->pathname)
  };
let hash = () =>
  switch (window()) {
  | None => ""
  | Some(window: Dom.window) =>
    switch (window->location->hash) {
    | ""
    | "#" => ""
    | raw =>
      /* remove the preceeding #, which every hash seems to have.
         Why is this even included in location.hash?? */
      Js.String.slice(~start=1, raw)
    }
  };
let searchParse = str =>
  switch (str) {
  | ""
  | "?" => ""
  | raw =>
    switch (Js.String.split(~sep="?", ~limit=2, raw)) {
    | [|_, search|] => search
    | _ => ""
    }
  };
let search = (~serverUrlString=?, ()) =>
  switch (serverUrlString, window()) {
  | (None, None) => ""
  | (Some(serverUrlString), _) => searchParse(serverUrlString)
  | (_, Some(window: Dom.window)) => searchParse(window->location->search)
  };
let push = path =>
  switch (history(), window()) {
  | (None, _)
  | (_, None) => ()
  | (Some(history: Dom.history), Some(window: Dom.window)) =>
    pushState(history, ~href=path);
    dispatchEvent(window, safeMakeEvent("popstate"));
  };
let replace = path =>
  switch (history(), window()) {
  | (None, _)
  | (_, None) => ()
  | (Some(history: Dom.history), Some(window: Dom.window)) =>
    replaceState(history, ~href=path);
    dispatchEvent(window, safeMakeEvent("popstate"));
  };
type url = {
  path: list(string),
  hash: string,
  search: string,
};
let urlNotEqual = (a, b) => {
  let rec listNotEqual = (aList, bList) =>
    switch (aList, bList) {
    | ([], []) => false
    | ([], [_, ..._])
    | ([_, ..._], []) => true
    | ([aHead, ...aRest], [bHead, ...bRest]) =>
      if (aHead !== bHead) {
        true;
      } else {
        listNotEqual(aRest, bRest);
      }
    };
  a.hash !== b.hash || a.search !== b.search || listNotEqual(a.path, b.path);
};
type watcherID = unit => unit;
let url = (~serverUrlString=?, ()) => {
  path: path(~serverUrlString?, ()),
  hash: hash(),
  search: search(~serverUrlString?, ()),
};
/* alias exposed publicly */
let dangerouslyGetInitialUrl = url;
let watchUrl = callback =>
  switch (window()) {
  | None => (() => ())
  | Some(window: Dom.window) =>
    let watcherID = () => callback(url());
    addEventListener(window, "popstate", watcherID);
    watcherID;
  };
let unwatchUrl = watcherID =>
  switch (window()) {
  | None => ()
  | Some(window: Dom.window) =>
    removeEventListener(window, "popstate", watcherID)
  };

let useUrl = (~serverUrl=?, ()) => {
  let (url, setUrl) =
    React.useState(() =>
      switch (serverUrl) {
      | Some(url) => url
      | None => dangerouslyGetInitialUrl()
      }
    );

  React.useEffect0(() => {
    let watcherId = watchUrl(url => setUrl(_ => url));

    /**
      * check for updates that may have occured between
      * the initial state and the subscribe above
      */
    let newUrl = dangerouslyGetInitialUrl();
    if (urlNotEqual(newUrl, url)) {
      setUrl(_ => newUrl);
    };

    Some(() => unwatchUrl(watcherId));
  });

  url;
};
