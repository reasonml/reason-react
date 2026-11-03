DOM prop completion remains available while editing JSX with data attributes.

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (target output)
  >  (alias mel)
  >  (emit_stdlib false)
  >  (libraries reason-react)
  >  (preprocess (pps melange.ppx reason-react-ppx)))
  > EOF

Build a valid component to initialize the Merlin configuration.

  $ cat > component.re <<EOF
  > let element =
  >   <div className="a"
  >   />;
  > EOF
  $ dune build @mel

Query completion before the closing tag, checking representative ordinary props.

  $ complete () {
  >   ocamlmerlin single complete-prefix -position 3:2 -prefix "" \
  >     -filename component.re < component.re |
  >     jq -c '[.value.context[1].labels[].name | select(. == "?id" or . == "?onClick" or . == "?style")] | sort'
  > }
  $ complete
  ["?id","?onClick","?style"]

Merlin also completes editor buffers that do not type-check. Adding a data
attribute must not hide the ordinary DOM props, even before data attributes are
supported by the JSX PPX.

  $ cat > component.re <<EOF
  > let element =
  >   <div className="a" dataVersion2="v2"
  >   />;
  > EOF
  $ complete
  ["?id","?onClick","?style"]

The same holds for an optional data attribute.

  $ cat > component.re <<EOF
  > let element =
  >   <div className="a" dataVersion2=?Some("v2")
  >   />;
  > EOF
  $ complete
  ["?id","?onClick","?style"]
