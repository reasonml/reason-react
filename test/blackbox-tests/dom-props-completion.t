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
  >   ocamlmerlin single complete-prefix -position "${1:-3:2}" -prefix "${2:-}" \
  >     -filename component.re < component.re |
  >     jq -c '[.value.context[1].labels[].name | select(. == "?id" or . == "?onClick" or . == "?style" or . == "?className" or startswith("~"))] | sort'
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

Partially typed names still complete ordinary props. Already supplied props and
generated helper arguments must not appear in the suggestions.

  $ cat > component.re <<EOF
  > let element =
  >   <div className="a" dataVersion2="v2"
  >   onC />;
  > EOF
  $ complete 3:5 onC
  ["?id","?onClick","?style"]

  $ cat > component.re <<EOF
  > let element =
  >   <div className="a" dataVersion2=?Some("v2")
  >   onC />;
  > EOF
  $ complete 3:5 onC
  ["?id","?onClick","?style"]

Completion also works between data attributes, before any ordinary prop is set.

  $ cat > component.re <<EOF
  > let element =
  >   <div dataFoo="first"
  >   cla dataBar="last" />;
  > EOF
  $ complete 3:5 cla
  ["?className","?id","?onClick","?style"]

Nested JSX keeps its own completion context, including inside ordinary prop
expressions.

  $ cat > component.re <<EOF
  > let element =
  >   <div dataFoo="outer">
  >     <button className="a" dataBar="inner"
  >       onC />
  >   </div>;
  > EOF
  $ complete 4:9 onC
  ["?id","?onClick","?style"]

  $ cat > component.re <<EOF
  > let element =
  >   <div title={ReactDOMServer.renderToStaticMarkup(
  >     <button className="a" dataBar="inner"
  >       onC />
  >   )} dataFoo="outer" />;
  > EOF
  $ complete 4:9 onC
  ["?id","?onClick","?style"]

Distinct underscored data names retain ordinary prop completion.

  $ cat > component.re <<EOF
  > let element =
  >   <div className="a" dataFoo="first" data_foo="second"
  >   onC />;
  > EOF
  $ complete 3:5 onC
  ["?id","?onClick","?style"]

  $ cat > component.re <<EOF
  > let element =
  >   <div className="a" dataFoo=?Some("first") data_foo=?None
  >   onC />;
  > EOF
  $ complete 3:5 onC
  ["?id","?onClick","?style"]
