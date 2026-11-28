open Jest;
open Jest.Expect;
open ReasonReactRouter;

describe("it allows to create url from string", () => {
  test("it supports basic paths", () => {
    let expected = {
      path: ["foo", "bar"],
      hash: "",
      search: "",
    };
    let generated = dangerouslyGetInitialUrl(~serverUrlString="/foo/bar", ());

    expect(generated == expected)->toBe(true);
  });

  test("it creates with search", () => {
    let expected = {
      path: ["foo", "bar"],
      hash: "",
      search: "q=term",
    };
    let generated =
      dangerouslyGetInitialUrl(~serverUrlString="/foo/bar?q=term", ());

    expect(generated == expected)->toBe(true);
  });

  test("it preserves path order and skips empty segments", () => {
    let generated =
      dangerouslyGetInitialUrl(
        ~serverUrlString="//first///second/third//?q=term",
        (),
      );

    expect(generated.path)->toEqual(["first", "second", "third"]);
    expect(generated.search)->toBe("q=term");
  });

  test("it supports empty and root paths", () => {
    List.iter(
      serverUrlString => {
        let generated = dangerouslyGetInitialUrl(~serverUrlString, ());
        expect(generated.path)->toEqual([]);
      },
      ["", "/", "///"],
    )
  });

  test("it ignores trailing slashes without changing the search", () => {
    List.iter(
      ((serverUrlString, search)) => {
        let generated = dangerouslyGetInitialUrl(~serverUrlString, ());
        expect(generated.path)->toEqual(["foo", "bar"]);
        expect(generated.search)->toBe(search);
      },
      [
        ("/foo/bar/", ""),
        ("/foo/bar///", ""),
        ("/foo/bar/?redirect=/next/", "redirect=/next/"),
        ("/foo/bar///?redirect=/next/", "redirect=/next/"),
      ],
    )
  });
});
