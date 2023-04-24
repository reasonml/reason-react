module Expect = Expect;
module Mock = Mock;

// Jest requires a function of *no arguments* to be passed into `describe`,
// hence the uncurried function.
[@bs.val] external describeU: (string, (. unit) => unit) => unit = "describe";

let describe: (string, unit => unit) => unit =
  (name, f) => describeU(name, (.) => f());

// Tests have an optional timeout (third argument)
[@bs.val]
external testU: (string, (. unit) => unit, option(int)) => unit = "test";

let test: (~timeout: int=?, string, unit => unit) => unit =
  (~timeout=?, name, f) => testU(name, (.) => f(), timeout);

[@bs.val]
external testAsyncU:
  (string, (. unit) => Js.Promise.t(unit), option(int)) => unit =
  "test";

let testAsync: (~timeout: int=?, string, unit => Js.Promise.t(unit)) => unit =
  (~timeout=?, name, f) => testAsyncU(name, (.) => f(), timeout);

module Only = {
  [@bs.val] [@bs.scope "describe"]
  external describeU: (string, (. unit) => unit) => unit = "only";

  let describe: (string, unit => unit) => unit =
    (name, f) => describeU(name, (.) => f());

  [@bs.val] [@bs.scope "test"]
  external testU: (string, (. unit) => unit, option(int)) => unit = "only";

  let test: (~timeout: int=?, string, unit => unit) => unit =
    (~timeout=?, name, f) => testU(name, (.) => f(), timeout);

  [@bs.val] [@bs.scope "test"]
  external testAsyncU:
    (string, (. unit) => Js.Promise.t(unit), option(int)) => unit =
    "only";

  let testAsync: (~timeout: int=?, string, unit => Js.Promise.t(unit)) => unit =
    (~timeout=?, name, f) => testAsyncU(name, (.) => f(), timeout);
};

module Skip = {
  [@bs.val] [@bs.scope "describe"]
  external describeU: (string, (. unit) => unit) => unit = "skip";

  let describe: (string, unit => unit) => unit =
    (name, f) => describeU(name, (.) => f());

  [@bs.val] [@bs.scope "test"]
  external testU: (string, (. unit) => unit, option(int)) => unit = "skip";

  let test: (~timeout: int=?, string, unit => unit) => unit =
    (~timeout=?, name, f) => testU(name, (.) => f(), timeout);

  [@bs.val] [@bs.scope "test"]
  external testAsyncU:
    (string, (. unit) => Js.Promise.t(unit), option(int)) => unit =
    "skip";

  let testAsync: (~timeout: int=?, string, unit => Js.Promise.t(unit)) => unit =
    (~timeout=?, name, f) => testAsyncU(name, (.) => f(), timeout);
};

[@bs.val] external beforeAllU: ((. unit) => unit) => unit = "beforeAll";

let beforeAll: (unit => unit) => unit = f => beforeAllU((.) => f());

[@bs.val] external beforeEachU: ((. unit) => unit) => unit = "beforeEach";

let beforeEach: (unit => unit) => unit = f => beforeEachU((.) => f());

[@bs.val] external afterAllU: ((. unit) => unit) => unit = "afterAll";

let afterAll: (unit => unit) => unit = f => afterAllU((.) => f());

[@bs.val] external afterEachU: ((. unit) => unit) => unit = "afterEach";

let afterEach: (unit => unit) => unit = f => afterEachU((.) => f());

[@bs.val]
external beforeAllAsyncU: ((. unit) => Js.Promise.t(unit)) => unit =
  "beforeAll";
let beforeAllAsync: (unit => Js.Promise.t(unit)) => unit =
  f => beforeAllAsyncU((.) => f());

[@bs.val]
external beforeEachAsyncU: ((. unit) => Js.Promise.t(unit)) => unit =
  "beforeEach";
let beforeEachAsync: (unit => Js.Promise.t(unit)) => unit =
  f => beforeEachAsyncU((.) => f());

[@bs.val]
external afterAllAsyncU: ((. unit) => Js.Promise.t(unit)) => unit =
  "afterAll";
let afterAllAsync: (unit => Js.Promise.t(unit)) => unit =
  f => afterAllAsyncU((.) => f());

[@bs.val]
external afterEachAsyncU: ((. unit) => Js.Promise.t(unit)) => unit =
  "afterEach";
let afterEachAsync: (unit => Js.Promise.t(unit)) => unit =
  f => afterEachAsyncU((.) => f());
