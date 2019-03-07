(* #if BS_COMPILER_IN_BROWSER then

module Js = struct
  module Unsafe = struct
    type any
    external inject : 'a -> any = "%identity"
    external get : 'a -> 'b -> 'c = "caml_js_get"
    external set : 'a -> 'b -> 'c -> unit = "caml_js_set"
    external pure_js_expr : string -> 'a = "caml_pure_js_expr"
    let global = pure_js_expr "joo_global_object"
    external obj : (string * any) array -> 'a = "caml_js_object"
  end
  type (-'a, +'b) meth_callback
  type 'a callback = (unit, 'a) meth_callback
  external wrap_meth_callback : ('a -> 'b) -> ('a, 'b) meth_callback = "caml_js_wrap_meth_callback"
  type + 'a t
  type js_string
  external string : string -> js_string t = "caml_js_from_string"
  external to_string : js_string t -> string = "caml_js_to_string"
end

(* keep in sync with jscomp/core/jsoo_main.ml `let implementation` *)
let rewrite code =
  let mapper = jsxMapper () in
  Location.input_name := "//toplevel//";
  try
    let lexer = Lexing.from_string code in
    let pstr = Parse.implementation lexer in
    let pstr = mapper.structure mapper pstr in
    let buffer = Buffer.create 1000 in
    Pprintast.structure Format.str_formatter pstr;
    let ocaml_code = Format.flush_str_formatter () in
    Js.Unsafe.(obj [| "ocaml_code", inject @@ Js.string ocaml_code |])
  with e ->
    match Location.error_of_exn e with
    | Some error ->
        Location.report_error Format.err_formatter error;
        let (file, line, startchar) = Location.get_pos_info error.loc.loc_start in
        let (file, endline, endchar) = Location.get_pos_info error.loc.loc_end in
        Js.Unsafe.(obj
          [|
            "ppx_error_msg", inject @@ Js.string (Printf.sprintf "Line %d, %d: %s" line startchar error.msg);
            "row", inject (line - 1);
            "column", inject startchar;
            "endRow", inject (endline - 1);
            "endColumn", inject endchar;
            "text", inject @@ Js.string error.msg;
            "type", inject @@ Js.string "error";
          |]
        )
    | None ->
        Js.Unsafe.(obj [|
          "js_error_msg" , inject @@ Js.string (Printexc.to_string e)
        |])

let export (field : string) v =
  Js.Unsafe.set (Js.Unsafe.global) field v

let make_ppx name =
  export name
    (Js.Unsafe.(obj
                  [|"rewrite",
                    inject @@
                    Js.wrap_meth_callback
                      (fun _ code -> rewrite (Js.to_string code));
                  |]))

let () = make_ppx "jsxv2" *)

(* #elif defined BS_NO_COMPILER_PATCH then *)
let () = Compiler_libs.Ast_mapper.register "JSX" (fun _argv -> jsxMapper ())
(* #else
let () = Ast_mapper.register "JSX" (fun _argv -> jsxMapper ())
#end *)
