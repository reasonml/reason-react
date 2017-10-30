---
id: reason-using-js
title: ReasonReact using ReactJS
---
MyBanner.js:
```javascript
var ReactDOM = require('react-dom');
var React = require('react');
var App = React.createClass({
  displayName: "MyBanner",
  render: function() {
    if (this.props.show) {
      return React.createElement('div', null,
        this.props.message
      );
    } else {
      return null;
    }
  }
});
module.exports = App;
```
MyBannerRe.re
```reason
/* Typing the MyBanner.js component's output as a `reactClass`. */
/* Note that this file's JS output is located at reason-react-example/lib/js/src/interop/MyBannerRe.js; we're specifying the relative path to MyBanner.js in the string below */
[@bs.module] external myBanner : ReasonReact.reactClass = "../../../../src/interop/MyBanner";

let make = (~show, ~message, children) =>
  ReasonReact.wrapJsForReason(
    ~reactClass=myBanner,
    ~props={
      "show": Js.Boolean.to_js_boolean(show), /* ^ don't forget to convert an OCaml bool into a JS boolean! */
      "message": message /* OCaml string maps to JS string, no conversion needed here */
    },
    children
  );
```
