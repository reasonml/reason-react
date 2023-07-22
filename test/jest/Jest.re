module Expect = Expect;
module Mock = Mock;

// Jest requires a function of *no arguments* to be passed into `describe`,
// hence the uncurried function.
[@mel.val] external describeU: (string, (. unit) => unit) => unit = "describe";

let describe: (string, unit => unit) => unit =
  (name, f) => describeU(name, (.) => f());

// Tests have an optional timeout (third argument)
[@mel.val]
external testU: (string, (. unit) => unit, option(int)) => unit = "test";

let test: (~timeout: int=?, string, unit => unit) => unit =
  (~timeout=?, name, f) => testU(name, (.) => f(), timeout);

[@mel.val]
external testAsyncU:
  (string, (. unit) => Js.Promise.t(unit), option(int)) => unit =
  "test";

let testAsync: (~timeout: int=?, string, unit => Js.Promise.t(unit)) => unit =
  (~timeout=?, name, f) => testAsyncU(name, (.) => f(), timeout);

module Only = {
  [@mel.val] [@mel.scope "describe"]
  external describeU: (string, (. unit) => unit) => unit = "only";

  let describe: (string, unit => unit) => unit =
    (name, f) => describeU(name, (.) => f());

  [@mel.val] [@mel.scope "test"]
  external testU: (string, (. unit) => unit, option(int)) => unit = "only";

  let test: (~timeout: int=?, string, unit => unit) => unit =
    (~timeout=?, name, f) => testU(name, (.) => f(), timeout);

  [@mel.val] [@mel.scope "test"]
  external testAsyncU:
    (string, (. unit) => Js.Promise.t(unit), option(int)) => unit =
    "only";

  let testAsync: (~timeout: int=?, string, unit => Js.Promise.t(unit)) => unit =
    (~timeout=?, name, f) => testAsyncU(name, (.) => f(), timeout);
};

module Skip = {
  [@mel.val] [@mel.scope "describe"]
  external describeU: (string, (. unit) => unit) => unit = "skip";

  let describe: (string, unit => unit) => unit =
    (name, f) => describeU(name, (.) => f());

  [@mel.val] [@mel.scope "test"]
  external testU: (string, (. unit) => unit, option(int)) => unit = "skip";

  let test: (~timeout: int=?, string, unit => unit) => unit =
    (~timeout=?, name, f) => testU(name, (.) => f(), timeout);

  [@mel.val] [@mel.scope "test"]
  external testAsyncU:
    (string, (. unit) => Js.Promise.t(unit), option(int)) => unit =
    "skip";

  let testAsync: (~timeout: int=?, string, unit => Js.Promise.t(unit)) => unit =
    (~timeout=?, name, f) => testAsyncU(name, (.) => f(), timeout);
};

[@mel.val] external beforeAllU: ((. unit) => unit) => unit = "beforeAll";

let beforeAll: (unit => unit) => unit = f => beforeAllU((.) => f());

[@mel.val] external beforeEachU: ((. unit) => unit) => unit = "beforeEach";

let beforeEach: (unit => unit) => unit = f => beforeEachU((.) => f());

[@mel.val] external afterAllU: ((. unit) => unit) => unit = "afterAll";

let afterAll: (unit => unit) => unit = f => afterAllU((.) => f());

[@mel.val] external afterEachU: ((. unit) => unit) => unit = "afterEach";

let afterEach: (unit => unit) => unit = f => afterEachU((.) => f());

[@mel.val]
external beforeAllAsyncU: ((. unit) => Js.Promise.t(unit)) => unit =
  "beforeAll";
let beforeAllAsync: (unit => Js.Promise.t(unit)) => unit =
  f => beforeAllAsyncU((.) => f());

[@mel.val]
external beforeEachAsyncU: ((. unit) => Js.Promise.t(unit)) => unit =
  "beforeEach";
let beforeEachAsync: (unit => Js.Promise.t(unit)) => unit =
  f => beforeEachAsyncU((.) => f());

[@mel.val]
external afterAllAsyncU: ((. unit) => Js.Promise.t(unit)) => unit =
  "afterAll";
let afterAllAsync: (unit => Js.Promise.t(unit)) => unit =
  f => afterAllAsyncU((.) => f());

[@mel.val]
external afterEachAsyncU: ((. unit) => Js.Promise.t(unit)) => unit =
  "afterEach";
let afterEachAsync: (unit => Js.Promise.t(unit)) => unit =
  f => afterEachAsyncU((.) => f());
