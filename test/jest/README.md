## Jest bindings in ReasonML

This is a set of bindings to `jest` in ReasonML, It aims to be simpler to use than `bs-jest`, with most functions returning `unit`, enabling a developer to write their tests with the same approach they would take writing them in JavaScript, but without needing to leave the type safety of ReasonML.

```reason
describe("myTests", () => {
  test("numbers", () => {
    let myNumber = 123;
    expect(myNumber)->toBeGreaterThan(100);
    expect(myNumber)->not->toBeLessThanOrEqual(1);
    expect(myNumber->float_of_int)->toBeLessThan(124.0);
  });

  testAsync("promises", () => {
    expect(Js.Promise.resolve(123))->resolves->toEqual(123);
  });

  test("arrays", () => {
    expect([|1, 2, 3, 4, 5|])->toContain(4);
  });

  // Still working on this one...
  Skip.test("This test is skipped", () =>
    expect(1)->toBeGreaterThan(0)
  );
});
```

## Stability

Very much a work in progress, but nonetheless it can do enough to test plenty of existing code.
