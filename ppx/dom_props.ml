open Ppxlib
open Ast_builder.Default

let attribute ~loc ?(payload = PStr []) name =
  attribute ~loc ~name:{ txt = name; loc } ~payload

let data_attribute name =
  (* Keep the standard [data] and [datatype] props on the ordinary DOM path.
     Other data-prefixed names follow server-reason-react's conversion, which
     inserts a hyphen before digits and underscores as well as uppercase letters. *)
  if
    String.starts_with ~prefix:"data" name
    && name <> "data" && name <> "datatype"
  then (
    let buffer = Buffer.create (String.length name + 4) in
    String.iter
      (fun c ->
        if Char.uppercase_ascii c = c then Buffer.add_char buffer '-';
        Buffer.add_char buffer (Char.lowercase_ascii c))
      name;
    Some (Buffer.contents buffer))
  else None

(* These are the [mel.as] conventions used by ReactDOM.domProps. Ordinary
   React prop names, such as className and onClick, keep their spelling. *)
let js_name name =
  match name with
  | "as_" | "begin_" | "end_" | "in_" | "open_" | "to_" | "type_" ->
      Some (String.sub name 0 (String.length name - 1))
  | _ when String.length name > 4 && String.sub name 0 4 = "aria" ->
      Some
        ("aria-"
        ^ String.lowercase_ascii (String.sub name 4 (String.length name - 4)))
  | _ -> None

let label_name = function
  | Labelled name | Optional name -> name
  | Nolabel -> ""

let ignored_type ~loc typ =
  { typ with ptyp_attributes = [ attribute ~loc "mel.ignore" ] }

(* [mel.obj] requires a literal [unit] type for unlabelled arguments. Use an
   ignored labelled argument so the type can be qualified against shadowing. *)
let make_label = function Nolabel -> Labelled "__jsx_unit" | label -> label

type prop = {
  label : arg_label;
  variable : string;
  typ : core_type;
  data_name : string option;
  expression : expression;
}

let make ~loc ~dom_props args =
  if
    not
      (List.exists
         (fun (label, _) -> Option.is_some (data_attribute (label_name label)))
         args)
  then dom_props args
  else
    let ghost_loc = { loc with loc_ghost = true } in
    let synthetic_loc = Location.none in
    let stdlib_type name =
      ptyp_constr ~loc:ghost_loc
        { txt = Ldot (Ldot (Lident "Stdlib", name), "t"); loc = ghost_loc }
        []
    in
    let unit_type = stdlib_type "Unit" in
    let string_type = stdlib_type "String" in
    let props_type =
      ptyp_constr ~loc:ghost_loc
        { txt = Ldot (Lident "ReactDOM", "domProps"); loc = ghost_loc }
        []
    in
    let data_names = Hashtbl.create 8 in
    let props =
      List.map
        (fun (label, expression) ->
          let variable = gen_symbol ~prefix:"prop" () in
          let data_name = data_attribute (label_name label) in
          Option.iter
            (fun name ->
              if Hashtbl.mem data_names name then
                Location.raise_errorf ~loc:expression.pexp_loc
                  "JSX: duplicate data attribute %S" name;
              Hashtbl.add data_names name ())
            data_name;
          let typ =
            match (label, data_name) with
            | Nolabel, _ -> unit_type
            | _, Some _ -> string_type
            | _, None -> ptyp_var ~loc:synthetic_loc variable
          in
          { label; variable; typ; data_name; expression })
        args
    in
    let ordinary_props =
      List.filter (fun prop -> prop.data_name = None) props
    in
    let arrow { label; typ; _ } result =
      ptyp_arrow ~loc:ghost_loc label typ result
    in
    (* The shared type variables connect each supplied prop to the corresponding
       argument of ReactDOM.domProps. Melange erases this pure callback after
       OCaml has checked both its labels and its types. *)
    let check_type =
      ignored_type ~loc:ghost_loc
        (List.fold_right arrow ordinary_props props_type)
    in
    let editor_copy { pexp_desc; _ } =
      (* Reason represents completion holes and partially typed props as
         identifiers. Copy only those small expressions: copying arbitrary
         values would duplicate nested JSX expansions and their typing work. *)
      match pexp_desc with
      | Pexp_ident _ -> true
      | _ -> false
    in
    let check_args =
      List.map
        (fun { label; variable; expression; _ } ->
          (label, evar ~loc:expression.pexp_loc variable))
        ordinary_props
    in
    let hidden_check = dom_props check_args in
    let hidden_check =
      {
        hidden_check with
        pexp_attributes = [ attribute ~loc:ghost_loc "merlin.hide" ];
      }
    in
    let editor_args =
      List.map
        (fun { label; variable; expression; _ } ->
          let expr =
            if editor_copy expression then
              {
                expression with
                pexp_attributes =
                  attribute ~loc:expression.pexp_loc "merlin.focus"
                  :: expression.pexp_attributes;
              }
            else
              let expr = evar ~loc:expression.pexp_loc variable in
              {
                expr with
                pexp_attributes = [ attribute ~loc:synthetic_loc "merlin.hide" ];
              }
          in
          (label, expr))
        ordinary_props
    in
    let check_body =
      (* Infer the constructor's argument types first, then give Merlin a DOM
         application containing the original identifiers. Other values remain
         visible in the constructor, with the inferred types as their context. *)
      pexp_let ~loc:ghost_loc Nonrecursive
        [
          value_binding ~loc:synthetic_loc
            ~pat:(ppat_any ~loc:synthetic_loc)
            ~expr:hidden_check;
        ]
        (dom_props editor_args)
    in
    let check =
      List.fold_right
        (fun { label; variable; _ } body ->
          pexp_fun ~loc:ghost_loc label None
            (pvar ~loc:synthetic_loc variable)
            body)
        ordinary_props check_body
    in
    let make_type =
      List.fold_right
        (fun { label; typ; data_name; _ } result ->
          let name =
            match data_name with
            | Some _ as name -> name
            | None -> js_name (label_name label)
          in
          let attributes =
            match (label, name) with
            | Nolabel, _ -> [ attribute ~loc:ghost_loc "mel.ignore" ]
            | _, None -> []
            | _, Some name ->
                [
                  attribute ~loc:ghost_loc "mel.as"
                    ~payload:
                      (PStr
                         [
                           pstr_eval ~loc:ghost_loc
                             (estring ~loc:ghost_loc name)
                             [];
                         ]);
                ]
          in
          ptyp_arrow ~loc:ghost_loc (make_label label)
            { typ with ptyp_attributes = attributes }
            result)
        props props_type
    in
    let make_type =
      ptyp_arrow ~loc:ghost_loc (Labelled "check") check_type make_type
    in
    let make =
      value_description ~loc:ghost_loc
        ~name:{ txt = "make"; loc = ghost_loc }
        ~type_:make_type ~prim:[ "" ]
    in
    let make =
      { make with pval_attributes = [ attribute ~loc:ghost_loc "mel.obj" ] }
    in
    let module_name = gen_symbol ~prefix:"Jsx_props" () in
    let module_ =
      pmod_structure ~loc:synthetic_loc
        [ pstr_primitive ~loc:synthetic_loc make ]
    in
    let call =
      pexp_apply ~loc
        (pexp_ident ~loc:synthetic_loc
           { txt = Ldot (Lident module_name, "make"); loc = synthetic_loc })
        ((Labelled "check", check)
        :: List.map
             (fun (label, expression) ->
               let expression =
                 if
                   Option.is_none (data_attribute (label_name label))
                   && (editor_copy expression
                      || (label = Nolabel && expression.pexp_loc.loc_ghost))
                 then
                   {
                     expression with
                     pexp_attributes =
                       attribute ~loc:expression.pexp_loc "merlin.hide"
                       :: expression.pexp_attributes;
                   }
                 else expression
               in
               (make_label label, expression))
             args)
    in
    pexp_letmodule ~loc:ghost_loc
      { txt = Some module_name; loc = ghost_loc }
      module_ call
