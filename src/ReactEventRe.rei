/* This is the whole synthetic event system of ReactJS/ReasonReact. The first module `Synthetic` represents
   the generic synthetic event. The rest are the specific ones.

   In each module, the type `t` commonly means "the type of that module" (OCaml convention). In our case, e.g.
   `ReactEventRe.Mouse.t` represents a ReactJS synthetic mouse event. You'd use it to type your props:

   ```
   type props = {
     onClick: ReactEventRe.Mouse.t => unit
   };
   ```

   All the methods and properties of a type of event are in the module, as seen below.

   Each module also has a `tag` type. You can ignore it; they're only needed by their `t` type. This way, we
   get to allow a base `Synthetic` event module with generic methods. So e.g. even a mouse event (`Mouse.t`)
   get to be passed to a generic handler:

   ```
   let handleClick {state, props} event => {
     ReactEventRe.Mouse.preventDefault event;
     ...
   };
   let handleSubmit {state, props} event => {
     /* this handler can be triggered by either a Keyboard or a Mouse event; conveniently use the generic
        preventDefault */
     ReactEventRe.Synthetic.preventDefault event;
     ...
   };

   let render _ => <Foo onSubmit=handleSubmit onEnter=handleSubmit .../>;
   ```

   How to translate idioms from ReactJS:

   1. myMouseEvent.preventDefault() -> ReactEventRe.Mouse.preventDefault myMouseEvent
   2. myKeyboardEvent.which -> ReactEventRe.Keyboard.which myMouseEvent
   */
type synthetic('a);

module Synthetic: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : synthetic('a) => bool = "";
  [@bs.get] external cancelable : synthetic('a) => bool = "";
  [@bs.get] external currentTarget : synthetic('a) => Dom.element = "";
  [@bs.get] external defaultPrevented : synthetic('a) => bool = "";
  [@bs.get] external eventPhase : synthetic('a) => int = "";
  [@bs.get] external isTrusted : synthetic('a) => bool = "";
  [@bs.get] external nativeEvent : synthetic('a) => Js.t({..}) = "";
  [@bs.send.pipe : synthetic('a)] external preventDefault : unit = "";
  [@bs.send.pipe : synthetic('a)] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : synthetic('a)] external stopPropagation : unit = "";
  [@bs.send.pipe : synthetic('a)] external isPropagationStopped : bool = "";
  [@bs.get] external target : synthetic('a) => Dom.element = "";
  [@bs.get] external timeStamp : synthetic('a) => float = "";
  [@bs.get] external _type : synthetic('a) => string = "type";
  [@bs.send.pipe : synthetic('a)] external persist : unit = "";
};

/* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
external toSyntheticEvent : synthetic('a) => Synthetic.t = "%identity";

module Clipboard: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external clipboardData : t => Js.t({..}) = ""; /* Should return Dom.dataTransfer */
};

module Composition: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external data : t => string = "";
};

module Keyboard: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external altKey : t => bool = "";
  [@bs.get] external charCode : t => int = "";
  [@bs.get] external ctrlKey : t => bool = "";
  [@bs.send.pipe : t] external getModifierState : string => bool = "";
  [@bs.get] external key : t => string = "";
  [@bs.get] external keyCode : t => int = "";
  [@bs.get] external locale : t => string = "";
  [@bs.get] external location : t => int = "";
  [@bs.get] external metaKey : t => bool = "";
  [@bs.get] external repeat : t => bool = "";
  [@bs.get] external shiftKey : t => bool = "";
  [@bs.get] external which : t => int = "";
};

module Focus: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external relatedTarget : t => Dom.element = ""; /* Should return Dom.eventTarget */
};

module Form: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
};

module Mouse: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external altKey : t => bool = "";
  [@bs.get] external button : t => int = "";
  [@bs.get] external buttons : t => int = "";
  [@bs.get] external clientX : t => int = "";
  [@bs.get] external clientY : t => int = "";
  [@bs.get] external ctrlKey : t => bool = "";
  [@bs.send.pipe : t] external getModifierState : string => bool = "";
  [@bs.get] external metaKey : t => bool = "";
  [@bs.get] external pageX : t => int = "";
  [@bs.get] external pageY : t => int = "";
  [@bs.get] external relatedTarget : t => Dom.element = ""; /* Should return Dom.eventTarget */
  [@bs.get] external screenX : t => int = "";
  [@bs.get] external screenY : t => int = "";
  [@bs.get] external shiftKey : t => bool = "";
};

module Selection: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
};

module Touch: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external altKey : t => bool = "";
  [@bs.get] external changedTouches : t => Js.t({..}) = ""; /* Should return Dom.touchList */
  [@bs.get] external ctrlKey : t => bool = "";
  [@bs.send.pipe : t] external getModifierState : string => bool = "";
  [@bs.get] external metaKey : t => bool = "";
  [@bs.get] external shiftKey : t => bool = "";
  [@bs.get] external targetTouches : t => Js.t({..}) = ""; /* Should return Dom.touchList */
  [@bs.get] external touches : t => Js.t({..}) = ""; /* Should return Dom.touchList */
};

module UI: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external detail : t => int = "";
  [@bs.get] external view : t => Dom.window = ""; /* Should return DOMAbstractView/WindowProxy */
};

module Wheel: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external deltaMode : t => int = "";
  [@bs.get] external deltaX : t => float = "";
  [@bs.get] external deltaY : t => float = "";
  [@bs.get] external deltaZ : t => float = "";
};

module Media: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
};

module Image: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
};

module Animation: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external animationName : t => string = "";
  [@bs.get] external pseudoElement : t => string = "";
  [@bs.get] external elapsedTime : t => float = "";
};

module Transition: {
  type tag;
  type t = synthetic(tag);
  [@bs.get] external bubbles : t => bool = "";
  [@bs.get] external cancelable : t => bool = "";
  [@bs.get] external currentTarget : t => Dom.element = "";
  [@bs.get] external defaultPrevented : t => bool = "";
  [@bs.get] external eventPhase : t => int = "";
  [@bs.get] external isTrusted : t => bool = "";
  [@bs.get] external nativeEvent : t => Js.t({..}) = "";
  [@bs.send.pipe : t] external preventDefault : unit = "";
  [@bs.send.pipe : t] external isDefaultPrevented : bool = "";
  [@bs.send.pipe : t] external stopPropagation : unit = "";
  [@bs.send.pipe : t] external isPropagationStopped : bool = "";
  [@bs.get] external target : t => Dom.element = "";
  [@bs.get] external timeStamp : t => float = "";
  [@bs.get] external _type : t => string = "type";
  [@bs.send.pipe : t] external persist : unit = "";
  [@bs.get] external propertyName : t => string = "";
  [@bs.get] external pseudoElement : t => string = "";
  [@bs.get] external elapsedTime : t => float = "";
};
