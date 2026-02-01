  $ bash ../ppx.sh --output ml input.re
  module Greeting :
    sig
      external makeProps :
        ?mockup:string ->
          ?key:string -> unit -> < mockup: string option   >  Js.t = ""
      [@@mel.obj ]
      val make :
        (< mockup: string option   >  Js.t, React.element) React.componentLike
    end =
    struct
      external makeProps :
        ?mockup:string ->
          ?key:string -> unit -> < mockup: string option   >  Js.t = ""
      [@@mel.obj ]
      let make =
        ((fun ?mockup:(mockup : string option) ->
            ReactDOM.jsx "button"
              (((ReactDOM.domProps)[@merlin.hide ])
                 ~children:(React.string "Hello!") ()))
        [@warning "-16"])
      let make =
        let Output$Greeting (Props : < mockup: string option   >  Js.t) =
          make ?mockup:(Props ## mockup) in
        Output$Greeting
    end 
  module MyPropIsOptionBool =
    struct
      external makeProps :
        ?myProp:bool -> ?key:string -> unit -> < myProp: bool option   >  Js.t
          = ""[@@mel.obj ]
      external make :
        (< myProp: bool option   >  Js.t, React.element) React.componentLike =
          "A"
    end
  module MyPropIsOptionOptionBool =
    struct
      external makeProps :
        ?myProp:bool option ->
          ?key:string -> unit -> < myProp: bool option option   >  Js.t = ""
      [@@mel.obj ]
      external make :
        (< myProp: bool option option   >  Js.t, React.element)
          React.componentLike = "B"
    end
  module MyPropIsOptionOptionBoolWithSig :
    sig
      external makeProps :
        ?myProp:bool option ->
          ?key:string -> unit -> < myProp: bool option option   >  Js.t = ""
      [@@mel.obj ]
      external make :
        (< myProp: bool option option   >  Js.t, React.element)
          React.componentLike = "B"
    end =
    struct
      external makeProps :
        ?myProp:bool option ->
          ?key:string -> unit -> < myProp: bool option option   >  Js.t = ""
      [@@mel.obj ]
      external make :
        (< myProp: bool option option   >  Js.t, React.element)
          React.componentLike = "B"
    end 
  module MyPropIsOptionOptionBoolWithValSig :
    sig
      external makeProps :
        ?myProp:bool option ->
          ?key:string -> unit -> < myProp: bool option option   >  Js.t = ""
      [@@mel.obj ]
      val make :
        (< myProp: bool option option   >  Js.t, React.element)
          React.componentLike
    end =
    struct
      external makeProps :
        ?myProp:bool option ->
          ?key:string -> unit -> < myProp: bool option option   >  Js.t = ""
      [@@mel.obj ]
      external make :
        (< myProp: bool option option   >  Js.t, React.element)
          React.componentLike = "B"
    end 
  module MyPropIsOptionOptionBoolLetWithValSig :
    sig
      external makeProps :
        ?myProp:bool option ->
          ?key:string -> unit -> < myProp: bool option option   >  Js.t = ""
      [@@mel.obj ]
      val make :
        (< myProp: bool option option   >  Js.t, React.element)
          React.componentLike
    end =
    struct
      external makeProps :
        ?myProp:bool option ->
          ?key:string -> unit -> < myProp: bool option option   >  Js.t = ""
      [@@mel.obj ]
      let make = ((fun ?myProp:(myProp : bool option option) -> React.null)
        [@warning "-16"])
      let make =
        let Output$MyPropIsOptionOptionBoolLetWithValSig
          (Props : < myProp: bool option option   >  Js.t) =
          make ?myProp:(Props ## myProp) in
        Output$MyPropIsOptionOptionBoolLetWithValSig
    end 
