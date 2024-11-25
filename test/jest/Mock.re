type undefined = Js.undefined(unit);

let undefined: undefined = Js.Undefined.empty;

type mock('a);

type t('a) = mock('a);
[@mel.scope "jest"] external fn: [@mel.unwrap] (unit => 'a) = "fn";
[@mel.scope "jest"] external fnWithImplementation: 'a => 'a = "fn";
[@mel.scope "jest"] external mockModule: string => unit = "mock";
external getMock: 'a => t('a) = "%identity";
[@mel.send]
external mockReturnValue: (t('a), 'b) => undefined = "mockReturnValue";
let mockReturnValue = (mock, value) => {
  let _ = mockReturnValue(mock, value);
  ();
};
[@mel.send]
external mockImplementation: (t('a), 'a) => undefined = "mockImplementation";
let mockImplementation = (mock, value) => {
  let _ = mockImplementation(mock, value);
  ();
};
[@mel.get] [@mel.scope "mock"]
external calls: t('a) => array(array('b)) = "calls";
[@mel.get] [@mel.scope "mock"] [@mel.return nullable]
external lastCall: t('a) => option(array('b)) = "lastCall";
[@mel.set] [@mel.scope "mock"]
external clearCalls: (t('a), [@mel.as {json|[]|json}] _) => unit = "calls";
