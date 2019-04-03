---
title: ReasonReact using ReactJS
---

`MyBanner.js:`

```javascript
var ReactDOM = require('react-dom');
var React = require('react');

var MyBanner = function(props) {
   if (props.show) {
    return React.createElement('div', null,
      'Here\'s the message from the owner: ' + props.message
    );
  } else {
    return null;
  }
};

module.exports = MyBanner;
```

`MyBannerRe.re`

```reason
/* ReactJS used by ReasonReact */
[@react.component] [@bs.module]
external make : (~show: bool, ~message: string) => React.element = "./MyBanner";
```
