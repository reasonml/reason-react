type event = unit;

type state = unit;

type t('renderedTree) = (state, StaticReact.noAction) => 'renderedTree;

let domEventHandler = e => ();

let domStateToString = state => "no dom state";

let div =
    (
      ~onClick: option(event => unit)=?,
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
      ~state=?,
      self,
    ) =>
  StaticReact.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<div>"
      | (Some(cn), None) =>
        "<div class='" ++ StaticReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<div class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<div style='" ++ StaticReactDOMUtils.escapeHtml(s) ++ "'>"
      }
    },
    "</div>",
  );

let i =
    (
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
      ~state=?,
      self,
    ) =>
  StaticReact.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<i>"
      | (Some(cn), None) =>
        "<i class='" ++ StaticReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<i class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<i style='" ++ StaticReactDOMUtils.escapeHtml(s) ++ "'>"
      }
    },
    "</i>",
  );

let b =
    (
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
      ~state=?,
      self,
    ) =>
  StaticReact.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<b>"
      | (Some(cn), None) =>
        "<b class='" ++ StaticReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<b class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<b style='" ++ StaticReactDOMUtils.escapeHtml(s) ++ "'>"
      }
    },
    "</b>",
  );

let p = (children, ~state=?, self) =>
  StaticReact.Node(
    (),
    Empty,
    () => "<p>" ++ StaticReactDOMUtils.escapeHtml(children),
    "</p>",
  );

let i =
    (
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
      ~state=?,
      self,
    ) =>
  StaticReact.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<i>"
      | (Some(cn), None) =>
        "<i class='" ++ StaticReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<i class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<i style='" ++ StaticReactDOMUtils.escapeHtml(s) ++ "'>"
      }
    },
    "</i>",
  );

let span =
    (
      ~onClick: option(event => unit)=?,
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
      ~state=?,
      self,
    ) =>
  StaticReact.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<span>"
      | (Some(cn), None) =>
        "<span class='" ++ StaticReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<span class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<span style='" ++ StaticReactDOMUtils.escapeHtml(s) ++ "'>"
      }
    },
    "</span>",
  );

let img =
    (
      ~onClick: option(event => unit)=?,
      ~className: option(string)=?,
      ~style: option(string)=?,
      ~src: option(string)=?,
      children,
      ~state=?,
      self,
    ) =>
  StaticReact.Node(
    (),
    children,
    () => {
      switch (className, style, src) {
      | (None, None, None) => "<img>"
      | (Some(cn), None, None) =>
        "<img class='" ++ StaticReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s), None) =>
        "<img class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s), None) =>
        "<img style='" ++ StaticReactDOMUtils.escapeHtml(s) ++ "'>"
      | (None, None, Some(sr)) =>
        "<img src='" ++ StaticReactDOMUtils.escapeHtml(sr) ++ "'>"
      | (Some(cn), None, Some(sr)) =>
        "<img class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' src='"
        ++ StaticReactDOMUtils.escapeHtml(sr)
        ++ "'>"
      | (Some(cn), Some(s), Some(sr)) =>
        "<img class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "' src='"
        ++ StaticReactDOMUtils.escapeHtml(sr)
        ++ "'>"
      | (None, Some(s), Some(sr)) =>
        "<img style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "' src='"
        ++ StaticReactDOMUtils.escapeHtml(sr)
        ++ "'>"
      }
    },
    "</img>",
  );
