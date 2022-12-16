/**
 Types that are used throughout these test utilities. They should be opened in
 order to allow access to the necessary record fields when using `describe`, and
 `test`.
 */

module Counter: {
  type t;

  /**
 * Creates a new counter starting at 0.
 */
  let create: unit => t;

  /**
 * Creates a new counter starting at the given integer.
 */
  let startingAt: int => t;

  /**
 * Gets the next value of the counter. This function will never return the same
 * value for a particular counter twice. (Unless you overflow ints...).
 */
  let next: t => int;
};

module Types: {
  type matcherUtils = {tmp: unit};
  type matcherConfig('a, 'b) =
    (matcherUtils, unit => 'a, unit => 'b) => (unit => string, bool);
  type matcherResult('a, 'b) = (unit => 'a, unit => 'b) => unit;
  type createMatcher('a, 'b) =
    matcherConfig('a, 'b) => matcherResult('a, 'b);
  type extendUtils = {createMatcher: 'a 'b. createMatcher('a, 'b)};
  type stringUtils = {
    toBeEmpty: unit => unit,
    toEqual: string => unit,
  };
  type stringUtilsWithNot = {
    toBeEmpty: unit => unit,
    toEqual: string => unit,
    toMatchSnapshot: unit => unit,
    not: stringUtils,
  };
  type valueUtils('a) = {toEqual: string => unit};
  type valueUtilsWithNot('a) = {
    toEqual: 'a => unit,
    toMatchSnapshot: unit => unit,
    not: valueUtils('a),
  };
  type boolUtils = {
    toBe: bool => unit,
    toBeTrue: unit => unit,
    toBeFalse: unit => unit,
  };
  type boolUtilsWithNot = {
    toBe: bool => unit,
    toBeTrue: unit => unit,
    toBeFalse: unit => unit,
    not: boolUtils,
  };
  type intUtils = {toBe: int => unit};
  type intUtilsWithNot = {
    toBe: int => unit,
    not: intUtils,
  };
  type floatUtils = {toBeCloseTo: (~digits: int=?, float) => unit};
  type floatUtilsWithNot = {
    toBeCloseTo: (~digits: int=?, float) => unit,
    not: floatUtils,
  };
  type collectionKind('a) =
    | String: collectionKind(string)
    | Bool: collectionKind(bool)
    | Int: collectionKind(int)
    /* TODO: Accept precision here for floats. */
    | Float: collectionKind(float)
    | Custom(('a, 'a) => bool): collectionKind('a);
  type listOfUtils('a) = {toEqual: list('a) => unit};
  type listOfUtilsWithNot('a) = {
    toEqual: list('a) => unit,
    not: listOfUtils('a),
  };
  type arrayOfUtils('a) = {toEqual: array('a) => unit};
  type arrayOfUtilsWithNot('a) = {
    toEqual: array('a) => unit,
    not: arrayOfUtils('a),
  };
  type expectUtils('ext) = {
    value: 'a. 'a => valueUtilsWithNot('a),
    string: string => stringUtilsWithNot,
    bool: bool => boolUtilsWithNot,
    int: int => intUtilsWithNot,
    float: float => floatUtilsWithNot,
    listOf: 'a. (collectionKind('a), list('a)) => listOfUtilsWithNot('a),
    arrayOf: 'a. (collectionKind('a), array('a)) => arrayOfUtilsWithNot('a),
    ext: 'ext,
  };
  type testUtils('ext) = {
    expect: expectUtils('ext),
    expectTrue: bool => unit,
    expectFalse: bool => unit,
    expectEqual: 'a. ('a, 'a) => unit,
    expectNotEqual: 'a. ('a, 'a) => unit,
    expectSame: 'a. ('a, 'a) => unit,
    expectNotSame: 'a. ('a, 'a) => unit,
  };
  type testAsyncUtils('ext) = {
    callback: unit => unit,
    expect: expectUtils('ext),
    expectTrue: bool => unit,
    expectFalse: bool => unit,
    expectEqual: 'a. ('a, 'a) => unit,
    expectNotEqual: 'a. ('a, 'a) => unit,
    expectSame: 'a. ('a, 'a) => unit,
    expectNotSame: 'a. ('a, 'a) => unit,
  };
  type testAsync('ext) = (string, testAsyncUtils('ext) => unit) => unit;
  /**
 `test` is used to create a single unit test, all of the functionality being
 tested in a single `test` should be related. An `expect` function is exposed
 in order to make assertions.

 The underlying JS implementation uses Jest's `test` funciton.

 ```
 test("add", ({expect}) => {
   expect.int(MyMath.add(3, 4)).toBe(7);
 });
 ```
   */
  type test('ext) = (string, testUtils('ext) => unit) => unit;
  type describeUtils('ext) = {
    beforeEach: (unit => unit) => unit,
    afterEach: (unit => unit) => unit,
    beforeAll: (unit => unit) => unit,
    test: test('ext),
    testAsync: testAsync('ext),
    testOnly: test('ext),
    testSkip: test('ext),
    testTodo: string => unit,
  };
  type describeFn('ext) = (string, describeUtils('ext) => unit) => unit;

  type extensionResult('ext) = {describe: describeFn('ext)};
};

open Types;

let extendDescribe: (extendUtils => 'ext) => extensionResult('ext);

/**
 `describe` is the entry point for creating tests. It exposes a `test` function
 and other utilties that can create tests.

 The underlying JS implementation uses Jest's `describe` funciton.

 ```
 describe("MyMath", ({test}) => {
   test("add", ({expect}) => {
     expect.int(MyMath.add(3, 4)).toBe(7);
   });
 });
 ```
 */
let describe: (string, describeUtils(unit) => unit) => unit;

/**
 Resets all modules. This is exactly the same as calling `jest.resetModules()`
 in JS.
 */
let resetModules: unit => unit;

let resetAllMocks: unit => unit;

module Mock: {
  type t('a);
  [@bs.scope "jest"] [@bs.val] external fn: unit => 'a = "fn";
  [@bs.scope "jest"] [@bs.val] external fnWithImplementation: 'a => 'a = "fn";
  [@bs.scope "jest"] [@bs.val] external mockModule: string => unit = "mock";
  external getMock: 'a => t('a) = "%identity";
  let mockReturnValue: (t('a), 'b) => unit;
  let mockImplementation: (t('a), 'a) => unit;
  [@bs.get] [@bs.scope "mock"]
  external calls: t('a) => array(array('b)) = "calls";
  [@bs.set] [@bs.scope "mock"]
  external clearCalls: (t('a), [@bs.as {json|[]|json}] _) => unit = "calls";
};
