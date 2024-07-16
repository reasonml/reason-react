Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ ../ppx.sh --output ml input.re
  module Component_with_x_as_main_function =
    struct
      external xProps : ?key:string -> unit -> <  >  Js.t = ""[@@mel.obj ]
      let x () = ReactDOM.jsx "div" (((ReactDOM.domProps)[@merlin.hide ]) ())
      let x =
        let Output$Component_with_x_as_main_function$x (Props : <  >  Js.t) =
          x () in
        Output$Component_with_x_as_main_function$x
    end
  module Component_with_createElement_as_main_function =
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
        let Output$Component_with_createElement_as_main_function$createElement
          (Props : < lola: 'lola   >  Js.t) =
          createElement ~lola:(Props ## lola) in
        Output$Component_with_createElement_as_main_function$createElement
    end
  module Parent_rendering =
    struct
      external makeProps : ?key:string -> unit -> <  >  Js.t = ""[@@mel.obj ]
      let make () =
        React.jsx Component_with_x_as_main_function.x
          (Component_with_x_as_main_function.xProps ());
        React.jsx Component_with_createElement_as_main_function.make
          (Component_with_createElement_as_main_function.makeProps ~lola:"lola"
             ())
      let make =
        let Output$Parent_rendering (Props : <  >  Js.t) = make () in
        Output$Parent_rendering
    end
