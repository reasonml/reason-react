/**
 * Important note on this module:
 * As soon as React provides a mechanism for error-catching using functional component,
 * this is likely to be deprecated and/or move to user space.
 */

type info = {componentStack: string};

type params('error) = {
  error: 'error,
  info,
};

[%%bs.raw {|
  var React = require("react");
  var ErrorBoundary = (function (Component) {
    function ErrorBoundary(props) {
      Component.call(this);
      this.state = {error: undefined};
    };
    ErrorBoundary.prototype = Object.create(Component.prototype);
    ErrorBoundary.prototype.componentDidCatch = function(error, info) {
      this.setState({error: {error: error, info: info}});
    };
    ErrorBoundary.prototype.render = function() {
      return this.state.error != undefined
        ? this.props.fallback(this.state.error)
        : this.props.children
    };
    return ErrorBoundary;
  })(React.Component);
|}];

[@react.component] [@bs.val]
external make: (
  ~children: React.element,
  ~fallback: params('error) => React.element,
) => React.element = "ErrorBoundary"
