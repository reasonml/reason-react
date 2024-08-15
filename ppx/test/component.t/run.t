Since we generate invalid syntax for the argument of the make fn `(Props : <>)`
We need to output ML syntax here, otherwise refmt could not parse it.
  $ ../ppx.sh --output ml input.re
  module React_component_with_props =
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
        let Output$React_component_with_props (Props : < lola: 'lola   >  Js.t)
          = make ~lola:(Props ## lola) in
        Output$React_component_with_props
    end
  let react_component_with_props =
    React.jsx React_component_with_props.make
      (React_component_with_props.makeProps ~lola:"flores" ())
  module Upper_case_with_fragment_as_root =
    struct
      external makeProps :
        ?name:'name -> ?key:string -> unit -> < name: 'name option   >  Js.t =
          ""[@@mel.obj ]
      let make =
        ((fun ?(name= "") ->
            React.jsxs React.jsxFragment
              (((ReactDOM.domProps)[@merlin.hide ])
                 ~children:(React.array
                              [|(ReactDOM.jsx "div"
                                   (((ReactDOM.domProps)[@merlin.hide ])
                                      ~children:(React.string ("First " ^ name))
                                      ()));(React.jsx Hello.make
                                              (Hello.makeProps
                                                 ~children:(React.string
                                                              ("2nd " ^ name))
                                                 ~one:"1" ()))|]) ()))
        [@warning "-16"])
      let make =
        let Output$Upper_case_with_fragment_as_root
          (Props : < name: 'name option   >  Js.t) = make ?name:(Props ## name) in
        Output$Upper_case_with_fragment_as_root
    end
  module Forward_Ref =
    struct
      external makeProps :
        children:'children ->
          buttonRef:'buttonRef ->
            ?key:string ->
              unit -> < children: 'children  ;buttonRef: 'buttonRef   >  Js.t =
          ""[@@mel.obj ]
      let make =
        ((fun ~children ->
            ((fun ~buttonRef ->
                ReactDOM.jsx "button"
                  (((ReactDOM.domProps)[@merlin.hide ]) ~children
                     ~ref:buttonRef ~className:"FancyButton" ()))
            [@warning "-16"]))
        [@warning "-16"])
      let make =
        React.forwardRef
          (let Output$Forward_Ref
             (Props : < children: 'children  ;buttonRef: 'buttonRef   >  Js.t)
             =
             make ~buttonRef:(Props ## buttonRef) ~children:(Props ## children) in
           Output$Forward_Ref)
    end
  module Onclick_handler_button =
    struct
      external makeProps :
        name:'name ->
          ?isDisabled:'isDisabled ->
            ?key:string ->
              unit -> < name: 'name  ;isDisabled: 'isDisabled option   >  Js.t
          = ""[@@mel.obj ]
      let make =
        ((fun ~name ->
            ((fun ?isDisabled ->
                let onClick event = Js.log event in
                ReactDOM.jsx "button"
                  (((ReactDOM.domProps)[@merlin.hide ]) ~name ~onClick
                     ~disabled:isDisabled ()))
            [@warning "-16"]))
        [@warning "-16"])
      let make =
        let Output$Onclick_handler_button
          (Props : < name: 'name  ;isDisabled: 'isDisabled option   >  Js.t) =
          make ?isDisabled:(Props ## isDisabled) ~name:(Props ## name) in
        Output$Onclick_handler_button
    end
  module Children_as_string =
    struct
      external makeProps :
        ?name:'name -> ?key:string -> unit -> < name: 'name option   >  Js.t =
          ""[@@mel.obj ]
      let make =
        ((fun ?(name= "joe") ->
            ReactDOM.jsx "div"
              (((ReactDOM.domProps)[@merlin.hide ])
                 ~children:((Printf.sprintf "`name` is %s" name) |>
                              React.string) ()))
        [@warning "-16"])
      let make =
        let Output$Children_as_string (Props : < name: 'name option   >  Js.t)
          = make ?name:(Props ## name) in
        Output$Children_as_string
    end
  let () = Dream.run ()
  let l = 33
  module Uppercase_with_SSR_components =
    struct
      external makeProps :
        children:'children ->
          moreProps:'moreProps ->
            ?key:string ->
              unit -> < children: 'children  ;moreProps: 'moreProps   >  Js.t =
          ""[@@mel.obj ]
      let make =
        ((fun ~children ->
            ((fun ~moreProps ->
                ReactDOM.jsxs "html"
                  (((ReactDOM.domProps)[@merlin.hide ])
                     ~children:(React.array
                                  [|(ReactDOM.jsx "head"
                                       (((ReactDOM.domProps)[@merlin.hide ])
                                          ~children:(ReactDOM.jsx "title"
                                                       (((ReactDOM.domProps)
                                                          [@merlin.hide ])
                                                          ~children:(React.string
                                                                      ("SSR React "
                                                                      ^
                                                                      moreProps))
                                                          ())) ()));(ReactDOM.jsxs
                                                                      "body"
                                                                      (((ReactDOM.domProps)
                                                                      [@merlin.hide
                                                                      ])
                                                                      ~children:(
                                                                      React.array
                                                                      [|(
                                                                      ReactDOM.jsx
                                                                      "div"
                                                                      (((ReactDOM.domProps)
                                                                      [@merlin.hide
                                                                      ])
                                                                      ~children
                                                                      ~id:"root"
                                                                      ()));(
                                                                      ReactDOM.jsx
                                                                      "script"
                                                                      (((ReactDOM.domProps)
                                                                      [@merlin.hide
                                                                      ])
                                                                      ~src:"/static/client.js"
                                                                      ()))|])
                                                                      ()))|])
                     ()))
            [@warning "-16"]))
        [@warning "-16"])
      let make =
        let Output$Uppercase_with_SSR_components
          (Props : < children: 'children  ;moreProps: 'moreProps   >  Js.t) =
          make ~moreProps:(Props ## moreProps) ~children:(Props ## children) in
        Output$Uppercase_with_SSR_components
    end
  module Upper_with_aria =
    struct
      external makeProps :
        children:'children ->
          ?key:string -> unit -> < children: 'children   >  Js.t = ""[@@mel.obj
                                                                      ]
      let make =
        ((fun ~children ->
            ReactDOM.jsx "div"
              (((ReactDOM.domProps)[@merlin.hide ]) ~children
                 ~ariaHidden:"true" ()))
        [@warning "-16"])
      let make =
        let Output$Upper_with_aria (Props : < children: 'children   >  Js.t) =
          make ~children:(Props ## children) in
        Output$Upper_with_aria
    end
