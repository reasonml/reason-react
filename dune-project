(lang dune 3.7)
(using melange 0.1)

(package
 (name reason-react)
 (synopsis "Reason bindings to React.js")
 (description "ReasonReact helps you use Reason to build React components with deeply integrated, strong, static type safety.

It is designed and built by people using Reason and React in large, mission critical production React codebases.")
 (maintainers "David Sancho <dsnxmoreno@gmail.com>")
 (authors "Cheng Lou <chenglou92@gmail.com>" "Ricky Vetter <rickywvetter@gmail.com>")
 (depends
  (ocaml (and (>= 4.12.0) (< 5.0.0)))
  (reason (= 3.8.1))
  ;; Dev dependencies, using with-test so that consumers don't install them
  (ocaml-lsp-server :with-test)
))

(package
 (name react-jsx-ppx)
 (synopsis "React JSX ppx transformation")
 (depends
  (ocaml (and (>= 4.12.0) (< 5.0.0)))
  (ppxlib (= 0.27.0))
  (reason (= 3.8.1))
  ;; Dev dependencies, using with-test so that consumers don't install them
  ;; (until package is released in opam)
  (ocamlformat (and (= 0.23.0) :with-test))
  (ocaml-lsp-server :with-test)
))
