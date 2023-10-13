open Jest;
open Jest.Expect;
open ReasonReactRouter;

describe("it allows to create url from string", () => {
  test("it supports basic paths", () => {
    let expected = {path: ["foo", "bar"], hash: "", search: ""};
    let generated = dangerouslyGetInitialUrl(~serverUrlString="/foo/bar", ());

    expect(generated == expected)->toBe(true);
  });

  test("it creates with search", () => {
    let expected = {path: ["foo", "bar"], hash: "", search: "q=term"};
    let generated =
      dangerouslyGetInitialUrl(~serverUrlString="/foo/bar?q=term", ());

    expect(generated == expected)->toBe(true);
  });
});
