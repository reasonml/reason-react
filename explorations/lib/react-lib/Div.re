type event = unit;

type state = string;

type t('renderedTree) = (state, React.noAction) => 'renderedTree;

let domEventHandler = e => ();

let domStateToString = state => state;

let render =
    (
      ~onFocusLost: option(event => unit)=?,
      ~onClick: option(event => unit)=?,
      ~className: string="",
      children,
      ~state=?,
      self,
    ) =>
  React.Reducer(
    className,
    children,
    /*  */
    (inst, React.NoAction) => "",
  );
