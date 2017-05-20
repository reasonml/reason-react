/**
 * Jordan's dream API
 */
let button ::txt="default" ::width=500 ::height=50 children ::state=initialState updater => {
  let handleChild e => {
    ..state,
    clickCount: state.clickCount + 1
  };
  <box onClick=(updater handleClick)> (string_of_int state.clickCount) </box>
};

/**
 * In case we want to return also the initial state this might be handier. Probably flawed however due 
 * to not handling the updater correctly.
 */
let button ::txt="default" ::width=500 ::height=50 children updater => state initialState {
  let handleChild e => {
    ..state,
    clickCount: state.clickCount + 1
  };
  <box onClick=(updater handleClick)> (string_of_int state.clickCount) </box>
};

/**
 * Closer to reality 
 */
type state = {
  clickCount: int
};

let myComponent ::colorAttr children {previous, updater} => {
  let state = previous.state |? {clickCount: 0};
  {
    state,
    rendered: <box color=(state.clickCount > 1 ? 0xFF0000 : colorAttr) onClick=(updater handleClick) />
  }
};

/**
 * Most realistic approach
 */
let myComponent ::colorAttr children => {
  initialState: fun () => {
    clickCount: 0
  },
  render: fun state updater =>
    <box color=(state.clickCount > 1 ? black : colorAttr) onClick=(updater handleClick) />
};
