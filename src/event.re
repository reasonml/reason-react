type synthetic('a);

module MakeEventWithType = (Type: {
                              type t;
                            }) => {
  [@mel.get] external bubbles: Type.t => bool = "bubbles";
  [@mel.get] external cancelable: Type.t => bool = "cancelable";
  [@mel.get] external currentTarget: Type.t => Js.t({..}) = "currentTarget"; /* Should return Dom.eventTarget */
  [@mel.get] external defaultPrevented: Type.t => bool = "defaultPrevented";
  [@mel.get] external eventPhase: Type.t => int = "eventPhase";
  [@mel.get] external isTrusted: Type.t => bool = "isTrusted";
  [@mel.get] external nativeEvent: Type.t => Js.t({..}) = "nativeEvent"; /* Should return Dom.event */
  [@mel.send] external preventDefault: Type.t => unit = "preventDefault";
  [@mel.send]
  external isDefaultPrevented: Type.t => bool = "isDefaultPrevented";
  [@mel.send] external stopPropagation: Type.t => unit = "stopPropagation";
  [@mel.send]
  external isPropagationStopped: Type.t => bool = "isPropagationStopped";
  [@mel.get] external target: Type.t => Js.t({..}) = "target"; /* Should return Dom.eventTarget */
  [@mel.get] external timeStamp: Type.t => float = "timeStamp";
  [@mel.get] external type_: Type.t => string = "type";
  [@mel.send] external persist: Type.t => unit = "persist";
};

module Synthetic = {
  type tag;
  type t = synthetic(tag);
  [@mel.get] external bubbles: synthetic('a) => bool = "bubbles";
  [@mel.get] external cancelable: synthetic('a) => bool = "cancelable";
  [@mel.get]
  external currentTarget: synthetic('a) => Js.t({..}) = "currentTarget"; /* Should return Dom.eventTarget */
  [@mel.get]
  external defaultPrevented: synthetic('a) => bool = "defaultPrevented";
  [@mel.get] external eventPhase: synthetic('a) => int = "eventPhase";
  [@mel.get] external isTrusted: synthetic('a) => bool = "isTrusted";
  [@mel.get]
  external nativeEvent: synthetic('a) => Js.t({..}) = "nativeEvent"; /* Should return Dom.event */
  [@mel.send]
  external preventDefault: synthetic('a) => unit = "preventDefault";
  [@mel.send]
  external isDefaultPrevented: synthetic('a) => bool = "isDefaultPrevented";
  [@mel.send]
  external stopPropagation: synthetic('a) => unit = "stopPropagation";
  [@mel.send]
  external isPropagationStopped: synthetic('a) => bool =
    "isPropagationStopped";
  [@mel.get] external target: synthetic('a) => Js.t({..}) = "target"; /* Should return Dom.eventTarget */
  [@mel.get] external timeStamp: synthetic('a) => float = "timeStamp";
  [@mel.get] external type_: synthetic('a) => string = "type";
  [@mel.send] external persist: synthetic('a) => unit = "persist";
};

/* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
external toSyntheticEvent: synthetic('a) => Synthetic.t = "%identity";

module Clipboard = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external clipboardData: t => Js.t({..}) = "clipboardData"; /* Should return Dom.dataTransfer */
};

module Composition = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external data: t => string = "data";
};

module Keyboard = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external altKey: t => bool = "altKey";
  [@mel.get] external charCode: t => int = "charCode";
  [@mel.get] external ctrlKey: t => bool = "ctrlKey";
  [@mel.send]
  external getModifierState: (t, string) => bool = "getModifierState";
  [@mel.get] external key: t => string = "key";
  [@mel.get] external keyCode: t => int = "keyCode";
  [@mel.get] external locale: t => string = "locale";
  [@mel.get] external location: t => int = "location";
  [@mel.get] external metaKey: t => bool = "metaKey";
  [@mel.get] external repeat: t => bool = "repeat";
  [@mel.get] external shiftKey: t => bool = "shiftKey";
  [@mel.get] external which: t => int = "which";
};

module Focus = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] [@mel.return nullable]
  external relatedTarget: t => option(Js.t({..})) = "relatedTarget"; /* Should return Dom.eventTarget */
};

module Form = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
};

module Mouse = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external altKey: t => bool = "altKey";
  [@mel.get] external button: t => int = "button";
  [@mel.get] external buttons: t => int = "buttons";
  [@mel.get] external clientX: t => int = "clientX";
  [@mel.get] external clientY: t => int = "clientY";
  [@mel.get] external ctrlKey: t => bool = "ctrlKey";
  [@mel.send]
  external getModifierState: (t, string) => bool = "getModifierState";
  [@mel.get] external metaKey: t => bool = "metaKey";
  [@mel.get] external movementX: t => int = "movementX";
  [@mel.get] external movementY: t => int = "movementY";
  [@mel.get] external pageX: t => int = "pageX";
  [@mel.get] external pageY: t => int = "pageY";
  [@mel.get] [@mel.return nullable]
  external relatedTarget: t => option(Js.t({..})) = "relatedTarget"; /* Should return Dom.eventTarget */
  [@mel.get] external screenX: t => int = "screenX";
  [@mel.get] external screenY: t => int = "screenY";
  [@mel.get] external shiftKey: t => bool = "shiftKey";
};

module Drag = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });

  // MouseEvent
  [@mel.get] external altKey: t => bool = "altKey";
  [@mel.get] external button: t => int = "button";
  [@mel.get] external buttons: t => int = "buttons";
  [@mel.get] external clientX: t => int = "clientX";
  [@mel.get] external clientY: t => int = "clientY";
  [@mel.get] external ctrlKey: t => bool = "ctrlKey";
  [@mel.send]
  external getModifierState: (t, string) => bool = "getModifierState";
  [@mel.get] external metaKey: t => bool = "metaKey";
  [@mel.get] external movementX: t => int = "movementX";
  [@mel.get] external movementY: t => int = "movementY";
  [@mel.get] external pageX: t => int = "pageX";
  [@mel.get] external pageY: t => int = "pageY";
  [@mel.get] [@mel.return nullable]
  external relatedTarget: t => option(Js.t({..})) = "relatedTarget"; /* Should return Dom.eventTarget */
  [@mel.get] external screenX: t => int = "screenX";
  [@mel.get] external screenY: t => int = "screenY";
  [@mel.get] external shiftKey: t => bool = "shiftKey";

  [@mel.get] external dataTransfer: t => Js.t({..}) = "dataTransfer"; /* Should return Dom.dataTransfer */
};

module Pointer = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });

  // UIEvent
  [@mel.get] external detail: t => int = "detail";
  [@mel.get] external view: t => Dom.window = "view"; /* Should return DOMAbstractView/WindowProxy */

  // MouseEvent
  [@mel.get] external screenX: t => int = "screenX";
  [@mel.get] external screenY: t => int = "screenY";
  [@mel.get] external clientX: t => int = "clientX";
  [@mel.get] external clientY: t => int = "clientY";
  [@mel.get] external pageX: t => int = "pageX";
  [@mel.get] external pageY: t => int = "pageY";
  [@mel.get] external movementX: t => int = "movementX";
  [@mel.get] external movementY: t => int = "movementY";

  [@mel.get] external ctrlKey: t => bool = "ctrlKey";
  [@mel.get] external shiftKey: t => bool = "shiftKey";
  [@mel.get] external altKey: t => bool = "altKey";
  [@mel.get] external metaKey: t => bool = "metaKey";
  [@mel.send]
  external getModifierState: (t, string) => bool = "getModifierState";

  [@mel.get] external button: t => int = "button";
  [@mel.get] external buttons: t => int = "buttons";

  [@mel.get] [@mel.return nullable]
  external relatedTarget: t => option(Js.t({..})) = "relatedTarget"; /* Should return Dom.eventTarget */

  // PointerEvent
  [@mel.get] external pointerId: t => Dom.eventPointerId = "pointerId";
  [@mel.get] external width: t => float = "width";
  [@mel.get] external height: t => float = "height";
  [@mel.get] external pressure: t => float = "pressure";
  [@mel.get] external tangentialPressure: t => float = "tangentialPressure";
  [@mel.get] external tiltX: t => int = "tiltX";
  [@mel.get] external tiltY: t => int = "tiltY";
  [@mel.get] external twist: t => int = "twist";
  [@mel.get] external pointerType: t => string = "pointerType";
  [@mel.get] external isPrimary: t => bool = "isPrimary";
};

module Selection = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
};

module Touch = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external altKey: t => bool = "altKey";
  [@mel.get] external changedTouches: t => Js.t({..}) = "changedTouches"; /* Should return Dom.touchList */
  [@mel.get] external ctrlKey: t => bool = "ctrlKey";
  [@mel.send]
  external getModifierState: (t, string) => bool = "getModifierState";
  [@mel.get] external metaKey: t => bool = "metaKey";
  [@mel.get] external shiftKey: t => bool = "shiftKey";
  [@mel.get] external targetTouches: t => Js.t({..}) = "targetTouches"; /* Should return Dom.touchList */
  [@mel.get] external touches: t => Js.t({..}) = "touches"; /* Should return Dom.touchList */
};

module UI = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external detail: t => int = "detail";
  [@mel.get] external view: t => Dom.window = "view"; /* Should return DOMAbstractView/WindowProxy */
};

module Wheel = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external deltaMode: t => int = "deltaMode";
  [@mel.get] external deltaX: t => float = "deltaX";
  [@mel.get] external deltaY: t => float = "deltaY";
  [@mel.get] external deltaZ: t => float = "deltaZ";
};

module Media = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
};

module Image = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
};

module Animation = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external animationName: t => string = "animationName";
  [@mel.get] external pseudoElement: t => string = "pseudoElement";
  [@mel.get] external elapsedTime: t => float = "elapsedTime";
};

module Transition = {
  type tag;
  type t = synthetic(tag);
  include MakeEventWithType({
    type nonrec t = t;
  });
  [@mel.get] external propertyName: t => string = "propertyName";
  [@mel.get] external pseudoElement: t => string = "pseudoElement";
  [@mel.get] external elapsedTime: t => float = "elapsedTime";
};
