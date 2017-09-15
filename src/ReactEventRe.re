type synthetic 'a;

module MakeSyntheticWrapper (Type : {type t;}) => {
  external bubbles : Type.t => bool = "" [@@bs.get];
  external cancelable : Type.t => bool = "" [@@bs.get];
  external currentTarget : Type.t => Dom.element = "" [@@bs.get]; /* Should return Dom.evetTarget */
  external defaultPrevented : Type.t => bool = "" [@@bs.get];
  external eventPhase : Type.t => int = "" [@@bs.get];
  external isTrusted : Type.t => bool = "" [@@bs.get];
  external nativeEvent : Type.t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.event */

  external preventDefault : unit = "" [@@bs.send.pipe: Type.t];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: Type.t];
  external stopPropagation : unit = "" [@@bs.send.pipe: Type.t];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: Type.t];
  external target : Type.t => Dom.element = "" [@@bs.get]; /* Should return Dom.evetTarget */

  external timeStamp : Type.t => float = "" [@@bs.get];
  external _type : Type.t => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: Type.t];
};

module Synthetic = {
  type tag;
  type t = synthetic tag;

  external bubbles : synthetic 'a => bool = "" [@@bs.get];
  external cancelable : synthetic 'a => bool = "" [@@bs.get];
  external currentTarget : synthetic 'a => Dom.element = "" [@@bs.get]; /* Should return Dom.evetTarget */
  external defaultPrevented : synthetic 'a => bool = "" [@@bs.get];
  external eventPhase : synthetic 'a => int = "" [@@bs.get];
  external isTrusted : synthetic 'a => bool = "" [@@bs.get];
  external nativeEvent : synthetic 'a => Js.t {..} = "" [@@bs.get]; /* Should return Dom.event */

  external preventDefault : unit = "" [@@bs.send.pipe: synthetic 'a];
  external isDefaultPrevented : bool = "" [@@bs.send.pipe: synthetic 'a];
  external stopPropagation : unit = "" [@@bs.send.pipe: synthetic 'a];
  external isPropagationStopped : bool = "" [@@bs.send.pipe: synthetic 'a];
  external target : synthetic 'a => Dom.element = "" [@@bs.get]; /* Should return Dom.evetTarget */

  external timeStamp : synthetic 'a => float = "" [@@bs.get];
  external _type : synthetic 'a => string = "type" [@@bs.get];

  external persist : unit = "" [@@bs.send.pipe: synthetic 'a];
};

/* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
external toSyntheticEvent: synthetic 'a => Synthetic.t = "%identity";

module Clipboard = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

  external clipboardData : t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.dataTransfer */
};

module Composition = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

  external data : t => string = "" [@@bs.get];
};

module Keyboard = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

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

module Focus = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

  external relatedTarget : t => Dom.element = "" [@@bs.get]; /* Should return Dom.eventTarget */
};

module Form = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };
};

module Mouse = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

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

module Selection = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };
};

module Touch = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

  external altKey : t => bool = "" [@@bs.get];
  external changedTouches : t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.touchList */
  external ctrlKey : t => bool = "" [@@bs.get];
  external getModifierState : string => bool = "" [@@bs.send.pipe: t];
  external metaKey : t => bool = "" [@@bs.get];
  external shiftKey : t => bool = "" [@@bs.get];
  external targetTouches : t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.touchList */
  external touches : t => Js.t {..} = "" [@@bs.get]; /* Should return Dom.touchList */
};

module UI = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

  external detail : t => int = "" [@@bs.get];
  external view : t => Dom.window = "" [@@bs.get]; /* Should return DOMAbstractView/WindowProxy */
};

module Wheel = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

  external deltaMode : t => int = "" [@@bs.get];
  external deltaX : t => float = "" [@@bs.get];
  external deltaY : t => float = "" [@@bs.get];
  external deltaZ : t => float = "" [@@bs.get];
};

module Media = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };
};

module Image = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };
};

module Animation = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

  external animationName : t => string = "" [@@bs.get];
  external pseudoElement : t => string = "" [@@bs.get];
  external elapsedTime : t => float = "" [@@bs.get];
};

module Transition = {
  type tag;
  type t = synthetic tag;

  include MakeSyntheticWrapper { type nonrec t = t };

  external propertyName : t => string = "" [@@bs.get];
  external pseudoElement : t => string = "" [@@bs.get];
  external elapsedTime : t => float = "" [@@bs.get];
};
