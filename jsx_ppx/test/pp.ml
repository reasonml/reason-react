open Migrate_parsetree

let () =
  Driver.register
    ~name:"JSX"
    Migrate_parsetree.Versions.ocaml_404 (fun _config _cookies -> Reactjs_jsx_ppx_v3_lib.jsxMapper ())
(* To run as a standalone binary, run the registered drivers *)
let () = Driver.run_main ()