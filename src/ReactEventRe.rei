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

type synthetic 'a;

module Synthetic: {
  type tag;
  type t = synthetic tag ;

  external bubbles : synthetic 'a => bool = "" [@@bs.get];
  external cancelable : synthetic 'a => bool = "" [@@bs.get];
  external currentTarget : synthetic 'a => Dom.element = "" [@@bs.get];
  external defaultPrevented : synthetic 'a => bool = "" [@@bs.get];
  external eventPhase : synthetic 'a => int = "" [@@bs.get];
  external isTrusted : synthetic 'a => bool = "" [@@bs.get];
  external nativeEvent : synthetic 'a => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: synthetic 'a];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: synthetic 'a];
  external stopPropagation : unit = "" [@@bs.send.pipe: synthetic 'a];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: synthetic 'a];
  external target : synthetic 'a => Dom.element = "" [@@bs.get];

  external timeStamp : synthetic 'a => float = "" [@@bs.get];
  external _type : synthetic 'a => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: synthetic 'a];
};

/* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
external toSyntheticEvent: synthetic 'a => Synthetic.t = "%identity";

module Clipboard: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external clipboardData : t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.dataTransfer */
};

module Composition: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external data : t => string = "" [@@bs.get];
};

module Keyboard: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external altKey : t => bool = "" [@@bs.get];
  external charCode : t => int = "" [@@bs.get];
  external ctrlKey : t => bool = "" [@@bs.get];
  external getModifierState : string => bool = "" [@@bs.send.pipe: t];
  external key : t => string = "" [@@bs.get];
  external keyCode : t => int = "" [@@bs.get];
  external locale : t => string = "" [@@bs.get];
  external location : t => int = "" [@@bs.get];
  external metaKey : t => bool = "" [@@bs.get];
  external repeat : t => bool = "" [@@bs.get];
  external shiftKey : t => bool = "" [@@bs.get];
  external which : t => int = "" [@@bs.get];
};

module Focus: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external relatedTarget : t => Dom.element = "" [@@bs.get]; /* Should return Dom.eventTarget */
};

module Form: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];
};

module Mouse: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external altKey : t => bool = "" [@@bs.get];
  external button : t => int = "" [@@bs.get];
  external buttons : t => int = "" [@@bs.get];
  external clientX : t => int = "" [@@bs.get];
  external clientY : t => int = "" [@@bs.get];
  external ctrlKey : t => bool = "" [@@bs.get];
  external getModifierState : string => bool = "" [@@bs.send.pipe: t];
  external metaKey : t => bool = "" [@@bs.get];
  external pageX : t => int = "" [@@bs.get];
  external pageY : t => int = "" [@@bs.get];
  external relatedTarget : t => Dom.element = "" [@@bs.get]; /* Should return Dom.eventTarget */
  external screenX : t => int = "" [@@bs.get];
  external screenY : t => int = "" [@@bs.get];
  external shiftKey : t => bool = "" [@@bs.get];
};

module Selection: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];
};

module Touch: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external altKey : t => bool = "" [@@bs.get];
  external changedTouches : t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.touchList */
  external ctrlKey : t => bool = "" [@@bs.get];
  external getModifierState : string => bool = "" [@@bs.send.pipe: t];
  external metaKey : t => bool = "" [@@bs.get];
  external shiftKey : t => bool = "" [@@bs.get];
  external targetTouches : t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.touchList */
  external touches : t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.touchList */
};

module UI: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external detail : t => int = "" [@@bs.get];
  external view : t => Dom.window = "" [@@bs.get]; /* Should return DOMAbstractView/WindowProxy */
};

module Wheel: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external deltaMode : t => int = "" [@@bs.get];
  external deltaX : t => float = "" [@@bs.get];
  external deltaY : t => float = "" [@@bs.get];
  external deltaZ : t => float = "" [@@bs.get];
};

module Media: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];
};

module Image: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];
};

module Animation: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external animationName : t => string = "" [@@bs.get];
  external pseudoElement : t => string = "" [@@bs.get];
  external elapsedTime : t => float = "" [@@bs.get];
};

module Transition: {
  type tag;
  type t = synthetic tag;

  external bubbles : t => bool = "" [@@bs.get];
  external cancelable : t => bool = "" [@@bs.get];
  external currentTarget : t => Dom.element = "" [@@bs.get];
  external defaultPrevented : t => bool = "" [@@bs.get];
  external eventPhase : t => int = "" [@@bs.get];
  external isTrusted : t => bool = "" [@@bs.get];
  external nativeEvent : t => Js.t {..} = "" [@@bs.get];

  external preventDefault : unit = "" [@@bs.send.pipe: t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: t];
  external stopPropagation : unit = "" [@@bs.send.pipe: t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: t];
  external target : t => Dom.element = "" [@@bs.get];

  external timeStamp : t => float = "" [@@bs.get];
  external _type : t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: t];

  external propertyName : t => string = "" [@@bs.get];
  external pseudoElement : t => string = "" [@@bs.get];
  external elapsedTime : t => float = "" [@@bs.get];
};
