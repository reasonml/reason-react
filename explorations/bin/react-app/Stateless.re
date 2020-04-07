[@refmt.staticExperiment];
open ReactLib;

/*
 * We can have something like this React.stateless, which the JSX
 * <React.stateless /> would simply call, so that it avoids wrapping its
 * render output.
 */
let render = (~txt="default", children) =>
  ReactDOM.div(~className=txt, Empty);
