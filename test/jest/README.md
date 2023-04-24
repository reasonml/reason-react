# Jest bindings

> Simpler bindings for Jest, taken from [draftbit/re-jest](https://github.com/draftbit/re-jest) and
> vendored here to avoid a dependency

- Write tests with the same approach as JavaScript
- Uses pipe first `->` for chaining assertions (expect)
- `expect` embrace a polymorphism API
- Most core functions returning unit

```reason
open Jest;
open Expect;

test("number", () => {
  let myNumber = 123;
  expect(myNumber)->toBeGreaterThan(100);
  expect(myNumber)->not->toBeLessThanOrEqual(1);
  expect(myNumber->float_of_int)->toBeLessThan(124.0);
});

testAsync("promise", () => {
  expect(Js.Promise.resolve(123))->resolves->toEqual(123);
});

test("array", () => {
  expect([|1, 2, 3, 4, 5|])->toContain(4);
});

// Still working on this one...
Skip.test("This test is skipped", () =>
  expect(1)->toBeGreaterThan(0)
);
```
