open Ppxlib
open Ast_builder.Default

let attribute ~loc ?(payload = PStr []) name =
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

let label_name = function
  | Labelled name | Optional name -> name
  | Nolabel -> ""

let make ~loc ~dom_props args =
  let ordinary, data =
    List.partition
      (fun (label, _) -> Option.is_none (data_attribute (label_name label)))
      args
  in
  match data with
  | [] -> dom_props args
  | _ ->
      let ghost_loc = { loc with loc_ghost = true } in
      (* Generated helpers must not compete with the original prop expressions
         when Merlin chooses the node at the cursor. *)
      let synthetic_loc = Location.none in
      let stdlib_type name =
        ptyp_constr ~loc:synthetic_loc
          {
            txt = Ldot (Ldot (Lident "Stdlib", name), "t");
            loc = synthetic_loc;
          }
          []
      in
      let unit_type = stdlib_type "Unit" in
      let string_type = stdlib_type "String" in
      let props_type =
        ptyp_constr ~loc:synthetic_loc
          { txt = Ldot (Lident "ReactDOM", "domProps"); loc = synthetic_loc }
          []
      in
      let set_type =
        List.fold_right
          (ptyp_arrow ~loc:synthetic_loc Nolabel)
          [ props_type; string_type; string_type ]
          unit_type
      in
      let set =
        value_description ~loc:synthetic_loc
          ~name:{ txt = "set"; loc = synthetic_loc }
          ~type_:set_type ~prim:[ "" ]
      in
      let set =
        {
          set with
          pval_attributes = [ attribute ~loc:synthetic_loc "mel.set_index" ];
        }
      in
      let module_name = gen_symbol ~prefix:"Jsx_data" () in
      let props_name = gen_symbol ~prefix:"jsx_props" () in
      let module_ =
        pmod_structure ~loc:synthetic_loc
          [ pstr_primitive ~loc:synthetic_loc set ]
      in
      let set_value ~loc name value =
        let setter =
          pexp_ident ~loc:synthetic_loc
            { txt = Ldot (Lident module_name, "set"); loc = synthetic_loc }
        in
        pexp_apply ~loc setter
          [
            (Nolabel, evar ~loc:synthetic_loc props_name);
            (Nolabel, estring ~loc:synthetic_loc name);
            (Nolabel, value);
          ]
      in
      let names = Hashtbl.create 8 in
      let operations =
        List.map
          (fun (label, expression) ->
            let name = Option.get (data_attribute (label_name label)) in
            let loc = expression.pexp_loc in
            if Hashtbl.mem names name then
              Location.raise_errorf ~loc "JSX: duplicate data attribute %S" name;
            Hashtbl.add names name ();
            match label with
            | Labelled _ -> set_value ~loc name expression
            | Optional _ ->
                let option_type =
                  ptyp_constr ~loc:synthetic_loc
                    {
                      txt = Ldot (Ldot (Lident "Stdlib", "Option"), "t");
                      loc = synthetic_loc;
                    }
                    [ string_type ]
                in
                let value_name = gen_symbol ~prefix:"jsx_data" () in
                pexp_match ~loc
                  (pexp_constraint ~loc expression option_type)
                  [
                    case
                      ~lhs:
                        (ppat_construct ~loc:synthetic_loc
                           {
                             txt =
                               Ldot (Ldot (Lident "Stdlib", "Option"), "None");
                             loc = synthetic_loc;
                           }
                           None)
                      ~guard:None ~rhs:(eunit ~loc:synthetic_loc);
                    case
                      ~lhs:
                        (ppat_construct ~loc:synthetic_loc
                           {
                             txt =
                               Ldot (Ldot (Lident "Stdlib", "Option"), "Some");
                             loc = synthetic_loc;
                           }
                           (Some (pvar ~loc:synthetic_loc value_name)))
                      ~guard:None
                      ~rhs:
                        (set_value ~loc:synthetic_loc name
                           (evar ~loc:synthetic_loc value_name));
                  ]
            | Nolabel -> assert false)
          data
      in
      let body =
        List.fold_right
          (fun operation body ->
            (* Keep the assignments within the data values' source range so
               completion between props reaches the [domProps] application. *)
            let loc = operation.pexp_loc in
            let loc =
              if body.pexp_loc = synthetic_loc then loc
              else { loc with loc_end = body.pexp_loc.loc_end }
            in
            pexp_sequence ~loc operation body)
          operations
          (evar ~loc:synthetic_loc props_name)
      in
      (* Keep ordinary props and their locations in the real [domProps] call.
         This preserves its typing, name conversions, and Merlin completions.
         Data values are then evaluated once and assigned to that fresh object. *)
      let body =
        pexp_let ~loc:ghost_loc Nonrecursive
          [
            value_binding ~loc:ghost_loc
              ~pat:(pvar ~loc:synthetic_loc props_name)
              ~expr:(dom_props ordinary);
          ]
          body
      in
      pexp_letmodule ~loc:ghost_loc
        { txt = Some module_name; loc = synthetic_loc }
        module_ body
