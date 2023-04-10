(lang dune 3.7)
(using melange 0.1)
(generate_opam_files true)
(implicit_transitive_deps false)

(package
 (name reason-react)
 (synopsis "Reason bindings for React.js")
  (documentation "https://reasonml.github.io/reason-react")
 (description "ReasonReact helps you use Reason to build React components with deeply integrated, strong, static type safety.

It is designed and built by people using Reason and React in large, mission critical production React codebases.")
(maintainers "David Sancho <dsnxmoreno@gmail.com>")
(authors "Cheng Lou <chenglou92@gmail.com>" "Ricky Vetter <rickywvetter@gmail.com>")
(source
 (github reasonml/reason-react))
(depends
  (ocaml (>= 4.06.1))
  (reason (>= 3.6.0))
  (ocaml-lsp-server :with-test)
))
