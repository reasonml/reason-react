type event = unit;

type domState =
  | Stateless;

type dom('renderedTree) =
  (domState, StaticReactReact.noAction) => 'renderedTree;

let domEventHandler = e => ();

let domStateToString = state => "no dom state";

let div =
    (
      ~onClick: option(event => unit)=?,
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
    )
    : StaticReactReact.renderable(dom(_)) =>
  (~state: domState=Stateless, self) =>
    StaticReactReact.Node(
      state,
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
      ~state: domState=Stateless,
      self,
    ) =>
  StaticReactReact.Node(
    state,
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
      ~state: domState=Stateless,
      self,
    ) =>
  StaticReactReact.Node(
    state,
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

let p = (children, ~state: domState=Stateless, self) =>
  StaticReactReact.Node(
    state,
    Empty,
    () => "<p>" ++ StaticReactDOMUtils.escapeHtml(children),
    "</p>",
  );

let text = (children, ~state: domState=Stateless, self) =>
  StaticReactReact.Node(
    state,
    Empty,
    () => StaticReactDOMUtils.escapeHtml(children),
    "",
  );

let i =
    (
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
      ~state=Stateless,
      self,
    ) =>
  StaticReactReact.Node(
    state,
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
      ~state=Stateless,
      self,
    ) =>
  StaticReactReact.Node(
    state,
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

let ul =
    (
      ~onClick: option(event => unit)=?,
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
      ~state=Stateless,
      self,
    ) =>
  StaticReactReact.Node(
    state,
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<ul>"
      | (Some(cn), None) =>
        "<ul class='" ++ StaticReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<ul class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<ul style='" ++ StaticReactDOMUtils.escapeHtml(s) ++ "'>"
      }
    },
    "</ul>",
  );

let li =
    (
      ~onClick: option(event => unit)=?,
      ~className: option(string)=?,
      ~style: option(string)=?,
      children,
      ~state=Stateless,
      self,
    ) =>
  StaticReactReact.Node(
    state,
    children,
    () => {
      switch (className, style) {
      | (None, None) => "<li>"
      | (Some(cn), None) =>
        "<li class='" ++ StaticReactDOMUtils.escapeHtml(cn) ++ "'>"
      | (Some(cn), Some(s)) =>
        "<li class='"
        ++ StaticReactDOMUtils.escapeHtml(cn)
        ++ "' style='"
        ++ StaticReactDOMUtils.escapeHtml(s)
        ++ "'>"
      | (None, Some(s)) =>
        "<li style='" ++ StaticReactDOMUtils.escapeHtml(s) ++ "'>"
      }
    },
    "</li>",
  );

let img =
    (
      ~onClick: option(event => unit)=?,
      ~className: option(string)=?,
      ~style: option(string)=?,
      ~src: option(string)=?,
      children,
      ~state=Stateless,
      self,
    ) =>
  StaticReactReact.Node(
    state,
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
