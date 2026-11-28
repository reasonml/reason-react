---
title: Testing components
---

Even though types make your code safer, it doesn't remove the need for testing!

If you want to test your ReasonReact components using your JavaScript testing stack, that's perfectly alright, but if you prefer to write them in Reason, here are some testing frameworks and bindings to make your life easier:

### Test framework

Pick the test framework you like the best (both use Jest under the hood):

- [reason-test-framework](https://github.com/bloodyowl/reason-test-framework)
- [bs-jest](https://github.com/glennsl/bs-jest)

### Test utilities

The `ReactDOMTestUtils` module is deprecated. Prefer `melange-testing-library` for rendering, querying, and cleaning up components in tests, and `React.act` or `React.actAsync` when testing React updates directly.

The deprecated `prepareContainer`, `cleanupContainer`, and `getContainer` helpers have been removed. See [Hooks__test](https://github.com/reasonml/reason-react/blob/main/test/Hooks__test.re) for examples of test setup using testing-library bindings.

### API

#### `ReactDOMTestUtils`

Directly from the [React test utilities](https://reactjs.org/docs/test-utils.html).

- `act`
- `actAsync` (let's your return a promise)
- `isElement`
- `isElementOfType`
- `isDOMComponent`
- `isCompositeComponent`
- `isCompositeComponentWithType`

#### `ReactDOMTestUtils.Simulate`

- `Simulate.click`
- `Simulate.clickWithEvent`
- `Simulate.change`
- `Simulate.changeWithEvent`
- `Simulate.changeWithValue`
- `Simulate.changeWithChecked`
- `Simulate.focus`
- `Simulate.blur`
- `Simulate.canPlay`
- `Simulate.timeUpdate`
- `Simulate.ended`

If you feel like some are missing, you can easily adapt the bindings: [`ReactDOMTestUtils`](https://github.com/reasonml/reason-react/blob/main/src/ReactDOMTestUtils.rei) and make a PR!

#### `ReactDOMTestUtils.DOM` convenience functions

- `value`
- `findBySelector`
- `findByAllSelector`
- `findBySelectorAndTextContent`
- `findBySelectorAndPartialTextContent`
