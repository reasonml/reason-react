(lang dune 3.7)

(using melange 0.1)

(generate_opam_files true)

(name reason-react)

(maintainers "David Sancho <dsnxmoreno@gmail.com>")

(authors
 "Cheng Lou <chenglou92@gmail.com>"
 "Ricky Vetter <rickywvetter@gmail.com>")

(source
 (github reasonml/reason-react))

(homepage "https://reasonml.github.io/reason-react")
(documentation "https://reasonml.github.io/reason-react")

(bug_reports "https://github.com/reasonml/reason-react/issues")

(license "MIT")

(package
 (name reason-react)
 (synopsis "Reason bindings for React.js")
 (description
  "ReasonReact helps you use Reason to build React components with deeply integrated, strong, static type safety.\n\nIt is designed and built by people using Reason and React in large, mission critical production React codebases.")
 (depends
  (ocaml
   (>= 4.06.1))
  (reason
   (>= 3.6.0))
  (ocaml-lsp-server :with-test)))

(package
 (name reactjs-jsx-ppx)
 (synopsis "React.js JSX PPX")
 (description "ReasonReact JSX PPX")
 (depends
  (ocaml
   (>= 4.06.1))
  (reason
   (>= 3.6.0))
  (ppxlib
   (>= 0.29.1))
  (ocaml-lsp-server :with-test)))
