/* Old code. See ReactEvent.re for documentation. */
[@deprecated "Please use ReactEvent.synthetic"]
type synthetic('a) = ReactEvent.synthetic('a);

module Synthetic: {
  [@deprecated "Please use ReactEvent.Synthetic.tag"]
  type tag = ReactEvent.Synthetic.tag;
  [@deprecated "Please use ReactEvent.Synthetic.t"]
  type t = ReactEvent.Synthetic.t;
  [@deprecated "Please use ReactEvent.Synthetic.bubbles"] [@bs.get]
  external bubbles: ReactEvent.synthetic('a) => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Synthetic.cancelable"] [@bs.get]
  external cancelable: ReactEvent.synthetic('a) => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Synthetic.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.synthetic('a) => Dom.element =
    "currentTarget";
  [@deprecated "Please use ReactEvent.Synthetic.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.synthetic('a) => bool =
    "defaultPrevented";
  [@deprecated "Please use ReactEvent.Synthetic.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.synthetic('a) => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Synthetic.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.synthetic('a) => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Synthetic.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.synthetic('a) => Js.t({..}) =
    "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Synthetic.preventDefault"]
  [@bs.send.pipe: ReactEvent.synthetic('a)]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Synthetic.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.synthetic('a)]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Synthetic.stopPropagation"]
  [@bs.send.pipe: ReactEvent.synthetic('a)]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Synthetic.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.synthetic('a)]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Synthetic.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.synthetic('a) => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Synthetic.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.synthetic('a) => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Synthetic.type_"] [@bs.get]
  external _type: ReactEvent.synthetic('a) => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Synthetic.persist"]
  [@bs.send.pipe: ReactEvent.synthetic('a)]
  external persist: unit = "persist";
};

/* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
[@deprecated "Please use ReactEvent.toSyntheticEvent"]
external toSyntheticEvent: ReactEvent.synthetic('a) => ReactEvent.Synthetic.t =
  "%identity";

module Clipboard: {
  [@deprecated "Please use ReactEvent.Clipboard.tag"]
  type tag = ReactEvent.Clipboard.tag;
  [@deprecated "Please use ReactEvent.Clipboard.tag"]
  type t = ReactEvent.Clipboard.t;
  [@deprecated "Please use ReactEvent.Clipboard.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Clipboard.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Clipboard.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Clipboard.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Clipboard.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Clipboard.t => Dom.element =
    "currentTarget";
  [@deprecated "Please use ReactEvent.Clipboard.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Clipboard.t => bool =
    "defaultPrevented";
  [@deprecated "Please use ReactEvent.Clipboard.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Clipboard.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Clipboard.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Clipboard.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Clipboard.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Clipboard.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Clipboard.preventDefault"]
  [@bs.send.pipe: ReactEvent.Clipboard.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Clipboard.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Clipboard.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Clipboard.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Clipboard.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Clipboard.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Clipboard.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Clipboard.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Clipboard.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Clipboard.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Clipboard.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Clipboard.type_"] [@bs.get]
  external _type: ReactEvent.Clipboard.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Clipboard.persist"]
  [@bs.send.pipe: ReactEvent.Clipboard.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.Clipboard.clipboardData"] [@bs.get]
  external clipboardData: ReactEvent.Clipboard.t => Js.t({..}) =
    "clipboardData"; /* Should return Dom.dataTransfer */
};

module Composition: {
  [@deprecated "Please use ReactEvent.Composition.tag"]
  type tag = ReactEvent.Composition.tag;
  [@deprecated "Please use ReactEvent.Composition.t"]
  type t = ReactEvent.Composition.t;
  [@deprecated "Please use ReactEvent.Composition.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Composition.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Composition.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Composition.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Composition.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Composition.t => Dom.element =
    "currentTarget";
  [@deprecated "Please use ReactEvent.Composition.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Composition.t => bool =
    "defaultPrevented";
  [@deprecated "Please use ReactEvent.Composition.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Composition.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Composition.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Composition.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Composition.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Composition.t => Js.t({..}) =
    "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Composition.preventDefault"]
  [@bs.send.pipe: ReactEvent.Composition.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Composition.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Composition.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Composition.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Composition.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated
    "Please use myEvent->ReactEvent.Composition.isPropagationStopped"
  ]
  [@bs.send.pipe: ReactEvent.Composition.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Composition.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Composition.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Composition.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Composition.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Composition.type_"] [@bs.get]
  external _type: ReactEvent.Composition.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Composition.persist"]
  [@bs.send.pipe: ReactEvent.Composition.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.Composition.data"] [@bs.get]
  external data: ReactEvent.Composition.t => string = "data";
};

module Keyboard: {
  [@deprecated "Please use ReactEvent.Keyboard.tag"]
  type tag = ReactEvent.Keyboard.tag;
  [@deprecated "Please use ReactEvent.Keyboard.t"]
  type t = ReactEvent.Keyboard.t;
  [@deprecated "Please use ReactEvent.Keyboard.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Keyboard.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Keyboard.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Keyboard.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Keyboard.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Keyboard.t => Dom.element =
    "currentTarget";
  [@deprecated "Please use ReactEvent.Keyboard.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Keyboard.t => bool =
    "defaultPrevented";
  [@deprecated "Please use ReactEvent.Keyboard.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Keyboard.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Keyboard.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Keyboard.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Keyboard.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Keyboard.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Keyboard.preventDefault"]
  [@bs.send.pipe: ReactEvent.Keyboard.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Keyboard.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Keyboard.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Keyboard.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Keyboard.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Keyboard.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Keyboard.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Keyboard.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Keyboard.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Keyboard.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Keyboard.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Keyboard.type_"] [@bs.get]
  external _type: ReactEvent.Keyboard.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Keyboard.persist"]
  [@bs.send.pipe: ReactEvent.Keyboard.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.Keyboard.altKey"] [@bs.get]
  external altKey: ReactEvent.Keyboard.t => bool = "altKey";
  [@deprecated "Please use ReactEvent.Keyboard.charCode"] [@bs.get]
  external charCode: ReactEvent.Keyboard.t => int = "charCode";
  [@deprecated "Please use ReactEvent.Keyboard.ctrlKey"] [@bs.get]
  external ctrlKey: ReactEvent.Keyboard.t => bool = "ctrlKey";
  [@deprecated "Please use myEvent->ReactEvent.Keyboard.getModifierState"]
  [@bs.send.pipe: ReactEvent.Keyboard.t]
  external getModifierState: string => bool = "getModifierState";
  [@deprecated "Please use ReactEvent.Keyboard.key"] [@bs.get]
  external key: ReactEvent.Keyboard.t => string = "key";
  [@deprecated "Please use ReactEvent.Keyboard.keyCode"] [@bs.get]
  external keyCode: ReactEvent.Keyboard.t => int = "keyCode";
  [@deprecated "Please use ReactEvent.Keyboard.locale"] [@bs.get]
  external locale: ReactEvent.Keyboard.t => string = "locale";
  [@deprecated "Please use ReactEvent.Keyboard.location"] [@bs.get]
  external location: ReactEvent.Keyboard.t => int = "location";
  [@deprecated "Please use ReactEvent.Keyboard.metaKey"] [@bs.get]
  external metaKey: ReactEvent.Keyboard.t => bool = "metaKey";
  [@deprecated "Please use ReactEvent.Keyboard.repeat"] [@bs.get]
  external repeat: ReactEvent.Keyboard.t => bool = "repeat";
  [@deprecated "Please use ReactEvent.Keyboard.shiftKey"] [@bs.get]
  external shiftKey: ReactEvent.Keyboard.t => bool = "shiftKey";
  [@deprecated "Please use ReactEvent.Keyboard.which"] [@bs.get]
  external which: ReactEvent.Keyboard.t => int = "which";
};

module Focus: {
  [@deprecated "Please use ReactEvent.Focus.tag"]
  type tag = ReactEvent.Focus.tag;
  [@deprecated "Please use ReactEvent.Focus.t"]
  type t = ReactEvent.Focus.t;
  [@deprecated "Please use ReactEvent.Focus.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Focus.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Focus.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Focus.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Focus.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Focus.t => Dom.element = "currentTarget";
  [@deprecated "Please use ReactEvent.Focus.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Focus.t => bool = "defaultPrevented";
  [@deprecated "Please use ReactEvent.Focus.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Focus.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Focus.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Focus.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Focus.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Focus.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Focus.preventDefault"]
  [@bs.send.pipe: ReactEvent.Focus.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Focus.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Focus.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Focus.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Focus.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Focus.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Focus.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Focus.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Focus.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Focus.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Focus.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Focus.type_"] [@bs.get]
  external _type: ReactEvent.Focus.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Focus.persist"]
  [@bs.send.pipe: ReactEvent.Focus.t]
  external persist: unit = "persist";
  [@deprecated
    "Please use ReactEvent.Focus.relatedTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external relatedTarget: ReactEvent.Focus.t => Dom.element = "relatedTarget"; /* Should return Dom.eventTarget */
};

module Form: {
  [@deprecated "Please use ReactEvent.Form.tag"]
  type tag = ReactEvent.Form.tag;
  [@deprecated "Please use ReactEvent.Form.t"]
  type t = ReactEvent.Form.t;
  [@deprecated "Please use ReactEvent.Form.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Form.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Form.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Form.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Form.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Form.t => Dom.element = "currentTarget";
  [@deprecated "Please use ReactEvent.Form.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Form.t => bool = "defaultPrevented";
  [@deprecated "Please use ReactEvent.Form.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Form.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Form.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Form.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Form.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Form.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Form.preventDefault"]
  [@bs.send.pipe: ReactEvent.Form.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Form.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Form.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Form.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Form.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Form.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Form.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Form.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Form.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Form.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Form.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Form.type_"] [@bs.get]
  external _type: ReactEvent.Form.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Form.persist"]
  [@bs.send.pipe: ReactEvent.Form.t]
  external persist: unit = "persist";
};

module Mouse: {
  [@deprecated "Please use ReactEvent.Mouse.tag"]
  type tag = ReactEvent.Mouse.tag;
  [@deprecated "Please use ReactEvent.Mouse.t"]
  type t = ReactEvent.Mouse.t;
  [@deprecated "Please use ReactEvent.Mouse.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Mouse.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Mouse.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Mouse.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Mouse.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Mouse.t => Dom.element = "currentTarget";
  [@deprecated "Please use ReactEvent.Mouse.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Mouse.t => bool = "defaultPrevented";
  [@deprecated "Please use ReactEvent.Mouse.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Mouse.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Mouse.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Mouse.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Mouse.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Mouse.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Mouse.preventDefault"]
  [@bs.send.pipe: ReactEvent.Mouse.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Mouse.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Mouse.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Mouse.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Mouse.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Mouse.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Mouse.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Mouse.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Mouse.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Mouse.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Mouse.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Mouse.type_"] [@bs.get]
  external _type: ReactEvent.Mouse.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Mouse.persist"]
  [@bs.send.pipe: ReactEvent.Mouse.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.Mouse.altKey"] [@bs.get]
  external altKey: ReactEvent.Mouse.t => bool = "altKey";
  [@deprecated "Please use ReactEvent.Mouse.button"] [@bs.get]
  external button: ReactEvent.Mouse.t => int = "button";
  [@deprecated "Please use ReactEvent.Mouse.buttons"] [@bs.get]
  external buttons: ReactEvent.Mouse.t => int = "buttons";
  [@deprecated "Please use ReactEvent.Mouse.clientX"] [@bs.get]
  external clientX: ReactEvent.Mouse.t => int = "clientX";
  [@deprecated "Please use ReactEvent.Mouse.clientY"] [@bs.get]
  external clientY: ReactEvent.Mouse.t => int = "clientY";
  [@deprecated "Please use ReactEvent.Mouse.ctrlKey"] [@bs.get]
  external ctrlKey: ReactEvent.Mouse.t => bool = "ctrlKey";
  [@deprecated "Please use myEvent->ReactEvent.Mouse.getModifierState"]
  [@bs.send.pipe: ReactEvent.Mouse.t]
  external getModifierState: string => bool = "getModifierState";
  [@deprecated "Please use ReactEvent.Mouse.metaKey"] [@bs.get]
  external metaKey: ReactEvent.Mouse.t => bool = "metaKey";
  [@deprecated "Please use ReactEvent.Mouse.pageX"] [@bs.get]
  external pageX: ReactEvent.Mouse.t => int = "pageX";
  [@deprecated "Please use ReactEvent.Mouse.pageY"] [@bs.get]
  external pageY: ReactEvent.Mouse.t => int = "pageY";
  [@deprecated
    "Please use ReactEvent.Mouse.relatedTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external relatedTarget: ReactEvent.Mouse.t => Dom.element = "relatedTarget"; /* Should return Dom.eventTarget */
  [@deprecated "Please use ReactEvent.Mouse.screenX"] [@bs.get]
  external screenX: ReactEvent.Mouse.t => int = "screenX";
  [@deprecated "Please use ReactEvent.Mouse.screenY"] [@bs.get]
  external screenY: ReactEvent.Mouse.t => int = "screenY";
  [@deprecated "Please use ReactEvent.Mouse.shiftKey"] [@bs.get]
  external shiftKey: ReactEvent.Mouse.t => bool = "shiftKey";
};

module Selection: {
  [@deprecated "Please use ReactEvent.Selection.tag"]
  type tag = ReactEvent.Selection.tag;
  [@deprecated "Please use ReactEvent.Selection.t"]
  type t = ReactEvent.Selection.t;
  [@deprecated "Please use ReactEvent.Selection.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Selection.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Selection.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Selection.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Selection.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Selection.t => Dom.element =
    "currentTarget";
  [@deprecated "Please use ReactEvent.Selection.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Selection.t => bool =
    "defaultPrevented";
  [@deprecated "Please use ReactEvent.Selection.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Selection.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Selection.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Selection.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Selection.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Selection.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Selection.preventDefault"]
  [@bs.send.pipe: ReactEvent.Selection.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Selection.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Selection.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Selection.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Selection.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Selection.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Selection.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Selection.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Selection.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Selection.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Selection.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Selection.type_"] [@bs.get]
  external _type: ReactEvent.Selection.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Selection.persist"]
  [@bs.send.pipe: ReactEvent.Selection.t]
  external persist: unit = "persist";
};

module Touch: {
  [@deprecated "Please use ReactEvent.Touch.tag"]
  type tag = ReactEvent.Touch.tag;
  [@deprecated "Please use ReactEvent.Touch.t"]
  type t = ReactEvent.Touch.t;
  [@deprecated "Please use ReactEvent.Touch.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Touch.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Touch.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Touch.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Touch.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Touch.t => Dom.element = "currentTarget";
  [@deprecated "Please use ReactEvent.Touch.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Touch.t => bool = "defaultPrevented";
  [@deprecated "Please use ReactEvent.Touch.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Touch.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Touch.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Touch.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Touch.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Touch.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Touch.preventDefault"]
  [@bs.send.pipe: ReactEvent.Touch.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Touch.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Touch.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Touch.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Touch.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Touch.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Touch.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Touch.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Touch.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Touch.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Touch.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Touch.type_"] [@bs.get]
  external _type: ReactEvent.Touch.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Touch.persist"]
  [@bs.send.pipe: ReactEvent.Touch.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.Touch.altKey"] [@bs.get]
  external altKey: ReactEvent.Touch.t => bool = "altKey";
  [@deprecated "Please use ReactEvent.Touch.changedTouches"] [@bs.get]
  external changedTouches: ReactEvent.Touch.t => Js.t({..}) =
    "changedTouches"; /* Should return Dom.touchList */
  [@deprecated "Please use ReactEvent.Touch.ctrlKey"] [@bs.get]
  external ctrlKey: ReactEvent.Touch.t => bool = "ctrlKey";
  [@deprecated "Please use myEvent->ReactEvent.Touch.getModifierState"]
  [@bs.send.pipe: ReactEvent.Touch.t]
  external getModifierState: string => bool = "getModifierState";
  [@deprecated "Please use ReactEvent.Touch.metaKey"] [@bs.get]
  external metaKey: ReactEvent.Touch.t => bool = "metaKey";
  [@deprecated "Please use ReactEvent.Touch.shiftKey"] [@bs.get]
  external shiftKey: ReactEvent.Touch.t => bool = "shiftKey";
  [@deprecated "Please use ReactEvent.Touch.targetTouches"] [@bs.get]
  external targetTouches: ReactEvent.Touch.t => Js.t({..}) = "targetTouches"; /* Should return Dom.touchList */
  [@deprecated "Please use ReactEvent.Touch.touches"] [@bs.get]
  external touches: ReactEvent.Touch.t => Js.t({..}) = "touches"; /* Should return Dom.touchList */
};

module UI: {
  [@deprecated "Please use ReactEvent.UI.tag"]
  type tag = ReactEvent.UI.tag;
  [@deprecated "Please use ReactEvent.UI.t"]
  type t = ReactEvent.UI.t;
  [@deprecated "Please use ReactEvent.UI.bubbles"] [@bs.get]
  external bubbles: ReactEvent.UI.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.UI.cancelable"] [@bs.get]
  external cancelable: ReactEvent.UI.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.UI.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.UI.t => Dom.element = "currentTarget";
  [@deprecated "Please use ReactEvent.UI.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.UI.t => bool = "defaultPrevented";
  [@deprecated "Please use ReactEvent.UI.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.UI.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.UI.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.UI.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.UI.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.UI.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.UI.preventDefault"]
  [@bs.send.pipe: ReactEvent.UI.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.UI.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.UI.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.UI.stopPropagation"]
  [@bs.send.pipe: ReactEvent.UI.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.UI.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.UI.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.UI.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.UI.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.UI.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.UI.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.UI.type_"] [@bs.get]
  external _type: ReactEvent.UI.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.UI.persist"]
  [@bs.send.pipe: ReactEvent.UI.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.UI.detail"] [@bs.get]
  external detail: ReactEvent.UI.t => int = "detail";
  [@deprecated "Please use ReactEvent.UI.view"] [@bs.get]
  external view: ReactEvent.UI.t => Dom.window = "view"; /* Should return DOMAbstractView/WindowProxy */
};

module Wheel: {
  [@deprecated "Please use ReactEvent.Wheel.tag"]
  type tag = ReactEvent.Wheel.tag;
  [@deprecated "Please use ReactEvent.Wheel.t"]
  type t = ReactEvent.Wheel.t;
  [@deprecated "Please use ReactEvent.Wheel.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Wheel.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Wheel.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Wheel.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Wheel.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Wheel.t => Dom.element = "currentTarget";
  [@deprecated "Please use ReactEvent.Wheel.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Wheel.t => bool = "defaultPrevented";
  [@deprecated "Please use ReactEvent.Wheel.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Wheel.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Wheel.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Wheel.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Wheel.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Wheel.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Wheel.preventDefault"]
  [@bs.send.pipe: ReactEvent.Wheel.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Wheel.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Wheel.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Wheel.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Wheel.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Wheel.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Wheel.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Wheel.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Wheel.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Wheel.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Wheel.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Wheel.type_"] [@bs.get]
  external _type: ReactEvent.Wheel.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Wheel.persist"]
  [@bs.send.pipe: ReactEvent.Wheel.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.Wheel.deltaMode"] [@bs.get]
  external deltaMode: ReactEvent.Wheel.t => int = "deltaMode";
  [@deprecated "Please use ReactEvent.Wheel.deltaX"] [@bs.get]
  external deltaX: ReactEvent.Wheel.t => float = "deltaX";
  [@deprecated "Please use ReactEvent.Wheel.deltaY"] [@bs.get]
  external deltaY: ReactEvent.Wheel.t => float = "deltaY";
  [@deprecated "Please use ReactEvent.Wheel.deltaZ"] [@bs.get]
  external deltaZ: ReactEvent.Wheel.t => float = "deltaZ";
};

module Media: {
  [@deprecated "Please use ReactEvent.Media.tag"]
  type tag = ReactEvent.Media.tag;
  [@deprecated "Please use ReactEvent.Media.t"]
  type t = ReactEvent.Media.t;
  [@deprecated "Please use ReactEvent.Media.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Media.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Media.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Media.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Media.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Media.t => Dom.element = "currentTarget";
  [@deprecated "Please use ReactEvent.Media.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Media.t => bool = "defaultPrevented";
  [@deprecated "Please use ReactEvent.Media.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Media.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Media.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Media.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Media.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Media.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Media.preventDefault"]
  [@bs.send.pipe: ReactEvent.Media.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Media.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Media.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Media.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Media.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Media.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Media.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Media.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Media.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Media.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Media.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Media.type_"] [@bs.get]
  external _type: ReactEvent.Media.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Media.persist"]
  [@bs.send.pipe: ReactEvent.Media.t]
  external persist: unit = "persist";
};

module Image: {
  [@deprecated "Please use ReactEvent.Image.tag"]
  type tag = ReactEvent.Image.tag;
  [@deprecated "Please use ReactEvent.Image.t"]
  type t = ReactEvent.Image.t;
  [@deprecated "Please use ReactEvent.Image.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Image.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Image.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Image.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Image.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Image.t => Dom.element = "currentTarget";
  [@deprecated "Please use ReactEvent.Image.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Image.t => bool = "defaultPrevented";
  [@deprecated "Please use ReactEvent.Image.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Image.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Image.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Image.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Image.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Image.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Image.preventDefault"]
  [@bs.send.pipe: ReactEvent.Image.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Image.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Image.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Image.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Image.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Image.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Image.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Image.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Image.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Image.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Image.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Image.type_"] [@bs.get]
  external _type: ReactEvent.Image.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Image.persist"]
  [@bs.send.pipe: ReactEvent.Image.t]
  external persist: unit = "persist";
};

module Animation: {
  [@deprecated "Please use ReactEvent.Animation.tag"]
  type tag = ReactEvent.Animation.tag;
  [@deprecated "Please use ReactEvent.Animation.t"]
  type t = ReactEvent.Animation.t;
  [@deprecated "Please use ReactEvent.Animation.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Animation.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Animation.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Animation.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Animation.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Animation.t => Dom.element =
    "currentTarget";
  [@deprecated "Please use ReactEvent.Animation.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Animation.t => bool =
    "defaultPrevented";
  [@deprecated "Please use ReactEvent.Animation.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Animation.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Animation.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Animation.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Animation.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Animation.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Animation.preventDefault"]
  [@bs.send.pipe: ReactEvent.Animation.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Animation.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Animation.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Animation.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Animation.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated "Please use myEvent->ReactEvent.Animation.isPropagationStopped"]
  [@bs.send.pipe: ReactEvent.Animation.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Animation.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Animation.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Animation.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Animation.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Animation.type_"] [@bs.get]
  external _type: ReactEvent.Animation.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Animation.persist"]
  [@bs.send.pipe: ReactEvent.Animation.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.Animation.animationName"] [@bs.get]
  external animationName: ReactEvent.Animation.t => string = "animationName";
  [@deprecated "Please use ReactEvent.Animation.pseudoElement"] [@bs.get]
  external pseudoElement: ReactEvent.Animation.t => string = "pseudoElement";
  [@deprecated "Please use ReactEvent.Animation.elapsedTime"] [@bs.get]
  external elapsedTime: ReactEvent.Animation.t => float = "elapsedTime";
};

module Transition: {
  [@deprecated "Please use ReactEvent.Transition.tag"]
  type tag = ReactEvent.Transition.tag;
  [@deprecated "Please use ReactEvent.Transition.t"]
  type t = ReactEvent.Transition.t;
  [@deprecated "Please use ReactEvent.Transition.bubbles"] [@bs.get]
  external bubbles: ReactEvent.Transition.t => bool = "bubbles";
  [@deprecated "Please use ReactEvent.Transition.cancelable"] [@bs.get]
  external cancelable: ReactEvent.Transition.t => bool = "cancelable";
  [@deprecated
    "Please use ReactEvent.Transition.currentTarget and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external currentTarget: ReactEvent.Transition.t => Dom.element =
    "currentTarget";
  [@deprecated "Please use ReactEvent.Transition.defaultPrevented"] [@bs.get]
  external defaultPrevented: ReactEvent.Transition.t => bool =
    "defaultPrevented";
  [@deprecated "Please use ReactEvent.Transition.eventPhase"] [@bs.get]
  external eventPhase: ReactEvent.Transition.t => int = "eventPhase";
  [@deprecated "Please use ReactEvent.Transition.isTrusted"] [@bs.get]
  external isTrusted: ReactEvent.Transition.t => bool = "isTrusted";
  [@deprecated "Please use ReactEvent.Transition.nativeEvent"] [@bs.get]
  external nativeEvent: ReactEvent.Transition.t => Js.t({..}) = "nativeEvent";
  [@deprecated "Please use myEvent->ReactEvent.Transition.preventDefault"]
  [@bs.send.pipe: ReactEvent.Transition.t]
  external preventDefault: unit = "preventDefault";
  [@deprecated "Please use myEvent->ReactEvent.Transition.isDefaultPrevented"]
  [@bs.send.pipe: ReactEvent.Transition.t]
  external isDefaultPrevented: bool = "isDefaultPrevented";
  [@deprecated "Please use myEvent->ReactEvent.Transition.stopPropagation"]
  [@bs.send.pipe: ReactEvent.Transition.t]
  external stopPropagation: unit = "stopPropagation";
  [@deprecated
    "Please use myEvent->ReactEvent.Transition.isPropagationStopped"
  ]
  [@bs.send.pipe: ReactEvent.Transition.t]
  external isPropagationStopped: bool = "isPropagationStopped";
  [@deprecated
    "Please use ReactEvent.Transition.target and remove the surrounding ReactDOMRe.domElementToObj wrapper if any (no longer needed)"
  ]
  [@bs.get]
  external target: ReactEvent.Transition.t => Dom.element = "target";
  [@deprecated "Please use ReactEvent.Transition.timeStamp"] [@bs.get]
  external timeStamp: ReactEvent.Transition.t => float = "timeStamp";
  [@deprecated "Please use ReactEvent.Transition.type_"] [@bs.get]
  external _type: ReactEvent.Transition.t => string = "type";
  [@deprecated "Please use myEvent->ReactEvent.Transition.persist"]
  [@bs.send.pipe: ReactEvent.Transition.t]
  external persist: unit = "persist";
  [@deprecated "Please use ReactEvent.Transition.propertyName"] [@bs.get]
  external propertyName: ReactEvent.Transition.t => string = "propertyName";
  [@deprecated "Please use ReactEvent.Transition.pseudoElement"] [@bs.get]
  external pseudoElement: ReactEvent.Transition.t => string = "pseudoElement";
  [@deprecated "Please use ReactEvent.Transition.elapsedTime"] [@bs.get]
  external elapsedTime: ReactEvent.Transition.t => float = "elapsedTime";
};
