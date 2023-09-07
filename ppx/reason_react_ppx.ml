open Ppxlib

module Builder = struct
  (* Ast_builder.Default assigns attributes to be the empty.
     This wrapper re-exports all used fns with attrs arg to override them. *)

  include Ast_builder.Default

  let pexp_apply ~loc ?(attrs = []) e args =
    let e = Ast_builder.Default.pexp_apply ~loc e args in
    { e with pexp_attributes = attrs }

  let pexp_ident ~loc ?(attrs = []) e =
    let e = Ast_builder.Default.pexp_ident ~loc e in
    { e with pexp_attributes = attrs }

  let value_binding ~loc ~attrs ~pat ~expr =
    let vb = Ast_builder.Default.value_binding ~loc ~pat ~expr in
    { vb with pvb_attributes = attrs }
end

(* [merlinHide] tells merlin to not look at a node, or at any of its
   descendants. *)
let merlinHideAttrs =
  [
    {
      attr_name = { txt = "merlin.hide"; loc = Location.none };
      attr_payload = PStr [];
      attr_loc = Location.none;
    };
  ]

let merlinFocus =
  {
    attr_name = { loc = Location.none; txt = "merlin.focus" };
    attr_payload = PStr [];
    attr_loc = Location.none;
  }

let nolabel = Nolabel
let labelled str = Labelled str
let optional str = Optional str

module Binding = struct
  (* Binding is the interface that the ppx uses to interact with the bindings.
     Here we define the same APIs as the bindings but it generates Parsetree *)
  module React = struct
    let null ~loc =
      Builder.pexp_ident ~loc { loc; txt = Ldot (Lident "React", "null") }

    let array ~loc children =
      Builder.pexp_apply ~loc
        (Builder.pexp_ident ~loc
           { txt = Longident.Ldot (Lident "React", "array"); loc })
        [ (nolabel, children) ]

    let componentLike ~loc props return =
      Ptyp_constr
        ( { loc; txt = Ldot (Lident "React", "componentLike") },
          [ props; return ] )

    let jsxFragment ~loc =
      Builder.pexp_ident ~loc
        { loc; txt = Ldot (Lident "React", "jsxFragment") }
  end

  module ReactDOM = struct
    let createElement ~loc ~attrs element children =
      Builder.pexp_apply ~loc ~attrs
        (Builder.pexp_ident ~loc
           { loc; txt = Ldot (Lident "ReactDOM", "createElement") })
        [ (nolabel, element); (nolabel, children) ]

    let domProps ~parentExpLoc ~loc props =
      Builder.pexp_apply ~loc:parentExpLoc
        (Builder.pexp_ident ~loc:parentExpLoc ~attrs:merlinHideAttrs
           { loc; txt = Ldot (Lident "ReactDOM", "domProps") })
        props
  end
end

let rec find_opt p = function
  | [] -> None
  | x :: l -> if p x then Some x else find_opt p l

let isOptional str = match str with Optional _ -> true | _ -> false
let isLabelled str = match str with Labelled _ -> true | _ -> false

let getLabel str =
  match str with Optional str | Labelled str -> str | Nolabel -> ""

let optionIdent = Lident "option"

let constantString ~loc str =
  Builder.pexp_constant ~loc (Pconst_string (str, Location.none, None))

let safeTypeFromValue valueStr =
  let valueStr = getLabel valueStr in
  match String.sub valueStr 0 1 with "_" -> "T" ^ valueStr | _ -> valueStr
[@@raises Invalid_argument]

let keyType loc =
  Builder.ptyp_constr ~loc { loc; txt = optionIdent }
    [ Builder.ptyp_constr ~loc { loc; txt = Lident "string" } [] ]

type 'a children = ListLiteral of 'a | Exact of 'a
type componentConfig = { propsName : string }

(* if children is a list, convert it to an array while mapping each element. If
   not, just map over it, as usual *)
let transformChildrenIfListUpper ~ctxt ~loc ~mapper theList =
  let rec transformChildren_ theList accum =
    (* not in the sense of converting a list to an array; convert the AST
       reprensentation of a list to the AST reprensentation of an array *)
    match theList with
    | { pexp_desc = Pexp_construct ({ txt = Lident "[]" }, None) } -> (
        match accum with
        | [ singleElement ] -> Exact singleElement
        | accum -> ListLiteral (Builder.pexp_array ~loc (List.rev accum)))
    | {
     pexp_desc =
       Pexp_construct
         ({ txt = Lident "::" }, Some { pexp_desc = Pexp_tuple [ v; acc ] });
    } ->
        transformChildren_ acc (mapper#expression ctxt v :: accum)
    | notAList -> Exact (mapper#expression ctxt notAList)
  in
  transformChildren_ theList []

let transformChildrenIfList ~ctxt ~loc ~mapper theList =
  let rec transformChildren_ theList accum =
    (* not in the sense of converting a list to an array; convert the AST
       reprensentation of a list to the AST reprensentation of an array *)
    match theList with
    | { pexp_desc = Pexp_construct ({ txt = Lident "[]" }, None) } ->
        Builder.pexp_array ~loc (List.rev accum)
    | {
     pexp_desc =
       Pexp_construct
         ({ txt = Lident "::" }, Some { pexp_desc = Pexp_tuple [ v; acc ] });
    } ->
        transformChildren_ acc (mapper#expression ctxt v :: accum)
    | notAList -> mapper#expression ctxt notAList
  in
  transformChildren_ theList []

let extractChildren ?(removeLastPositionUnit = false) propsAndChildren =
  let rec allButLast_ lst acc =
    match lst with
    | [] -> []
    | [
     (Nolabel, { pexp_desc = Pexp_construct ({ txt = Lident "()" }, None) });
    ] ->
        acc
    | (Nolabel, _) :: _rest ->
        raise
          (Invalid_argument
             "JSX: found non-labelled argument before the last position")
    | arg :: rest -> allButLast_ rest (arg :: acc)
      [@@raises Invalid_argument]
  in
  let allButLast lst =
    allButLast_ lst [] |> List.rev
      [@@raises Invalid_argument]
  in
  match
    List.partition
      (fun (label, _) -> label = labelled "children")
      propsAndChildren
  with
  | [], props ->
      (* no children provided? Place a placeholder list *)
      (None, if removeLastPositionUnit then allButLast props else props)
  | ( [
        ( _,
          { pexp_desc = Pexp_construct ({ txt = Lident "[]"; loc = _ }, None) }
        );
      ],
      props ) ->
      (None, if removeLastPositionUnit then allButLast props else props)
  | [ (_, childrenExpr) ], props ->
      ( Some childrenExpr,
        if removeLastPositionUnit then allButLast props else props )
  | _ ->
      raise
        (Invalid_argument "JSX: somehow there's more than one `children` label")
[@@raises Invalid_argument]

let unerasableIgnore loc =
  let structure_item =
    Builder.pstr_eval ~loc:Location.none
      (Builder.pexp_constant ~loc:Location.none
         (Pconst_string ("-16", Location.none, None)))
      []
  in
  Builder.attribute ~loc ~name:{ loc; txt = "warning" }
    ~payload:(PStr [ structure_item ])

(* Helper method to look up the [@react.component] attribute *)
let hasAttr { attr_name = loc; _ } = loc.txt = "react.component"

(* Helper method to filter out any attribute that isn't [@react.component] *)
let otherAttrsPure { attr_name = loc; _ } = loc.txt <> "react.component"

(* Iterate over the attributes and try to find the [@react.component]
   attribute *)
let hasAttrOnBinding { pvb_attributes } =
  find_opt hasAttr pvb_attributes <> None

(* Finds the name of the variable the binding is assigned to, otherwise raises
   Invalid_argument *)
let getFnName binding =
  match binding with
  | { pvb_pat = { ppat_desc = Ppat_var { txt } } } -> txt
  | _ ->
      raise (Invalid_argument "react.component calls cannot be destructured.")
[@@raises Invalid_argument]

let makeNewBinding binding expression newName =
  match binding with
  | { pvb_pat = { ppat_desc = Ppat_var ppat_var } as pvb_pat } ->
      {
        binding with
        pvb_pat =
          { pvb_pat with ppat_desc = Ppat_var { ppat_var with txt = newName } };
        pvb_expr = expression;
        pvb_attributes = [ merlinFocus ];
      }
  | _ ->
      raise (Invalid_argument "react.component calls cannot be destructured.")
[@@raises Invalid_argument]

(* Lookup the value of `props` otherwise raise Invalid_argument error *)
let getPropsNameValue _acc (loc, exp) =
  match (loc, exp) with
  | { txt = Lident "props" }, { pexp_desc = Pexp_ident { txt = Lident str } } ->
      { propsName = str }
  | { txt }, _ ->
      raise
        (Invalid_argument
           ("react.component only accepts props as an option, given: "
          ^ Longident.last_exn txt))
[@@raises Invalid_argument]

(* Lookup the `props` record or string as part of [@react.component] and store
   the name for use when rewriting *)
let getPropsAttr payload =
  let defaultProps = { propsName = "Props" } in
  match payload with
  | Some
      (PStr
        ({
           pstr_desc =
             Pstr_eval ({ pexp_desc = Pexp_record (recordFields, None) }, _);
         }
        :: _rest)) ->
      List.fold_left getPropsNameValue defaultProps recordFields
  | Some
      (PStr
        ({
           pstr_desc =
             Pstr_eval ({ pexp_desc = Pexp_ident { txt = Lident "props" } }, _);
         }
        :: _rest)) ->
      { propsName = "props" }
  | Some (PStr ({ pstr_desc = Pstr_eval (_, _) } :: _rest)) ->
      raise
        (Invalid_argument
           "react.component accepts a record config with props as an options.")
  | _ -> defaultProps
[@@raises Invalid_argument]

(* Plucks the label, loc, and type_ from an AST node *)
let pluckLabelDefaultLocType (label, default, _, _, loc, type_) =
  (label, default, loc, type_)

(* Lookup the filename from the location information on the AST node and turn
   it into a valid module identifier *)
let filenameFromLoc ~ctxt (pstr_loc : Location.t) =
  let fileName =
    match pstr_loc.loc_start.pos_fname with
    | "" -> Expansion_context.Base.input_name ctxt
    | fileName -> fileName
  in
  let fileName =
    try Filename.chop_extension (Filename.basename fileName)
    with Invalid_argument _ -> fileName
  in
  let fileName = String.capitalize_ascii fileName in
  fileName

(* Build a string representation of a module name with segments
   separated by $ *)
let makeModuleName fileName nestedModules fnName =
  let fullModuleName =
    match (fileName, nestedModules, fnName) with
    (* TODO: is this even reachable? It seems like the fileName always exists *)
    | "", nestedModules, "make" -> nestedModules
    | "", nestedModules, fnName -> List.rev (fnName :: nestedModules)
    | fileName, nestedModules, "make" -> fileName :: List.rev nestedModules
    | fileName, nestedModules, fnName ->
        fileName :: List.rev (fnName :: nestedModules)
  in
  let fullModuleName = String.concat "$" fullModuleName in
  fullModuleName

(* AST node builders
   These functions help us build AST nodes that are needed when transforming a
   [@react.component] into a constructor and a props external *)

(* Build an AST node representing all named args for the `external` definition
   for a component's props *)
let rec recursivelyMakeNamedArgsForExternal list args =
  match list with
  | (label, default, loc, interiorType) :: tl ->
      recursivelyMakeNamedArgsForExternal tl
        (Builder.ptyp_arrow ~loc:Location.none label
           (match (label, interiorType, default) with
           (* ~foo=1 *)
           | label, None, Some _ ->
               {
                 ptyp_desc = Ptyp_var (safeTypeFromValue label);
                 ptyp_loc = loc;
                 ptyp_loc_stack = [];
                 ptyp_attributes = [];
               }
           (* ~foo: int=1 *)
           | _label, Some type_, Some _ -> type_
           (* ~foo: option(int)=? *)
           | ( label,
               Some
                 {
                   ptyp_desc = Ptyp_constr ({ txt = Lident "option" }, [ type_ ]);
                 },
               _ )
           | ( label,
               Some
                 {
                   ptyp_desc =
                     Ptyp_constr
                       ({ txt = Ldot (Lident "*predef*", "option") }, [ type_ ]);
                 },
               _ )
           (* ~foo: int=? - note this isnt valid. but we want to get a type
              error *)
           | label, Some type_, _
             when isOptional label ->
               type_
           (* ~foo=? *)
           | label, None, _ when isOptional label ->
               {
                 ptyp_desc = Ptyp_var (safeTypeFromValue label);
                 ptyp_loc = loc;
                 ptyp_loc_stack = [];
                 ptyp_attributes = [];
               }
           (* ~foo *)
           | label, None, _ ->
               {
                 ptyp_desc = Ptyp_var (safeTypeFromValue label);
                 ptyp_loc_stack = [];
                 ptyp_loc = loc;
                 ptyp_attributes = [];
               }
           | _label, Some type_, _ -> type_)
           args)
  | [] -> args
[@@raises Invalid_argument]

(* Build an AST node for the [@bs.obj] representing props for a component *)
let makePropsValue fnName loc namedArgListWithKeyAndRef propsType =
  let propsName = fnName ^ "Props" in
  {
    pval_name = { txt = propsName; loc };
    pval_type =
      recursivelyMakeNamedArgsForExternal namedArgListWithKeyAndRef
        (Builder.ptyp_arrow ~loc nolabel
           {
             ptyp_desc = Ptyp_constr ({ txt = Lident "unit"; loc }, []);
             ptyp_loc = loc;
             ptyp_loc_stack = [];
             ptyp_attributes = [];
           }
           propsType);
    pval_prim = [ "" ];
    pval_attributes =
      [
        {
          attr_name = { txt = "bs.obj"; loc };
          attr_payload = PStr [];
          attr_loc = loc;
        };
      ];
    pval_loc = loc;
  }
[@@raises Invalid_argument]

(* Build an AST node representing an `external` with the definition of the
   [@bs.obj] *)
let makePropsExternal fnName loc namedArgListWithKeyAndRef propsType =
  {
    pstr_loc = loc;
    pstr_desc =
      Pstr_primitive
        (makePropsValue fnName loc namedArgListWithKeyAndRef propsType);
  }
[@@raises Invalid_argument]

(* Build an AST node for the signature of the `external` definition *)
let makePropsExternalSig fnName loc namedArgListWithKeyAndRef propsType =
  {
    psig_loc = loc;
    psig_desc =
      Psig_value (makePropsValue fnName loc namedArgListWithKeyAndRef propsType);
  }
[@@raises Invalid_argument]

(* Build an AST node for the props name when converted to an object inside the
   function signature *)
let makePropsName ~loc name =
  {
    ppat_desc = Ppat_var { txt = name; loc };
    ppat_loc = loc;
    ppat_loc_stack = [];
    ppat_attributes = [];
  }

let makeObjectField loc (str, attrs, type_) =
  {
    pof_desc = Otag ({ loc; txt = str }, type_);
    pof_loc = loc;
    pof_attributes = attrs;
  }

(* Build an AST node representing a "closed" object representing a component's
   props *)
let makePropsType ~loc namedTypeList =
  Builder.ptyp_constr ~loc
    { txt = Ldot (Lident "Js", "t"); loc }
    [
      {
        ptyp_desc =
          Ptyp_object (List.map (makeObjectField loc) namedTypeList, Closed);
        ptyp_loc = loc;
        ptyp_loc_stack = [];
        ptyp_attributes = [];
      };
    ]

let jsxExprAndChildren ~ident ~loc ~ctxt mapper ~keyProps children =
  let childrenExpr =
    Option.map (transformChildrenIfListUpper ~loc ~mapper ~ctxt) children
  in
  match (childrenExpr, keyProps) with
  | Some (Exact children), (label, key) :: _ ->
      ( Builder.pexp_ident ~loc { loc; txt = Ldot (Lident ident, "jsxKeyed") },
        Some (label, key),
        Some children )
  | Some (Exact children), [] ->
      ( Builder.pexp_ident ~loc { loc; txt = Ldot (Lident ident, "jsx") },
        None,
        Some children )
  | ( Some (ListLiteral ({ pexp_desc = Pexp_array list } as children)),
      (label, key) :: _ )
    when list = [] ->
      ( Builder.pexp_ident ~loc { loc; txt = Ldot (Lident ident, "jsxKeyed") },
        Some (label, key),
        Some (Binding.React.array ~loc children) )
  | Some (ListLiteral { pexp_desc = Pexp_array list }), [] when list = [] ->
      ( Builder.pexp_ident ~loc { loc; txt = Ldot (Lident ident, "jsx") },
        None,
        children )
  | Some (ListLiteral children), (label, key) :: _ ->
      (* this is a hack to support react components that introspect into their
         children *)
      ( Builder.pexp_ident ~loc { loc; txt = Ldot (Lident ident, "jsxsKeyed") },
        Some (label, key),
        Some (Binding.React.array ~loc children) )
  | Some (ListLiteral children), [] ->
      (* this is a hack to support react components that introspect into their
         children *)
      ( Builder.pexp_ident ~loc { loc; txt = Ldot (Lident ident, "jsxs") },
        None,
        Some (Binding.React.array ~loc children) )
  | None, (label, key) :: _ ->
      ( Builder.pexp_ident ~loc { loc; txt = Ldot (Lident ident, "jsxKeyed") },
        Some (label, key),
        None )
  | None, [] ->
      ( Builder.pexp_ident ~loc { loc; txt = Ldot (Lident ident, "jsx") },
        None,
        None )

let reactJsxExprAndChildren = jsxExprAndChildren ~ident:"React"
let reactDomJsxExprAndChildren = jsxExprAndChildren ~ident:"ReactDOM"

(* Builds an AST node for the entire `external` definition of props *)
let makeExternalDecl fnName loc namedArgListWithKeyAndRef namedTypeList =
  makePropsExternal fnName loc
    (List.map pluckLabelDefaultLocType namedArgListWithKeyAndRef)
    (makePropsType ~loc namedTypeList)
[@@raises Invalid_argument]

(* TODO: some line number might still be wrong *)
let jsxMapper =
  let unit =
    Builder.pexp_construct ~loc:Location.none
      { txt = Lident "()"; loc = Location.none }
      None
  in
  let transformUppercaseCall3 ~caller modulePath ~ctxt mapper loc attrs _
      callArguments =
    let children, argsWithLabels = extractChildren callArguments in
    let argsForMake = argsWithLabels in
    let keyProps, otherProps =
      List.partition
        (fun (arg_label, _) -> "key" = getLabel arg_label)
        argsForMake
    in
    let jsxExpr, key, childrenProp =
      reactJsxExprAndChildren ~loc ~ctxt mapper ~keyProps children
    in
    let propsArg =
      (match childrenProp with
      | Some childrenProp -> (labelled "children", childrenProp) :: otherProps
      | None -> otherProps)
      |> List.map (fun (label, expression) ->
             (label, mapper#expression ctxt expression))
    in
    let isCap str =
      let first = String.sub str 0 1 [@@raises Invalid_argument] in
      let capped = String.uppercase_ascii first in
      first = capped
        [@@raises Invalid_argument]
    in
    let ident =
      match modulePath with
      | Lident _ -> Ldot (modulePath, caller)
      | Ldot (_modulePath, value) as fullPath when isCap value ->
          Ldot (fullPath, caller)
      | modulePath -> modulePath
    in
    let propsIdent =
      match ident with
      | Lident path -> Lident (path ^ "Props")
      | Ldot (ident, path) -> Ldot (ident, path ^ "Props")
      | _ ->
          raise
            (Invalid_argument
               "JSX name can't be the result of function applications")
    in
    let props =
      Builder.pexp_apply ~loc
        (Builder.pexp_ident ~loc { loc; txt = propsIdent })
        propsArg
    in
    let key_args =
      match key with
      | Some (label, key) ->
          [ (label, mapper#expression ctxt key); (nolabel, unit) ]
      | None -> []
    in
    Builder.pexp_apply ~loc ~attrs jsxExpr
      ([
         (nolabel, Builder.pexp_ident ~loc { txt = ident; loc });
         (nolabel, props);
       ]
      @ key_args)
  in

  let transformLowercaseCall3 ~ctxt parentExpLoc mapper loc attrs callArguments
      id =
    let children, nonChildrenProps = extractChildren callArguments in
    let componentNameExpr = constantString ~loc id in
    let keyProps, nonChildrenProps =
      List.partition
        (fun (arg_label, _) -> "key" = getLabel arg_label)
        nonChildrenProps
    in
    let jsxExpr, args =
      let jsxExpr, key, childrenProp =
        reactDomJsxExprAndChildren ~loc:parentExpLoc ~ctxt mapper ~keyProps
          children
      in
      let props =
        (match childrenProp with
        | Some childrenProp ->
            (labelled "children", childrenProp) :: nonChildrenProps
        | None -> nonChildrenProps)
        |> List.map (fun (label, expression) ->
               (label, mapper#expression ctxt expression))
      in
      let key_args =
        match key with
        | Some (label, key) ->
            [ (label, mapper#expression ctxt key); (nolabel, unit) ]
        | None -> []
      in
      ( jsxExpr,
        [
          (nolabel, componentNameExpr);
          (nolabel, Binding.ReactDOM.domProps ~parentExpLoc ~loc props);
        ]
        @ key_args )
    in
    Builder.pexp_apply ~loc:parentExpLoc ~attrs jsxExpr args
  in

  let rec recursivelyTransformNamedArgsForMake ~ctxt mapper expr list =
    let expr = mapper#expression ctxt expr in
    match expr.pexp_desc with
    (* TODO: make this show up with a loc. *)
    | Pexp_fun (Labelled "key", _, _, _) | Pexp_fun (Optional "key", _, _, _) ->
        raise
          (Invalid_argument
             "Key cannot be accessed inside of a component. Don't worry - you \
              can always key a component from its parent!")
    | Pexp_fun (Labelled "ref", _, _, _) | Pexp_fun (Optional "ref", _, _, _) ->
        raise
          (Invalid_argument
             "Ref cannot be passed as a normal prop. Please use `forwardRef` \
              API instead.")
    | Pexp_fun (arg, default, pattern, expression)
      when isOptional arg || isLabelled arg ->
        let () =
          match (isOptional arg, pattern, default) with
          | true, { ppat_desc = Ppat_constraint (_, { ptyp_desc }) }, None -> (
              match ptyp_desc with
              | Ptyp_constr ({ txt = Lident "option" }, [ _ ]) -> ()
              | _ ->
                  let currentType =
                    match ptyp_desc with
                    | Ptyp_constr ({ txt }, []) ->
                        String.concat "." (Longident.flatten_exn txt)
                    | Ptyp_constr ({ txt }, _innerTypeArgs) ->
                        String.concat "." (Longident.flatten_exn txt) ^ "(...)"
                    | _ -> "..."
                  in
                  Ocaml_common.Location.prerr_warning pattern.ppat_loc
                    (Preprocessor
                       (Printf.sprintf
                          "react-jsx-ppx: optional argument annotations must \
                           have an explicit `option` type. Did you mean \
                           `option(%s)=?`?"
                          currentType)))
          | _ -> ()
        in
        let alias =
          match pattern with
          | { ppat_desc = Ppat_alias (_, { txt }) | Ppat_var { txt } } -> txt
          | { ppat_desc = Ppat_any } -> "_"
          | _ -> getLabel arg
        in
        let type_ =
          match pattern with
          | { ppat_desc = Ppat_constraint (_, type_) } -> Some type_
          | _ -> None
        in

        recursivelyTransformNamedArgsForMake ~ctxt mapper expression
          ((arg, default, pattern, alias, pattern.ppat_loc, type_) :: list)
    | Pexp_fun
        ( Nolabel,
          _,
          { ppat_desc = Ppat_construct ({ txt = Lident "()" }, _) | Ppat_any },
          _expression ) ->
        (list, None)
    | Pexp_fun
        ( Nolabel,
          _,
          {
            ppat_desc =
              ( Ppat_var { txt }
              | Ppat_constraint ({ ppat_desc = Ppat_var { txt } }, _) );
          },
          _expression ) ->
        (list, Some txt)
    | Pexp_fun (Nolabel, _, pattern, _expression) ->
        Location.raise_errorf ~loc:pattern.ppat_loc
          "react-jsx-ppx: react.component refs only support plain arguments \
           and type annotations."
    | _ -> (list, None)
      [@@raises Invalid_argument]
  in

  let argToType types (name, default, _noLabelName, _alias, loc, type_) =
    match (type_, name, default) with
    | ( Some { ptyp_desc = Ptyp_constr ({ txt = Lident "option" }, [ type_ ]) },
        name,
        _ )
      when isOptional name ->
        ( getLabel name,
          [],
          {
            type_ with
            ptyp_desc =
              Ptyp_constr
                ({ loc = type_.ptyp_loc; txt = optionIdent }, [ type_ ]);
          } )
        :: types
    | Some type_, name, Some _default ->
        ( getLabel name,
          [],
          {
            ptyp_desc = Ptyp_constr ({ loc; txt = optionIdent }, [ type_ ]);
            ptyp_loc = loc;
            ptyp_loc_stack = [];
            ptyp_attributes = [];
          } )
        :: types
    | Some type_, name, _ -> (getLabel name, [], type_) :: types
    | None, name, _ when isOptional name ->
        ( getLabel name,
          [],
          {
            ptyp_desc =
              Ptyp_constr
                ( { loc; txt = optionIdent },
                  [
                    {
                      ptyp_desc = Ptyp_var (safeTypeFromValue name);
                      ptyp_loc = loc;
                      ptyp_loc_stack = [];
                      ptyp_attributes = [];
                    };
                  ] );
            ptyp_loc = loc;
            ptyp_loc_stack = [];
            ptyp_attributes = [];
          } )
        :: types
    | None, name, _ when isLabelled name ->
        ( getLabel name,
          [],
          {
            ptyp_desc = Ptyp_var (safeTypeFromValue name);
            ptyp_loc = loc;
            ptyp_loc_stack = [];
            ptyp_attributes = [];
          } )
        :: types
    | _ -> types
      [@@raises Invalid_argument]
  in

  let argToConcreteType types (name, loc, type_) =
    match name with
    | name when isLabelled name -> (getLabel name, [], type_) :: types
    | name when isOptional name ->
        ( getLabel name,
          [],
          Builder.ptyp_constr ~loc { loc; txt = optionIdent } [ type_ ] )
        :: types
    | _ -> types
  in

  let nestedModules = ref [] in
  let transformComponentDefinition ~ctxt mapper structure returnStructures =
    match structure with
    (* external *)
    | {
        pstr_loc;
        pstr_desc =
          Pstr_primitive
            ({ pval_name = { txt = fnName }; pval_attributes; pval_type } as
             value_description);
      } as pstr -> (
        match List.filter hasAttr pval_attributes with
        | [] -> structure :: returnStructures
        | [ _ ] ->
            let rec getPropTypes types ({ ptyp_loc; ptyp_desc } as fullType) =
              match ptyp_desc with
              | Ptyp_arrow (name, type_, ({ ptyp_desc = Ptyp_arrow _ } as rest))
                when isLabelled name || isOptional name ->
                  getPropTypes ((name, ptyp_loc, type_) :: types) rest
              | Ptyp_arrow (Nolabel, _type, rest) -> getPropTypes types rest
              | Ptyp_arrow (name, type_, returnValue)
                when isLabelled name || isOptional name ->
                  (returnValue, (name, returnValue.ptyp_loc, type_) :: types)
              | _ -> (fullType, types)
            in
            let innerType, propTypes = getPropTypes [] pval_type in
            let namedTypeList = List.fold_left argToConcreteType [] propTypes in
            let pluckLabelAndLoc (label, loc, type_) =
              (label, None (* default *), loc, Some type_)
            in
            let retPropsType = makePropsType ~loc:pstr_loc namedTypeList in
            let externalPropsDecl =
              makePropsExternal fnName pstr_loc
                ((optional "key", None, pstr_loc, Some (keyType pstr_loc))
                :: List.map pluckLabelAndLoc propTypes)
                retPropsType
            in
            (* can't be an arrow because it will defensively uncurry *)
            let newExternalType =
              Binding.React.componentLike ~loc:pstr_loc retPropsType innerType
            in
            let newStructure =
              {
                pstr with
                pstr_desc =
                  Pstr_primitive
                    {
                      value_description with
                      pval_type = { pval_type with ptyp_desc = newExternalType };
                      pval_attributes =
                        List.filter otherAttrsPure pval_attributes;
                    };
              }
            in
            externalPropsDecl :: newStructure :: returnStructures
        | _ ->
            raise
              (Invalid_argument
                 "Only one react.component call can exist on a component at \
                  one time"))
    (* let component = ... *)
    | { pstr_loc; pstr_desc = Pstr_value (recFlag, valueBindings) } ->
        let fileName = filenameFromLoc ~ctxt pstr_loc in
        let gloc = { pstr_loc with loc_ghost = true } in
        let mapBinding binding =
          if hasAttrOnBinding binding then
            let bindingLoc = binding.pvb_loc in
            let bindingPatLoc = binding.pvb_pat.ppat_loc in
            let fnName = getFnName binding in
            let internalFnName = fnName ^ "$Internal" in
            let fullModuleName =
              makeModuleName fileName !nestedModules fnName
            in
            let modifiedBindingOld binding =
              let expression = binding.pvb_expr in
              (* TODO: there is a long-tail of unsupported features inside of
                 blocks - Pexp_letmodule , Pexp_letexception , Pexp_ifthenelse *)
              let rec spelunkForFunExpression expression =
                match expression with
                (* let make = (~prop) => ... *)
                | { pexp_desc = Pexp_fun _ } -> expression
                (* let make = {let foo = bar in (~prop) => ...} *)
                | { pexp_desc = Pexp_let (_recursive, _vbs, returnExpression) }
                  ->
                    (* here's where we spelunk! *)
                    spelunkForFunExpression returnExpression
                (* let make = React.forwardRef((~prop) => ...) *)
                | {
                 pexp_desc =
                   Pexp_apply
                     (_wrapperExpression, [ (Nolabel, innerFunctionExpression) ]);
                } ->
                    spelunkForFunExpression innerFunctionExpression
                (* let make = React.memoCustomCompareProps(
                     (~prop) => ...,
                     (prevProps, nextProps) => false
                   ) *)
                | {
                 pexp_desc =
                   Pexp_apply
                     ( _wrapperExpression,
                       [ (Nolabel, innerFunctionExpression); _ ] );
                } ->
                    spelunkForFunExpression innerFunctionExpression
                | {
                 pexp_desc =
                   Pexp_sequence (_wrapperExpression, innerFunctionExpression);
                } ->
                    spelunkForFunExpression innerFunctionExpression
                | _ ->
                    raise
                      (Invalid_argument
                         "react.component calls can only be on function \
                          definitions or component wrappers (forwardRef, memo \
                          or memoCustomCompareProps).")
                  [@@raises Invalid_argument]
              in
              spelunkForFunExpression expression
            in
            let modifiedBinding binding =
              let hasApplication = ref false in
              let wrapExpressionWithBinding expressionFn expression =
                Builder.value_binding ~loc:bindingLoc
                  ~attrs:(List.filter otherAttrsPure binding.pvb_attributes)
                  ~pat:
                    (Builder.ppat_var ~loc:bindingPatLoc
                       { loc = bindingPatLoc; txt = fnName })
                  ~expr:(expressionFn expression)
              in
              let expression = binding.pvb_expr in
              let unerasableIgnoreExp exp =
                {
                  exp with
                  pexp_attributes = unerasableIgnore gloc :: exp.pexp_attributes;
                }
              in
              (* TODO: there is a long-tail of unsupported features inside of
                 blocks - Pexp_letmodule , Pexp_letexception , Pexp_ifthenelse *)
              let rec spelunkForFunExpression expression =
                match expression with
                (* let make = (~prop) => ... with no final unit *)
                | {
                 pexp_desc =
                   Pexp_fun
                     ( ((Labelled _ | Optional _) as label),
                       default,
                       pattern,
                       ({ pexp_desc = Pexp_fun _ } as internalExpression) );
                } ->
                    let wrap, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( wrap,
                      hasUnit,
                      unerasableIgnoreExp
                        {
                          expression with
                          pexp_desc = Pexp_fun (label, default, pattern, exp);
                        } )
                (* let make = (()) => ... *)
                (* let make = (_) => ... *)
                | {
                 pexp_desc =
                   Pexp_fun
                     ( Nolabel,
                       _default,
                       {
                         ppat_desc =
                           Ppat_construct ({ txt = Lident "()" }, _) | Ppat_any;
                       },
                       _internalExpression );
                } ->
                    ((fun a -> a), true, expression)
                (* let make = (~prop) => ... *)
                | {
                 pexp_desc =
                   Pexp_fun
                     ( (Labelled _ | Optional _),
                       _default,
                       _pattern,
                       _internalExpression );
                } ->
                    ((fun a -> a), false, unerasableIgnoreExp expression)
                (* let make = (prop) => ... *)
                | {
                 pexp_desc =
                   Pexp_fun (_nolabel, _default, pattern, _internalExpression);
                } ->
                    if hasApplication.contents then
                      ((fun a -> a), false, unerasableIgnoreExp expression)
                    else
                      Location.raise_errorf ~loc:pattern.ppat_loc
                        "react-jsx-ppx: props need to be labelled arguments.\n\
                        \  If you are working with refs be sure to wrap with \
                         React.forwardRef.\n\
                        \  If your component doesn't have any props, use () \
                         (unit) or _ (wildcard) instead of a name."
                (* let make = {let foo = bar in (~prop) => ...} *)
                | { pexp_desc = Pexp_let (recursive, vbs, internalExpression) }
                  ->
                    (* here's where we spelunk! *)
                    let wrap, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( wrap,
                      hasUnit,
                      {
                        expression with
                        pexp_desc = Pexp_let (recursive, vbs, exp);
                      } )
                (* let make = React.forwardRef((~prop) => ...) *)
                | {
                 pexp_desc =
                   Pexp_apply
                     (wrapperExpression, [ (Nolabel, internalExpression) ]);
                 pexp_loc;
                } ->
                    let () = hasApplication := true in
                    let _, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( (fun exp ->
                        Builder.pexp_apply ~loc:pexp_loc wrapperExpression
                          [ (nolabel, exp) ]),
                      hasUnit,
                      exp )
                | {
                 pexp_desc =
                   Pexp_sequence (wrapperExpression, internalExpression);
                } ->
                    let wrap, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( wrap,
                      hasUnit,
                      {
                        expression with
                        pexp_desc = Pexp_sequence (wrapperExpression, exp);
                      } )
                | e -> ((fun a -> a), false, e)
              in
              let wrapExpression, hasUnit, expression =
                spelunkForFunExpression expression
              in
              (wrapExpressionWithBinding wrapExpression, hasUnit, expression)
            in
            let bindingWrapper, hasUnit, expression = modifiedBinding binding in
            let reactComponentAttribute =
              try Some (List.find hasAttr binding.pvb_attributes)
              with Not_found -> None
            in
            let _attr_loc, payload =
              match reactComponentAttribute with
              | Some { attr_name = loc; attr_payload = payload; _ } ->
                  (loc.loc, Some payload)
              | None -> (gloc, None)
            in
            let props = getPropsAttr payload in
            (* do stuff here! *)
            let namedArgList, forwardRef =
              recursivelyTransformNamedArgsForMake ~ctxt mapper
                (modifiedBindingOld binding)
                []
            in
            let namedArgListWithKeyAndRef =
              ( optional "key",
                None,
                Builder.ppat_var ~loc:gloc { loc = gloc; txt = "key" },
                "key",
                gloc,
                Some (keyType gloc) )
              :: namedArgList
            in
            let namedArgListWithKeyAndRef =
              match forwardRef with
              | Some _ ->
                  ( optional "ref",
                    None,
                    Builder.ppat_var ~loc:gloc { loc = gloc; txt = "key" },
                    "ref",
                    gloc,
                    None )
                  :: namedArgListWithKeyAndRef
              | None -> namedArgListWithKeyAndRef
            in
            let namedArgListWithKeyAndRefForNew =
              match forwardRef with
              | Some txt ->
                  namedArgList
                  @ [
                      ( nolabel,
                        None,
                        Builder.ppat_var ~loc:gloc { loc = gloc; txt },
                        txt,
                        gloc,
                        None );
                    ]
              | None -> namedArgList
            in
            let pluckArg (label, _, _, alias, loc, _) =
              let labelString =
                match label with
                | label when isOptional label || isLabelled label ->
                    getLabel label
                | _ -> ""
              in
              ( label,
                match labelString with
                | "" -> Builder.pexp_ident ~loc { txt = Lident alias; loc }
                | labelString ->
                    Builder.pexp_apply ~loc
                      (Builder.pexp_ident ~loc { txt = Lident "##"; loc })
                      [
                        ( nolabel,
                          Builder.pexp_ident ~loc
                            { txt = Lident props.propsName; loc } );
                        ( nolabel,
                          Builder.pexp_ident ~loc
                            { txt = Lident labelString; loc } );
                      ] )
            in
            let namedTypeList = List.fold_left argToType [] namedArgList in
            let loc = gloc in
            let externalDecl =
              makeExternalDecl fnName loc namedArgListWithKeyAndRef
                namedTypeList
            in
            let innerExpressionArgs =
              List.map pluckArg namedArgListWithKeyAndRefForNew
              @
              if hasUnit then
                [
                  ( Nolabel,
                    Builder.pexp_construct ~loc:Location.none
                      { loc; txt = Lident "()" } None );
                ]
              else []
            in
            let innerExpression =
              Builder.pexp_apply ~loc
                (Builder.pexp_ident ~loc
                   {
                     loc;
                     txt =
                       Lident
                         (match recFlag with
                         | Recursive -> internalFnName
                         | Nonrecursive -> fnName);
                   })
                innerExpressionArgs
            in
            let innerExpressionWithRef =
              match forwardRef with
              | Some txt ->
                  {
                    innerExpression with
                    pexp_desc =
                      Pexp_fun
                        ( nolabel,
                          None,
                          {
                            ppat_desc = Ppat_var { txt; loc = gloc };
                            ppat_loc = gloc;
                            ppat_loc_stack = [];
                            ppat_attributes = [];
                          },
                          innerExpression );
                  }
              | None -> innerExpression
            in
            let fullExpression =
              Builder.pexp_fun ~loc nolabel None
                {
                  ppat_desc =
                    Ppat_constraint
                      ( makePropsName ~loc:gloc props.propsName,
                        makePropsType ~loc:gloc namedTypeList );
                  ppat_loc = gloc;
                  ppat_loc_stack = [];
                  ppat_attributes = [];
                }
                innerExpressionWithRef
            in
            let fullExpression =
              match fullModuleName with
              | "" -> fullExpression
              | txt ->
                  Builder.pexp_let ~loc:gloc Nonrecursive
                    [
                      Builder.value_binding ~loc:gloc ~attrs:[]
                        ~pat:(Builder.ppat_var ~loc:gloc { loc = gloc; txt })
                        ~expr:fullExpression;
                    ]
                    (Builder.pexp_ident ~loc:gloc
                       { loc = gloc; txt = Lident txt })
            in
            let bindings, newBinding =
              match recFlag with
              | Recursive ->
                  ( [
                      bindingWrapper
                        (Builder.pexp_let ~loc:gloc Recursive
                           [
                             makeNewBinding binding expression internalFnName;
                             Builder.value_binding ~loc:gloc ~attrs:[]
                               ~pat:
                                 (Builder.ppat_var ~loc:gloc
                                    { loc = gloc; txt = fnName })
                               ~expr:fullExpression;
                           ]
                           (Builder.pexp_ident ~loc:gloc
                              { loc = gloc; txt = Lident fnName }));
                    ],
                    None )
              | Nonrecursive ->
                  ( [
                      { binding with pvb_expr = expression; pvb_attributes = [] };
                    ],
                    Some (bindingWrapper fullExpression) )
            in
            (Some externalDecl, bindings, newBinding)
          else (None, [ binding ], None)
            [@@raises Invalid_argument]
        in
        let structuresAndBinding = List.map mapBinding valueBindings in
        let otherStructures (extern, binding, newBinding)
            (externs, bindings, newBindings) =
          let externs =
            match extern with
            | Some extern -> extern :: externs
            | None -> externs
          in
          let newBindings =
            match newBinding with
            | Some newBinding -> newBinding :: newBindings
            | None -> newBindings
          in
          (externs, binding @ bindings, newBindings)
        in
        let externs, bindings, newBindings =
          List.fold_right otherStructures structuresAndBinding ([], [], [])
        in
        externs
        @ [ { pstr_loc; pstr_desc = Pstr_value (recFlag, bindings) } ]
        @ (match newBindings with
          | [] -> []
          | newBindings ->
              [
                {
                  pstr_loc = gloc;
                  pstr_desc = Pstr_value (recFlag, newBindings);
                };
              ])
        @ returnStructures
    | structure -> structure :: returnStructures
      [@@raises Invalid_argument]
  in

  let reactComponentTransform ~ctxt mapper structures =
    List.fold_right (transformComponentDefinition ~ctxt mapper) structures []
      [@@raises Invalid_argument]
  in

  let transformComponentSignature _mapper signature returnSignatures =
    match signature with
    | {
        psig_loc;
        psig_desc =
          Psig_value
            ({ pval_name = { txt = fnName }; pval_attributes; pval_type } as
             psig_desc);
      } as psig -> (
        match List.filter hasAttr pval_attributes with
        | [] -> signature :: returnSignatures
        | [ _ ] ->
            let rec getPropTypes types ({ ptyp_loc; ptyp_desc } as fullType) =
              match ptyp_desc with
              | Ptyp_arrow (name, type_, ({ ptyp_desc = Ptyp_arrow _ } as rest))
                when isOptional name || isLabelled name ->
                  getPropTypes ((name, ptyp_loc, type_) :: types) rest
              | Ptyp_arrow (Nolabel, _type, rest) -> getPropTypes types rest
              | Ptyp_arrow (name, type_, returnValue)
                when isOptional name || isLabelled name ->
                  (returnValue, (name, returnValue.ptyp_loc, type_) :: types)
              | _ -> (fullType, types)
            in
            let innerType, propTypes = getPropTypes [] pval_type in
            let namedTypeList = List.fold_left argToConcreteType [] propTypes in
            let pluckLabelAndLoc (label, loc, type_) =
              (label, None, loc, Some type_)
            in
            let retPropsType = makePropsType ~loc:psig_loc namedTypeList in
            let externalPropsDecl =
              makePropsExternalSig fnName psig_loc
                ((optional "key", None, psig_loc, Some (keyType psig_loc))
                :: List.map pluckLabelAndLoc propTypes)
                retPropsType
            in
            (* can't be an arrow because it will defensively uncurry *)
            let newExternalType =
              Binding.React.componentLike ~loc:psig_loc retPropsType innerType
            in
            let newStructure =
              {
                psig with
                psig_desc =
                  Psig_value
                    {
                      psig_desc with
                      pval_type = { pval_type with ptyp_desc = newExternalType };
                      pval_attributes =
                        List.filter otherAttrsPure pval_attributes;
                    };
              }
            in
            externalPropsDecl :: newStructure :: returnSignatures
        | _ ->
            raise
              (Invalid_argument
                 "Only one react.component call can exist on a component at \
                  one time"))
    | signature -> signature :: returnSignatures
      [@@raises Invalid_argument]
  in

  let reactComponentSignatureTransform mapper signatures =
    List.fold_right (transformComponentSignature mapper) signatures []
      [@@raises Invalid_argument]
  in

  let transformJsxCall ~ctxt parentExpLoc mapper callExpression callArguments
      attrs =
    match callExpression.pexp_desc with
    | Pexp_ident caller -> (
        match caller with
        | { txt = Lident "createElement" } ->
            raise
              (Invalid_argument
                 "JSX: `createElement` should be preceeded by a module name.")
        (* Foo.createElement(~prop1=foo, ~prop2=bar, ~children=[], ()) *)
        | { txt = Ldot (modulePath, ("createElement" | "make")) } ->
            transformUppercaseCall3 ~ctxt ~caller:"make" modulePath mapper
              parentExpLoc attrs callExpression callArguments
        (* div(~prop1=foo, ~prop2=bar, ~children=[bla], ()) *)
        (* turn that into
           ReactDOM.createElement("div", ~props=ReactDOM.domProps(~props1=foo,
           ~props2=bar, ()), [|bla|]) *)
        | { loc; txt = Lident id } ->
            transformLowercaseCall3 ~ctxt parentExpLoc mapper loc attrs
              callArguments id
        (* Foo.bar(~prop1=foo, ~prop2=bar, ~children=[], ()) *)
        (* Not only "createElement" or "make". See
           https://github.com/reasonml/reason/pull/2541 *)
        | { txt = Ldot (modulePath, anythingNotCreateElementOrMake) } ->
            transformUppercaseCall3 ~ctxt ~caller:anythingNotCreateElementOrMake
              modulePath mapper parentExpLoc attrs callExpression callArguments
        | { txt = Lapply _ } ->
            (* don't think there's ever a case where this is reached *)
            raise
              (Invalid_argument
                 "JSX: encountered a weird case while processing the code. \
                  Please report this!"))
    | _ ->
        raise
          (Invalid_argument
             "JSX: `createElement` should be preceeded by a simple, direct \
              module name.")
      [@@raises Invalid_argument]
  in

  object (self)
    inherit
      [Expansion_context.Base.t] Ppxlib.Ast_traverse.map_with_context as super

    method! signature ctxt sig_ =
      super#signature ctxt (reactComponentSignatureTransform self sig_)
    [@@raises Invalid_argument]

    method! structure ctxt stru =
      super#structure ctxt (reactComponentTransform ~ctxt self stru)
    [@@raises Invalid_argument]

    method! expression ctxt expr =
      match expr with
      (* Does the function application have the @JSX attribute? *)
      | {
       pexp_desc = Pexp_apply (callExpression, callArguments);
       pexp_attributes;
       pexp_loc = parentExpLoc;
      } -> (
          let jsxAttribute, nonJSXAttributes =
            List.partition
              (fun { attr_name = attribute; _ } -> attribute.txt = "JSX")
              pexp_attributes
          in
          match (jsxAttribute, nonJSXAttributes) with
          (* no JSX attribute *)
          | [], _ -> super#expression ctxt expr
          | _, nonJSXAttributes ->
              transformJsxCall ~ctxt parentExpLoc self callExpression
                callArguments nonJSXAttributes)
      (* is it a list with jsx attribute? Reason <>foo</> desugars to
         [@JSX][foo]*)
      | {
          pexp_desc =
            ( Pexp_construct
                ({ txt = Lident "::"; loc }, Some { pexp_desc = Pexp_tuple _ })
            | Pexp_construct ({ txt = Lident "[]"; loc }, None) );
          pexp_attributes;
        } as listItems -> (
          let jsxAttribute, nonJSXAttributes =
            List.partition
              (fun { attr_name = attribute; _ } -> attribute.txt = "JSX")
              pexp_attributes
          in
          match (jsxAttribute, nonJSXAttributes) with
          (* no JSX attribute *)
          | [], _ -> super#expression ctxt expr
          | _, nonJSXAttributes ->
              let childrenExpr =
                transformChildrenIfList ~loc ~ctxt ~mapper:self listItems
              in
              let fragment = Binding.React.jsxFragment ~loc in
              (* throw away the [@JSX] attribute and keep the others, if any *)
              Binding.ReactDOM.createElement ~loc ~attrs:nonJSXAttributes
                fragment childrenExpr)
      (* Delegate to the default mapper, a deep identity traversal *)
      | e -> super#expression ctxt e
    [@@raises Invalid_argument]

    method! module_binding ctxt module_binding =
      (match module_binding.pmb_name.txt with
      | None -> ()
      | Some name -> nestedModules := name :: !nestedModules);
      let mapped = super#module_binding ctxt module_binding in
      let _ = nestedModules := List.tl !nestedModules in
      mapped
    [@@raises Failure]
  end

let () =
  Driver.V2.register_transformation "reactjs"
    ~impl:(fun ctxt str -> jsxMapper#structure ctxt str)
    ~intf:(fun ctxt sig_ -> jsxMapper#signature ctxt sig_)
