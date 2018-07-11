type state = string;

type event;

type t('renderedTree) = (state, React.noAction) => 'renderedTree;

let render:
  (
    ~onFocusLost: event => unit=?,
    ~onClick: event => unit=?,
    ~className: string=?,
    React.elem('renderedTree)
  ) =>
  React.renderable(t('renderedTree));

let domStateToString: state => string;
