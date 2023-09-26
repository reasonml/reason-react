  $ ../ppx.sh --output ml input.re
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
            React.DOM.jsx "button"
              (((React.DOM.domProps)[@merlin.hide ])
                 ~children:(React.string "Hello!") ()))
        [@warning "-16"])
      let make =
        let Output$Greeting (Props : < mockup: string option   >  Js.t) =
          make ?mockup:(Props ## mockup) in
        Output$Greeting
    end 
