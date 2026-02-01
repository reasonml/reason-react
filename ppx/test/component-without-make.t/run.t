Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ ../run-ppx.sh --output ml input.re
  module X_as_main_function =
    struct
      external xProps : ?key:string -> unit -> <  >  Js.t = ""[@@mel.obj ]
      let x =
        ((fun () ->
            ReactDOM.jsx "div" (((ReactDOM.domProps)[@merlin.hide ]) ()))
        [@warning "-16"])
      let x =
        let Output$X_as_main_function$x (Props : <  >  Js.t) = x () in
        Output$X_as_main_function$x
    end
  module Create_element_as_main_function =
    struct
      external createElementProps :
        lola:'lola -> ?key:string -> unit -> < lola: 'lola   >  Js.t = ""
      [@@mel.obj ]
      let createElement =
        ((fun ~lola ->
            ReactDOM.jsx "div"
              (((ReactDOM.domProps)[@merlin.hide ])
                 ~children:(React.string lola) ()))
        [@warning "-16"])
      let createElement =
        let Output$Create_element_as_main_function$createElement
          (Props : < lola: 'lola   >  Js.t) =
          createElement ~lola:(Props ## lola) in
        Output$Create_element_as_main_function$createElement
    end
  module Invalid_case =
    struct
      external makeProps :
        lola:'lola -> ?key:string -> unit -> < lola: 'lola   >  Js.t = ""
      [@@mel.obj ]
      let make =
        ((fun ~lola ->
            React.jsx Create_element_as_main_function.make
              (Create_element_as_main_function.makeProps ~lola ()))
        [@warning "-16"])
      let make =
        let Output$Invalid_case (Props : < lola: 'lola   >  Js.t) =
          make ~lola:(Props ## lola) in
        Output$Invalid_case
    end
  module Valid_case =
    struct
      external makeProps : ?key:string -> unit -> <  >  Js.t = ""[@@mel.obj ]
      let make =
        ((fun () ->
            React.jsx Component_with_x_as_main_function.x
              (Component_with_x_as_main_function.xProps ()))
        [@warning "-16"])
      let make =
        let Output$Valid_case (Props : <  >  Js.t) = make () in
        Output$Valid_case
    end
