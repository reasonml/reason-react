(lang dune 3.9)

(using melange 0.1)

(generate_opam_files true)

(cram enable)

(name reason-react)

(maintainers
 "David Sancho <dsnxmoreno@gmail.com>"
 "Antonio Monteiro <anmonteiro@gmail.com>")

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
   (>= 4.13.0))
  (melange
   (>= 1.0.0))
  (reason-react-ppx (= :version))
  (reason
   (and (>= 3.6.0) (< 3.10.0)))
  (ocaml-lsp-server :with-test)
  (merlin
   (and
    (= 4.10-414)
    :with-test))
  (opam-check-npm-deps
   (and
    (= 1.0.0)
    :with-dev-setup))
  (ocamlformat
   (and
    (= 0.24.0)
    :with-dev-setup))))

(package
 (name reason-react-ppx)
 (synopsis "React.js JSX PPX")
 (description "ReasonReact JSX PPX")
 (depends
  (ocaml
   (>= 4.13.0))
  (reason
   (and (>= 3.6.0) (< 3.10.0)))
  (ppxlib
   (>= 0.28.0))
  (merlin :with-test)
  (ocamlformat
   (and
    (= 0.24.0)
    :with-dev-setup))))
