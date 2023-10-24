type element;
type componentLike('props, 'return) = 'props => 'return;
type component('props) = componentLike('props, element);

let null: element;
let float: float => element;
let int: int => element;
let string: string => element;
let array: array(element) => element;

/* this function exists to prepare for making `component` abstract */
let component: componentLike('props, element) => component('props);

let createElement: (component('props), 'props) => element;

let cloneElement: (element, 'props) => element;

let createElementVariadic:
  (component('props), 'props, array(element)) => element;

let jsxKeyed: (component('props), 'props, ~key: string=?, unit) => element;

let jsx: (component('props), 'props) => element;

let jsxs: (component('props), 'props) => element;

let jsxsKeyed: (component('props), 'props, ~key: string=?, unit) => element;

let jsxFragment: 'element;

type ref('value) = {mutable current: 'value};

module Ref: {
  [@deprecated "Please use the type React.ref instead"]
  type t('value) = ref('value);

  [@deprecated "Please directly read from ref.current instead"]
  let current: ref('value) => 'value;

  [@deprecated "Please directly assign to ref.current instead"]
  let setCurrent: (ref('value), 'value) => unit;
};

let createRef: unit => ref(Js.nullable('a));

module Children: {
  let map: (element, element => element) => element;

  let mapWithIndex: (element, (element, int) => element) => element;

  let forEach: (element, element => unit) => unit;

  let forEachWithIndex: (element, (element, int) => unit) => unit;

  let count: element => int;

  let only: element => element;

  let toArray: element => array(element);
};

module Context: {
  type t('props);

  let makeProps:
    (~value: 'props, ~children: element, unit) =>
    {
      .
      "value": 'props,
      "children": element,
    };

  let provider:
    t('props) =>
    component({
      .
      "value": 'props,
      "children": element,
    });
};

let createContext: 'a => Context.t('a);

let forwardRef:
  (('props, Js.Nullable.t(ref('a))) => element) => component('props);

let memo: component('props) => component('props);

let memoCustomCompareProps:
  (component('props), ('props, 'props) => bool) => component('props);

module Fragment: {
  let makeProps: (~children: element, unit) => {. "children": element};

  let make: component({. "children": element});
};

module StrictMode: {
  let makeProps: (~children: element, unit) => {. "children": element};

  let make: component({. "children": element});
};

module Suspense: {
  let makeProps:
    (~children: element=?, ~fallback: element=?, unit) =>
    {
      .
      "children": option(element),
      "fallback": option(element),
    };

  let make:
    component({
      .
      "children": option(element),
      "fallback": option(element),
    });
};

/* HOOKS */

/*
 * Yeah, we know this api isn't great. tl;dr: useReducer instead.
 * It's because useState can take functions or non-function values and treats
 * them differently. Lazy initializer + callback which returns state is the
 * only way to safely have any type of state and be able to update it correctly.
 */

let useState: (unit => 'state) => ('state, ('state => 'state) => unit);

let useReducer:
  (('state, 'action) => 'state, 'state) => ('state, 'action => unit);

let useReducerWithMapState:
  (('state, 'action) => 'state, 'initialState, 'initialState => 'state) =>
  ('state, 'action => unit);

let useSyncExternalStore:
  (
    ~subscribe: (unit => unit, unit) => unit,
    ~getSnapshot: unit => 'snapshot
  ) =>
  'snapshot;

let useSyncExternalStoreWithServer:
  (
    ~subscribe: (unit => unit, unit) => unit,
    ~getSnapshot: unit => 'snapshot,
    ~getServerSnapshot: unit => 'snapshot
  ) =>
  'snapshot;

let useEffect: (unit => option(unit => unit)) => unit;

let useEffect0: (unit => option(unit => unit)) => unit;

let useEffect1: (unit => option(unit => unit), array('a)) => unit;

let useEffect2: (unit => option(unit => unit), ('a, 'b)) => unit;

let useEffect3: (unit => option(unit => unit), ('a, 'b, 'c)) => unit;

let useEffect4: (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit;

let useEffect5: (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit;

let useEffect6:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit;

let useEffect7:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit;

let useInsertionEffect: (unit => option(unit => unit)) => unit;

let useInsertionEffect0: (unit => option(unit => unit)) => unit;

let useInsertionEffect1: (unit => option(unit => unit), array('a)) => unit;

let useInsertionEffect2: (unit => option(unit => unit), ('a, 'b)) => unit;

let useInsertionEffect3:
  (unit => option(unit => unit), ('a, 'b, 'c)) => unit;

let useInsertionEffect4:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit;

let useInsertionEffect5:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit;

let useInsertionEffect6:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit;

let useInsertionEffect7:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit;

let useLayoutEffect: (unit => option(unit => unit)) => unit;

let useLayoutEffect0: (unit => option(unit => unit)) => unit;

let useLayoutEffect1: (unit => option(unit => unit), array('a)) => unit;

let useLayoutEffect2: (unit => option(unit => unit), ('a, 'b)) => unit;

let useLayoutEffect3: (unit => option(unit => unit), ('a, 'b, 'c)) => unit;

let useLayoutEffect4:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit;

let useLayoutEffect5:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit;

let useLayoutEffect6:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit;

let useLayoutEffect7:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit;

let useMemo: (unit => 'any) => 'any;

let useMemo0: (unit => 'any) => 'any;

let useMemo1: (unit => 'any, array('a)) => 'any;

let useMemo2: (unit => 'any, ('a, 'b)) => 'any;

let useMemo3: (unit => 'any, ('a, 'b, 'c)) => 'any;

let useMemo4: (unit => 'any, ('a, 'b, 'c, 'd)) => 'any;

let useMemo5: (unit => 'any, ('a, 'b, 'c, 'd, 'e)) => 'any;

let useMemo6: (unit => 'any, ('a, 'b, 'c, 'd, 'e, 'f)) => 'any;

let useMemo7: (unit => 'any, ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'any;

/* This is used as return values  */
type callback('input, 'output) = 'input => 'output;

let useCallback: 'fn => 'fn;

let useCallback0: 'fn => 'fn;

let useCallback1: ('fn, array('a)) => 'fn;

let useCallback2: ('fn, ('a, 'b)) => 'fn;

let useCallback3: ('fn, ('a, 'b, 'c)) => 'fn;

let useCallback4: ('fn, ('a, 'b, 'c, 'd)) => 'fn;

let useCallback5: ('fn, ('a, 'b, 'c, 'd, 'e)) => 'fn;

let useCallback6: ('fn, ('a, 'b, 'c, 'd, 'e, 'f)) => 'fn;

let useCallback7: ('fn, ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'fn;

let useContext: Context.t('any) => 'any;

let useRef: 'value => ref('value);
let useId: unit => string;

let useDeferredValue: 'a => 'a;

let useImperativeHandle0:
  (Js.Nullable.t(ref('value)), unit => 'value) => unit;

let useImperativeHandle1:
  (Js.Nullable.t(ref('value)), unit => 'value, array('a)) => unit;

let useImperativeHandle2:
  (Js.Nullable.t(ref('value)), unit => 'value, ('a, 'b)) => unit;

let useImperativeHandle3:
  (Js.Nullable.t(ref('value)), unit => 'value, ('a, 'b, 'c)) => unit;

let useImperativeHandle4:
  (Js.Nullable.t(ref('value)), unit => 'value, ('a, 'b, 'c, 'd)) => unit;

let useImperativeHandle5:
  (Js.Nullable.t(ref('value)), unit => 'value, ('a, 'b, 'c, 'd, 'e)) => unit;

let useImperativeHandle6:
  (Js.Nullable.t(ref('value)), unit => 'value, ('a, 'b, 'c, 'd, 'e, 'f)) =>
  unit;

let useImperativeHandle7:
  (
    Js.Nullable.t(ref('value)),
    unit => 'value,
    ('a, 'b, 'c, 'd, 'e, 'f, 'g)
  ) =>
  unit;

module Uncurried: {
  let useState: (unit => 'state) => ('state, (. ('state => 'state)) => unit);

  let useReducer:
    (('state, 'action) => 'state, 'state) => ('state, (. 'action) => unit);

  let useReducerWithMapState:
    (('state, 'action) => 'state, 'initialState, 'initialState => 'state) =>
    ('state, (. 'action) => unit);

  /* This is used as return values */
  type callback('input, 'output) = (. 'input) => 'output;

  let useCallback: ('input => 'output) => callback('input, 'output);

  let useCallback0: ('input => 'output) => callback('input, 'output);

  let useCallback1:
    ('input => 'output, array('a)) => callback('input, 'output);

  let useCallback2:
    ('input => 'output, ('a, 'b)) => callback('input, 'output);

  let useCallback3:
    ('input => 'output, ('a, 'b, 'c)) => callback('input, 'output);

  let useCallback4:
    ('input => 'output, ('a, 'b, 'c, 'd)) => callback('input, 'output);

  let useCallback5:
    ('input => 'output, ('a, 'b, 'c, 'd, 'e)) => callback('input, 'output);

  let useCallback6:
    ('input => 'output, ('a, 'b, 'c, 'd, 'e, 'f)) =>
    callback('input, 'output);

  let useCallback7:
    ('input => 'output, ('a, 'b, 'c, 'd, 'e, 'f, 'g)) =>
    callback('input, 'output);
};

let useTransition: unit => (bool, callback(callback(unit, unit), unit));

module Experimental: {
  /* This module is used to bind to APIs for future versions of React. There is no guarantee of backwards compatibility or stability. */
  let use: Js.Promise.t('a) => 'a;
};

let setDisplayName: (component('props), string) => unit;

let displayName: component('props) => option(string);

let useDebugValue: ('value, ~format: 'value => string=?, unit) => unit;

module Event: {
  /* This is the whole synthetic event system of ReactJS/ReasonReact. The first module `Synthetic` represents
     the generic synthetic event. The rest are the specific ones.

     In each module, the type `t` commonly means "the type of that module" (OCaml convention). In our case, e.g.
     `ReactEvent.Mouse.t` represents a ReactJS synthetic mouse event. You'd use it to type your props:

     ```
     type props = {
       onClick: ReactEvent.Mouse.t => unit
     };
     ```

     All the methods and properties of a type of event are in the module, as seen below.

     Each module also has a `tag` type. You can ignore it; they're only needed by their `t` type. This way, we
     get to allow a base `Synthetic` event module with generic methods. So e.g. even a mouse event (`Mouse.t`)
     get to be passed to a generic handler:

     ```
     let handleClick = ({state, props}, event) => {
       ReactEvent.Mouse.preventDefault(event);
       ...
     };
     let handleSubmit = ({state, props}, event) => {
       /* this handler can be triggered by either a Keyboard or a Mouse event; conveniently use the generic
          preventDefault */
       ReactEvent.Synthetic.preventDefault(event);
       ...
     };

     let render = (_) => <Foo onSubmit=handleSubmit onEnter=handleSubmit .../>;
     ```

     How to translate idioms from ReactJS:

     1. myMouseEvent.preventDefault() -> ReactEvent.Mouse.preventDefault(myMouseEvent)
     2. myKeyboardEvent.which -> ReactEvent.Keyboard.which(myKeyboardEvent)
     */
  type synthetic('a);

  module Synthetic: {
    type tag;
    type t = synthetic(tag);
    let bubbles: synthetic('a) => bool;
    let cancelable: synthetic('a) => bool;

    let currentTarget: synthetic('a) => Js.t({..});

    let defaultPrevented: synthetic('a) => bool;
    let eventPhase: synthetic('a) => int;
    let isTrusted: synthetic('a) => bool;

    let nativeEvent: synthetic('a) => Js.t({..});

    let preventDefault: synthetic('a) => unit;

    let isDefaultPrevented: synthetic('a) => bool;

    let stopPropagation: synthetic('a) => unit;

    let isPropagationStopped: synthetic('a) => bool;
    let target: synthetic('a) => Js.t({..});
    let timeStamp: synthetic('a) => float;
    let type_: synthetic('a) => string;
    let persist: synthetic('a) => unit;
  };

  /* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
  let toSyntheticEvent: synthetic('a) => Synthetic.t;

  module Clipboard: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let clipboardData: t => Js.t({..}); /* Should return Dom.dataTransfer */
  };

  module Composition: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let data: t => string;
  };

  module Drag: {
    type tag;
    type t = synthetic(tag);

    // SyntheticEvent
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;

    // MouseEvent
    let altKey: t => bool;
    let button: t => int;
    let buttons: t => int;
    let clientX: t => int;
    let clientY: t => int;
    let ctrlKey: t => bool;

    let getModifierState: (t, string) => bool;
    let metaKey: t => bool;
    let movementX: t => int;
    let movementY: t => int;
    let pageX: t => int;
    let pageY: t => int;

    let relatedTarget: t => option(Js.t({..})); /* Should return Dom.eventTarget */
    let screenX: t => int;
    let screenY: t => int;
    let shiftKey: t => bool;

    let dataTransfer: t => Js.t({..}); /* Should return Dom.dataTransfer */
  };

  module Keyboard: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let altKey: t => bool;
    let charCode: t => int;
    let ctrlKey: t => bool;

    let getModifierState: (t, string) => bool;
    let key: t => string;
    let keyCode: t => int;
    let locale: t => string;
    let location: t => int;
    let metaKey: t => bool;
    let repeat: t => bool;
    let shiftKey: t => bool;
    let which: t => int;
  };

  module Focus: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;

    let relatedTarget: t => option(Js.t({..})); /* Should return Dom.eventTarget */
  };

  module Form: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
  };

  module Mouse: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let altKey: t => bool;
    let button: t => int;
    let buttons: t => int;
    let clientX: t => int;
    let clientY: t => int;
    let ctrlKey: t => bool;

    let getModifierState: (t, string) => bool;
    let metaKey: t => bool;
    let movementX: t => int;
    let movementY: t => int;
    let pageX: t => int;
    let pageY: t => int;

    let relatedTarget: t => option(Js.t({..})); /* Should return Dom.eventTarget */
    let screenX: t => int;
    let screenY: t => int;
    let shiftKey: t => bool;
  };

  module Pointer: {
    type tag;
    type t = synthetic(tag);

    // Event
    let type_: t => string;
    let target: t => Js.t({..});
    let currentTarget: t => Js.t({..});

    let eventPhase: t => int;

    let stopPropagation: t => unit; // aka cancelBubble
    let bubbles: t => bool;
    let cancelable: t => bool;
    let preventDefault: t => unit;
    let defaultPrevented: t => bool;

    let isTrusted: t => bool;
    let timeStamp: t => float;

    // SyntheticEvent
    let nativeEvent: t => Js.t({..});
    let isDefaultPrevented: t => bool;

    let isPropagationStopped: t => bool;
    let persist: t => unit;

    // UIEvent
    let detail: t => int;
    let view: t => Dom.window; /* Should return DOMAbstractView/WindowProxy */

    // MouseEvent
    let screenX: t => int;
    let screenY: t => int;
    let clientX: t => int;
    let clientY: t => int;
    let pageX: t => int;
    let pageY: t => int;
    let movementX: t => int;
    let movementY: t => int;

    let ctrlKey: t => bool;
    let shiftKey: t => bool;
    let altKey: t => bool;
    let metaKey: t => bool;

    let getModifierState: (t, string) => bool;

    let button: t => int;
    let buttons: t => int;

    let relatedTarget: t => option(Js.t({..})); /* Should return Dom.eventTarget */

    // PointerEvent
    let pointerId: t => Dom.eventPointerId;
    let width: t => float;
    let height: t => float;
    let pressure: t => float;
    let tangentialPressure: t => float;
    let tiltX: t => int;
    let tiltY: t => int;
    let twist: t => int;
    let pointerType: t => string;
    let isPrimary: t => bool;
  };

  module Selection: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
  };

  module Touch: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let altKey: t => bool;
    let changedTouches: t => Js.t({..}); /* Should return Dom.touchList */
    let ctrlKey: t => bool;

    let getModifierState: (t, string) => bool;
    let metaKey: t => bool;
    let shiftKey: t => bool;
    let targetTouches: t => Js.t({..}); /* Should return Dom.touchList */
    let touches: t => Js.t({..}); /* Should return Dom.touchList */
  };

  module UI: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let detail: t => int;
    let view: t => Dom.window; /* Should return DOMAbstractView/WindowProxy */
  };

  module Wheel: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let deltaMode: t => int;
    let deltaX: t => float;
    let deltaY: t => float;
    let deltaZ: t => float;
  };

  module Media: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
  };

  module Image: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
  };

  module Animation: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let animationName: t => string;
    let pseudoElement: t => string;
    let elapsedTime: t => float;
  };

  module Transition: {
    type tag;
    type t = synthetic(tag);
    let bubbles: t => bool;
    let cancelable: t => bool;
    let currentTarget: t => Js.t({..});
    let defaultPrevented: t => bool;
    let eventPhase: t => int;
    let isTrusted: t => bool;
    let nativeEvent: t => Js.t({..});
    let preventDefault: t => unit;
    let isDefaultPrevented: t => bool;
    let stopPropagation: t => unit;

    let isPropagationStopped: t => bool;
    let target: t => Js.t({..});
    let timeStamp: t => float;
    let type_: t => string;
    let persist: t => unit;
    let propertyName: t => string;
    let pseudoElement: t => string;
    let elapsedTime: t => float;
  };
};
