external makeProps :
  a:'a -> b:'b -> ?key:string -> unit -> < a: 'a  ;b: 'b   >  Js.t = ""
[@@bs.obj ]
let make =
  let Test (Props : < a: 'a  ;b: 'b   >  Js.t) =
    let a = Props ## a in
    let b = Props ## b in
    Js.log "This function should be named `Test`";
    ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test
module Foo =
  struct
    external componentProps :
      a:int ->
        b:string -> ?key:string -> unit -> < a: int  ;b: string   >  Js.t =
        ""[@@bs.obj ]
    external component :
      (< a: int  ;b: string   >  Js.t, React.element) React.componentLike =
        ""[@@bs.module "Foo"]
  end
module Bar =
  struct
    external makeProps :
      a:'a -> b:'b -> ?key:string -> unit -> < a: 'a  ;b: 'b   >  Js.t = ""
    [@@bs.obj ]
    let make =
      let Test$Bar (Props : < a: 'a  ;b: 'b   >  Js.t) =
        let a = Props ## a in
        let b = Props ## b in
        Js.log "This function should be named `Test$Bar`";
        ReactDOMRe.createDOMElementVariadic "div" [||] in
      Test$Bar
    external componentProps :
      a:'a -> b:'b -> ?key:string -> unit -> < a: 'a  ;b: 'b   >  Js.t = ""
    [@@bs.obj ]
    let component =
      let Test$Bar$component (Props : < a: 'a  ;b: 'b   >  Js.t) =
        let a = Props ## a in
        let b = Props ## b in
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
        b:'b -> ?key:string -> ?ref:'ref -> unit -> < a: 'a  ;b: 'b   >  Js.t
        = ""[@@bs.obj ]
    let make =
      React.forwardRef
        (let Test$Func (Props : < a: 'a  ;b: 'b   >  Js.t) ref =
           let a = Props ## a in
           let b = Props ## b in
           Js.log "This function should be named `Test$Func`" M.x;
           ReactDOMRe.createDOMElementVariadic "div"
             ~props:(ReactDOMRe.domProps ~ref ()) [||] in
         Test$Func)
  end
external makeProps :
  ?a:'a ->
    ?b:'b -> ?key:string -> unit -> < a: 'a option  ;b: 'b option   >  Js.t =
    ""[@@bs.obj ]
let make =
  let Test (Props : < a: 'a option  ;b: 'b option   >  Js.t) =
    let a = match Props ## a with | Some a -> a | None -> 1 in
    let b = Props ## b in
    Js.log "This function should be named `Test`";
    ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test
external componentProps :
  ?a:int ->
    b:string ->
      ?c:foo Js.t Js.Nullable.t ->
        ?key:string ->
          unit ->
            < a: int  ;b: string  ;c: foo Js.t Js.Nullable.t option   >  Js.t
    = ""[@@bs.obj ]
external component :
  (< a: int  ;b: string  ;c: foo Js.t Js.Nullable.t option   >  Js.t,
    React.element) React.componentLike = ""[@@bs.module "Foo"]
external makeProps :
  ?a:'a ->
    ?b:'b -> ?key:string -> unit -> < a: 'a option  ;b: 'b option   >  Js.t =
    ""[@@bs.obj ]
let make =
  let Test (Props : < a: 'a option  ;b: 'b option   >  Js.t) =
    let a = match Props ## a with | Some a -> a | None -> 1 in
    let b = Props ## b in ReactDOMRe.createDOMElementVariadic "div" [||] in
  Test
module Issue369Optionals =
  struct
    module One =
      struct
        external makeProps :
          ?prop:string ->
            ?key:string -> unit -> < prop: string option   >  Js.t = ""
        [@@bs.obj ]
        let make =
          let Test$Issue369Optionals$One
            (Props : < prop: string option   >  Js.t) =
            let (prop : string) =
              match Props ## prop with | Some prop -> prop | None -> "" in
            React.null in
          Test$Issue369Optionals$One
      end
    module Two =
      struct
        external makeProps :
          ?prop:string ->
            ?key:string -> unit -> < prop: string option   >  Js.t = ""
        [@@bs.obj ]
        let make =
          let Test$Issue369Optionals$Two
            (Props : < prop: string option   >  Js.t) =
            let (prop : string option) =
              match Props ## prop with | Some prop -> prop | None -> "" in
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
                            labelled: 'labelled  ;labelledT: string  ;
                            optional: 'optional option  ;optionalT: string
                                                                    option  ;
                            default: 'default option  ;defaultT: string
                                                                   option  
                            >  Js.t = ""[@@bs.obj ]
        let make =
          let Test$Issue369Optionals$All
            (Props :
              <
                labelled: 'labelled  ;labelledT: string  ;optional: 'optional
                                                                    option  ;
                optionalT: string option  ;default: 'default option  ;
                defaultT: string option   >  Js.t)
            =
            let labelled = Props ## labelled in
            let (labelledT : string) = Props ## labelledT in
            let optional = Props ## optional in
            let (optionalT : string option) = Props ## optionalT in
            let default =
              match Props ## default with
              | Some default -> default
              | None -> "" in
            let (defaultT : string) =
              match Props ## defaultT with
              | Some defaultT -> defaultT
              | None -> "" in
            React.null in
          Test$Issue369Optionals$All
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
              ?key:string ->
                unit -> < prop1: 'prop1  ;prop2: 'prop2   >  Js.t = ""
        [@@bs.obj ]
        external componentProps :
          prop1:'prop1 ->
            prop2:'prop2 ->
              ?key:string ->
                unit -> < prop1: 'prop1  ;prop2: 'prop2   >  Js.t = ""
        [@@bs.obj ]
        let rec make =
          let Test$Recursive$One
            (Props : < prop1: 'prop1  ;prop2: 'prop2   >  Js.t) =
            let prop1 = Props ## prop1 in
            let prop2 = Props ## prop2 in
            match prop2 with
            | true ->
                ReactDOMRe.createDOMElementVariadic "div"
                  ~props:(ReactDOMRe.domProps ~onClick:(fun _ -> prop1 prop2)
                            ()) [|(React.string "Cities")|]
            | false ->
                React.createElement component
                  (componentProps ~prop1 ~prop2 ()) in
          Test$Recursive$One
        and component =
          let Test$Recursive$One$component
            (Props : < prop1: 'prop1  ;prop2: 'prop2   >  Js.t) =
            let prop1 = Props ## prop1 in
            let prop2 = Props ## prop2 in
            ReactDOMRe.createDOMElementVariadic "div"
              ~props:(ReactDOMRe.domProps ~onClick:(fun _ -> prop1 prop2) ())
              [|(React.string "Cities")|] in
          Test$Recursive$One$component
      end
    let one =
      React.createElement One.make
        (One.makeProps ~prop:(fun _ -> ()) ~prop2:false ())
  end
module Issue378Destructuring =
  struct
    module One =
      struct
        external makeProps :
          tuple:'tuple -> ?key:string -> unit -> < tuple: 'tuple   >  Js.t =
            ""[@@bs.obj ]
        let make =
          let Test$Issue378Destructuring$One
            (Props : < tuple: 'tuple   >  Js.t) =
            let (a, b) = Props ## tuple in React.null in
          Test$Issue378Destructuring$One
      end
    let one = React.createElement One.make (One.makeProps ~tuple:(1, 2) ())
  end
module Blocks =
  struct
    module One =
      struct
        external makeProps :
          prop:'prop -> ?key:string -> unit -> < prop: 'prop   >  Js.t = ""
        [@@bs.obj ]
        let make =
          let foo = 1 in
          Js.log foo;
          (let Test$Blocks$One (Props : < prop: 'prop   >  Js.t) =
             let prop = Props ## prop in React.null in
           Test$Blocks$One)
      end
    let one = React.createElement One.make (One.makeProps ~prop:1 ())
  end
module Error =
  struct
    module MiniHelmetJsCompat =
      struct
        external make : ?title:string -> React.element = "default"[@@bs.module
                                                                    "react-helmet"]
      end
    external makeProps :
      ?title:string -> ?key:string -> unit -> < title: string   >  Js.t = ""
    [@@bs.obj ]
    let make =
      let Test$Error (Props : < title: string   >  Js.t) =
        let (title : string) = Props ## title in
        MiniHelmetJsCompat.make ~title in
      Test$Error
  end
