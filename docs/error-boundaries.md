---
title: Error boundaries
---

> **Important note on the API described in this guide:**
> As soon as React provides a mechanism for error-catching using functional component,
> `ReasonReactErrorBoundary` is likely to be deprecated and/or move to user space.

ReactJS provides [a way to catch errors](https://reactjs.org/docs/error-boundaries.html) thrown in descendent component render functions in its class API using `componentDidCatch`, it enables you to display a fallback:

```javascript
class MyErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      hasError: false,
    },
  }
  componentDidCatch(error, info) {
    this.setState({hasError: true})
  }
  // ...
  render() {
    if(this.state.hasError) {
      return this.props.fallback
    } else {
      return this.props.children
    }
  }
};

<MyErrorBoundary>
  <ComponentThatCanThrow />
</MyErrorBoundary>
```

We're providing a lightweight component that does that just for you: `ReasonReactErrorBoundary`.

```reason
<ReasonReactErrorBoundary
  fallback={_ => "An error occured"->React.string}
 >
  <ComponentThatCanThrow />
</ReasonReactErrorBoundary>
```

In case you need to log your errors to your analytics service, we pass a record containing `error` and `info` to your fallback function:

```reason
module ErrorHandler = {
  [@react.component]
  let make = (~error, ~info) => {
    React.useEffect2(() => {
      reportError(error, info) // your analytics function
      None
    }, (error, info));
    "An error occured"->React.string
  }
};

<ReasonReactErrorBoundary
  fallback={({error, info}) => <ErrorHandler error info />}
 >
  <ComponentThatCanThrow />
</ReasonReactErrorBoundary>
```
