external makeProps :
  a:'a -> b:'b -> ?key:string -> unit -> < a :'a ;b :'b  > Js.t = ""[@@bs.obj
                                                                    ]
let make =
  let Test (Props : < a :'a ;b :'b  > Js.t) =
    let a = ## Props a in
    let b = ## Props b in
    Js.log "This function should be named `Test`";
    ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test
module Foo =
  struct
    external componentProps :
      a:int -> b:string -> ?key:string -> unit -> < a :int ;b :string  > Js.t
        = ""[@@bs.obj ]
    external component :
      (< a :int ;b :string  > Js.t,React.element) React.componentLike = ""
    [@@bs.module "Foo"]
  end
module Bar =
  struct
    external makeProps :
      a:'a -> b:'b -> ?key:string -> unit -> < a :'a ;b :'b  > Js.t = ""
    [@@bs.obj ]
    let make =
      let Test$Bar (Props : < a :'a ;b :'b  > Js.t) =
        let a = ## Props a in
        let b = ## Props b in
        Js.log "This function should be named `Test$Bar`";
        ReactDOMRe.createDOMElementVariadic "div" [||] in
      Test$Bar
    external componentProps :
      a:'a -> b:'b -> ?key:string -> unit -> < a :'a ;b :'b  > Js.t = ""
    [@@bs.obj ]
    let component =
      let Test$Bar$component (Props : < a :'a ;b :'b  > Js.t) =
        let a = ## Props a in
        let b = ## Props b in
        Js.log "This function should be named `Test$Bar$component`";
        ReactDOMRe.createDOMElementVariadic "div" [||] in
      Test$Bar$component
  end
module type X_int  = sig val x : int end
module Func(M:X_int) =
  struct
    let x = M.x + 1
    external makeProps :
      a:'a ->
        b:'b -> ?key:string -> ?ref:'ref -> unit -> < a :'a ;b :'b  > Js.t =
        ""[@@bs.obj ]
    let make =
      React.forwardRef
        (let Test$Func (Props : < a :'a ;b :'b  > Js.t) ref =
           let a = ## Props a in
           let b = ## Props b in
           Js.log "This function should be named `Test$Func`" M.x;
           ReactDOMRe.createDOMElementVariadic "div"
             ~props:(ReactDOMRe.domProps ~ref ()) [||] in
         Test$Func)
  end
external makeProps :
  ?a:'a ->
    ?b:'b ->
      ?key:string ->
        unit ->
          < a :'a ( *predef* ).option ;b :'b ( *predef* ).option  > Js.t = ""
[@@bs.obj ]
let make =
  let Test
    (Props : < a :'a ( *predef* ).option ;b :'b ( *predef* ).option  > Js.t)
    =
    let a = match ## Props a with | Some a -> a | None  -> 1 in
    let b = ## Props b in
    Js.log "This function should be named `Test`";
    ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test
external componentProps :
  ?a:int ->
    b:string ->
      ?c:foo Js.t Js.Nullable.t ->
        ?key:string ->
          unit ->
            <
              a :int ( *predef* ).option ;b :string ;c
                                                       :foo Js.t
                                                          Js.Nullable.t (
                                                          *predef* ).option 
              > Js.t = ""[@@bs.obj ]
external component :
  (<
     a :int ( *predef* ).option ;b :string ;c
                                              :foo Js.t Js.Nullable.t (
                                                 *predef* ).option  >
     Js.t,React.element)
    React.componentLike = ""[@@bs.module "Foo"]
external makeProps :
  ?a:'a ->
    ?b:'b ->
      ?key:string ->
        unit ->
          < a :'a ( *predef* ).option ;b :'b ( *predef* ).option  > Js.t = ""
[@@bs.obj ]
let make =
  let Test
    (Props : < a :'a ( *predef* ).option ;b :'b ( *predef* ).option  > Js.t)
    =
    let a = match ## Props a with | Some a -> a | None  -> 1 in
    let b = ## Props b in ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test
module Issue369Optionals =
  struct
    module One =
      struct
        external makeProps :
          ?prop:string ->
            ?key:string -> unit -> < prop :string ( *predef* ).option  > Js.t
            = ""[@@bs.obj ]
        let make =
          let Test$Issue369Optionals$One
            (Props : < prop :string ( *predef* ).option  > Js.t) =
            let prop =
              match ## Props prop with | Some prop -> prop | None  -> "" in
            React.null in
          Test$Issue369Optionals$One
      end
    module Two =
      struct
        external makeProps :
          ?prop:string ->
            ?key:string ->
              unit -> < prop :string option ( *predef* ).option  > Js.t = ""
        [@@bs.obj ]
        let make =
          let Test$Issue369Optionals$Two
            (Props : < prop :string option ( *predef* ).option  > Js.t) =
            let prop =
              match ## Props prop with | Some prop -> prop | None  -> "" in
            React.null in
          Test$Issue369Optionals$Two
      end
    module All =
      struct
        external makeProps :
          labelled:'labelled ->
            labelledT:string ->
              ?optional:'optional ->
                ?optionalT:string ->
                  ?default:'default ->
                    ?defaultT:string ->
                      ?key:string ->
                        unit ->
                          <
                            labelled :'labelled ;labelledT :string ;optional
                                                                    :'optional
                                                                    (
                                                                    *predef*
                                                                    ).option ;
                            optionalT :string option ( *predef* ).option ;
                            default :'default ( *predef* ).option ;defaultT
                                                                    :string (
                                                                    *predef*
                                                                    ).option 
                            > Js.t = ""[@@bs.obj ]
        let make =
          let Test$Issue369Optionals$All
            (Props :
              <
                labelled :'labelled ;labelledT :string ;optional
                                                          :'optional (
                                                             *predef*
                                                             ).option ;
                optionalT :string option ( *predef* ).option ;default
                                                                :'default (
                                                                   *predef*
                                                                   ).option ;
                defaultT :string ( *predef* ).option  > Js.t)
            =
            let labelled = ## Props labelled in
            let labelledT = ## Props labelledT in
            let optional = ## Props optional in
            let optionalT = ## Props optionalT in
            let default =
              match ## Props default with
              | Some default -> default
              | None  -> "" in
            let defaultT =
              match ## Props defaultT with
              | Some defaultT -> defaultT
              | None  -> "" in
            React.null in
          Test$Issue369Optionals$All
      end
    let one = React.createElement One.make (One.makeProps ~prop:"foo" ())
    let two =
      React.createElement Two.make
        (Two.makeProps ~prop:((Some "foo")[@explicit_arity ]) ())
  end
