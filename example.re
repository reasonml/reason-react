let button ::txt="default" ::width=500 ::height=50 children ::state=initialState updater => {
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

let button ::txt="default" ::width=500 ::height=50 children ::state=initialState updater => {
  let handleChild e => {
    ..state,
    clickCount: state.clickCount + 1
  };
  <box onClick=(updater handleClick)> (string_of_int state.clickCount) </box>
};
