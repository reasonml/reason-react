Snapshot the OCaml expansion of DOM JSX with data attributes. This runs only
the JSX PPX, so unsupported prop labels can be captured before type-checking.

Ordinary DOM JSX and component props provide unchanged reference cases alongside
required and optional data attributes, renamed props, expressions, and nested JSX.

  $ ../ppx.sh --output ml input.re
  let ordinary =
    ReactDOM.jsx "button"
      (((ReactDOM.domProps)[@merlin.hide ]) ~className:"button" ())
  let required =
    ReactDOM.jsx "button"
      (let module Jsx_props__005_ =
         struct
           external make :
             check:((className:'prop__001_ ->
                       onClick:'prop__003_ ->
                         Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ])
               ->
               className:'prop__001_ ->
                 dataTestId:((Stdlib.String.t)[@mel.as "data-test-id"]) ->
                   onClick:'prop__003_ ->
                     __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                       ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__005_.make
           ~check:(fun ~className:prop__001_ ~onClick:prop__003_ prop__004_ ->
                     let _ =
                       ((((ReactDOM.domProps)[@merlin.hide ])
                           ~className:prop__001_ ~onClick:prop__003_ prop__004_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ])
                       ~className:((className)
                       [@merlin.focus ][@alert "-all"][@warning "-a"])
                       ~onClick:((prop__003_)[@merlin.hide ]) ((prop__004_)
                       [@merlin.hide ])) ~className:((className)
           [@merlin.hide ]) ~dataTestId
           ~onClick:(fun event -> React.Event.Mouse.preventDefault event)
           ~__jsx_unit:())
  let optional ?className =
    fun ?dataFoo ->
      fun () ->
        ReactDOM.jsx "div"
          (let module Jsx_props__009_ =
             struct
               external make :
                 check:((?className:'prop__006_ ->
                           Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ])
                   ->
                   ?className:'prop__006_ ->
                     ?dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                       __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                         ReactDOM.domProps = ""[@@mel.obj ]
             end in
             Jsx_props__009_.make
               ~check:(fun ?className:prop__006_ prop__008_ ->
                         let _ =
                           ((((ReactDOM.domProps)[@merlin.hide ])
                               ?className:prop__006_ prop__008_)
                           [@merlin.hide ]) in
                         ((ReactDOM.domProps)[@merlin.hide ])
                           ?className:((className)
                           [@merlin.focus ][@alert "-all"][@warning "-a"])
                           ((prop__008_)[@merlin.hide ]))
               ?className:((className)[@merlin.hide ]) ?dataFoo ~__jsx_unit:())
  let renamed =
    ReactDOM.jsx "input"
      (let module Jsx_props__014_ =
         struct
           external make :
             check:((type_:'prop__010_ ->
                       ariaLabel:'prop__011_ ->
                         Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ])
               ->
               type_:(('prop__010_)[@mel.as "type"]) ->
                 ariaLabel:(('prop__011_)[@mel.as "aria-label"]) ->
                   dataFoo__bar:((Stdlib.String.t)[@mel.as "data-foo__bar__"])
                     ->
                     __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                       ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__014_.make
           ~check:(fun ~type_:prop__010_ ~ariaLabel:prop__011_ prop__013_ ->
                     let _ =
                       ((((ReactDOM.domProps)[@merlin.hide ]) ~type_:prop__010_
                           ~ariaLabel:prop__011_ prop__013_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ~type_:((prop__010_)
                       [@merlin.hide ]) ~ariaLabel:((prop__011_)
                       [@merlin.hide ]) ((prop__013_)[@merlin.hide ]))
           ~type_:"text" ~ariaLabel:"name" ~dataFoo__bar:"value" ~__jsx_unit:())
  let expressions =
    ReactDOM.jsx "div"
      (let module Jsx_props__018_ =
         struct
           external make :
             check:((className:'prop__015_ ->
                       Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ])
               ->
               className:'prop__015_ ->
                 dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                     ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__018_.make
           ~check:(fun ~className:prop__015_ prop__017_ ->
                     let _ =
                       ((((ReactDOM.domProps)[@merlin.hide ])
                           ~className:prop__015_ prop__017_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ])
                       ~className:((prop__015_)[@merlin.hide ]) ((prop__017_)
                       [@merlin.hide ])) ~className:(next "class")
           ~dataFoo:(next "data") ~__jsx_unit:())
  let nested =
    ReactDOM.jsx "div"
      (let module Jsx_props__025_ =
         struct
           external make :
             check:((children:'prop__022_ -> Stdlib.Unit.t -> ReactDOM.domProps)
               [@mel.ignore ]) ->
               children:'prop__022_ ->
                 dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                     ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__025_.make
           ~check:(fun ~children:prop__022_ prop__024_ ->
                     let _ =
                       ((((ReactDOM.domProps)[@merlin.hide ])
                           ~children:prop__022_ prop__024_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ])
                       ~children:((prop__022_)[@merlin.hide ]) ((prop__024_)
                       [@merlin.hide ]))
           ~children:(ReactDOM.jsx "span"
                        (let module Jsx_props__021_ =
                           struct
                             external make :
                               check:((Stdlib.Unit.t -> ReactDOM.domProps)
                                 [@mel.ignore ]) ->
                                 dataBar:((Stdlib.String.t)[@mel.as "data-bar"])
                                   ->
                                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ])
                                     -> ReactDOM.domProps = ""[@@mel.obj ]
                           end in
                           Jsx_props__021_.make
                             ~check:(fun prop__020_ ->
                                       let _ =
                                         ((((ReactDOM.domProps)[@merlin.hide ])
                                             prop__020_)
                                         [@merlin.hide ]) in
                                       ((ReactDOM.domProps)[@merlin.hide ])
                                         ((prop__020_)[@merlin.hide ]))
                             ~dataBar:"inner" ~__jsx_unit:())) ~dataFoo:"outer"
           ~__jsx_unit:())
  let component =
    React.jsx Widget.make (Widget.makeProps ~dataFoo:"component" ())
