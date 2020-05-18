open TestFramework;
open ReasonReactRouter;

describe("it allows to create url from string", ({test}) => {
  test("it supports basic paths", ({expect}) => {
    let expected = {path: ["foo", "bar"], hash: "", search: ""};
    let generated = fromServer("/foo/bar");

    expect.bool(generated == expected).toBeTrue();
  });

  test("it creates with hash", ({expect}) => {
    let expected = {path: ["foo", "bar"], hash: "someHash", search: ""};
    let generated = fromServer("/foo/bar#someHash");

    expect.bool(generated == expected).toBeTrue();
  });

  test("it creates with search", ({expect}) => {
    let expected = {path: ["foo", "bar"], hash: "", search: "q=term"};
    let generated = fromServer("/foo/bar?q=term");

    expect.bool(generated == expected).toBeTrue();
  });

  test("it creates with both present", ({expect}) => {
    let expected = {
      path: ["foo", "bar"],
      hash: "someHash",
      search: "q=term",
    };
    let generated = fromServer("/foo/bar#someHash?q=term");

    expect.bool(generated == expected).toBeTrue();
  });
  test("expect hash to come before search", ({expect}) => {
    let expected = {
      path: ["foo", "bar"],
      hash: "",
      search: "q=term#someHash",
    };
    let generated = fromServer("/foo/bar?q=term#someHash");

    expect.bool(generated == expected).toBeTrue();
  });
});
