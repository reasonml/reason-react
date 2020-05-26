---
title: Testing ReasonReact components
---

Even though types make your code safer, it doesn't remove the need for testing!
If you want to test your ReasonReact components using your JavaScript testing stack, that's perfectly alright, but if you prefer to write them in Reason, here are some testing frameworks and bindings to make your life easier:

### Test framework

Pick the test framework you like the best (both use Jest under the hood):

- [reason-test-framework](https://github.com/bloodyowl/reason-test-framework)
- [bs-jest](https://github.com/glennsl/bs-jest)

### Test utilities

We provide test utilities in the [`ReactTestUtils`](https://github.com/reasonml/reason-react/blob/master/src/ReactTestUtils.rei) module.

Here's what a test might look like:

```reason
open TestFramework;
open ReactTestUtils;

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

    // Most of the ReactTestUtils API is there 
    act(() => {
      ReactDOMRe.render(<div> "Hello world!"->React.string </div>, container)
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

#### `ReactTestUtils`

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

#### `ReactTestUtils.Simulate`

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

If you feel like some are missing, you can easily adapt the bindings: [`ReactTestUtils`](https://github.com/reasonml/reason-react/blob/master/src/ReactTestUtils.rei) and make a PR!

#### `ReactTestUtils.DOM` convenience functions

- `value`
- `findBySelector`
- `findByAllSelector`
- `findBySelectorAndTextContent`
- `findBySelectorAndPartialTextContent`
