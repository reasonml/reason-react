(* [@@@bs.config { jsx = 3 }]
let handleClick _event =
  Js.log (("clicked!")[@reason.raw_literal "clicked!"])
let make ~message  () =
  React.useEffect
    (fun ()  -> Js.log (("Hey!")[@reason.raw_literal "Hey!"]); None);
  ((button ~onClick:handleClick ~children:[ReasonReact.string message] ())
  [@JSX ])[@@react.component ]
module A =
  struct
    let make ~className  ~children  =
      ((div ~className ~children:[children] ())[@JSX ])[@@react.component ]
  end
module B =
  struct
    let make () =
      ((A.createElement ~className:(("test")[@reason.raw_literal "test"])
          ~children:[((div ~children:[] ())[@JSX ]);
                    ((div ~children:[] ())[@JSX ])] ())[@JSX ])[@@react.component
                                                                 ]
  end *)


  module Suspense =
  struct
    external make :
      ?children:element -> ?fallback:element -> ?maxDuration:int -> element =
        "Suspense"[@@react.component ][@@bs.module
                                        (("React")[@reason.raw_literal
                                                    "React"])]
  end
  