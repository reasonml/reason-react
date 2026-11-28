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

The deprecated `ReactDOMTestUtils` module has been removed. Use `React.act` or `React.actAsync` when testing React updates, `melange-testing-library` for rendering, querying, and cleaning up components in tests, and `melange-webapi` for direct DOM access.

See [Hooks__test](https://github.com/reasonml/reason-react/blob/main/test/Hooks__test.re) for examples of test setup using testing-library bindings.
