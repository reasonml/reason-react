Snapshot distinct data names and reject repeated or aliased names, following
server-reason-react#420. This exercises the JSX PPX before type-checking.

  $ ../ppx.sh --output ml input.re
  let distinct =
    ReactDOM.jsx "div"
      (let module Jsx_props__004_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 data_foo:((Stdlib.String.t)[@mel.as "data_foo"]) ->
                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                     ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__004_.make
           ~check:(fun prop__003_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__003_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__003_)
                       [@merlin.hide ])) ~dataFoo:"first" ~data_foo:"second"
           ~__jsx_unit:())
  let optional first =
    fun second ->
      ReactDOM.jsx "div"
        (let module Jsx_props__008_ =
           struct
             external make :
               check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
                 ?dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                   ?data_foo:((Stdlib.String.t)[@mel.as "data_foo"]) ->
                     __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                       ReactDOM.domProps = ""[@@mel.obj ]
           end in
           Jsx_props__008_.make
             ~check:(fun prop__007_ ->
                       let _ =
                         ((((ReactDOM.domProps)[@merlin.hide ]) prop__007_)
                         [@merlin.hide ]) in
                       ((ReactDOM.domProps)[@merlin.hide ]) ((prop__007_)
                         [@merlin.hide ])) ?dataFoo:first ?data_foo:second
             ~__jsx_unit:())
  let optionalFirst first =
    ReactDOM.jsx "div"
      (let module Jsx_props__012_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               ?dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 data_foo:((Stdlib.String.t)[@mel.as "data_foo"]) ->
                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                     ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__012_.make
           ~check:(fun prop__011_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__011_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__011_)
                       [@merlin.hide ])) ?dataFoo:first ~data_foo:"fallback"
           ~__jsx_unit:())
  let requiredFirst second =
    ReactDOM.jsx "div"
      (let module Jsx_props__016_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 ?data_foo:((Stdlib.String.t)[@mel.as "data_foo"]) ->
                   __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                     ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__016_.make
           ~check:(fun prop__015_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__015_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__015_)
                       [@merlin.hide ])) ~dataFoo:"first" ?data_foo:second
           ~__jsx_unit:())
  let effects =
    ReactDOM.jsx "div"
      (let module Jsx_props__021_ =
         struct
           external make :
             check:((className:'prop__017_ ->
                       Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ])
               ->
               className:'prop__017_ ->
                 dataURL:((Stdlib.String.t)[@mel.as "data-url"]) ->
                   data_URL:((Stdlib.String.t)[@mel.as "data_url"]) ->
                     __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                       ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__021_.make
           ~check:(fun ~className:prop__017_ prop__020_ ->
                     let _ =
                       ((((ReactDOM.domProps)[@merlin.hide ])
                           ~className:prop__017_ prop__020_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ])
                       ~className:((prop__017_)[@merlin.hide ]) ((prop__020_)
                       [@merlin.hide ])) ~className:(next "class")
           ~dataURL:(next "first") ~data_URL:(next "second") ~__jsx_unit:())
  let serverNames =
    ReactDOM.jsx "div"
      (let module Jsx_props__034_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo:((Stdlib.String.t)[@mel.as "data-foo"]) ->
                 dataFoo__bar:((Stdlib.String.t)[@mel.as "data-foo__bar__"]) ->
                   dataFoo___:((Stdlib.String.t)[@mel.as "data-foo_____"]) ->
                     dataFoo_bar:((Stdlib.String.t)[@mel.as "data-foo_bar"]) ->
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
                                 data_foo:((Stdlib.String.t)[@mel.as
                                                              "data_foo"])
                                   ->
                                   datafoo:((Stdlib.String.t)[@mel.as
                                                               "datafoo"])
                                     ->
                                     __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ])
                                       -> ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__034_.make
           ~check:(fun prop__033_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__033_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__033_)
                       [@merlin.hide ])) ~dataFoo:"plain"
           ~dataFoo__bar:"double" ~dataFoo___:"trailing" ~dataFoo_bar:"single"
           ~dataURL:"acronym" ~dataURLPath:"acronym then word"
           ~dataVersion2:"digit" ~dataVersion20:"digits" ~data2:"leading digit"
           ~data_foo:"leading underscore" ~datafoo:"lowercase" ~__jsx_unit:())
  let underscoreThenUppercase =
    ReactDOM.jsx "div"
      (let module Jsx_props__037_ =
         struct
           external make :
             check:((Stdlib.Unit.t -> ReactDOM.domProps)[@mel.ignore ]) ->
               dataFoo_Bar:((Stdlib.String.t)[@mel.as "data-foo_bar"]) ->
                 __jsx_unit:((Stdlib.Unit.t)[@mel.ignore ]) ->
                   ReactDOM.domProps = ""[@@mel.obj ]
         end in
         Jsx_props__037_.make
           ~check:(fun prop__036_ ->
                     let _ = ((((ReactDOM.domProps)[@merlin.hide ]) prop__036_)
                       [@merlin.hide ]) in
                     ((ReactDOM.domProps)[@merlin.hide ]) ((prop__036_)
                       [@merlin.hide ]))
           ~dataFoo_Bar:"underscore then uppercase" ~__jsx_unit:())

  $ cat > repeated.re <<EOF
  > let element = <div dataFoo="a" dataFoo="b" />;
  > EOF
  $ ../ppx.sh --output ml repeated.re
  File "output.ml", line 1, characters 42-45:
  1 | let element = ((div ~dataFoo:"a" ~dataFoo:"b" ~children:[] ())[@JSX ])
                                                ^^^
  Error: JSX: the prop dataFoo appears more than once on <div>
  [1]

  $ cat > aliases.re <<EOF
  > let element = <div dataURL="a" dataUrl=?None />;
  > EOF
  $ ../ppx.sh --output ml aliases.re
  File "output.ml", line 1, characters 42-46:
  1 | let element = ((div ~dataURL:"a" ?dataUrl:None ~children:[] ())[@JSX ])
                                                ^^^^
  Error: JSX: dataUrl and dataURL both render as the attribute data-url
  [1]
