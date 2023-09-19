Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ ../ppx.sh --output ml input.re
  module type X_int  = sig val x : int end
  module Func(M:X_int) =
    struct
      let x = M.x + 1
      external makeProps :
        a:'a -> b:'b -> ?key:string -> unit -> < a: 'a  ;b: 'b   >  Js.t = ""
      [@@mel.obj ]
      let make =
        ((fun ~a ->
            ((fun ~b ->
                print_endline "This function should be named `Test$Func`" M.x;
                ReactDOM.jsx "div" (((ReactDOM.domProps)[@merlin.hide ]) ()))
            [@warning "-16"]))
        [@warning "-16"])
      let make =
        let Output$Func (Props : < a: 'a  ;b: 'b   >  Js.t) =
          make ~b:(Props ## b) ~a:(Props ## a) in
        Output$Func
    end
