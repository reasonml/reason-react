Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ bash ../ppx.sh --output ml input.re
  module Record_props =
    struct
      external makeProps :
        lola:'lola -> ?key:string -> unit -> < lola: 'lola   >  Js.t = ""
      [@@mel.obj ]
      let make =
        ((fun ~lola ->
            ReactDOM.jsx "div"
              (((ReactDOM.domProps)[@merlin.hide ])
                 ~children:(React.string lola) ()))
        [@warning "-16"])
      let make =
        let Output$Record_props (string : < lola: 'lola   >  Js.t) =
          make ~lola:(string ## lola) in
        Output$Record_props
    end
