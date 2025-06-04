---
title: Testing components
---

Even though types make your code safer, it doesn't remove the need for testing!

If you want to test your reason-react components using your JavaScript testing stack, that's perfectly alright, but if you prefer to write them in Reason, here are some testing frameworks and bindings to make your life easier:

### Test framework

Pick the test framework you like the best (both use Jest under the hood):

- [reason-test-framework](https://github.com/bloodyowl/reason-test-framework)
- [bs-jest](https://github.com/glennsl/bs-jest)

### Test utilities

We provide test utilities in the [`ReactDOMTestUtils`](https://github.com/reasonml/reason-react/blob/main/src/ReactDOMTestUtils.re) module.

If you want to have a look at a real example, here's what a test might look like from reason-react's test suite [Hooks__test](https://github.com/reasonml/reason-react/blob/main/test/Hooks__test.re).

Here's is a basic example of what a test might look like:

```reason
open ReactDOMTestUtils;
open TestFramework;
// TestFramework isn't a real module, just an imaginary set of bindings
// to a JavaScript testing framework

describe("My basic test", ({test, beforeEach, afterEach}) => {
  // Here, we prepare an empty ref that will eventually be
  // the root node for our test
  let container = ref(None);

  // Before each test, creates a new div root
  beforeEach(prepareContainer(container));
  // After each test, removes the div
  afterEach(cleanupContainer(container));

  test("can render DOM elements", ({expect}) => {
    // The following function gives us the div
    let container = getContainer(container);
    let root = ReactDOM.Client.createRoot(container);

    // Most of the ReactDOMTestUtils API is there
    act(() => {
      ReactDOM.Client.render(root, <div> "Hello world!"->React.string </div>);
    });

    expect.bool(
      container
      // We also provide some basic DOM querying utilities
      // to ease your tests
      ->DOM.findBySelectorAndTextContent("div", "Hello world!")
      ->Option.isSome,
    ).
      toBeTrue();
  });
});
```

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

And utilities for setup and teardown:

- `prepareContainer`
- `cleanupContainer`
- `getContainer`

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
