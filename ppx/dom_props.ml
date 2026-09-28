open Ppxlib
open Ast_builder.Default

let attribute ~loc name payload =
  attribute ~loc ~name:{ txt = name; loc } ~payload

let data_attribute name =
  if
    String.length name > 4
    && String.sub name 0 4 = "data"
    && name.[4] >= 'A'
    && name.[4] <= 'Z'
  then (
    let buffer = Buffer.create (String.length name + 4) in
    String.iter
      (function
        | 'A' .. 'Z' as c ->
            Buffer.add_char buffer '-';
            Buffer.add_char buffer (Char.lowercase_ascii c)
        | c -> Buffer.add_char buffer c)
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

let make ~loc ~dom_props args =
  if
    not
      (List.exists
         (fun (label, _) -> Option.is_some (data_attribute (label_name label)))
         args)
  then dom_props args
  else
    let ghost_loc = { loc with loc_ghost = true } in
    let unit_type =
      ptyp_constr ~loc:ghost_loc { txt = Lident "unit"; loc } []
    in
    let props_type =
      ptyp_constr ~loc:ghost_loc
        { txt = Ldot (Lident "ReactDOM", "domProps"); loc }
        []
    in
    let props =
      List.mapi
        (fun index (label, expression) ->
          let name = "prop" ^ string_of_int index in
          let data_name = data_attribute (label_name label) in
          let type_ =
            match (label, data_name) with
            | Nolabel, _ -> unit_type
            | _, Some _ ->
                ptyp_constr ~loc:ghost_loc { txt = Lident "string"; loc } []
            | _, None -> ptyp_var ~loc:ghost_loc name
          in
          (label, expression, name, type_, data_name))
        args
    in
    let ordinary_props =
      List.filter (fun (_, _, _, _, data_name) -> data_name = None) props
    in
    let arrow (label, _, _, type_, _) result =
      ptyp_arrow ~loc:ghost_loc label type_ result
    in
    (* The shared type variables connect each supplied prop to the corresponding
       argument of ReactDOM.domProps. Melange erases this pure callback after
       OCaml has checked both its labels and its types. *)
    let check_type = List.fold_right arrow ordinary_props props_type in
    let check_type =
      {
        check_type with
        ptyp_attributes = [ attribute ~loc:ghost_loc "mel.ignore" (PStr []) ];
      }
    in
    let check_args =
      List.map
        (fun (label, expression, name, _, _) ->
          let loc = { expression.pexp_loc with loc_ghost = true } in
          let arg =
            match label with
            | Nolabel -> pexp_construct ~loc { txt = Lident "()"; loc } None
            | Labelled _ | Optional _ ->
                pexp_ident ~loc { txt = Lident name; loc }
          in
          (label, arg))
        ordinary_props
    in
    let check =
      List.fold_right
        (fun (label, _, name, _, _) body ->
          let pattern =
            match label with
            | Nolabel ->
                ppat_construct ~loc:ghost_loc { txt = Lident "()"; loc } None
            | Labelled _ | Optional _ ->
                ppat_var ~loc:ghost_loc { txt = name; loc = ghost_loc }
          in
          pexp_fun ~loc:ghost_loc label None pattern body)
        ordinary_props (dom_props check_args)
    in
    let check =
      {
        check with
        pexp_attributes = [ attribute ~loc:ghost_loc "merlin.hide" (PStr []) ];
      }
    in
    let make_type =
      List.fold_right
        (fun (label, _, _, type_, data_name) result ->
          let name =
            match data_name with
            | Some _ -> data_name
            | None -> js_name (label_name label)
          in
          let type_ =
            match name with
            | None -> type_
            | Some name ->
                {
                  type_ with
                  ptyp_attributes =
                    [
                      attribute ~loc:ghost_loc "mel.as"
                        (PStr
                           [
                             pstr_eval ~loc:ghost_loc
                               (estring ~loc:ghost_loc name)
                               [];
                           ]);
                    ];
                }
          in
          ptyp_arrow ~loc:ghost_loc label type_ result)
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
      {
        make with
        pval_attributes = [ attribute ~loc:ghost_loc "mel.obj" (PStr []) ];
      }
    in
    let module_name = gen_symbol ~prefix:"Jsx_props" () in
    let module_ =
      pmod_structure ~loc:ghost_loc [ pstr_primitive ~loc:ghost_loc make ]
    in
    let call =
      pexp_apply ~loc
        (pexp_ident ~loc:ghost_loc
           { txt = Ldot (Lident module_name, "make"); loc = ghost_loc })
        ((Labelled "check", check) :: args)
    in
    pexp_letmodule ~loc:ghost_loc
      { txt = Some module_name; loc = ghost_loc }
      module_ call
