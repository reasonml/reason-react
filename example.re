
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
let button ::txt="default" ::width=500 ::height=50 children updater => state initialState  {
  let handleChild e => {
    ..state,
    clickCount: state.clickCount + 1
  };
  <box onClick=(updater handleClick)> (string_of_int state.clickCount) </box>
};

let button ::txt="default" ::width=500 ::height=50 children ::state=initialState updater => {
  let handleChild e => {
    ..state,
    clickCount: state.clickCount + 1
  };
  <box onClick=(updater handleClick)> (string_of_int state.clickCount) </box>
};
