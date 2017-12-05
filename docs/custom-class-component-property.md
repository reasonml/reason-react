---
id: custom-class-component-property
title: Custom Class/Component Property
---

Your ReactJS component might have extra properties attached onto it:

```js
class HelloMessage extends React.Component {
  static getRandomNumber() {
    return 4;
  };

  getAnswerToLife() {
    return 42;
  };

  render() {
    ...
  }
}
```

Since ReasonReact components are created from a record (which has fixed fields), you can't attach arbitrary fields onto it. Here are the solutions.

## Static Class Property

Just export a standalone value/function:

```reason
let component = ...;
let make = ...;

let getRandomNumber = () => 4;
```

Keep it simple!

## Instance (Component) Property

If the component property/method doesn't refer to the component instance (aka `this` in JS), then it can just be a static class property, in which case you should just export a normal `let` value.

If the component _does_ conceptually refer to `this`, then still try to turn it into a normal `let` value that takes in a normal argument instead of reading into the component's `this`.

_If this part's unclear, or if it doesn't work in your case, please [file an issue](https://github.com/reasonml/reason-react/issues/new)_!
