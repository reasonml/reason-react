DOM JSX source locations remain available while editing buffers with data
attributes, even before the JSX PPX supports those attributes.

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
  > let element = <button />;
  > EOF
  $ dune build @mel

Query the editor buffer containing a data attribute without rebuilding it.

  $ cat > component.re <<EOF
  > let className = "example";
  > let dataFoo = "value";
  > let element =
  >   <button className dataFoo onClick={event => React.Event.Mouse.preventDefault(event)} />;
  > EOF

Hover retains the types and ranges of ordinary props, data values, and callback
arguments. Go-to-definition still resolves their original bindings.

  $ hover () {
  >   ocamlmerlin single type-enclosing -position "$1" -verbosity 0 \
  >     -filename component.re < component.re | jq -c '.value[0] | {start, end, type}'
  > }
  $ locate () {
  >   ocamlmerlin single locate -position "$1" -look-for ml \
  >     -filename component.re < component.re | jq -c '.value | if type == "object" then .pos else . end'
  > }
  $ hover 4:12
  {"start":{"line":4,"col":10},"end":{"line":4,"col":19},"type":"string"}
  $ locate 4:12
  {"line":1,"col":4}
  $ hover 4:22
  {"start":{"line":4,"col":20},"end":{"line":4,"col":27},"type":"string"}
  $ locate 4:22
  {"line":2,"col":4}
  $ hover 4:81
  {"start":{"line":4,"col":79},"end":{"line":4,"col":84},"type":"React.Event.Mouse.t"}
  $ locate 4:81
  {"line":4,"col":37}

The diagnostic for an unknown ordinary prop points at its value, both with and
without a data attribute.

  $ errors () {
  >   ocamlmerlin single errors -filename component.re < component.re |
  >     jq -c '[.value[] | {start, end, message: (.message | split("\n") | last)}]'
  > }
  $ cat > component.re <<EOF
  > let element = <div clasName="oops" />;
  > EOF
  $ errors
  [{"start":{"line":1,"col":28},"end":{"line":1,"col":34},"message":"This argument cannot be applied with label ~clasName"}]
  $ cat > component.re <<EOF
  > let element = <div clasName="oops" dataFoo="x" />;
  > EOF
  $ errors
  [{"start":{"line":1,"col":28},"end":{"line":1,"col":34},"message":"This argument cannot be applied with label ~clasName"}]

Distinct underscored data values keep their original types and bindings.

  $ cat > component.re <<EOF
  > let className = "example";
  > let first = "one";
  > let second = Some("two");
  > let element =
  >   <button className dataFoo=first data_foo=?second />;
  > EOF
  $ hover 5:12
  {"start":{"line":5,"col":10},"end":{"line":5,"col":19},"type":"string"}
  $ locate 5:12
  {"line":1,"col":4}
  $ hover 5:30
  {"start":{"line":5,"col":28},"end":{"line":5,"col":33},"type":"string"}
  $ locate 5:30
  {"line":2,"col":4}
  $ hover 5:46
  {"start":{"line":5,"col":44},"end":{"line":5,"col":50},"type":"option(string)"}
  $ locate 5:46
  {"line":3,"col":4}
  $ errors
  []
