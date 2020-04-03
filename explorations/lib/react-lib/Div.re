type event = unit;

type state = unit;

type t('renderedTree) = (state, React.noAction) => 'renderedTree;

let domEventHandler = e => ();

let domStateToString = state => "no dom state";

let render =
    (
      ~onFocusLost: option(event => unit)=?,
      ~onClick: option(event => unit)=?,
      ~className: option(string)=?,
      children,
      ~state=?,
      self,
    ) =>
  React.Node(
    (),
    children,
    () => {
      switch (className) {
      | None => "<div>"
      | Some(cn) => "<div class='" ++ cn ++ "'>"
      }
    },
    "</div>",
  );
