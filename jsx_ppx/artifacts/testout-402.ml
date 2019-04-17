external makeProps :
  a:'a -> b:'b -> ?key:string -> unit -> < a :'a ;b :'b  > Js.t = ""[@@bs.obj
                                                                    ]
let make =
  let Test-402 (Props : < a :'a ;b :'b  > Js.t) =
    let a = ## Props a in
    let b = ## Props b in
    Js.log "This function should be named `Test`";
    ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test-402
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
      let Test-402$Bar (Props : < a :'a ;b :'b  > Js.t) =
        let a = ## Props a in
        let b = ## Props b in
        Js.log "This function should be named `Test$Bar`";
        ReactDOMRe.createDOMElementVariadic "div" [||] in
      Test-402$Bar
    external componentProps :
      a:'a -> b:'b -> ?key:string -> unit -> < a :'a ;b :'b  > Js.t = ""
    [@@bs.obj ]
    let component =
      let Test-402$Bar$component (Props : < a :'a ;b :'b  > Js.t) =
        let a = ## Props a in
        let b = ## Props b in
        Js.log "This function should be named `Test$Bar$component`";
        ReactDOMRe.createDOMElementVariadic "div" [||] in
      Test-402$Bar$component
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
        (let Test-402$Func (Props : < a :'a ;b :'b  > Js.t) ref =
           let a = ## Props a in
           let b = ## Props b in
           Js.log "This function should be named `Test$Func`" M.x;
           ReactDOMRe.createDOMElementVariadic "div"
             ~props:(ReactDOMRe.domProps ~ref ()) [||] in
         Test-402$Func)
  end
external makeProps :
  ?a:'a ->
    ?b:'b ->
      ?key:string ->
        unit ->
          < a :'a ( *predef* ).option ;b :'b ( *predef* ).option  > Js.t = ""
[@@bs.obj ]
let make =
  let Test-402
    (Props : < a :'a ( *predef* ).option ;b :'b ( *predef* ).option  > Js.t)
    =
    let a = match ## Props a with | Some a -> a | None  -> 1 in
    let b = ## Props b in
    Js.log "This function should be named `Test`";
    ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test-402
external componentProps :
  ?a:int ->
    b:string ->
      ?c:foo Js.t Js.Nullable.t option ->
        ?key:string ->
          unit ->
            <
              a :int ( *predef* ).option ;b :string ;c
                                                       :foo Js.t
                                                          Js.Nullable.t
                                                          option ( *predef*
                                                          ).option  >
              Js.t = ""[@@bs.obj ]
external component :
  (<
     a :int ( *predef* ).option ;b :string ;c
                                              :foo Js.t Js.Nullable.t option
                                                 ( *predef* ).option  >
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
  let Test-402
    (Props : < a :'a ( *predef* ).option ;b :'b ( *predef* ).option  > Js.t)
    =
    let a = match ## Props a with | Some a -> a | None  -> 1 in
    let b = ## Props b in ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test-402
module Issue369Optionals =
  struct
    module One =
      struct
        external makeProps :
          ?prop:string ->
            ?key:string -> unit -> < prop :string ( *predef* ).option  > Js.t
            = ""[@@bs.obj ]
        let make =
          let Test-402$Issue369Optionals$One
            (Props : < prop :string ( *predef* ).option  > Js.t) =
            let (prop :string)=
              match ## Props prop with | Some prop -> prop | None  -> "" in
            React.null in
          Test-402$Issue369Optionals$One
      end
    module Two =
      struct
        external makeProps :
          ?prop:string option ->
            ?key:string -> unit -> < prop :string ( *predef* ).option  > Js.t
            = ""[@@bs.obj ]
        let make =
          let Test-402$Issue369Optionals$Two
            (Props : < prop :string ( *predef* ).option  > Js.t) =
            let (prop :string option)=
              match ## Props prop with | Some prop -> prop | None  -> "" in
            React.null in
          Test-402$Issue369Optionals$Two
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
                      nonOptionalOptionT:string option ->
                        ?nonOptionalDefaultT:string option ->
                          ?key:string ->
                            unit ->
                              <
                                labelled :'labelled ;labelledT :string ;
                                optional :'optional ( *predef* ).option ;
                                optionalT :string ( *predef* ).option ;
                                default :'default ( *predef* ).option ;
                                defaultT :string ( *predef* ).option ;
                                nonOptionalOptionT :string option ;nonOptionalDefaultT
                                                                    :string (
                                                                    *predef*
                                                                    ).option 
                                > Js.t = ""[@@bs.obj ]
        let make =
          let Test-402$Issue369Optionals$All
            (Props :
              <
                labelled :'labelled ;labelledT :string ;optional
                                                          :'optional (
                                                             *predef*
                                                             ).option ;
                optionalT :string ( *predef* ).option ;default
                                                         :'default ( *predef*
                                                            ).option ;
                defaultT :string ( *predef* ).option ;nonOptionalOptionT
                                                        :string option ;
                nonOptionalDefaultT :string ( *predef* ).option  > Js.t)
            =
            let labelled = ## Props labelled in
            let (labelledT :string)= ## Props labelledT in
            let optional = ## Props optional in
            let (optionalT :string option)= ## Props optionalT in
            let default =
              match ## Props default with
              | Some default -> default
              | None  -> "" in
            let (defaultT :string)=
              match ## Props defaultT with
              | Some defaultT -> defaultT
              | None  -> "" in
            let (nonOptionalOptionT :string option)=
              ## Props nonOptionalOptionT in
            let (nonOptionalDefaultT :string option)=
              match ## Props nonOptionalDefaultT with
              | Some nonOptionalDefaultT -> nonOptionalDefaultT
              | None  -> None in
            React.null in
          Test-402$Issue369Optionals$All
      end
    let one = React.createElement One.make (One.makeProps ~prop:"foo" ())
    let two =
      React.createElement Two.make
        (Two.makeProps ~prop:((Some "foo")[@explicit_arity ]) ())
  end
module Recursive =
  struct
    module One =
      struct
        external makeProps :
          prop1:'prop1 ->
            prop2:'prop2 ->
              ?key:string -> unit -> < prop1 :'prop1 ;prop2 :'prop2  > Js.t =
            ""[@@bs.obj ]
        external componentProps :
          prop1:'prop1 ->
            prop2:'prop2 ->
              ?key:string -> unit -> < prop1 :'prop1 ;prop2 :'prop2  > Js.t =
            ""[@@bs.obj ]
        let rec make =
          let Test-402$Recursive$One
            (Props : < prop1 :'prop1 ;prop2 :'prop2  > Js.t) =
            let prop1 = ## Props prop1 in
            let prop2 = ## Props prop2 in
            match prop2 with
            | true  ->
                ReactDOMRe.createDOMElementVariadic "div"
                  ~props:(ReactDOMRe.domProps
                            ~onClick:(fun _  -> prop1 prop2) ())
                  [|(React.string "Cities")|]
            | false  ->
                React.createElement component
                  (componentProps ~prop1 ~prop2 ()) in
          Test-402$Recursive$One
        and component =
          let Test-402$Recursive$One$component
            (Props : < prop1 :'prop1 ;prop2 :'prop2  > Js.t) =
            let prop1 = ## Props prop1 in
            let prop2 = ## Props prop2 in
            ReactDOMRe.createDOMElementVariadic "div"
              ~props:(ReactDOMRe.domProps ~onClick:(fun _  -> prop1 prop2) ())
              [|(React.string "Cities")|] in
          Test-402$Recursive$One$component
      end
    let one =
      React.createElement One.make
        (One.makeProps ~prop:(fun _  -> ()) ~prop2:false ())
  end
module Issue378Destructuring =
  struct
    module One =
      struct
        external makeProps :
          tuple:'tuple -> ?key:string -> unit -> < tuple :'tuple  > Js.t = ""
        [@@bs.obj ]
        let make =
          let Test-402$Issue378Destructuring$One
            (Props : < tuple :'tuple  > Js.t) =
            let (a,b) = ## Props tuple in React.null in
          Test-402$Issue378Destructuring$One
      end
    let one = React.createElement One.make (One.makeProps ~tuple:(1, 2) ())
  end
module Blocks =
  struct
    module One =
      struct
        external makeProps :
          prop:'prop -> ?key:string -> unit -> < prop :'prop  > Js.t = ""
        [@@bs.obj ]
        let make =
          let foo = 1 in
          Js.log foo;
          (let Test-402$Blocks$One (Props : < prop :'prop  > Js.t) =
             let prop = ## Props prop in React.null in
           Test-402$Blocks$One)
      end
    let one = React.createElement One.make (One.makeProps ~prop:1 ())
  end
