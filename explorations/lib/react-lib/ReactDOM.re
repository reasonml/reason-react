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
      | (Some(cn), None) => "<div class='" ++ cn ++ "'>"
      | (Some(cn), Some(s)) =>
        "<div class='" ++ cn ++ "' style='" ++ s ++ "'>"
      | (None, Some(s)) => "<div style='" ++ s ++ "'>"
      }
    },
    "</div>",
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
      | (Some(cn), None) => "<span class='" ++ cn ++ "'>"
      | (Some(cn), Some(s)) =>
        "<span class='" ++ cn ++ "' style='" ++ s ++ "'>"
      | (None, Some(s)) => "<span style='" ++ s ++ "'>"
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
      | (Some(cn), None, None) => "<img class='" ++ cn ++ "'>"
      | (Some(cn), Some(s), None) =>
        "<img class='" ++ cn ++ "' style='" ++ s ++ "'>"
      | (None, Some(s), None) => "<img style='" ++ s ++ "'>"
      | (None, None, Some(sr)) => "<img src='" ++ sr ++ "'>"
      | (Some(cn), None, Some(sr)) =>
        "<img class='" ++ cn ++ "' src='" ++ sr ++ "'>"
      | (Some(cn), Some(s), Some(sr)) =>
        "<img class='" ++ cn ++ "' style='" ++ s ++ "' src='" ++ sr ++ "'>"
      | (None, Some(s), Some(sr)) =>
        "<img style='" ++ s ++ "' src='" ++ sr ++ "'>"
      }
    },
    "</img>",
  );
