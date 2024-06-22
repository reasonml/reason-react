Showcase constant detection in reason-react-ppx:

- constants in children get wrapped in their respective `React.<primitive>` functions
- Array literals also get `React.array` treatment + recursion into their elements

  $ ../ppx.sh --output ml input.re
  module Foo =
    struct
      external makeProps :
        id:'id -> ?key:string -> unit -> < id: 'id   >  Js.t = ""[@@mel.obj ]
      let make =
        ((fun ~id ->
            let Key = id in
            ReactDOM.jsxsKeyed ~key:Key "div"
              (((ReactDOM.domProps)[@merlin.hide ])
                 ~children:(React.array
                              [|(React.array
                                   [|(ReactDOM.jsx "div"
                                        (((ReactDOM.domProps)[@merlin.hide ])
                                           ()));(React.string "a")|]);(
                                React.string "a");(React.char 'b');(React.int 3);false|])
                 ()) ())
        [@warning "-16"])
      let make =
        let Output$Foo (Props : < id: 'id   >  Js.t) = make ~id:(Props ## id) in
        Output$Foo
    end
  module Bar =
    struct
      external makeProps : ?key:string -> unit -> <  >  Js.t = ""[@@mel.obj ]
      let make () =
        let a = 42 in
        ReactDOM.jsx "div"
          (((ReactDOM.domProps)[@merlin.hide ]) ~children:a ())
      let make = let Output$Bar (Props : <  >  Js.t) = make () in Output$Bar
    end
