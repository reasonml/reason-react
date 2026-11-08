Snapshot DOM JSX with repeated data props and names that normalize to the same
attribute in server-reason-react#412. Run only the JSX PPX so this baseline can
capture the expansion before data attribute type-checking is supported.

  $ ../ppx.sh --output ml input.re
  let aliases =
    ReactDOM.jsx "div"
      (let _dataFoo__001_ : Stdlib.String.t = "first" in
       let _data_foo__002_ : Stdlib.String.t = "second" in
       let module Jsx_props__005_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                   ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__005_.make
           ~check:(fun prop__004_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__004_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__004_)
                       [@merlin.hide ])) ~dataFoo:_dataFoo__001_ ~__jsx_unit:())
  let repeated =
    ReactDOM.jsx "div"
      (let _dataFoo__006_ : Stdlib.String.t = "first" in
       let _dataFoo__007_ : Stdlib.String.t = "second" in
       let module Jsx_props__010_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                   ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__010_.make
           ~check:(fun prop__009_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__009_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__009_)
                       [@merlin.hide ])) ~dataFoo:_dataFoo__006_ ~__jsx_unit:())
  let optional first =
    fun second ->
      ReactDOM.jsx "div"
        (let _dataFoo__011_ : Stdlib.String.t Stdlib.Option.t = first in
         let _data_foo__012_ : Stdlib.String.t Stdlib.Option.t = second in
         let module Jsx_props__016_ =
           struct
             external make :
               check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
                 ?dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                     ReactDOM.domProps = ""[@@mel.obj ]
           end in
           Jsx_props__016_.make
             ~check:(fun prop__015_ ->
                       let _ =
                         ((((ReactDOM.domProps)[@merlin.hide ]) prop__015_)
                         [@merlin.hide ]) in
                       ((ReactDOM.domProps)[@merlin.hide ]) ((prop__015_)
                         [@merlin.hide ]))
             ?dataFoo:(match _dataFoo__011_ with
                       | Stdlib.Option.None -> _data_foo__012_
                       | Stdlib.Option.Some _ -> _dataFoo__011_) ~__jsx_unit:())
  let optionalFirst first =
    ReactDOM.jsx "div"
      (let _dataFoo__017_ : Stdlib.String.t Stdlib.Option.t = first in
       let _data_foo__018_ : Stdlib.String.t = "fallback" in
       let module Jsx_props__022_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                   ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__022_.make
           ~check:(fun prop__021_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__021_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__021_)
                       [@merlin.hide ]))
           ~dataFoo:(match _dataFoo__017_ with
                     | Stdlib.Option.None -> _data_foo__018_
                     | Stdlib.Option.Some _data__019_ -> _data__019_)
           ~__jsx_unit:())
  let requiredFirst second =
    ReactDOM.jsx "div"
      (let _dataFoo__023_ : Stdlib.String.t = "first" in
       let _data_foo__024_ : Stdlib.String.t Stdlib.Option.t = second in
       let module Jsx_props__027_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                   ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__027_.make
           ~check:(fun prop__026_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__026_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__026_)
                       [@merlin.hide ])) ~dataFoo:_dataFoo__023_ ~__jsx_unit:())
  let effects =
    ReactDOM.jsx "div"
      (let _dataURL__028_ : Stdlib.String.t = next "first" in
       let _dataUrl__029_ : Stdlib.String.t = next "second" in
       let module Jsx_props__033_ =
         struct
           external make :
             check:((className:'prop__030_ ->
                       Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ])
               ->
               className:'prop__030_ ->
                 dataURL:((Stdlib.String.t)[@mel.as "data-url"]) ->
                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                     ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__033_.make
           ~check:(fun ~className:prop__030_ prop__032_ ->
                     let _ =
                       ((((ReactDOM.domProps)[@merlin.hide ])
                           ~className:prop__030_ prop__032_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ])
                       ~className:((prop__030_)[@merlin.hide ]) ((prop__032_)
                       [@merlin.hide ])) ~className:(next "class")
           ~dataURL:_dataURL__028_ ~__jsx_unit:())
  let serverNames =
    ReactDOM.jsx "div"
      (let _dataFoo__034_ : Stdlib.String.t = "plain" in
       let _dataFoo_bar__035_ : Stdlib.String.t = "single" in
       let _dataFoo_Bar__036_ : Stdlib.String.t = "underscore then uppercase" in
       let _data_foo__037_ : Stdlib.String.t = "leading underscore" in
       let module Jsx_props__049_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 dataFoo__bar:((Stdlib.String.t)[@mel.as "data-foo--bar"]) ->
                   dataFoo___:((Stdlib.String.t)[@mel.as "data-foo---"]) ->
                     dataFoo_bar:((Stdlib.String.t)[@mel.as "data-foo-bar"]) ->
                       dataURL:((Stdlib.String.t)[@mel.as "data-url"]) ->
                         dataURLPath:((Stdlib.String.t)[@mel.as
                                                         "data-url-path"])
                           ->
                           dataVersion2:((Stdlib.String.t)[@mel.as
                                                            "data-version2"])
                             ->
                             dataVersion20:((Stdlib.String.t)[@mel.as
                                                               "data-version20"])
                               ->
                               data2:((Stdlib.String.t)[@mel.as "data2"]) ->
                                 datafoo:((Stdlib.String.t)[@mel.as "datafoo"])
                                   ->
                                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ])
                                     -> ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__049_.make
           ~check:(fun prop__048_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__048_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__048_)
                       [@merlin.hide ])) ~dataFoo:_dataFoo__034_
           ~dataFoo__bar:"double" ~dataFoo___:"trailing"
           ~dataFoo_bar:_dataFoo_bar__035_ ~dataURL:"acronym"
           ~dataURLPath:"acronym then word" ~dataVersion2:"digit"
           ~dataVersion20:"digits" ~data2:"leading digit" ~datafoo:"lowercase"
           ~__jsx_unit:())
