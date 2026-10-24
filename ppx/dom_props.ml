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

let ignored_type ~loc typ =
  { typ with ptyp_attributes = [ attribute ~loc "mel.ignore" (PStr []) ] }

(* [mel.obj] requires a literal [unit] type for unlabelled arguments. Use an
   ignored labelled argument so the type can be qualified against shadowing. *)
let make_label = function Nolabel -> Labelled "__jsx_unit" | label -> label

type prop = {
  label : arg_label;
  expression : expression;
  variable : string;
  typ : core_type;
  data_name : string option;
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
    let stdlib_type name =
      ptyp_constr ~loc:ghost_loc
        { txt = Ldot (Ldot (Lident "Stdlib", name), "t"); loc = ghost_loc }
        []
    in
    let unit_type = stdlib_type "Unit" in
    let string_type = stdlib_type "String" in
    let props_type =
      ptyp_constr ~loc:ghost_loc
        { txt = Ldot (Lident "ReactDOM", "domProps"); loc }
        []
    in
    let data_names = Hashtbl.create 8 in
    let props =
      List.mapi
        (fun index (label, expression) ->
          let variable = "prop" ^ string_of_int index in
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
            | _, None -> ptyp_var ~loc:ghost_loc variable
          in
          { label; expression; variable; typ; data_name })
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
    let check_args =
      List.map
        (fun { label; expression; variable; _ } ->
          let loc = { expression.pexp_loc with loc_ghost = true } in
          let arg =
            match label with
            | Nolabel -> pexp_construct ~loc { txt = Lident "()"; loc } None
            | Labelled _ | Optional _ ->
                pexp_ident ~loc { txt = Lident variable; loc }
          in
          (label, arg))
        ordinary_props
    in
    let check =
      List.fold_right
        (fun { label; variable; _ } body ->
          let pattern =
            match label with
            | Nolabel ->
                ppat_construct ~loc:ghost_loc { txt = Lident "()"; loc } None
            | Labelled _ | Optional _ ->
                ppat_var ~loc:ghost_loc { txt = variable; loc = ghost_loc }
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
        (fun { label; typ; data_name; _ } result ->
          let name =
            match data_name with
            (* Melange strips the last [__suffix], even in [mel.as]. An empty
               suffix preserves any double underscores in the attribute. *)
            | Some name -> Some (name ^ "__")
            | None -> js_name (label_name label)
          in
          let typ =
            match (label, name) with
            | Nolabel, _ -> ignored_type ~loc:ghost_loc typ
            | _, None -> typ
            | _, Some name ->
                {
                  typ with
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
          ptyp_arrow ~loc:ghost_loc (make_label label) typ result)
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
        ((Labelled "check", check)
        :: List.map
             (fun (label, expression) -> (make_label label, expression))
             args)
    in
    pexp_letmodule ~loc:ghost_loc
      { txt = Some module_name; loc = ghost_loc }
      module_ call
