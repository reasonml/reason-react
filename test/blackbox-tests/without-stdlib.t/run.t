Build the runtime bindings with the compiler's implicit standard library path
disabled, reproducing the missing Stdlib in a clean vendored Melange build.

  $ cp -RL ../../../src src
  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > (package (name reason-react))
  > EOF

  $ cat > dune <<EOF
  > (env (_ (flags :standard -nostdlib)))
  > EOF

  $ dune build --display quiet -j 1 @install
