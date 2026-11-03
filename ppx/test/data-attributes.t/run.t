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
      (((ReactDOM.domProps)[@merlin.hide ]) ~className ~dataTestId
         ~onClick:(fun event -> React.Event.Mouse.preventDefault event) ())
  let optional ?className =
    fun ?dataFoo ->
      fun () ->
        ReactDOM.jsx "div"
          (((ReactDOM.domProps)[@merlin.hide ]) ?className ?dataFoo ())
  let renamed =
    ReactDOM.jsx "input"
      (((ReactDOM.domProps)[@merlin.hide ]) ~type_:"text" ~ariaLabel:"name"
         ~dataFoo__bar:"value" ())
  let expressions =
    ReactDOM.jsx "div"
      (((ReactDOM.domProps)[@merlin.hide ]) ~className:(next "class")
         ~dataFoo:(next "data") ())
  let nested =
    ReactDOM.jsx "div"
      (((ReactDOM.domProps)[@merlin.hide ])
         ~children:(ReactDOM.jsx "span"
                      (((ReactDOM.domProps)[@merlin.hide ]) ~dataBar:"inner" ()))
         ~dataFoo:"outer" ())
  let component =
    React.jsx Widget.make (Widget.makeProps ~dataFoo:"component" ())
