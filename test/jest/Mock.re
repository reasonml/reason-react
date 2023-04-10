type undefined = Js.undefined(unit);

let undefined: undefined = Js.Undefined.empty;

type mock('a);

type t('a) = mock('a);
[@bs.scope "jest"] [@bs.val] external fn: unit => 'a = "fn";
[@bs.scope "jest"] [@bs.val] external fnWithImplementation: 'a => 'a = "fn";
[@bs.scope "jest"] [@bs.val] external mockModule: string => unit = "mock";
external getMock: 'a => t('a) = "%identity";
[@bs.send]
external mockReturnValue: (t('a), 'b) => undefined = "mockReturnValue";
let mockReturnValue = (mock, value) => {
  let _ = mockReturnValue(mock, value);
  ();
};
[@bs.send]
external mockImplementation: (t('a), 'a) => undefined =
  "mockImplementation";
let mockImplementation = (mock, value) => {
  let _ = mockImplementation(mock, value);
  ();
};
[@bs.get] [@bs.scope "mock"]
external calls: t('a) => array(array('b)) = "calls";
[@bs.set] [@bs.scope "mock"]
external clearCalls: (t('a), [@bs.as {json|[]|json}] _) => unit = "calls";
