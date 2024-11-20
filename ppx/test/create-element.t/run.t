Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ ../ppx.sh --output ml input.re
  module Foo =
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
        let Output$Foo$createElement (Props : < lola: 'lola   >  Js.t) =
          createElement ~lola:(Props ## lola) in
        Output$Foo$createElement
    end
  module Invalid_case =
    struct
      external makeProps :
        lola:'lola -> ?key:string -> unit -> < lola: 'lola   >  Js.t = ""
      [@@mel.obj ]
      let make = ((fun ~lola -> React.jsx Foo.make (Foo.makeProps ~lola ()))
        [@warning "-16"])
      let make =
        let Output$Invalid_case (Props : < lola: 'lola   >  Js.t) =
          make ~lola:(Props ## lola) in
        Output$Invalid_case
    end
