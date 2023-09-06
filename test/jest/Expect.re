type t('a);

external expect: 'a => t('a) = "expect";

[@mel.send] external toEqual: (t('a), 'a) => unit = "toEqual";
[@mel.send] external toBe: (t('a), 'a) => unit = "toBe";
[@mel.get] external not: t('a) => t('a) = "not";
[@mel.send]
external toMatchSnapshot: (t('a), unit) => unit = "toMatchSnapshot";

[@mel.send] external toThrowSomething: t('a => 'b) => unit = "toThrow";

[@mel.send] external toBeGreaterThan: (t('a), 'a) => unit = "toBeGreaterThan";
[@mel.send] external toBeLessThan: (t('a), 'a) => unit = "toBeLessThan";
[@mel.send]
external toBeGreaterThanOrEqual: (t('a), 'a) => unit =
  "toBeGreaterThanOrEqual";
[@mel.send]
external toBeLessThanOrEqual: (t('a), 'a) => unit = "toBeLessThanOrEqual";

[@mel.get]
external rejects: t(Js.Promise.t('a)) => t(unit => 'a) = "rejects";

[@mel.send] external toContain: (t(array('a)), 'a) => unit = "toContain";

// This isn't a real string, but it can be used to construct a predicate on a string
// expect("hello world")->toEqual(stringContaining("hello"));
[@mel.scope "expect"]
external stringContaining: string => string = "stringContaining";

// This isn't a real array, but it can be used to construct a predicate on an array
// expect([|"x", "y", "z"|])->toEqual(arrayContaining([|"x", "z"|]))
[@mel.scope "expect"]
external arrayContaining: array('a) => array('a) = "arrayContaining";
