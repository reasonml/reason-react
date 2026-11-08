Snapshot DOM JSX with repeated data props and names that normalize to the same
attribute in server-reason-react#412. Run only the JSX PPX so this baseline can
capture the expansion before data attribute type-checking is supported.

  $ ../ppx.sh --output ml input.re
  let aliases =
    ReactDOM.jsx "div"
      (((ReactDOM.domProps)[@merlin.hide ]) ~dataFoo:"first" ~data_foo:"second"
         ())
  let repeated =
    ReactDOM.jsx "div"
      (((ReactDOM.domProps)[@merlin.hide ]) ~dataFoo:"first" ~dataFoo:"second"
         ())
  let optional first =
    fun second ->
      ReactDOM.jsx "div"
        (((ReactDOM.domProps)[@merlin.hide ]) ?dataFoo:first ?data_foo:second
           ())
  let optionalFirst first =
    ReactDOM.jsx "div"
      (((ReactDOM.domProps)[@merlin.hide ]) ?dataFoo:first ~data_foo:"fallback"
         ())
  let requiredFirst second =
    ReactDOM.jsx "div"
      (((ReactDOM.domProps)[@merlin.hide ]) ~dataFoo:"first" ?data_foo:second
         ())
  let effects =
    ReactDOM.jsx "div"
      (((ReactDOM.domProps)[@merlin.hide ]) ~className:(next "class")
         ~dataURL:(next "first") ~dataUrl:(next "second") ())
  let serverNames =
    ReactDOM.jsx "div"
      (((ReactDOM.domProps)[@merlin.hide ]) ~dataFoo:"plain"
         ~dataFoo__bar:"double" ~dataFoo___:"trailing" ~dataFoo_bar:"single"
         ~dataURL:"acronym" ~dataURLPath:"acronym then word"
         ~dataFoo_Bar:"underscore then uppercase" ~dataVersion2:"digit"
         ~dataVersion20:"digits" ~data2:"leading digit"
         ~data_foo:"leading underscore" ~datafoo:"lowercase" ())
