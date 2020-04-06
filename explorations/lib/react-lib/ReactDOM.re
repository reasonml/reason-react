type event = unit;

type state = unit;

type t('renderedTree) = (state, React.noAction) => 'renderedTree;

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
  React.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<div>"
      | (Some(cn), None) =>
        "<div class='" ++ ReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<div class='"
        ++ ReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ ReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<div style='" ++ ReactDOMUtils.escapeHtml(s) ++ "'>"
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
  React.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<i>"
      | (Some(cn), None) =>
        "<i class='" ++ ReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<i class='"
        ++ ReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ ReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<i style='" ++ ReactDOMUtils.escapeHtml(s) ++ "'>"
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
  React.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<b>"
      | (Some(cn), None) =>
        "<b class='" ++ ReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<b class='"
        ++ ReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ ReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<b style='" ++ ReactDOMUtils.escapeHtml(s) ++ "'>"
      }
    },
    "</b>",
  );

let p = (children, ~state=?, self) =>
  React.Node(
    (),
    Empty,
    () => "<p>" ++ ReactDOMUtils.escapeHtml(children),
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
  React.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<i>"
      | (Some(cn), None) =>
        "<i class='" ++ ReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<i class='"
        ++ ReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ ReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<i style='" ++ ReactDOMUtils.escapeHtml(s) ++ "'>"
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
  React.Node(
    (),
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<span>"
      | (Some(cn), None) =>
        "<span class='" ++ ReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<span class='"
        ++ ReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ ReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<span style='" ++ ReactDOMUtils.escapeHtml(s) ++ "'>"
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
  React.Node(
    (),
    children,
    () => {
      switch (className, style, src) {
      | (None, None, None) => "<img>"
      | (Some(cn), None, None) =>
        "<img class='" ++ ReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s), None) =>
        "<img class='"
        ++ ReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ ReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s), None) =>
        "<img style='" ++ ReactDOMUtils.escapeHtml(s) ++ "'>"
      | (None, None, Some(sr)) =>
        "<img src='" ++ ReactDOMUtils.escapeHtml(sr) ++ "'>"
      | (Some(cn), None, Some(sr)) =>
        "<img class='"
        ++ ReactDOMUtils.escapeHtml(cn)
        ++ "' src='"
        ++ ReactDOMUtils.escapeHtml(sr)
        ++ "'>"
      | (Some(cn), Some(s), Some(sr)) =>
        "<img class='"
        ++ ReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ ReactDOMUtils.escapeHtml(s)
        ++ "' src='"
        ++ ReactDOMUtils.escapeHtml(sr)
        ++ "'>"
      | (None, Some(s), Some(sr)) =>
        "<img style='"
        ++ ReactDOMUtils.escapeHtml(s)
        ++ "' src='"
        ++ ReactDOMUtils.escapeHtml(sr)
        ++ "'>"
      }
    },
    "</img>",
  );
